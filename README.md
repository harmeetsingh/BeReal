#  Explanation

Welcome! 

### Design 

I decided to implement the project with Model-View-ViewModel architecture with the Coordinator pattern to manage the navigation. I've used this approach in other projects (Deutsche Bank) which have UIKit, but this is the first time I've used this with SwiftUI. 

I decided to use SwiftUI instead of UIKit as it works well for this exercise and helps build things quickly and declaratively. I've decided to use async/await as it's modern compared to the Swift Result<T, Error> type and fit's in nicely with SwiftUI.

- AppCoordinator: The purpose of this is to contain all the dependencies and easily create Coordinators which provide the View and it's ViewModel.

The general approach of data flow is below:

- View (1) -> ViewModel (2) -> Repository (3) -> NetworkSession (4)

1. View appears and calls the view model.
2. ViewModel calls the Repository layer and fetches some data
3. Repository encapsulates the dependencies e.g. Network for now but this can be files, databases, web connections. The aim is to abstract and decouple the dependencies away in the Repository. Repository will fetch some data from the Network layer.
4. NetworkSession accepts a Request, which is used to fetch data and return it. Request is a protocol.

- View (4) <- ViewModel (3) <- Repository (2) <- NetworkSession (1)

1. NetworkSession decodes the data and returns a model or error.
2. Repository forwards the model or error.
3. ViewModel will update it's viewState property to either loaded or failed. The viewState change will publish to the View.
4. View reacts to the published change and recreates the body.

### Features

- Login: I decided to implement the LoginView as the root view because the following views; DirectoryView and ImageDetailsView depend on user credentials so it's worth blocking the journey with LoginView. This approach enables me to fetch the credentials early and ensure the API calls will not fail due to authentication later. I would usually persist the credentials in the Keychain but decided it's not necessary for this exercise. 
- Navigation: I implemented the folder navigation functionality with DirectoryView. This view will show the folders and it's contents and if the user selects a folder it will create another DirectoryView with the selected model.
- Image: I implemented the image functionality with ImageDetailsView. This will fetch the image and show it in the view. It's a very straight forward View.

### Tests 

I've implemented unit tests for the NetworkSession, Repository and ViewModel layer. 
I've not added a unit test for ImageDetailsViewModel or any of the Coordinators (LoginCoordinator, DirectoryCoorindator, ImageDetailsCoordinator) becuase there are enough tests to demonstrate my approach and decision-making. I would have all these areas tested in a production app. 

### Misc

TODOs - I've left these in the project for areas which I would improve if I had more time. 
