import 'package:dossier_medical/controllers/userController.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  // ignore: unused_field
  String _email = '';
  // ignore: unused_field
  String _name = '';
  // ignore: unused_field
  String _password = '';
  // ignore: unused_field
  String _passwordConf = '';
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConf = TextEditingController();
  TextEditingController number = TextEditingController();
  bool isNumber = true;
  UserController userCtrl = UserController();
  bool samePassword(String password, String passwordConf) {
    return password == passwordConf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
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
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez entrer un nom';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez entrer un email';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                          prefixIcon: Icon(Icons.key),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: passwordConf,
                        decoration: InputDecoration(
                          labelText: 'Confirmer le mot de passe',
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                          prefixIcon: Icon(Icons.key),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez confirmer le mot de passe';
                          }
                          return null;
                        },
                        onSaved: (value) => _passwordConf = value!,
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              try {
                                if (!samePassword(password.text.trim(),
                                    passwordConf.text.trim())) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Les mots de passe ne correspondent pas.'),
                                      backgroundColor: Colors.red,
                                      action: SnackBarAction(
                                        label: 'retour',
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                  return;
                                }





                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erreur inconnue'),
                                    backgroundColor: Colors.red,
                                    action: SnackBarAction(
                                      label: 'retour',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                print(e);
                              }
                            }
                          },
                          child: Text('S\'inscrire'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            fixedSize: Size(370, 44),
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            primary: Colors.deepOrange,
                            textStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      googleSignUpButton(),
                      facebookSignUpButton(),
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

  Widget googleSignUpButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
      child: ElevatedButton.icon(
        onPressed: isLoading
            ? null
            : () async {
          try {
            setState(() {
              isLoading = true;
            });

          //  final UserCredential userCredential =await userCtrl.signUpWithGoogle(context);
       //     print('Google login successful: ${userCredential.user?.displayName}');
          } catch (e) {
            print('Google login failed: $e');
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        icon: Image.asset('images/google.png', height: 24, width: 24),
        label: Text(' S\'inscrire avec Google '),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget facebookSignUpButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: ElevatedButton.icon(
        onPressed: isLoading
            ? null
            : () async {
          try {
            setState(() {
              isLoading = true;
            });

           // final UserCredential userCredential =   await userCtrl.signUpWithFacebook(context);
        //    print('Facebook login successful: ${userCredential.user?.displayName}');
            setState(() {
              isLoading = false;
            });
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            print('Facebook login failed: $e');
          }
        },
        icon: Image.asset('images/fb.png', height: 24, width: 24),
        label: Text('S\'inscrire avec Facebook'),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
