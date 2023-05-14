class UserModel {
  String? id;
  String? email;
  String? password;
  int score = 0;
  UserModel({this.id, this.email, this.password,this.score = 0});

  toJson() {
    return {
      "email": email,
      "password": email,
      "score": score,
    };
  }
}
