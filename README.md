# MarvelUniverse
iOS project implemented to explore marvel characters with their details. Application built with clean layered architecture and MVVM.  

![Alt text](ReadMeResources/CleanArchitecture+MVVM.png?raw=true "Clean Architecture Layers")

## Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network)
* **Presentation Layer (MVVM)** = ViewModels + Views

### Dependency Direction
![Alt text](ReadMeResources/CleanArchitectureDependencies.png?raw=true "Modules Dependencies")

## Architecture concepts used here
* [Clean Architecture](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)
* [MVVM](MarvelUniverse/Presentation/CharacterList) 
* Data Binding using [Observable](MarvelUniverse/Presentation/Utils/Observable.swift) without 3rd party libraries 
* [Dependency Injection](MarvelUniverse/Application/DIContainers/AppDIContainer.swift)
* [Flow Coordinator](MarvelUniverse/Presentation/FlowCoordinator/MarvelUniverseFlowCoordinator.swift)
* [Data Transfer Object (DTO)](MarvelUniverse/Data/Network/DataMapping/MarvelCharacterResposnseDTO+Mapping.swift)
* [UIKit view](MarvelUniverse/Presentation/CharacterList/View/CharacterListViewController.swift) implementations by [ViewModel](MarvelUniverse/Presentation/CharacterList/ViewModel/CharacterListViewModel.swift) (at least Xcode 11 required)
* Error handling examples: in [ViewModel](MarvelUniverse/Presentation/CharacterList/ViewModel/CharacterListViewModel.swift), in [Networking](MarvelUniverse/Infrastructure/Network/NetworkService.swift)
 
## Includes
* Unit Tests for Use Cases(Domain Layer), ViewModels(Presentation Layer), NetworkService(Infrastructure Layer)
* Size Classes and UIStackView in Detail view
* Pagination

## Networking
For networking, [Alamofire](https://github.com/Alamofire/Alamofire.git) dependancy integrated by Swift Package Manager.  


## Requirements
* Xcode Version 12.4+  Swift 5.0+

# How to use app
Launch the application to explore marvel characters in the list format. There is one network call for marvel character list. On successful request respective data gets updated on screen. By clicking on any character you can able to see details about selected character. 
