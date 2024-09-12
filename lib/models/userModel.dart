
class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.adresse,
    this.photo
  });
  String? uid;
  String? name;
  String? email;
  String? adresse;
  String? photo;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"] == null ? null : json["uid"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    photo: json["photo"] == null ? null : json["photo"],
    adresse: json["adresse"] == null ? null : json["adresse"],
  );

  Map<String, dynamic> toJson() => {
    "id": uid == null ? null : uid,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "photo": photo == null ? null : photo,
    "adresse": adresse == null ? null : adresse,
  };
}