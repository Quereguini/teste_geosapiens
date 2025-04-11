import 'package:flutter_test/flutter_test.dart';
import 'package:teste_geosapiens/model/user_model.dart';

// String nomePescador;
// String nomePeixe;
// int aparelhoPesca;
// int quantidadeKilos;
// double geolocalizacao;

void main() {
  group('User Model Validations', () {
    test('Cadastro deve ser valido', () {
      final user = UserModel(
        nomePescador: 'John Doe',
        nomePeixe: 'Peixe Teste',
        aparelhoPesca: 1,
        quantidadeKilos: 10,
        geolocalizacao: 0.0,
      );
      expect(user.isValidName(), true);

      user.nomePescador = 'TesteValido';
      expect(user.isValidName(), true);

      user.nomePeixe = 'tucunare';
      expect(user.isValidName(), true);
    });
  });
}
