import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title = '';
  final String description = '';
  final ValueChanged<String>? onChangedTitle;
  final ValueChanged<String>? onChangedDescription;
  final VoidCallback? onSavedTodo;

  const TodoFormWidget({
    Key? key,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [buildTitle()],
        ),
      );

  Widget buildTitle() => TextFormField(
        initialValue: title,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          } else {
            return null;
          }
        },
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: 'Title'),
      );
}
