//
//  ImageDownLoader.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit


enum OperationState {
    case waitingToDownload
    case downloading
    case finished
    case cancelled
    case failed
}
protocol NeedsOperationQueue {
    
}
extension NeedsOperationQueue{
    func defaulOptQueue()->OperationQueue {
        let queue : OperationQueue = OperationQueue()
        queue.name = "module.name.opqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }
    func optQueue(withIdentifier idf : String)->OperationQueue {
        let queue : OperationQueue = OperationQueue()
        queue.name = idf
        queue.qualityOfService = .userInteractive
        return queue
    }
}
private protocol URLSessionDataDownloader {
    func startDownload(url : String)
}
extension URLSessionDataDownloader {
}
final class DownLoadOperation : Operation,URLSessionDataDownloader {
    let url : String
    var state : OperationState
    var imageForOperation :((UIImage?,Data?)->Void)?
    required init(url : String,state : OperationState) {
        self.url = url
        self.state = state
    }
    
    override func main() {
        guard !isCancelled else {
            updateOperation(withState: .finished)
            return
        }
        updateOperation(withState: .downloading)
        self.startDownload(url: url)
    }
    /**update operation state*/
    private func updateOperation(withState state : OperationState) {
        self.state = state
    }
    fileprivate  func startDownload(url: String) {
        let downloadSession  = URLSession.shared
        guard let url = URL(string: url) else {
            updateOperation(withState: .finished)
            return
        }
        let downloadTask = downloadSession.dataTask(with: url) {[self]  data, _, error in
            guard error == nil else {
                updateOperation(withState: .failed)
                return
            }
            guard let data = data else{
                imageForOperation?(nil,nil)
                return
                
            }
            let image = UIImage(data: data)
            imageForOperation?(image,data)
        }
        downloadTask.resume()
    }
}

final public class ImageDownLoader : NSObject,NeedsOperationQueue {
    
    private lazy var tQueue  = defaulOptQueue()
    private let internalQueue = DispatchQueue(label: "com.imagedownloaderinternal.queue",
                                              qos: .default,
                                              attributes: .concurrent)
    private var operationLookup : [String:DownLoadOperation] = [:]
    /*These list will be used to invoke multiple completion when same url downloaded requested for more than 1 time**/
    private var blocksToInvokeOnCompletion : [String : [onImageResult]] = [:]
    
   public typealias onImageResult = ((UIImage?,Data?)->Void)?
    
    //chache
    private let cache = NSCache<NSString, NSData>()
    
    static var shared = ImageDownLoader()
    private override init() {
        
    }
   public class func image(fromURL : String, completion : onImageResult) {
    let dowLoader = ImageDownLoader.shared
    dowLoader.download(url: fromURL, completion: completion)
    }
    private func download(url : String,completion :onImageResult){
        //return image from cache if already downloaded
        if let cachedData = self.cache.object(forKey: url as NSString){
            completion?(UIImage(data: cachedData as Data),cachedData as Data)
        }
        else
        {
            //check already running operation
            if let operation = self.getOperationAtURL(url: url), let blocks = self.getBlocks(atURL: url){
                operation.queuePriority = .high
                
                self.updateBlocks(atURL: url, andBlocks: blocks + [completion])
            }
            // define new task 
            else
            {
                let operation = DownLoadOperation(url: url,state: .waitingToDownload)
                tQueue.addOperation(operation)
                operation.imageForOperation = {image,data in
                                               if let data = data {
                                                self.cache.setObject(data as NSData , forKey: operation.url as NSString)
                                                                   }
                    guard let blocks = self.getBlocks(atURL: url) else {return}
                    for block in blocks {
                        block?(image,data)
                    }
                    self.removeBlocks(atURL: url)
                    self.removeOperations(atURL: url)
                    
                }
                self.updateOperationAtURL(url: url, operation: operation)
                self.updateBlocks(atURL: url, andBlocks:  [completion])
                
                
           }
        }
        
        
    }
    
    
    /*Thread Safe operations*/
    private func removeOperations(atURL url : String) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.operationLookup.removeValue(forKey: url)
        }
    }
    private func removeBlocks(atURL url : String) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.blocksToInvokeOnCompletion[url]?.removeAll()
        }
    }
  
    private func getBlocks(atURL url : String)->[onImageResult]? {
        internalQueue.sync(flags: .barrier) {
            self.blocksToInvokeOnCompletion[url]
        }
    }
    private func updateBlocks(atURL url : String , andBlocks blocks : [onImageResult]) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.blocksToInvokeOnCompletion[url] = blocks
        }
    }
    private func getOperationAtURL(url : String)->DownLoadOperation? {
        internalQueue.sync(flags: .barrier) {
            return self.operationLookup[url]
        }
    }
    private func updateOperationAtURL(url : String,operation : DownLoadOperation) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.operationLookup[url] =  operation
        }
    }
  
}
