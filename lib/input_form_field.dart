/// Author: Momshad Dinury
/// Github: @dinurymomshad
/// Date: 06/09/2022
///
/// Use of this source code is governed by a BSD-style license that can be
/// found in the LICENSE file.

library input_form_field;

import 'package:flutter/material.dart';

/// Input form field
///
/// A [StatefulWidget] that contains a [TextFormField]. A convinient widget aiming
/// to simplify complexitiy of default [TextFormField] widget.

class InputFormField extends StatefulWidget {
  InputFormField({
    Key? key,
    required this.textEditingController,
    this.style,
    this.hintText,
    this.hintTextStyle,
    this.label,
    this.labelText,
    this.labelTextStyle,
    this.errorTextStyle,
    this.floatingLabelBehavior,
    this.suffix,
    this.prefix,
    this.password,
    this.obscureText,
    this.obscuringCharacter = '•',
    this.validator,
    this.enableDefaultValidation = false,
    this.height,
    this.contentPadding,
    this.errorPadding,
    this.bottomMargin,
    this.borderType = BorderType.outlined,
    this.borderRadius,
    this.borderColor = Colors.blue,
    this.fillColor,
    this.errorColor = Colors.red,
  })  : assert(obscuringCharacter.isNotNull && obscuringCharacter.length == 1),
        assert(
          !(password.isNotNull && obscureText.isNotNull),
          """Both can't be used at the same time. Use isPasswordTrue to handle password visibility internally. To handle externally use obscureText""",
        ),
        super(key: key);

  final TextEditingController textEditingController;

  /// The style to use for the text being edited.
  final TextStyle? style;

  final Widget? label;

  /// Optional text that describes the input field.
  final String? labelText;

  /// If null, defaults to a value derived from the base TextStyle for the input
  /// field and the current Theme.
  final TextStyle? labelTextStyle;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// If null, defaults to a value derived from the base TextStyle for the input
  /// field and the current Theme.
  final TextStyle? hintTextStyle;

  /// WARNING: This is custom text style for error widget
  final TextStyle? errorTextStyle;

  /// If null, InputDecorationTheme.floatingLabelBehavior will be used.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Optional widget to place on the line before the input.
  final Widget? prefix;

  /// Optional widget to place on the line after the input.
  final Widget? suffix;

  /// Treats the field as password field.
  ///
  /// Handles visibility toggle by default.
  /// Supports icon customization
  final EnabledPassword? password;

  /// Obscure text, helps with password visibility toggle.
  final bool? obscureText;

  /// Default '•'.
  final String obscuringCharacter;

  /// Signature for validating a form field.
  ///
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  final String? Function(String?)? validator;

  /// Enables default validation. Takes care of null and empty value check if
  /// enabled
  final bool enableDefaultValidation;

  /// If null, defaults to 48px in order to comply with Material spec's minimum
  /// interactive size guideline
  final double? height;

  /// The padding for the input decoration's container. Defaults to 10px horizontally
  /// and 10px vertically
  final EdgeInsetsGeometry? contentPadding;

  /// The padding for the input error text, defaults to 10px from left and
  /// 5px from top
  final EdgeInsetsGeometry? errorPadding;

  /// Bottom margin to create space between intermediate element
  final double? bottomMargin;

  /// Determines the border type. Border can be [BorderType.outlined] or
  /// [BorderType.bottom] or [BorderType.none].
  ///
  /// Defaults to [BorderType.outlined].
  /// If you want to disable border use [BorderType.none]
  final BorderType borderType;

  /// The color for the container border
  final Color borderColor;

  /// If non-null, the corners of this box are rounded by this [BorderRadius]
  /// A [borderRadius] can only be given for a uniform Border.
  ///
  /// Default border radius is 8px
  final BorderRadiusGeometry? borderRadius;

  /// The color for the container background
  final Color? fillColor;

  /// The color for the error, applies to everywhere that reacts to input
  /// validation error
  final Color errorColor;

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  bool isError = false;
  bool _showPassword = true;
  String? feedback;

  @override
  Widget build(BuildContext context) {
    bool isOutlinedBorder = widget.borderType == BorderType.outlined;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) widget.label!,
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: widget.borderRadius ??
                _getDefaultBorderRadius(isOutlinedBorder),
            border: _getBorder(isOutlinedBorder),
          ),
          child: TextFormField(
            controller: widget.textEditingController,
            textAlignVertical: TextAlignVertical.center,
            style: widget.style,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding ?? _defaultConentPadding(),
              labelText: widget.labelText,
              labelStyle: widget.labelTextStyle,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,

              /// Error text style fontSize is set to 0.01 to hide error text
              /// completely for custom error handling
              errorStyle: const TextStyle(fontSize: 0.01),

              /// Borders are intentionally disabled
              border: InputBorder.none,
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix ??
                  (widget.password.isNotNull
                      ? _visibilityButton(widget.password!)
                      : null),
            ),
            obscureText: widget.password.isNotNull
                ? _showPassword
                : widget.obscureText ?? false,
            obscuringCharacter: widget.obscuringCharacter,
            onChanged: (String? v) {
              if (isError) {
                setState(() => isError = false);
              }
            },
            validator: (String? v) {
              /// Default validation. Fields can't be empty. If you want to disable it
              /// change disableDefaultValidation
              if (widget.enableDefaultValidation && v.isNullOrEmpty()) {
                setState(() => isError = true);
                feedback = "Required";
              } else if (widget.validator != null) {
                setState(() => isError = true);
                feedback = widget.validator!(v);
              }
              return feedback;
            },
          ),
        ),
        if (isError && feedback.isNotNull)
          Padding(
            padding: widget.errorPadding ??
                const EdgeInsets.only(
                  left: 10.0,
                  top: 5,
                ),
            child: Text(
              feedback!,
              style: widget.errorTextStyle ??
                  const TextStyle(
                    color: Colors.red,
                  ),
            ),
          ),
        if (widget.bottomMargin.isNotNull) SizedBox(height: widget.bottomMargin)
      ],
    );
  }

  Border? _getBorder(bool isOutlinedBorder) {
    return widget.borderType == BorderType.none
        ? null
        : isOutlinedBorder
            ? Border.all(color: _getBorderColor())
            : Border(bottom: BorderSide(color: _getBorderColor()));
  }

  BorderRadius? _getDefaultBorderRadius(bool isOutlinedBorder) =>
      isOutlinedBorder || widget.fillColor.isNotNull
          ? BorderRadius.circular(8)
          : null;

  Color _getBorderColor() => isError ? widget.errorColor : widget.borderColor;

  EdgeInsets _defaultConentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    );
  }

  IconButton _visibilityButton(EnabledPassword password) {
    return IconButton(
      onPressed: () {
        setState(() => _showPassword = !_showPassword);
      },
      icon: _showPassword
          ? password.hidePasswordIcon ?? const Icon(Icons.visibility_off)
          : password.showPasswordIcon ?? const Icon(Icons.visibility),
      splashColor: Colors.transparent,
    );
  }
}

class EnabledPassword {
  EnabledPassword({
    this.showPasswordIcon,
    this.hidePasswordIcon,
  });

  final Widget? showPasswordIcon;
  final Widget? hidePasswordIcon;
}

enum BorderType { outlined, bottom, none }

extension _GenericExtension<T> on T? {
  bool get isNotNull => this != null;
}

extension _StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
