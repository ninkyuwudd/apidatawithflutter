class Akundata{
  String? id;
  String? username;
  String? email;
  String? password;

  Akundata({
    this.id,
    this.username,
    this.email,
    this.password
  });

    Akundata.fromJson(Map<String,dynamic> json){
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }
}