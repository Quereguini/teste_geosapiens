import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Importa o FFI do Sqflite
import 'package:flutter_test/flutter_test.dart';
import 'package:teste_geosapiens/controller/user_controller.dart';
import 'package:teste_geosapiens/model/user_model.dart';

void main() {
  // Inicializa o FFI do sqflite e sobrescreve o databaseFactory para testes em desktop.
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Garante que as bindings do Flutter estejam inicializadas para o ambiente de testes.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UserController - Integração com SQFlite', () {
    late UserController userController;

    setUpAll(() async {
      // Instancia o controller
      userController = UserController();

      // Limpa o banco:
      await userController.getAllUsers();
      // Cria uma cópia para evitar modificação concorrente
      final allUsers = List<UserModel>.from(userController.userList);
      for (var u in allUsers) {
        if (u.id != null) {
          await userController.deleteUser(u.id!);
        }
      }
    });

    test('Deve inserir e recuperar o usuário no banco', () async {
      // Cria um usuário válido
      final user = UserModel(
        nomePescador: 'John Doe',
        nomePeixe: 'Peixe Teste',
        aparelhoPesca: 1,
        quantidadeKilos: 10,
        geolocalizacao: 0.0,
      );

      // Insere o usuário usando o controller (que internamente usa o DatabaseHelper)
      await userController.createUser(user);

      // Atualiza a lista de usuários (o método getAllUsers() atualiza a variável observável userList)
      await userController.getAllUsers();
      final users = userController.userList;

      // Verifica se há ao menos 1 usuário inserido
      expect(users.length, greaterThan(0));

      // Pega o último usuário inserido e verifica as informações
      final insertedUser = users.last;
      expect(insertedUser.nomePeixe, equals('Peixe Teste'));
      expect(insertedUser.nomePescador, equals('John Doe'));
      expect(insertedUser.aparelhoPesca, equals(1));
      expect(insertedUser.quantidadeKilos, equals(10));
      expect(insertedUser.geolocalizacao, equals(0.0));
    });

    test('Deve atualizar um usuário já existente', () async {
      // Insere um usuário inicialmente
      final user = UserModel(
        nomePescador: 'OldName',
        nomePeixe: 'OldFish',
        aparelhoPesca: 1,
        quantidadeKilos: 10,
        geolocalizacao: 0.0,
      );
      await userController.createUser(user);
      await userController.getAllUsers();
      final insertedUser = userController.userList.last;

      // Modifica os dados
      insertedUser.nomePescador = 'NewName';
      insertedUser.nomePeixe = 'new@email.com';

      // Atualiza o usuário
      await userController.updateUser(insertedUser);
      await userController.getAllUsers();
      final updatedUser = userController.userList.last;

      // Verifica se os dados foram atualizados
      expect(updatedUser.nomePescador, equals('NewName'));
      expect(updatedUser.nomePeixe, equals('new@email.com'));
    });

    test('Deve excluir um usuário', () async {
      // Insere um usuário para deletar
      final user = UserModel(
        nomePescador: 'UserToDelete',
        nomePeixe: 'FishToDelete',
        aparelhoPesca: 1,
        quantidadeKilos: 10,
        geolocalizacao: 0.0,
      );
      await userController.createUser(user);
      await userController.getAllUsers();
      final insertedUser = userController.userList.last;

      // Exclui o usuário
      await userController.deleteUser(insertedUser.id!);
      await userController.getAllUsers();

      // Verifica se o usuário foi removido da lista
      final exists = userController.userList.any(
        (u) => u.id == insertedUser.id,
      );
      expect(exists, false);
    });
  });
}
