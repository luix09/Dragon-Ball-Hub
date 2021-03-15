import 'package:dragonballhub/custom_widgets/dart/signup_widgets.dart';
import 'package:dragonballhub/models/auth_management.dart';
import 'package:dragonballhub/models/user_data_model.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/repository/auth_exception_handler.dart';
import 'package:dragonballhub/repository/auth_helper.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


final userSignUpModel = Provider<UserDataModel>((ref){
  final signUpProvider = ref.watch(registrationProvider);
  return signUpProvider.userDataModel;
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
                    ), //Expanded(child: Container()),
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
  bool _showPassword = false;

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

  Future<void> showSignUpDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialogSignUpWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<AuthResultStatus?>>(
      provider: registrationProvider,
      onChange: (context, snapshot) {
        if(snapshot.state == AuthResultStatus.successful)
          showSignUpDialog();
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                validator: (value) => null,
                onChanged: (value) =>
                    context.read(userSignUpModel).nome = value,
                decoration: new InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Nome")),
            SizedBox(height: 25),
            TextFormField(
              validator: (value) => null,
              onChanged: (value) =>
                  context.read(userSignUpModel).cognome = value,
              decoration: new InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                  hintText: "Cognome"),
            ),
            SizedBox(height: 25),
            DatePickerSignUpWidget(),
            SizedBox(height: 25),
            TextFormField(
              validator: (value) => _validatePassword(value!),
              onChanged: (value) =>
                  context.read(userSignUpModel).email = value,
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
              obscureText: !_showPassword,
              validator: (value) => _validatePassword(value!),
              onChanged: (value) =>
                  context.read(userSignUpModel).password = value,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off
                    ),
                  ),
                  icon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                  hintText: "Password"),
            ),
            SizedBox(height: 30),
            SignUpButtonWidget(_formKey, showSignUpDialog),
          ],
        ),
      ),
    );
  }
}

class AlertDialogSignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Account created'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Now go to your email.'),
            Text('Click to the link and verify your account!'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


class DatePickerSignUpWidget extends StatefulWidget {
  @override
  _DatePickerSignUpWidgetState createState() => _DatePickerSignUpWidgetState();
}

class _DatePickerSignUpWidgetState extends State<DatePickerSignUpWidget> {
  DateTime? _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  final String hintText = "Data di nascita";

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(2000);
    _textEditingController = new TextEditingController(
        text: DateFormat("dd-MM-yyyy").format(_selectedDate!));
    context.read(userSignUpModel).birthDate = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: AlwaysDisabledFocusNode(),
      decoration: InputDecoration(
        icon: Icon(Icons.calendar_today),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _textEditingController,
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
                primary: const Color(0xFFFF7D45),
                onPrimary: Colors.white,
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
