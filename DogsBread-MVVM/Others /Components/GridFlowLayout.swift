//
//  GridFlowLayout.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 13/02/2022.
//

import UIKit

class GridFlowLayout : UICollectionViewFlowLayout {
    private var numberOfColumns : Int = 1
    private var horizonatalSpacing : Int = 0
    private var verticalSpacing : Int = 0
    override init() {
        super.init()
        
        
    }
    init(numberOfColumns : Int = 1,horizonatalSpacing : Int = 0 ,verticalSpacing : Int = 0) {
        super.init()
        self.numberOfColumns = numberOfColumns
        self.horizonatalSpacing = horizonatalSpacing
        self.verticalSpacing = verticalSpacing
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func prepare() {
            super.prepare()

            guard let collectionView = collectionView,
                collectionView.numberOfSections != 0 else { return }
        
        minimumInteritemSpacing = CGFloat(horizonatalSpacing)
           // itemSize = CGSize(width: 30, height: 30)

            sectionInsetReference = .fromSafeArea


        let totalCellWidth = (collectionView.frame.size.width/CGFloat(numberOfColumns)) - CGFloat(numberOfColumns * horizonatalSpacing)
        itemSize = CGSize(width: totalCellWidth, height: totalCellWidth)
//            let totalSpacingWidth = minimumInteritemSpacing * CGFloat(n - 1)
//
//            let leftInset = (collectionView.bounds.maxX - CGFloat(totalCellWidth + totalSpacingWidth)) / 2

        sectionInset = UIEdgeInsets(top: 0, left: CGFloat(0), bottom: 0, right: CGFloat(0))
        }
}
