# flutter_easy_popup
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html) [![pub package](https://img.shields.io/pub/v/easy_popup.svg)](https://pub.dartlang.org/packages/easy_popup)

An easy way to show a flutter custom popup widget.

## Screenshot

| Example | Screenshot |
| :------: | :------: |
| [Dropdown Menu](https://github.com/BakerJQ/flutter_easy_popup/blob/master/example/lib/drop_down_menu.dart) | ![](https://raw.githubusercontent.com/BakerJQ/flutter_easy_popup/master/screenshot/dropdown.gif) |
| [App Operation Guide](https://github.com/BakerJQ/flutter_easy_popup/blob/master/example/lib/guide_popup.dart) | ![](https://raw.githubusercontent.com/BakerJQ/flutter_easy_popup/master/screenshot/guide.gif) |
| [Multi Highlights](https://github.com/BakerJQ/flutter_easy_popup/blob/master/example/lib/home_page.dart) | ![](https://raw.githubusercontent.com/BakerJQ/flutter_easy_popup/master/screenshot/multi_highlights.gif) |
| [Loading](https://github.com/BakerJQ/flutter_easy_popup/blob/master/example/lib/loading.dart) |![](https://raw.githubusercontent.com/BakerJQ/flutter_easy_popup/master/screenshot/loading.gif) |

## Example
You can run example by commands below.
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

## Usage

### Define Custom Popup Widget
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

### Call Show
Call *EasyPopup.show()* to show your widget as a popup.
```dart
EasyPopup.show(context, CustomWidget());
```

### Call pop
Call *EasyPopup.pop()* to dismiss the popup.
```dart
EasyPopup.pop(context);
```

### Params
| Param | Desc |
| :------: | :------: |
| context | BuildContext |
| child | Your popup widget |
| offsetLT | Left and Top offset of the dark background |
| offsetRB | Right and Bottom offset of the dark background |
| cancelable | Whether the popup can be dismissed by pressing back button on Android |
| outsideTouchCancelable | Whether the popup can be dismissed by touch the outside area |
| darkEnable | Whether to show the dark background |
| duration | Duration to show the animation |
| highlights | Rects to show highlight area |


