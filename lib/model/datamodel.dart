class Datamodel{
  int? id;
  String? firstname;
  String? lastname;
  String? phone;

  Datamodel({
    this.id,
    this.firstname,
    this.lastname,
    this.phone
  });

  Datamodel.fromJson(Map<String,dynamic> json){
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
  }
}