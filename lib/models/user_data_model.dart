class UserDataModel {
  String nome = "";
  String cognome = "";
  DateTime? birthDate = DateTime(2000);
  String email = "";
  String password = "";

  void resetData() {
    nome = "";
    cognome = "";
    birthDate = DateTime(2000);
    email = "";
    password = "";
  }
}