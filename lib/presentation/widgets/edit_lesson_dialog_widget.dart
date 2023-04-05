import 'package:flutter/material.dart';

Future<T?> showEditLessonDialog<T>(BuildContext context, {
  required String title,
  required String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => EditLessonDialogWidget(
        title: title,
        value: value,
      )
    );

class EditLessonDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const EditLessonDialogWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  EditLessonDialogWidgetState createState() => EditLessonDialogWidgetState();
}

class EditLessonDialogWidgetState extends State<EditLessonDialogWidget> {
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
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: controller,
            keyboardType: TextInputType.number,
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