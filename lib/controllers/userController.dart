
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../models/userModel.dart';
import '../utils.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class UserController extends ChangeNotifier {
  String? token;
  UserModel user = UserModel();
  GetStorage stockage = GetStorage();


  void storeUser(Map<String, dynamic> data) {
    // Convertissez les données en objet UserModel
    user = UserModel.fromJson(data);

    stockage.write(Utils.ST_USER_KEY, data);
    // Stockez les données dans le Provider
    notifyListeners();
  }

  readLocalUser() {
    var local = stockage.read(Utils.ST_USER_KEY) as Map<String, dynamic>?;
    if (local != null) {
      user = UserModel.fromJson(local);
    }
  }

  UserModel? readLocalUser2() {
    var local = stockage.read(Utils.ST_USER_KEY) as Map<String, dynamic>?;
    if (local != null) {
      user = UserModel.fromJson(local);
      return user;
    }
    return null; // Si les données ne sont pas disponibles localement
  }

  storeToken(String data) {
    token = data;
    stockage.write(Utils.ST_TOKEN_KEY, data);
  }

  readLocalToken() {
    var local = stockage.read(Utils.ST_TOKEN_KEY) as String?;
    if (local != null) {
      token = local;
    }
  }

  logOut() async {
    await GetStorage().remove(Utils.ST_USER_KEY);
    await GetStorage().remove(Utils.ST_TOKEN_KEY);
    user = UserModel();
    token = null;
  }

  authentifier(Map data) async {
    var url = Uri.parse("${Utils.API_URL}/api/auth");
    Map resultat = await Utils.postRequest(url, data);

    if (resultat['status']) {
      Map resp = resultat['resp'];
      storeToken(resp['token']);
      storeUser(resp['user']);
      return resp;
    } else {
      throw new Exception(resultat['resp']);
    }
  }


  // Fonction pour compresser l'image
  Future<File> compressImage(File imageFile) async {
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

    // Redimensionner l'image à une taille spécifique (par exemple, 800x800 pixels)
    img.Image resizedImage = img.copyResize(image, width: 800, height: 800);

    // Convertir l'image compressée en bytes
    List<int> compressedBytes = img.encodeJpg(resizedImage);

    // Créer un nouveau fichier avec l'image compressée
    File compressedImage = File(imageFile.path)
      ..writeAsBytesSync(compressedBytes);

    return compressedImage;
  }


}
