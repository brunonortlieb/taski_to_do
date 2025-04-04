# Taski To-Do App
Taski To-Do is a task management app built with Flutter to showcase clean architecture and different state management approaches. Users can choose between MobX and BLoC when running the app.

## Technologies Used
### Architecture & Patterns
* **Clean Architecture :** Separation of concerns into `presentation`, `domain`, and `data` layers.  
* **SOLID Principles :** Follows best practices for maintainability and scalability
* **Dependency Injection :** Uses `auto_injector` for efficient dependency management.
### State Management
* **MobX :** Reactive state management for simplicity and efficiency.
* **BloC :** Scalable architecture for better state and data flow management.
### Testing
* **Unit Tests :** Business logic validation through unit tests.
* **Widget Tests :** UI interaction and rendering validation.
* **Mocktail :** Dependency mocking for isolated testing.
### Other Tools
* **Offline Database :** `Hive` for local data storage.
* **CI/CD:** Automated builds and tests using `GitHub Actions`

For a full list of dependencies, check the `pubspec.yaml` file.

## How to Run the Project
1. Clone the repository:
```bash
git clone https://github.com/brunonortlieb/taski_to_do
cd taski_to_do
```
2. Install dependencies:
```bash
flutter pub get
```
3. Choose the state management approach:
Run the app specifying the entry point for your preferred state management approach:
* **MobX:**
```bash
flutter run -t lib/main_mobx.dart
```
* **BloC:**
```bash
flutter run -t lib/main_bloc.dart
```

## Project Structure
```
lib/
├── core/
│   ├── constants/           # Global constants  
│   ├── di/                  # Dependency injection setup  
│   ├── exceptions/          # Custom exceptions  
│   ├── extensions/          # Utility extensions 
│   ├── routes/              # App navigation setup 
│   ├── theme/               # Global styling and themes  
│   └── validators/          # Input validation logic    
├── data/  
│   ├── datasources/         # External data sources (local DB) 
│   ├── models/              # Data models (DTOs)  
│   └── repositories/        # Implementation of domain repositories 
├── domain/  
│   ├── entities/            # Business entities (core app models)  
│   └── repositories/        # Abstract repository interfaces
├── presentation/
│   ├── mobx/                # MobX-based state management  
│   ├── bloc/                # BLoC-based state management  
│   ├── widgets/             # Reusable UI components  
│   └── pages/               # UI pages
├── app.dart                 # Main app widget  
├── main_bloc.dart           # App entry point (BLoC)
└── main_mobx.dart           # App entry point (MobX)
```
##  Running Tests
To execute tests, run:
```bash
flutter test
```
The test suite covers:
* Widget rendering and UI interactions.
* Business logic and state management.
* User interaction validations.

##  Contact
- **Bruno Nunes Ortlieb**  
- **Email**: [bruno.10nuness@gmail.com](mailto:bruno.10nuness@gmail.com)  
- **GitHub**: [brunonortlieb](https://github.com/brunonortlieb)
- **Linkedin**: [bruno10nuness](https://www.linkedin.com/in/bruno10nuness/)