class FishingEquipmentModel {
  final int id;
  final String txtNome;

  FishingEquipmentModel({required this.id, required this.txtNome});

  factory FishingEquipmentModel.fromJson(Map<String, dynamic> json) {
    return FishingEquipmentModel(id: json['id'], txtNome: json['txt_nome']);
  }
}
