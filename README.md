# Rentify

TBD

## Table of Contents

- [Rentify](#rentify)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Project Structure](#project-structure)
  - [Run steps](#run-steps)

## Requirements

- flutter = 3.41.2
- fvm = 4.0.5

## Project Structure

This project is structured based on the offcial [Flutter package structure](https://docs.flutter.dev/app-architecture/case-study#package-structure) guidelines and uses a lightweight Clean Architecture approach to maintain clear separation of concerns, making the codebase easier to scale and maintain.

```markdown
lib/
├── ui/
│   ├── core/
│   │   └── ui/
│   │       ├── shared_widgets/
│   │       └── themes/
│   │
│   └── <feature_name>/
│       ├── view_models/
│       │   └── <view_model_class>.dart
│       │
│       └── widgets/
│           ├── <feature_name>_screen.dart
│           └── <other_widgets>
│
├── domain/
│   └── models/
│       └── <model_name>.dart
│
├── data/
│   ├── repositories/
│   │   └── <repository_class>.dart
│   │
│   ├── services/
│   │   └── <service_class>.dart
│   │
│   └── model/
│       └── <api_model_class>.dart
│
├── config/
├── utils/
├── routing/
│
├── main_staging.dart
├── main_development.dart
└── main.dart


test/                  # Contains unit and widget tests
├── data/
├── domain/
├── ui/
└── utils/


testing/               # Contains mocks used by tests
├── fakes/
└── models/
```

## Run steps

```bash
fvm flutter pub get
```

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

```bash
fvm flutter run
```
