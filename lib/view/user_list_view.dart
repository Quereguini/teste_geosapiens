import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(title: Text("Listagem de Usuários")),
      body: Obx(() {
        if (userController.userList.isEmpty) {
          return Center(child: Text("Sem registros."));
        }
        return ListView.builder(
          itemCount: userController.userList.length,
          itemBuilder: (context, index) {
            final user = userController.userList[index];
            return ListTile(
              title: Text(user.nomePescador),
              subtitle: Text(user.geolocalizacao.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await userController.deleteUser(user.id!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
