import 'dart:async';

import 'package:dossier_medical/controllers/userController.dart';
import 'package:dossier_medical/utils.dart';
import 'package:flutter/material.dart';


class Authentification extends StatefulWidget {
  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  UserController userCtrl = UserController();

  String _emailOrPhone = '';
  String _password = '';
  String _emailReinit = '';
  bool showPassword = false;
  bool isEmailValid = true;
  bool isEmailValid2 = true;
  int _state = 0;
  String changeText = 'Connexion';
  bool isLoading = false;

  bool okoko = false;
  RegExp digitValidator = RegExp("[0-9]");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z][a-zA-Z0-9_.+-]*@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email);
  }

  void validateEmail(String email, GlobalKey<FormState> formKey) {
    setState(() {
      if (formKey == _formKey) {
        isEmailValid = isValidEmail(email);
      } else if (formKey == _formKey2) {
        isEmailValid2 = isValidEmail(email);
      }
    });
  }

  void authentifier() async {
    if (!_formKey.currentState!.validate()) {
      Utils.afficherSnack(context, "Tous les champs sont obligatoires");
      return;
    }

    Utils.closeKeyboard(context);

    setState(() {
      _state = 1;
    });

    // var userCtrl = context.read<UserController>();
    UserController userCtrl = UserController();
    try {
     // await userCtrl.signIn(_emailOrPhone, _password);

      Utils.afficherSnack(context, "Connexion réussie", Colors.green);
      await Future.delayed(Duration(seconds: 0));
      Navigator.pushReplacementNamed(context,'/home');
    } catch (e) {
      print(e);

      setState(() {
        _state = 0;
        changeText = 'Connexion';
      });
      Utils.afficherSnack(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/logo2.png',
                        width: 200,
                        height: 200,
                      ),


                              emailChamp(),
                              SizedBox(height: 16.0),
                              passwordChamp(),
                              SizedBox(height: 16.0),
                              loginButton2(),

                      SizedBox(height: 20.0),
                      textOr(),
                      SizedBox(height: 20.0),
                      privacySection(),
                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                    child: Form(
                                      key: _formKey2,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: SizedBox(
                                          height: 305,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 20, 20, 10),
                                                child: Text(
                                                  'Réinitialiser le mot de passe oublié',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 10, 20, 10),
                                                child: Text(
                                                  'Si vous avez un compte avec l\'e-mail fourni, nous vous enverrons les instructions pour réinitialiser votre mot de passe.',
                                                ),
                                              ),
                                              resetField(),
                                              resetButton(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        },
                        child: Text(
                          'Mot de passe oublié?',
                          style: TextStyle(
                            color: Colors.pink[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailChamp() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        labelText: 'Email',
        errorText: !isEmailValid ? 'Entrez une adresse e-mail valide' : null,
        border: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer un e-mail';
        } else if (!isEmailValid) {
          return 'Adresse e-mail invalide';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _emailOrPhone = value;
          isEmailValid = true; // Réinitialiser l'état lors de la modification
        });
        validateEmail(value, _formKey);
      },
      onSaved: (value) => _emailOrPhone = value!,
    );
  }

  Widget passwordChamp() {
    return TextFormField(
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        prefixIcon: Icon(Icons.key),
        suffixIcon: IconButton(
          onPressed: () {
            showPassword = !showPassword;
            setState(() {});
          },
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.lightGreen),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer un mot de passe';
        }
        return null;
      },
      onSaved: (value) => _password = value!,
    );
  }

  Widget loginButton2() {
    return Container(
      margin: EdgeInsets.all(0),
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.all(0.0),
          backgroundColor: Colors.lightGreen,
        ),
        child: _state != 1
            ? Text(
          changeText,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        )
            : SizedBox(
          height: 36.0,
          width: 36.0,
          child: CircularProgressIndicator(
            value: null,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        onPressed: () {
        //  authentifier();
          Navigator.pushReplacementNamed(context, '/home');
        },
      ),
    );
  }

  Widget textOr() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 1,
          color: Colors.black,
          margin: EdgeInsets.only(right: 10),
        ),
        Text(
          'ou',
          style: TextStyle(color: Colors.pink[600]),
        ),
        Container(
          width: 80,
          height: 1,
          color: Colors.black,
          margin: EdgeInsets.only(left: 10),
        ),
      ],
    );
  }

  Widget privacySection() {
    return Column(
      children: [
        Text(
          'Vous n\'avez pas de compte?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      Text(
            'Présentez-vous au Ministère de la santé publique',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 113, 152, 236),
            ),
          ),
      ],
    );
  }

  Widget resetField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          labelText: 'Adresse e-mail',
          errorText: !isEmailValid2 ? 'Entrez une adresse e-mail valide' : null,
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: Colors.grey)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Veuillez entrer un e-mail';
          } else if (!isEmailValid2) {
            return 'Adresse e-mail invalide';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            _emailReinit = value;
            isEmailValid2 = true;
          });
          validateEmail(value, _formKey2);
        },
        onSaved: (value) => _emailReinit = value!,
      ),
    );
  }

  Widget resetButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey2.currentState!.validate()) {
            _formKey2.currentState!.save();
         //   userCtrl.resetPassword(context, _emailReinit);
          }
        },
        child: Text('Réinitialiser'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          fixedSize: Size(350, 44),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }


  Widget phoneLoginButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/phoneauth');
        },
        icon: Icon(Icons.phone),
        label: Text('Utiliser un numéro de telephone'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}



