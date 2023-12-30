# Input Form Field plugin for Flutter

This input form is a wrapper around default TextFormField widget. It is supported by all platforms flutter supports.

## Breaking: (0.0.6)
* **BREAKING** - `InputFormFieldConfig` singleton class has been introduced. Styling will be handled by `InputFormFieldConfig` class.
* **BREAKING** - `borderColor``fillColor``height``bottomMargin``labelTextStyle``labelErrorTextStyle``style``errorTextStyle``hintTextStyle``contentPadding``borderRadius``errorPadding``borderType``errorColor``obscuringCharacter` parameter from `InputFormField` has been removed and placed these to `InputFormFieldConfig`.
* **BREAKING** - `readOnly` feature has been added.
* **BREAKING** - TextCentre alignment issue has been solved.
* **BREAKING** - Assets address issue has been resolved

## Feature: 
- Styling configurations no longer need to be declared individually.
- Label text doesn't overlap with Border 
- Default isNullOrEmpty validation support 
- Supports bottom margin 
- Dynamic height support 
- Easy password visibility 
- Theme support 
- All platform support

## Installing
Install the latest version from [pub](https://pub.dev/packages/input_form_field/install)

## Usage
Now in your Dart code, you can use:
```
import 'package:input_form_field/input_form_field.dart';
```

## Example

Custom style need to be set at `InputFormFieldConfig`
```
InputFormFieldConfig inputFormFieldConfig = InputFormFieldConfig(
    setBottomMargin: 10,
    setBorderType: BorderType.outlined,
);

```
Added default style for all kind of input form field.

Simple usage's of InputFormField:
```
            /// Basic
              InputFormField(
                textEditingController: _controller,
              ),

              /// Custom Top Label
              InputFormField(
                textEditingController: _controller,
                label: const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Custom Label"),
                ),
              ),

              /// Standard - Outlined Border
              InputFormField(
                textEditingController: _controller,
                labelText: "Standard - Outlined Border",
                hintText: "Hint Text",
              ),

              /// No Border - Filled
              InputFormField(
                textEditingController: _controller,
                labelText: "No Border - Filled",
                hintText: "Hint Text",
              ),

              /// Default Password Field
              InputFormField(
                textEditingController: _controller,
                labelText: "Default Password",
                hintText: "*****",
                password: EnabledPassword(),
              ),

              /// Customize Default Password Field
              InputFormField(
                textEditingController: _controller,
                labelText: "Custom Default Password",
                hintText: "*****",
                password: EnabledPassword(
                  showPasswordIcon: const Icon(
                    Icons.add,
                    color: Colors.amber,
                  ),
                  hidePasswordIcon: const Icon(
                    Icons.visibility_off_sharp,
                    color: Colors.amber,
                  ),
                ),
              ),

              /// Custom (Suffix)
              InputFormField(
                textEditingController: _controller,
                prefix: const Icon(Icons.mail),
                labelText: "Email",
                hintText: "abc@email.com",
              ),

              /// Custom (Suffix, Prefix)
              InputFormField(
                textEditingController: _controller,
                prefix: const Icon(Icons.mail),
                labelText: "Email",
                hintText: "abc@email.com",
                suffix: const Icon(Icons.info),
              ),
```
## Screenshot
![Screenshot](/assets/demo.png)

## Want to contribute:
Leave a star if this was helpful [Github Repository](https://github.com/dinurymomshad/input_form_field)