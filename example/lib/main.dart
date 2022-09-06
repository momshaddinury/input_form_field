import 'package:flutter/material.dart';
import 'package:input_form_field/input_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Input Form Field Example",
      home: DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  DemoScreen({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              /// Standard - Outlined Border
              InputFormField(
                textEditingController: _controller,
                labelText: "Label Text",
                hintText: "Hint Text",
              ),
              /// Default Password Field
              InputFormField(
                textEditingController: _controller,
                labelText: "Password",
                hintText: "*****",
                isPasswordField: true,
              ),
              /// No Border
              InputFormField(
                textEditingController: _controller,
                labelText: "Label Text",
                hintText: "Hint Text",
                disableBorder: false,
              ),
              /// Filled
              InputFormField(
                textEditingController: _controller,
                labelText: "Label Text",
                hintText: "Hint Text",
                disableBorder: false,
                fillColor: Colors.blue.withOpacity(0.10),
              ),
              /// Label will always show
              InputFormField(
                textEditingController: _controller,
                labelText: "Label Text",
                hintText: "Hint Text",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              /// Rounded Border
              InputFormField(
                textEditingController: _controller,
                labelText: "Label Text",
                hintText: "Hint Text",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
