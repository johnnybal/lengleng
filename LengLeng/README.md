# LengLeng iOS App

This directory contains the main iOS application code for LengLeng, a social networking and polling app built with SwiftUI and Firebase.

## Development Setup

### Prerequisites

- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9+
- Firebase account and configuration
- Apple Developer Account (for device builds)

### Project Structure

```
LengLeng/
├── Features/           # Feature-specific modules
│   ├── Authentication/
│   ├── Profile/
│   ├── Polls/
│   ├── Messaging/
│   └── Notifications/
├── Services/          # Firebase and other service integrations
├── Models/            # Data models
├── Views/             # UI components
└── Resources/         # Assets and configuration files
```

### Building the App

The project supports multiple environments and build configurations:

#### Environments
- `development`: For development and testing
- `staging`: For beta testing and internal distribution
- `production`: For App Store distribution

#### Build Commands

1. Make the build script executable:
   ```bash
   chmod +x scripts/build.sh
   ```

2. Build for development:
   ```bash
   ./scripts/build.sh development
   ```

3. Build for staging:
   ```bash
   ./scripts/build.sh staging
   ```

4. Build for production:
   ```bash
   ./scripts/build.sh production
   ```

### Testing

1. Run unit tests:
   ```bash
   xcodebuild test -scheme LengLeng -destination 'platform=iOS Simulator,name=iPhone 15'
   ```

2. Run UI tests:
   ```bash
   xcodebuild test -scheme LengLengUITests -destination 'platform=iOS Simulator,name=iPhone 15'
   ```

## Development Guidelines

1. Follow SwiftUI best practices
2. Use SwiftLint for code style consistency
3. Write unit tests for new features
4. Document public interfaces
5. Follow the project's architecture patterns

## Troubleshooting

Common issues and solutions:

1. **Firebase Configuration**
   - Ensure `GoogleService-Info.plist` is properly added to the project
   - Verify Firebase dependencies are up to date

2. **Build Issues**
   - Clean build folder: `Cmd + Shift + K`
   - Reset package caches: `File > Packages > Reset Package Caches`

3. **Simulator Issues**
   - Reset simulator: `Device > Erase All Content and Settings`
   - Check simulator logs for detailed error information

## Related Resources

- [Main Project README](../README.md)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Firebase iOS SDK](https://firebase.google.com/docs/ios/setup) 