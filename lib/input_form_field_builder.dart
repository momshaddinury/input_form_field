import 'package:flutter/material.dart';
import 'package:input_form_field/input_form_field_config.dart';

/// Input form field
///
/// A [StatefulWidget] that contains a [TextFormField]. A convinient widget aiming
/// to simplify complexitiy of default [TextFormField] widget.
///
///

InputFormFieldConfig config = InputFormFieldConfig();

class InputFormField extends StatefulWidget {
  InputFormField({
    Key? key,
    required this.textEditingController,
    this.hintText,
    this.labelText,
    this.label,
    this.validator,
    this.enableDefaultValidation = false,
    this.suffix,
    this.prefix,
    this.floatingLabelBehavior,
    this.password,
    this.isReadOnly,
    this.isObscureText,
  })  : assert(
          config.obscuringCharacter != null &&
              config.obscuringCharacter?.length == 1,
        ),
        assert(
          !(password.isNotNull && isObscureText.isNotNull),
          """Both can't be used at the same time. Use isPasswordTrue to handle password visibility internally. To handle externally use obscureText""",
        ),
        super(key: key);

  final TextEditingController textEditingController;

  final Widget? label;

  /// Optional text that describes the input field.
  final String? labelText;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

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
  final bool? isObscureText;

  final bool? isReadOnly;

  /// Signature for validating a form field.
  ///
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  final String? Function(String?)? validator;

  /// Enables default validation. Takes care of null and empty value check if
  /// enabled
  final bool enableDefaultValidation;

  /// If non-null, the corners of this box are rounded by this [BorderRadius]
  /// A [borderRadius] can only be given for a uniform Border.
  ///

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  bool isError = false;
  bool _showPassword = true;
  String? feedback;

  @override
  Widget build(BuildContext context) {
    bool isOutlinedBorder = config.borderType == BorderType.outlined;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) widget.label!,
        Container(
          height: config.height,
          decoration: BoxDecoration(
            color: config.fillColor,
            borderRadius: config.borderRadius ??
                _getDefaultBorderRadius(isOutlinedBorder),
            border: _getBorder(isOutlinedBorder),
          ),
          child: TextFormField(
            controller: widget.textEditingController,
            textAlignVertical: TextAlignVertical.center,
            style: config.style,
            decoration: InputDecoration(
              contentPadding: config.contentPadding,
              labelText: widget.labelText,
              labelStyle:
                  isError ? config.labelErrorTextStyle : config.labelTextStyle,
              hintText: widget.hintText,
              hintStyle: config.hintTextStyle,
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
                      : const SizedBox.shrink()),
            ),
            obscureText: widget.password.isNotNull
                ? _showPassword
                : widget.isObscureText ?? false,
            readOnly: widget.isReadOnly ?? false,
            obscuringCharacter: config.obscuringCharacter!,
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
            padding: config.errorPadding!,
            child: Text(
              feedback!,
              style: config.errorTextStyle ??
                  const TextStyle(
                    color: Colors.red,
                  ),
            ),
          ),
        SizedBox(height: config.bottomMargin),
      ],
    );
  }

  Border? _getBorder(bool isOutlinedBorder) {
    return config.borderType == BorderType.none
        ? null
        : isOutlinedBorder
            ? Border.all(color: _getBorderColor())
            : Border(bottom: BorderSide(color: _getBorderColor()));
  }

  BorderRadius? _getDefaultBorderRadius(bool isOutlinedBorder) =>
      isOutlinedBorder || config.fillColor != null
          ? BorderRadius.circular(8)
          : null;

  Color _getBorderColor() => isError ? config.errorColor! : config.borderColor!;

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

extension _GenericExtension<T> on T? {
  bool get isNotNull => this != null;
}

extension _StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
