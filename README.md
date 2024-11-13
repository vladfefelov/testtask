
# Testtask Project for ABZ Agency

## Description
The **Testtask Project** is a sample application developed in Swift using SwiftUI, created as a test task for abz.agency. The application demonstrates essential features for working with a user registration API, including:

- **User Listing**: The app loads and displays users from an API in batches of six.
- **User Registration**: It allows new users to register with essential details like name, email, phone, position, and profile photo.

The code structure follows the MVVM (Model-View-ViewModel) architectural pattern, which helps separate business logic from UI, making the code more testable and maintainable.

## Installation and Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/vladfefelov/testtask
   ```
2. Open the project in Xcode.
3. Build and run the app on a simulator or a device.

## Configuration
- **Style Settings**: All application styles can be modified in the `Styles` folder:
      - Color settings: `Colors.swift`
      - Text settings: `TextStyles.swift`
      - Button styles: `ButtonStyles.swift`

## Dependencies
There are no external dependencies or libraries in this project. All network and data-handling functionalities are implemented using native Swift frameworks, ensuring lightweight and efficient code.

## Code Structure

- **Model**: Data models used in the app.
    - `User.swift`: User model.
    - `Position.swift`: Position model.

- **ViewModel**: Manages data processing, API interactions, and states for views.
    - `UserViewModel.swift`: Manages the user listing state.
    - `SignUpViewModel.swift`: Logic for the registration screen.
    - `UserService.swift`: Handles fetching users and managing user registration API calls.
    - `PositionService.swift`: Retrieves available user positions from the API, enabling position selection during registration.
    - `NetworkMonitor.swift`: Checks network connection status to inform the app of connectivity changes.
    - `ImagePicker.swift`: Handles image selection for user profile photos during registration.

- **View**: Contains the app's UI screens.
    - `MainScreen.swift`: Main screen of the app.
    - `SignUpView.swift`: User registration screen.
    - `RegistrationSuccessView.swift`: Displays a success message after a user has successfully registered, providing a confirmation of the completed registration process.
    - `RegistrationFailedView.swift`: Error screen for registration failure.
    - `SplashScreenView.swift`: Splash screen.
    - `NoInternetView.swift`: Screen displayed when there is no internet connection.

- **View/Components**: Reusable UI components.
    - `BottomBar.swift` and `TopBar.swift`: Navigation bars.
    - `PhotoUploadButton.swift`: Button for uploading profile photos.
    - `PositionRow.swift`: Component for displaying a position.
    - `UserCardView.swift` and `UserRowView.swift`: Components for displaying user data.
    - `NoUsersView.swift`: Shown when no users are available.
    - `TopBar.swift`: A customizable top navigation bar for displaying titles or other header content in various screens.
    - `UserListView.swift`: A view that displays a list of users retrieved from the API, utilizing individual user rows for each user.
    - `UserRowView.swift`: Represents a single user's data in a compact, styled row within the user list.
    - `NoUsersView.swift`: A view displayed when no users are available or retrieved, providing a placeholder message to the user.

- **Styles**: Application-wide styles and fonts.
    - `Colors.swift`: Color palette.
    - `TextStyles.swift`: Text styles.
    - `ButtonStyles.swift`: Button styling.
    - `TextFieldStyles.swift`: Provides custom styles and configurations for text fields used throughout the app, including placeholder text, error states, and visual styling to ensure a consistent look
    - `NunitoSans-Regular.ttf`: Main font for the UI.

## Troubleshooting Tips
- **No Internet Connection**: Ensure that the device is connected to the internet. The `NoInternetView` screen will automatically appear if there is no network connectivity.

## Project Structure Overview
The app follows the MVVM architecture:
- **Model**: Represents the data structure.
- **ViewModel**: Handles business logic and data state management.
- **View**: Manages the UI and updates based on ViewModel changes.

This structure enhances code organization, maintainability, and scalability.
