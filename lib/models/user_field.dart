class UserField {
  String value;
  String error;

  UserField({
    this.value = "",
    this.error = ""
  });

  void setValue(String value) => this.value = value;

  void setError(String error) => this.error = error;
}