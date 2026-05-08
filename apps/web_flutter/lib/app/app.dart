import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

class EduGestorApp extends StatelessWidget {
  const EduGestorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EduGestor 360',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
