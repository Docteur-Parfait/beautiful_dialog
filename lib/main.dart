import 'package:beautiful_dialog/provider/theme_provider.dart';
import 'package:beautiful_dialog/views/dialog_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dialogs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green, foregroundColor: Colors.white),
        useMaterial3: true,
      ),
      builder: BotToastInit(), // Initialize BotToast
      navigatorObservers: [
        BotToastNavigatorObserver()
      ], // Add BotToast navigator observer
      home: const DialogView(),
    );
  }
}
