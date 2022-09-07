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
                labelText: "Standard - Outlined Border",
                hintText: "Hint Text",
                bottomMargin: 10, // Optional
              ),

              /// No Border - Filled
              InputFormField(
                textEditingController: _controller,
                labelText: "No Border - Filled",
                hintText: "Hint Text",
                fillColor: Colors.black12,
                borderType: BorderType.none,
                bottomMargin: 10, // Optional
              ),

              /// Default Password Field
              InputFormField(
                textEditingController: _controller,
                labelText: "Default Password",
                hintText: "*****",
                password: EnabledPassword(),
                bottomMargin: 10, // Optional
              ),

              /// Customize Default Password Field
              InputFormField(
                textEditingController: _controller,
                labelText: "Custom Default Password",
                hintText: "*****",
                obscuringCharacter: "*",
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
                bottomMargin: 10, // Optional
              ),

              /// Custom
              InputFormField(
                textEditingController: _controller,
                labelText: "Custom",
                labelTextStyle: const TextStyle(fontSize: 25),
                hintText: "Hint Text",
                hintTextStyle: const TextStyle(fontSize: 18),
                borderColor: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10),
                bottomMargin: 10, // Optional
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),

              /// Custom 2
              InputFormField(
                textEditingController: _controller,
                labelText: "Custom 2",
                labelTextStyle: const TextStyle(color: Colors.deepOrange),
                hintText: "Hint Text",
                hintTextStyle: const TextStyle(color: Colors.deepOrangeAccent),
                borderType: BorderType.outlined,
                borderColor: Colors.deepOrange,
                bottomMargin: 10, // Optional
                borderRadius: BorderRadius.circular(10),
              ),

              /// Custom 3 (Suffix)
              InputFormField(
                textEditingController: _controller,
                prefix: const Icon(Icons.mail),
                labelText: "Email",
                hintText: "abc@email.com",
                borderType: BorderType.outlined,
                bottomMargin: 10, // Optional
              ),

              /// Custom 4 (Suffix, Prefix)
              InputFormField(
                textEditingController: _controller,
                prefix: const Icon(Icons.mail),
                labelText: "Email",
                hintText: "abc@email.com",
                suffix: const Icon(Icons.info),
                borderType: BorderType.outlined,
                bottomMargin: 10, // Optional
              ),
            ],
          ),
        ),
      ),
    );
  }
}
