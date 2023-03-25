import 'package:flutter/material.dart';

Future<T?> showTextDialog<T>(BuildContext context, {
  required String title,
  required String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) =>
          TextDialogWidget(
            title: title,
            value: value,
          ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
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
            validator: (value){
              if (value!='1'&&value!='2'&&value!='3'&&value!='4'&&value!='5'&&value!='6'&&
                  value!='7'&&value!='8'&&value!='9'&&value!='10'&&value!='11'&&value!='12') {
                return 'Please enter the correct points';
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
