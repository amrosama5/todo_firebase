class UserModel {
  static const String collectionName="Users";
  late String id;
  late String name;
  late String email;
  late String phone;
  late bool emailVerified;

  UserModel(
      {required this.id,required this.name,
      required this.phone,
      required this.email,
        this.emailVerified=false});


  UserModel.fromJson(Map<String,dynamic> json):this(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    emailVerified: json['emailVerified'],
  );


  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'phone':phone,
      'emailVerified':emailVerified
    };
  }

}
