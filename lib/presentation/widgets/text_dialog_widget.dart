import 'package:flutter/material.dart';

Future<T?> showTextDialog<T>(BuildContext context, {
  required String title,
  required String value,
  required String? Function(String? value)? validator,
  required TextInputType? keyboardType,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) =>
          TextDialogWidget(
            title: title,
            value: value,
            validator: validator,
            keyboardType: keyboardType,
          ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;


  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  TextDialogWidgetState createState() => TextDialogWidgetState();
}

class TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) =>
      AlertDialog(
        title: Text(widget.title),
        content: Form(
          key: _formKey,
          child: TextFormField(
            validator: widget.validator,
            controller: controller,
            keyboardType: widget.keyboardType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              child: const Text('Done'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop(controller.text);
                }
              }
          )
        ],
      );
}
