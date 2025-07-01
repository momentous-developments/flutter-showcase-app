# Flutter Material3 Demo App

A comprehensive Flutter application showcasing Material Design 3 features, components, and design patterns. This demo app serves as a reference implementation for developers looking to build modern Flutter applications with Material 3.

## Live Demo

🌐 [View Live Demo](https://flutter-material3-showcase.web.app)

## Features

- **Material 3 Components**: Complete showcase of Material 3 widgets and components
- **Responsive Design**: Adaptive layouts for mobile, tablet, and desktop
- **Theme Customization**: Dynamic color themes with light/dark mode support
- **Real-world Modules**:
  - 📊 Dashboard with statistics and charts
  - 📅 Calendar with event management
  - 💬 Chat interface
  - 📧 Email client
  - 📋 Kanban board
  - 🛒 E-commerce components
  - 📚 Academy/Learning management
  - 📄 Forms with validation
  - 📊 Data tables with advanced features

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- IDE with Flutter support (VS Code, Android Studio, IntelliJ)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter-material3-demo.git
cd flutter-material3-demo
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building for Production

#### Web
```bash
flutter build web
```

#### Android
```bash
flutter build apk
# or
flutter build appbundle
```

#### iOS
```bash
flutter build ios
```

#### Desktop
```bash
flutter build macos
flutter build windows
flutter build linux
```

## Project Structure

```
lib/
├── app.dart                 # Main app configuration
├── main.dart               # Entry point
├── core/                   # Core functionality
│   ├── constants/         # App constants
│   ├── layouts/          # Layout templates
│   ├── navigation/       # Navigation setup
│   ├── router/          # Routing configuration
│   ├── theme/           # Theme definitions
│   └── widgets/         # Core widgets
├── components/            # Reusable UI components
│   ├── cards/           # Card components
│   ├── charts/          # Chart components
│   ├── dialogs/         # Dialog components
│   ├── forms/           # Form components
│   ├── inputs/          # Input components
│   ├── navigation/      # Navigation components
│   └── tables/          # Table components
├── features/             # Feature modules
│   ├── dashboard/       # Dashboard feature
│   ├── calendar/        # Calendar feature
│   ├── chat/           # Chat feature
│   ├── email/          # Email feature
│   ├── kanban/         # Kanban board
│   ├── ecommerce/      # E-commerce components
│   └── ...             # Other features
└── modules/             # Business modules
    ├── academy/        # Learning management
    ├── analytics/      # Analytics dashboard
    └── ...            # Other modules
```

## Material 3 Features

### Theme System
- Dynamic color generation from seed colors
- Support for light and dark themes
- Material You design principles

### Components Showcase
- Buttons (Filled, Outlined, Text, Icon)
- Cards with various layouts
- Navigation (Rail, Drawer, Bottom Navigation)
- Input fields with Material 3 styling
- Dialogs and bottom sheets
- Data tables with sorting and filtering
- Charts and visualizations

### Responsive Design
- Adaptive layouts based on screen size
- Navigation rail for larger screens
- Bottom navigation for mobile
- Flexible grid systems

## Firebase Deployment

The app is configured for Firebase hosting. To deploy:

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Deploy:
```bash
firebase deploy --only hosting
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for Material 3 specifications
- Community contributors