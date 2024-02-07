# AssetsInserter

AssetsInserter is a command-line tool for automatically inserting asset paths into Flutter code by using templates.

## Installation

You can install AssetsInserter globally using the following command:

```bash
flutter pub global activate assets_inserter
```

## Usage
To use AssetsInserter, navigate to the root directory of your Flutter project and run the following command:

```bash
dart assets_inserter.dart:replace
```

This command will recursively search for Dart files in the lib directory of your project, find asset path strings matching a specified pattern (e.g., ["assets/images/pic[000:002].png"]), and replace them with arrays of image paths. The script supports leading zeros in the range specified within the square brackets.

## Example

From
```dart
class MyApp {
  final List<String> images = ["assets/images/pic[00:2].png"];
  final String path = "assets/images/logo.png";
}

```

To
```dart
class MyApp {
  final List<String> images = [
    "assets/images/pic00.png",
    "assets/images/pic01.png",
    "assets/images/pic02.png"
  ];
  final String path = "assets/images/logo.png";
}
```

From
```dart
class MyApp {
  final List<String> images = ["assets/images/pic[0:2].png"];
  final String path = "assets/images/logo.png";
}

```

