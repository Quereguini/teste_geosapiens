class UserModel {
  int? id;
  String nomePescador;
  String nomePeixe;
  int aparelhoPesca;
  int quantidadeKilos;
  double geolocalizacao;

  UserModel({
    this.id,
    required this.nomePescador,
    required this.nomePeixe,
    required this.aparelhoPesca,
    required this.quantidadeKilos,
    required this.geolocalizacao,
  });

  // Validações de campos apenas para representar a lógica de negócio
  bool isValidName() => true;

  bool isValidEmail() => true;

  bool isValidSenha() => true;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nome_pescador': nomePescador,
      'nome_peixe': nomePeixe,
      'aparelho_pesca': aparelhoPesca,
      'quantidade_kilos': quantidadeKilos,
      'geolocalizacao': geolocalizacao,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nomePescador: map['nome_pescador'],
      nomePeixe: map['nome_peixe'],
      aparelhoPesca: map['aparelho_pesca'],
      quantidadeKilos: map['quantidade_kilos'],
      geolocalizacao: map['geolocalizacao'],
    );
  }
}
