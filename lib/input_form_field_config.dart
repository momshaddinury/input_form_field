import 'package:flutter/material.dart';

enum BorderType { outlined, bottom, none }

class InputFormFieldConfig {
  static final InputFormFieldConfig _instance =
      InputFormFieldConfig._internal();

  InputFormFieldConfig._internal();

  factory InputFormFieldConfig({
    Color? setBorderColor,
    Color? setFillColor,
    double? setHeight,
    double? setBottomMargin,
    TextStyle? setLabelTextStyle,
    TextStyle? setLabelErrorTextStyle,
    TextStyle? setStyle,
    TextStyle? setErrorTextStyle,
    TextStyle? setHintTextStyle,
    EdgeInsetsGeometry? setContentPadding,
    BorderRadiusGeometry? setBorderRadius,
    EdgeInsetsGeometry? setErrorPadding,
    BorderType? setBorderType,
    Color? setErrorColor,
    String? setObscuringCharacter,
  }) {
    _instance.borderColor = setBorderColor ?? const Color(0xFFCDD1D0);
    _instance.fillColor = setFillColor ?? Colors.white;
    _instance.height = setHeight ?? 60;
    _instance.bottomMargin = setBottomMargin ?? 30;
    _instance.labelTextStyle = setLabelTextStyle ??
        const TextStyle(
          color: Color(0xFF24786D),
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'Lato',
        );
    _instance.labelErrorTextStyle = setLabelErrorTextStyle ??
        const TextStyle(
          color: Color(0xFFFF2D1B),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Lato',
        );
    _instance.style = setStyle ??
        const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Lato',
        );
    _instance.errorTextStyle = setErrorTextStyle ??
        const TextStyle(
          color: Color(0xFFFF2D1B),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Lato',
        );
    _instance.hintTextStyle =
        setHintTextStyle ?? const TextStyle(color: Colors.grey);
    _instance.contentPadding = setContentPadding ??
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        );
    _instance.borderRadius = setBorderRadius ?? BorderRadius.circular(8);
    _instance.errorPadding = setErrorPadding ??
        const EdgeInsets.only(
          left: 10.0,
          top: 5,
        );
    _instance.borderType = setBorderType ?? BorderType.outlined;
    _instance.errorColor = setErrorColor ?? Colors.red;
    _instance.obscuringCharacter = setObscuringCharacter ?? '.';
    return _instance;
  }

  /// Border color of the input field, Defaults to Color(0xFFCDD1D0)
  Color? borderColor;

  /// The color for the container background, Defaults to Color.white
  Color? fillColor;

  /// Height of the input field, , Defaults to 60
  double? height;

  /// Bottom margin for the input field, , Defaults to 30
  double? bottomMargin;

  /// If null, defaults to a value derived from the base TextStyle for the input
  /// field and the current Theme.
  TextStyle? labelTextStyle;

  /// WARNING: This is custom text style for the error widget
  TextStyle? labelErrorTextStyle;

  /// The style to use for the text being edited.
  TextStyle? style;

  /// WARNING: This is custom text style for error widget
  TextStyle? errorTextStyle;

  /// If null, defaults to a value derived from the base TextStyle for the input
  /// field and the current Theme.
  TextStyle? hintTextStyle;

  /// The padding for the input decoration's container. Defaults to 10px horizontally
  /// and 10px vertically
  EdgeInsetsGeometry? contentPadding;

  /// Default border radius is 8px
  BorderRadiusGeometry? borderRadius;

  /// The padding for the input error text, defaults to 10px from left and
  /// 5px from top
  EdgeInsetsGeometry? errorPadding;

  /// Determines the border type. Border can be [BorderType.outlined] or
  /// [BorderType.bottom] or [BorderType.none].
  ///
  /// Defaults to [BorderType.outlined].
  /// If you want to disable border use [BorderType.none]
  BorderType? borderType;

  /// The color for the error, applies to everywhere that reacts to input
  /// validation error
  Color? errorColor;

  /// Default '•'.
  String? obscuringCharacter;
}
