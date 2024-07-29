import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'Screens/Homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TorchController().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homescreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
