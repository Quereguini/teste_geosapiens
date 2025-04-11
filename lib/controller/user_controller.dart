import 'package:get/get.dart';
import '../model/user_model.dart';
import '../database/database_helper.dart';
import '../service/location_service.dart';

class UserController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final LocationService _locationService = LocationService();

  var userList = <UserModel>[].obs;

  Future<void> getAllUsers() async {
    final userMaps = await _dbHelper.getAllUsers();
    final users = userMaps.map((map) => UserModel.fromMap(map)).toList();
    userList.assignAll(users);
  }

  Future<void> createUser(UserModel user) async {
    if (!user.isValidName()) {
      throw Exception('O nome é inválido! Deve ter 5 a 15 caracteres.');
    }
    if (!user.isValidEmail()) {
      throw Exception('E-mail inválido.');
    }
    if (!user.isValidSenha()) {
      throw Exception(
        'A senha deve ter de 6 a 8 caracteres, com letra e número.',
      );
    }
    await _dbHelper.insertUser(user.toMap());
    await getAllUsers();
  }

  Future<void> deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
    await getAllUsers();
  }

  Future<void> updateUser(UserModel user) async {
    if (user.id == null) {
      throw Exception('ID ausente: não é possível atualizar sem ID!');
    }
    await _dbHelper.updateUser(user.toMap());
    await getAllUsers();
  }

  Future<void> registerUser({
    required String nomePescador,
    required String nomePeixe,
    required int aparelhoPesca,
    required int quantidadeKilos,
  }) async {
    double geoValue = await _locationService.getCurrentLatitude();
    UserModel newUser = UserModel(
      nomePescador: nomePescador,
      nomePeixe: nomePeixe,
      aparelhoPesca: aparelhoPesca,
      quantidadeKilos: quantidadeKilos,
      geolocalizacao: geoValue,
    );
    await createUser(newUser);
  }

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }
}
