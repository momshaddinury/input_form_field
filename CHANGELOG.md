## 0.0.5
* Screenshots fixed
* Custom Label added

## 0.0.4

* **BREAKING** - `disabledBorder` param removed. It's now handled by `BorderType.none`
* **BREAKING** - Default 56px heigth removed, supports dynamic height.
* **BREAKING** - `isPasswordField` removed. `Password` added. Supports customizing the default show/hide icon for visibility.
* **FIX** - Show/Hide password UI logic fixed
* `obscuringCharacter` support added.
* `BorderType` introduced. Supports `outlined`, `bottom` and `none`.
* Added support for `bottomMargin`. No need to wrap `InputFormField` with  `padding` / using `SizedBox` in between text fields to give bttom margin.
* `disableDefaultValidation` changed to `enableDefaultValidation`

## 0.0.3

* Closes [Need a parameter or design update to make the Label centered when it's not focused
](https://github.com/dinurymomshad/input_form_field/issues/4)
* Closes [Need textStyle to change input textStyle
](https://github.com/dinurymomshad/input_form_field/issues/3)
* Readme file updated

## 0.0.2

* Example added.
* Default text field height changed to 56, if null.

## 0.0.1

* Initial release
