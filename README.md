# flutter_easy_popup
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html) [![pub package](https://img.shields.io/pub/v/easy_popup.svg)](https://pub.dartlang.org/packages/easy_popup)

An easy way to show a flutter custom popup widget.

## Example
```
cd ./example
flutter create .
flutter run
```

## How to use
### Add dependencies
```yaml
dependencies:
  easy_popup: ^1.0.0
```
or
```yaml
dependencies:
  easy_popup: 
    git: https://github.com/BakerJQ/flutter_easy_popup.git
```

### 1. Define custom popup widget with Mixin *EasyPopupChild*
Define your custom popup widget with *EasyPopupChild*, and implement *dismiss* function which does work that need to be done while dismiss, eg. show dismiss animation
```dart
class CustomWidget extends StatefulWidget with EasyPopupChild {

  ...

  @override
  dismiss() {
    ...
  }
}
```

### 2. Call show function
```dart
EasyPopup.show(context, CustomWidget());
```

