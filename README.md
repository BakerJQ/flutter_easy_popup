# flutter_easy_popup
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html) [![pub package](https://img.shields.io/pub/v/easy_popup.svg)](https://pub.dartlang.org/packages/easy_popup)

An easy way to show a flutter custom popup widget.

## Screenshot
| Android | iOS |
| :------: | :------: |
| ![](https://raw.githubusercontent.com/BakerJQ/flutter_easy_popup/master/screenshot/android.gif) |
![](https://raw.githubusercontent.com/BakerJQ/flutter_easy_popup/master/screenshot/iOS.gif) |

## Example
```
cd ./example
flutter create .
flutter run
```

## Getting Started

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

## Define Custom Popup Widget
Define your custom popup widget with *EasyPopupChild*, and implement *dismiss* function which does work that need to be done while dismiss, eg. show dismiss animation.
```dart
class CustomWidget extends StatefulWidget with EasyPopupChild {

  ...

  @override
  dismiss() {
    ...
  }
}
```

## Call Show
Call *EasyPopup.show()* to show your widget as a popup.
```dart
EasyPopup.show(context, CustomWidget());
```

