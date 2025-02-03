# Taski To-Do App

Taski To-Do is a simple task management app developed in Flutter. It allows users to create, edit, mark as completed, and delete tasks. The app uses **Hive** for local storage, **MobX** for state management, and **Modular** for route management and dependency injection.

## How to Run the Project


```bash
git clone https://github.com/brunonortlieb/taski_to_do
```

```bash
cd taski_to_do
```

```bash
flutter pub get
```

```bash
flutter run
```

---

## Project Structure

```
lib/
├── core/ 
│   ├── constants/
│   ├── entities/
│   ├── extensions/
│   ├── failures/
│   ├── theme/
│   ├── utils/
│   └── validators/
├── data/
│   ├── models/
│   └── repositories/
├── modules/ 
│   └── home/
│       ├── stores/
│       ├── views/
│       └── widgets/
├── app_module.dart 
├── app_widget.dart 
└── main.dart
```

---

##  Main Dependencies

- **Flutter Modular**: For dependency injection and route management.
- **MobX**: For reactive state management.
- **Hive**: For local data storage.
- **Mocktail**: For unit and widget testing.

For a full list of dependencies, check the `pubspec.yaml` file.

---

##  Contact

- **Name**: Bruno Nunes Ortlieb
- **Email**: bruno.10nuness@gmail.com
- **GitHub**: https://github.com/brunonortlieb

---