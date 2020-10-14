# flutter_easy_popup
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)

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

