class UserDataModel {
  String? nome = "";
  String? cognome = "";
  DateTime? birthDate = DateTime(2000);
  String? email = "";
  String? password = "";

  UserDataModel({
    this.nome,
    this.cognome,
    this.birthDate,
    this.email,
    this.password
});

  void resetData() {
    nome = "";
    cognome = "";
    birthDate = DateTime(2000);
    email = "";
    password = "";
  }

  UserDataModel.fromMap(Map<String, dynamic> data) {
    UserDataModel(
        nome: data["name"],
        cognome: data["surname"],
        birthDate: data["birthDate"],
    );
  }
}