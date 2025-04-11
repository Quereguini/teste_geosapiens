import 'package:get/get.dart';
import 'package:teste_geosapiens/model/fishing_equipment_model.dart';

import '../service/fishing_equipment_service.dart';

class EquipmentController extends GetxController {
  final FishingEquipmentService _service = FishingEquipmentService();

  var equipmentList = <FishingEquipmentModel>[].obs;

  Future<void> loadEquipment() async {
    try {
      final list = await _service.fetchEquipment();

      final Map<int, FishingEquipmentModel> uniqueMap = {};
      for (var equip in list) {
        uniqueMap[equip.id] = equip;
      }

      final uniqueEquipments = uniqueMap.values.toList();

      equipmentList.assignAll(uniqueEquipments);
    } catch (e) {
      Get.snackbar("Erro", e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadEquipment();
  }
}
