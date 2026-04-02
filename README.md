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
    │   ├── model/
    │   │   ├── <entity_name>.dart
    │   │   ├── <model_name>_model.dart
    │   │   ├── <model_name>_model.freeze.dart
    │   │   └── <model_name>_model.g.dart
    │   │
    │   ├── repository/
    │   │   ├── <repository_name>.dart
    │   │   └── <repository_name>_imp.dart
    │   │
    │   ├── provider/
    │   │   ├── <provider>_state.dart
    │   │   ├── <provider>_state.freeze.dart
    │   │   ├── <provider>_view_model.dart
    │   │   └── <provider>_view_model.g.dart
    │   │
    │   └── ui/
    │       ├── widgets/
    │       │   └── <widget_name>.dart
    │       └── <screen_name>_screen.dart
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
