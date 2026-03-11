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

```markdown
lib/
└── features/
    ├── <features_name>/
    │   ├── domain/
    │   │   └── entites/
    │   │       └── <entity_name>.dart
    │   │
    │   ├── data/
    │   │   ├── repositories/
    │   │   │   └── <repository_name>.dart
    │   │   │
    │   │   └── models/
    │   │       └── <model_name>.dart
    │   │
    │   └── ui/
    │       ├── widgets/
    │       │   └── <widget_name>.dart
    │       │
    │       └── <screen_name>/
    │           ├── states/
    │           │   └── <state_name>_state.dart
    │           │
    │           ├── view_models/
    │           │   └── <view_model_name>_view_model.dart
    │           │
    │           └── <screen_name>_screen.dart
    │
    ├── configs
    ├── utils
    ├── routing
    ├── constants
    ├── localization
    ├── common_widgets
    └── extensions
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
