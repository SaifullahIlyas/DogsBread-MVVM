# DogsBread-MVVM
The idea of the project is to expose Dogs API to make a sample app based on Clean Architecture Paradigms. 
# Implementation
* Dog Breead API Integration for bread list, bread images
* Architecture  implemented is   MVVM-RC(Router components).combine is used for MVVM data data binding
* Thread-safe cached base ImageDownloader is implemented based on top of operation queue to improve app performance and to reduce battery Consumption. Currently this downloader support memory cache only
* DispatchGroup Base network layer(only get). 
* Some other design patterns implemented are singleton internal, facade exposable, and decorator.
* Some heavily used programming paradimes are OOP(Object Oriented programming , FP(Functional Programming) and POP(Protocols Oriented Programming)

# Tested Environment
  The implemented solution is tested on iOS 14.5 and the source code was compiled with Xcode 12.5. Maybe some issues will encounter on iOS 15(like navigation bar  styling)
# Framework Used
* Cocoa Touch
* Combine 
* GCD
# Pods/Packages Used 
no third party framework is used to demonstrate this project 

# Future Improvements  
* To add disk base cache to image downloader . currently it is is supporting only memory cache .
* To add more exposeable method to imagedownloaded like sdwebimage is doing
* Project currently support horizontal layering architecture . Can be break into vertical or multi modular architecture. 

# Outputs
 <img src="https://github.com/SaifullahIlyas/DogsBread-MVVM/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20Max%20-%202022-02-13%20at%2018.59.28.png" width="250"> <img src="https://github.com/SaifullahIlyas/DogsBread-MVVM/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20Max%20-%202022-02-13%20at%2018.59.33.png" width="250"> <img src="https://github.com/SaifullahIlyas/DogsBread-MVVM/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20Max%20-%202022-02-13%20at%2018.59.42.png" width="250"> <img src="https://github.com/SaifullahIlyas/DogsBread-MVVM/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20Max%20-%202022-02-13%20at%2018.59.39.png" width="250">


