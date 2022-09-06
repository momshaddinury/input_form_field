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
              /// Standard
              InputFormField(
                textEditingController: _controller,
                height: 56,
                labelText: "Label Text",
                hintText: "Hint Text",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
