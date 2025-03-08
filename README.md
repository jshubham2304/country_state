# Flutter Countries & States App

A Flutter application with clean architecture that displays a list of countries and their associated states using multiple API endpoints with fallback capabilities.

## Features

- Displays dropdowns for countries and states selection
- Implements primary and backup API sources for reliability
- Works across all platforms (Mobile, Web, Desktop)
- Clean Architecture implementation with BLoC pattern (Cubit)
- Comprehensive error handling and connectivity checks
- Well-structured codebase with separation of concerns
- Complete test coverage

## Architecture

This project follows the principles of Clean Architecture with a focus on separation of concerns, testability, and maintainability.

### Layers

1. **Domain Layer**

   - Business logic and use cases
   - Repository interfaces
   - Entity models

2. **Data Layer**

   - API implementations
   - Repository implementations
   - Data models

3. **Presentation Layer**

   - UI components
   - Cubits for state management
   - Pages and widgets

4. **Core Layer**
   - Shared utilities
   - Error handling
   - Dependency injection

### Data Flow

The app uses multiple data sources with fallback capabilities:

1. **Primary API** (`https://api.stagingcupid.com/api/v1`)

   - Provides countries and states data
   - Requires specific headers for authentication

2. **Backup API** (`https://country-state-city-search-rest-api.p.rapidapi.com`)
   - Provides alternative data when primary API fails
   - Uses RapidAPI key for authentication

### State Management

The app uses the Cubit pattern from the flutter_bloc package for state management. This provides:

- Predictable state management
- Easy testing
- Separation of UI and business logic
- Handling of loading, success, and error states

## Setup & Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/flutter_countries_states.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Generate code (for Freezed models, JSON serialization, etc.):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run tests:

```bash
flutter test
```

5. Run the app:

```bash
flutter run
```

## API Integration

### Primary API

- Base URL: `https://api.stagingcupid.com/api/v1`
- Endpoints:
  - GET `/countries` - Get all countries
  - GET `/countries/{countryId}/states` - Get states for a specific country
- Required Headers:
  - `X-API-Key`: `XXXXX`
  - `User-Agent`: `com.stagingcupid.api/10.16.6 (Release) Android/31`

### Backup API (RapidAPI)

- Base URL: `https://country-state-city-search-rest-api.p.rapidapi.com`
- Endpoints:
  - GET `/allcountries` - Get all countries
  - GET `/states-by-countrycode?countrycode={code}` - Get states by country code
- Required Headers:
  - `x-rapidapi-host`: `country-state-city-search-rest-api.p.rapidapi.com`
  - `x-rapidapi-key`: `XXXXX`

## Project Structure

```
lib/
├── app/                       # Presentation layer
│   ├── pages/                 # App screens
│   │   └── location/          # Location selection screen
│   │       ├── cubit/         # State management
│   │       └── location_view.dart
│   └── widgets/               # Reusable UI components
│       └── location_dropdown.dart
│
├── core/                      # Core utilities
│   ├── constants/             # App constants
│   ├── di/                    # Dependency injection
│   │   └── injection_container.dart
│   └── error/                 # Error handling
│       ├── exceptions.dart
│       └── failures.dart
│
├── data/                      # Data layer
│   ├── constants/             # API constants
│   │   ├── api_constants.dart
│   │   └── backup_api_constants.dart
│   ├── models/                # Data models
│   │   └── location_model.dart
│   └── repositories/          # Repository implementations
│       ├── backup_repository_impl.dart
│       ├── location_backup_datasource.dart
│       ├── location_remote_datasource.dart
│       └── location_repository_impl.dart
│
├── device/                    # Device-specific functionality
│   └── repositories/          # Device repositories
│       └── network_info.dart
│
├── domain/                    # Domain layer
│   ├── entities/              # Business entities
│   │   └── location_entity.dart
│   ├── repositories/          # Repository interfaces
│   │   ├── backup_repository.dart
│   │   └── location_repository.dart
│   └── usecases/              # Business use cases
│       ├── get_countries_usecase.dart
│       └── get_states_usecase.dart
│
└── main.dart                  # Application entry point
```

## Testing

The app includes comprehensive tests:

- **Unit Tests**: Testing individual classes and functions
- **Widget Tests**: Testing UI components in isolation
- **Integration Tests**: Testing the interaction between components

Run the tests with:

```bash
flutter test
```

## Dependencies

- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **http**: API communication
- **dartz**: Functional programming utilities
- **equatable**: Value equality
- **freezed**: Immutable classes
- **internet_connection_checker**: Network connectivity detection

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
