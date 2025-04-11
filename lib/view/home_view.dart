import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_list_view.dart';
import 'user_registration_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => UserRegistrationView());
              },
              child: Text("Cadastrar"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => UserListView());
              },
              child: Text("Listar"),
            ),
          ],
        ),
      ),
    );
  }
}
