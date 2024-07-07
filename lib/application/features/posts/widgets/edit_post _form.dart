import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_bloc_task/application/features/posts/postbloc/post_bloc.dart';
import 'package:crud_bloc_task/domain/entities/post_entity.dart';

class EditPostForm extends StatefulWidget {
  final PostsEntity post;

  EditPostForm({required this.post});

  @override
  _EditPostFormState createState() => _EditPostFormState();
}

class _EditPostFormState extends State<EditPostForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;

  @override
  void initState() {
    super.initState();
    _title = widget.post.title;
    _body = widget.post.body;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              initialValue: _body,
              decoration: const InputDecoration(labelText: 'Body'),
              onSaved: (value) {
                _body = value!;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedPost = PostsEntity(
                    id: widget.post.id,
                    userId: widget.post.userId,
                    title: _title,
                    body: _body,
                  );
                  BlocProvider.of<PostBloc>(context).add(PostUpdatedEvent(post: updatedPost));
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
