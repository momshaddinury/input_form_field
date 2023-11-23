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

  InputFormFieldConfig inputFormFieldConfig = InputFormFieldConfig(
    setBottomMargin: 10,
    setBorderType: BorderType.outlined,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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

              /// Custom
              InputFormField(
                textEditingController: _controller,
                labelText: "Custom",
                hintText: "Hint Text",
                // Optional
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),

              /// Custom 2
              InputFormField(
                textEditingController: _controller,
                labelText: "Custom 2",
                hintText: "Hint Text",
              ),

              /// Custom 3 (Suffix)
              InputFormField(
                textEditingController: _controller,
                prefix: const Icon(Icons.mail),
                labelText: "Email",
                hintText: "abc@email.com",
              ),

              /// Custom 4 (Suffix, Prefix)
              InputFormField(
                textEditingController: _controller,
                prefix: const Icon(Icons.mail),
                labelText: "Email",
                hintText: "abc@email.com",
                suffix: const Icon(Icons.info),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
