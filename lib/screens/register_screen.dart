import 'package:dragonballhub/models/auth_management.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/repository/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final registrationProvider = Provider<UserSignUpData>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userSignUp = UserSignUpData(auth: FirebaseAuthRepository(authInstance));
  return userSignUp;
});

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Registration Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RegisterField(
              obscureText: false,
              hintText: "Nome",
              errorText: context.read(registrationProvider).nome.error,
              onChangedField: (String value) {
                context.read(registrationProvider).nome.setValue(value);
              },
            ),
            SizedBox(
              height: 25,
            ),
            RegisterField(
              obscureText: false,
              hintText: "Cognome",
              errorText: context.read(registrationProvider).cognome.error,
              onChangedField: (String value) {
                context.read(registrationProvider).cognome.setValue(value);
              },
            ),
            SizedBox(
              height: 25,
            ),
            DatePickerWidget(), // TODO: send date to the register provider
            SizedBox(
              height: 40,
            ),
            RegisterField(
              obscureText: false,
              hintText: "Email",
              errorText: context.read(registrationProvider).email.error,
              onChangedField: (String value) {
                context.read(registrationProvider).email.setValue(value);
              },
            ),
            SizedBox(
              height: 25,
            ),
            RegisterField(
              obscureText: true,
              hintText: "Password",
              errorText: context.read(registrationProvider).password.error,
              onChangedField: (String value) {
                context.read(registrationProvider).password.setValue(value);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 75),
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      print(
                        "${context.read(registrationProvider).nome.value}\n"
                        "${context.read(registrationProvider).cognome.value}\n"
                            "${context.read(registrationProvider).birthDate}\n"
                            "${context.read(registrationProvider).email.value}\n"
                            "${context.read(registrationProvider).password.value}\n"
                      );
                      context.read(registrationProvider).signUpEmail();
                    },
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterField extends StatelessWidget {
  RegisterField(
      {this.obscureText,
      this.hintText,
      this.errorText,
      this.onChangedField,
      this.onTap});

  final bool? obscureText;
  final String? hintText;
  String? errorText;
  Function? onChangedField;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.obscureText!,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: this.hintText,
          errorText: this.errorText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onChanged: this.onChangedField as void Function(String)?,
      onTap: this.onTap as void Function()?,
    );
  }
}

class RegistrationFormWidget extends StatefulWidget {
  @override
  _RegistrationFormWidgetState createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {

  final _formKey = GlobalKey<FormState>();
  static const String tooShortEmail = "Email is too short";
  static const String errorMinCharactersPassword =
      "Password must be at least 6 characters";

  // TODO: modify validation
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Cannot be empty';
    } else if (email.length < 4) {
      return tooShortEmail;
    }
    return null;
  }

  // TODO: modify validation
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Cannot be empty';
    } else if (password.length < 6) {
      return errorMinCharactersPassword;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ],
      ),
    );
  }
}





class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  final String hintText = "Data di nascita";

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(2000);
    _textEditingController = new TextEditingController(
        text: DateFormat("dd-MM-yyyy").format(_selectedDate!));
    context.read(registrationProvider).birthDate = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: AlwaysDisabledFocusNode(),
      controller: _textEditingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onTap: () {
        _selectDate(context);

      },
    );
  }

  Future<void>_selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate! : DateTime(2000),
        firstDate: DateTime(1920),
        lastDate: DateTime(2008),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.red,
                onPrimary: Colors.white,
                surface: Colors.red,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if(newSelectedDate != null) {
      DateFormat europeanFormat = DateFormat("dd-MM-yyyy");
      setState(() {
        _selectedDate = newSelectedDate;
        _textEditingController
          ..text = europeanFormat.format(_selectedDate!);
      });

    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
