import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/equipament_controller.dart';
import '../controller/user_controller.dart';

class UserRegistrationView extends StatelessWidget {
  final TextEditingController nomePescador = TextEditingController();
  final TextEditingController nomePeixe = TextEditingController();
  final TextEditingController quantidadeKilos = TextEditingController();

  UserRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final EquipmentController equipmentController =
        Get.find<EquipmentController>();
    final Rxn<int> selectedEquipmentId = Rxn<int>();

    return Scaffold(
      appBar: AppBar(title: const Text("User Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomePescador,
              decoration: const InputDecoration(labelText: "Nome do Pescador"),
            ),
            TextField(
              controller: nomePeixe,
              decoration: const InputDecoration(labelText: "Nome do Peixe"),
            ),
            Obx(() {
              if (equipmentController.equipmentList.isEmpty) {
                return const CircularProgressIndicator();
              }
              return SizedBox(
                width: double.infinity,
                child: DropdownButton<int>(
                  isExpanded: true,
                  hint: const Text("Selecione o Aparelho de Pesca"),
                  value: selectedEquipmentId.value,
                  items:
                      equipmentController.equipmentList.map((equip) {
                        return DropdownMenuItem<int>(
                          value: equip.id,
                          child: Text(equip.txtNome),
                        );
                      }).toList(),
                  onChanged: (value) {
                    selectedEquipmentId.value = value;
                  },
                ),
              );
            }),
            TextField(
              controller: quantidadeKilos,
              decoration: const InputDecoration(
                labelText: "Quantidade em Kilos",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await userController.registerUser(
                    nomePescador: nomePescador.text,
                    nomePeixe: nomePeixe.text,
                    aparelhoPesca: selectedEquipmentId.value ?? 0,
                    quantidadeKilos: int.tryParse(quantidadeKilos.text) ?? 0,
                  );
                  Get.snackbar("Success", "Usuário cadastrado com sucesso.");
                  nomePescador.clear();
                  nomePeixe.clear();
                  quantidadeKilos.clear();
                  selectedEquipmentId.value = null;
                } catch (e) {
                  Get.snackbar("Error", e.toString());
                }
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
