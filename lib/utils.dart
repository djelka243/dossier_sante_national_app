import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Utils {
  static const String ST_USER_KEY = 'USER_KEY';
  static const String ST_TOKEN_KEY = 'TOKEN_KEY';
  static const String API_URL = 'http://192.168.131.166:8000';

  static afficherSnack(BuildContext context, String msg,
      [Color color = Colors.red]) {
    final scaffold = ScaffoldMessenger.of(context);
    var snackbar = SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
    scaffold.showSnackBar(snackbar);
  }

  static lancerChargementDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Traitement en cours..."),
                SizedBox(height: 12.0),
                CircularProgressIndicator(),
              ],
            ));
      },
    );
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static offlineScreen() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/offline.json',
            height: 400.0,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10.0),
          Text(
            "Oups...",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            "Impossible de recuperer les ressources",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic),
          ),
          Text(
            "Verifier votre connexion internet",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  static getRequest(Uri url) async {
    var stockage = GetStorage();
    String token = stockage.read(ST_TOKEN_KEY) ?? "";
    print('tojken $token');
    var myHeader = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    try {
      var reponse = await http.get(url, headers: myHeader);
      String body = reponse.body;
      print('response body $body');
      var bodyMap = json.decode(body);
      bool statucCheck = reponse.statusCode == 200 || reponse.statusCode == 201;
      var resp = statucCheck ? bodyMap : bodyMap['error'];
      return {"resp": resp, 'status': statucCheck};
    } catch (e, stack) {
      print(e);
      print(stack);
      return {"resp": "Desolé, Erreur inattendue", 'status': false};
    }
  }

  static postRequest(Uri url, Map data) async {
    String final_data = json.encode(data);
    var myHeader = {'Content-Type': 'application/json',};
    try {
      await http.post(url, body: final_data, headers: myHeader);
      // String body = reponse.body;
      // print('response body $body');
      // var bodyMap = json.decode(body);
      // bool statucCheck = reponse.statusCode == 200 || reponse.statusCode == 201;
      // var resp = statucCheck ? bodyMap : bodyMap['error'];
      // return {"resp": resp, 'status': statucCheck};
    } catch (e, stack) {
      print(e);
      print(stack);
      // return {"resp": "Desolé, Erreur inattendue", 'status': false};
    }
  }


}
