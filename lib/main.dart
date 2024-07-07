
import 'package:crud_bloc_task/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application/core/services/theme_service.dart';
import 'application/features/posts/pages/post_page.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>ThemeServiceProvider(),child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeServiceProvider>(
        builder: (context,themeService, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeService.isDarkModeOn? ThemeMode.dark:ThemeMode.light,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const PostWrapper(),
          );
        }
    );
  }
}
