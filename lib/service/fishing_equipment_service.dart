import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_geosapiens/model/fishing_equipment_model.dart';

class FishingEquipmentService {
  final String apiUrl =
      'https://geosapiens-flutter.free.beeceptor.com/v1/aparelho-pesca';

  Future<List<FishingEquipmentModel>> fetchEquipment() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => FishingEquipmentModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Falha ao carregar os equipamentos de pesca');
    }
  }
}
