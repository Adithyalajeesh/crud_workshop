import 'package:crud_bloc_task/application/core/services/theme_service.dart';
import 'package:crud_bloc_task/application/core/widgets/customButtons/add_post_button.dart';
import 'package:crud_bloc_task/application/features/posts/pages/post_detail_screen.dart';
import 'package:crud_bloc_task/application/features/posts/postbloc/post_bloc.dart';
import 'package:crud_bloc_task/application/features/posts/widgets/add_form.dart';
import 'package:crud_bloc_task/application/features/posts/widgets/edit_post%20_form.dart';
import 'package:crud_bloc_task/domain/usecases/post_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/customButtons/custom_icon_button.dart';

class PostWrapper extends StatelessWidget {
  const PostWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(postUseCases: PostUseCases()),
      child: const PostPage(),
    );
  }
}

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'C R U D',
          style: themeData.textTheme.titleLarge,
        ),
        actions: [
          Switch(
            activeColor: Colors.green,
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
            value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeServiceProvider>(context, listen: false)
                  .toggleTheme();
            },
          ),
          CustomIconButton(
            icon: Icons.refresh,
            size: 24,
            onPressed: () {
              print("refresh button pressed"); // debug text print
              BlocProvider.of<PostBloc>(context).add(PostRequestedEvent());
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Posts",
                style: themeData.textTheme.titleLarge,
              ),
              Expanded(child:
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state is PostInitial) {
                  return const Text("Your posts are waiting to be loaded");
                } else if (state is PostStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  );
                } else if (state is PostStateLoaded) {
                  return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _navigateToPostDetail(
                                context, state.posts[index].id);
                          },
                          child: Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Center(
                                      child: Text("${index + 1}"),
                                    ),
                                  ),
                                  title: Text("${state.posts![index].title}"),
                                  subtitle: Text("${state.posts![index].body}"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomIconButton(
                                      icon: Icons.edit,
                                      size: 20,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return EditPostForm(
                                                post: state.posts[index]);
                                          },
                                        );
                                      },
                                    ),
                                    CustomIconButton(
                                      icon: Icons.delete,
                                      size: 20,
                                      onPressed: () {
                                        print(
                                            'Delete button pressed'); //debug text print
                                        BlocProvider.of<PostBloc>(context).add(
                                            PostDeletedEvent(
                                                postId: state.posts[index].id));
                                    BlocProvider.of<PostBloc>(context).add(
                                    PostRequestedEvent());



                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is PostStateError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const Center(
                  child: Text("some error occurred"),
                );
              }))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              final postBloc = BlocProvider.of<PostBloc>(
                  context); // Get the bloc from parent context
              return BlocProvider.value(
                // Use BlocProvider.value here, wrapping the entire content
                value: postBloc,
                child: Column(
                  // Or any other layout widget
                  children: [AddPostForm()],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToPostDetail(BuildContext context, int postId) {
    final postBloc = BlocProvider.of<PostBloc>(context);

    postBloc.add(PostDetailRequestedEvent(postId: postId));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: postBloc,
          child: PostDetailScreen(postId: postId),
        ),
      ),
    );
  }
}
