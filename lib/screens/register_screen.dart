import 'package:dragonballhub/custom_widgets/dart/login_widgets.dart';
import 'package:dragonballhub/custom_widgets/dart/signup_widgets.dart';
import 'package:dragonballhub/models/auth_management.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/repository/auth_helper.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final registrationProvider = Provider<UserSignUpData>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userSignUp = UserSignUpData(auth: AuthHelper(auth: authInstance));
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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.orange, Colors.deepOrange])),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(29),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TopCenterGokuLogo(),
                    SizedBox(height: SizeConfig.heightMultiplier * 3.3),
                    Material(
                      elevation: 7.0,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: RegistrationFormWidget(),
                      ),
                    ),
                    //Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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
          TextFormField(
              validator: (value) => _validateEmail(value!),
              onChanged: (value) =>
                  context.read(registrationProvider).email= value,
              decoration: new InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Nome")),
          SizedBox(height: 25),
          TextFormField(
            validator: (value) => _validatePassword(value!),
            onChanged: (value) =>
                context.read(registrationProvider).password = value,
            decoration: new InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                hintText: "Cognome"),
          ),
          SizedBox(height: 25),
          DatePickerWidget(),
          SizedBox(height: 25),
          TextFormField(
            validator: (value) => _validatePassword(value!),
            onChanged: (value) =>
                context.read(registrationProvider).password = value,
            decoration: new InputDecoration(
                icon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                hintText: "Email"),
          ),
          SizedBox(height: 25),
          TextFormField(
            obscureText: true,
            validator: (value) => _validatePassword(value!),
            onChanged: (value) =>
                context.read(registrationProvider).password = value,
            decoration: new InputDecoration(
                icon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                hintText: "Password"),
          ),
          SizedBox(height: 30),
          SignUpButtonWidget(_formKey),
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
    return TextFormField(
      focusNode: AlwaysDisabledFocusNode(),
      controller: _textEditingController,
      decoration: InputDecoration(
        icon: Icon(Icons.calendar_today),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onTap: () {
        _selectDate(context);
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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

    if (newSelectedDate != null) {
      DateFormat europeanFormat = DateFormat("dd-MM-yyyy");
      setState(() {
        _selectedDate = newSelectedDate;
        _textEditingController..text = europeanFormat.format(_selectedDate!);
      });
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
