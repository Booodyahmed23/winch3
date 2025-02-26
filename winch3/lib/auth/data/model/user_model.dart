import '../../domain/entites/account_entites.dart';

class User extends Account {
  User({
    final String? password,
    final String? firstName,
    final String? secondName,
    final String? email,
    final String? retypePassword,
    final String? mobileNumber,
    final String? location,
    final String? brand,
    final String? model,
    final String? carplate,
    final String? message,
  }) : super(
          password: password,
          firstName: firstName,
          secondName: secondName,
          email: email,
          retypePassword: retypePassword,
          mobileNumber: mobileNumber,
          location: location,
          brand: brand,
          model: model,
          carplate: carplate,
          message: message,
        );

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'mobileNumber': mobileNumber,
      'location': location,
      'brand': brand,
      'model': model,
      'carplate': carplate,
      'message': message,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      password: map['password'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      email: map['email'],
      mobileNumber: map['mobileNumber'],
      location: map['location'],
      brand: map['brand'],
      model: map['model'],
      carplate: map['carplate'],
      message: map['message'],
    );
  }
}

