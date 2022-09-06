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
  const InputFormField({
    Key? key,
    required this.textEditingController,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.labelTextStyle,
    this.errorTextStyle,
    this.floatingLabelBehavior,
    this.suffix,
    this.prefix,
    this.isPasswordField = false,
    this.obscureText,
    this.validator,
    this.disableDefaultValidation = true,
    this.height,
    this.contentPadding,
    this.errorPadding,
    this.borderRadius,
    this.borderColor = Colors.blue,
    this.disableBorder = false,
    this.fillColor = Colors.white,
    this.errorColor = Colors.red,
  })  : assert(!(isPasswordField && obscureText != null),
            """Both can't be used at the same time. Use isPasswordTrue to handle password visibility internally. To handle externally use obscureText"""),
        super(key: key);

  final TextEditingController textEditingController;

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

  /// To treat the field as password field.
  final bool isPasswordField;

  /// Obscure text, helps with password visibility toggle.
  final bool? obscureText;

  /// Signature for validating a form field.
  ///
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  final String? Function(String?)? validator;

  /// Enables default validation. Takes care of null and empty value check if
  /// enabled
  final bool disableDefaultValidation;

  /// If null, defaults to 48px in order to comply with Material spec's minimum
  /// interactive size guideline
  final double? height;

  /// The padding for the input decoration's container. Defaults to 10px horizontally
  /// and 10px vertically
  final EdgeInsetsGeometry? contentPadding;

  /// The padding for the input error text, defaults to 10px from left and
  /// 5px from top
  final EdgeInsetsGeometry? errorPadding;

  /// The color for the container border
  final Color borderColor;

  /// If non-null, the corners of this box are rounded by this [BorderRadius]
  final BorderRadiusGeometry? borderRadius;

  /// Toggle this if you don't want outlined border
  final bool disableBorder;

  /// The color for the container background
  final Color fillColor;

  /// The color for the error, applies to everywhere that reacts to input
  /// validation error
  final Color errorColor;

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  bool isError = false;
  bool _showPassword = false;
  String? feedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height ?? 56,
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: widget.borderRadius,
            border: widget.disableBorder
                ? null
                : Border.all(
                    color: isError ? widget.errorColor : widget.borderColor,
                  ),
          ),
          child: TextFormField(
            controller: widget.textEditingController,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(textBaseline: TextBaseline.alphabetic),
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
                  (widget.isPasswordField ? _visibilityButton() : null),
            ),
            obscureText: widget.isPasswordField
                ? _showPassword
                : widget.obscureText ?? false,
            onChanged: (String? v) {
              if (isError) {
                setState(() => isError = false);
              }
            },
            validator: (String? v) {
              /// Default validation. Fields can't be empty. If you want to disable it
              /// change disableDefaultValidation
              if (!widget.disableDefaultValidation && v.isNullOrEmpty()) {
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
        if (isError && feedback != null)
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
          )
      ],
    );
  }

  EdgeInsets _defaultConentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    );
  }

  IconButton _visibilityButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      icon: _showPassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      splashColor: Colors.transparent,
    );
  }
}

extension _StringExtension on String? {
  bool isNullOrEmpty() {
    if (this == null) {
      return true;
    } else if (this!.isEmpty) {
      return true;
    }
    return false;
  }
}
