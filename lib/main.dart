import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_geosapiens/view/home_view.dart';
import 'controller/equipament_controller.dart';
import 'controller/user_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(EquipmentController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Title',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeView(),
    );
  }
}
