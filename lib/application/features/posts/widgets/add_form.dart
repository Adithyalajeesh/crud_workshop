import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../core/widgets/customButtons/add_post_button.dart';
import '../postbloc/post_bloc.dart';

class AddPostForm extends StatefulWidget {
  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDarkMode = themeData.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.blueGrey.shade900
              : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: themeData.textTheme.titleMedium),
              style: themeData.textTheme.titleMedium,
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
                labelStyle: themeData.textTheme.titleMedium,
              ),
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            AddPostButton(
              onPressed: () {
                final title = _titleController.text;
                final body = _bodyController.text;
                if (title.isNotEmpty && body.isNotEmpty) {
                  // Add post only if both fields are filled
                  BlocProvider.of<PostBloc>(context).add(PostAddedEvent(title: title, body: body));
                  Navigator.of(context).pop();  // Close the form after adding
                } else {
                  // Display a snackbar if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter both title and body.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}

