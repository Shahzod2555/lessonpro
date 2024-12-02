import 'package:flutter/material.dart';


const Duration kFakeHttpRequestDuration = Duration(seconds: 3);

class TextFormFieldExampleApp extends StatelessWidget {
  const TextFormFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TextFormFieldExample(),
    );
  }
}

class TextFormFieldExample extends StatefulWidget {
  const TextFormFieldExample({super.key});

  @override
  State<TextFormFieldExample> createState() => _TextFormFieldExampleState();
}

class _TextFormFieldExampleState extends State<TextFormFieldExample> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? forceErrorText;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length != value.replaceAll(' ', '').length) {
      return 'Username must not contain any spaces';
    }
    if (int.tryParse(value[0]) != null) {
      return 'Username must not start with a number';
    }
    if (value.length <= 2) {
      return 'Username should be at least 3 characters long';
    }
    return null;
  }

  Future<void> onSave() async {
    var isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              forceErrorText: forceErrorText,
              controller: controller,
              decoration: const InputDecoration(hintText: 'Please write a username'),
              validator: validator,
            ),
            const SizedBox(height: 40.0),
            TextButton(onPressed: onSave, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
