# LengLeng

A social networking and polling app built with SwiftUI and Firebase.

## Features

- User authentication and profile management
- Social networking and user interactions
- Real-time polling system
- Push notifications
- Real-time messaging
- Admin panel for content moderation

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- Firebase account and configuration

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/johnnybal/lengleng.git
   cd lengleng
   ```

2. Install dependencies:
   ```bash
   swift package resolve
   ```

3. Open the project in Xcode:
   ```bash
   open LengLeng.xcodeproj
   ```

## Configuration

1. Add your Firebase configuration:
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Download `GoogleService-Info.plist`
   - Add it to the `LengLeng` directory in Xcode

2. Update project settings:
   - Open Xcode project settings
   - Update the bundle identifier to match your Firebase configuration
   - Configure your development team
   - Set the deployment target to iOS 17.0

3. Build and run:
   - Select your target device (simulator or physical device)
   - Choose the appropriate scheme (development, staging, or production)
   - Build and run the project

## Project Structure

- `LengLeng/`: Main iOS application code
  - `Features/`: Feature-specific modules
  - `Services/`: Firebase and other service integrations
  - `Models/`: Data models
  - `Views/`: UI components
- `admin-panel/`: Web-based admin interface
- `documentation/`: Project documentation
- `Tests/`: Unit and UI tests

## Documentation

Detailed documentation is available in the `documentation/` directory:
- `onboarding-flow.md`: User onboarding process
- `user-model.md`: User model documentation
- Additional feature-specific documentation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
