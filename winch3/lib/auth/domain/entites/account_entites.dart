class Account {
  final String? password;
  final String? firstName;
  final String? secondName;
  final String? email;
  final String? retypePassword;
  final String? mobileNumber;
  final String? location;
  final String? brand;
  final String? model;
  final String? carplate;
  final String? message;
  Account({
    this.firstName,
    this.password,
    this.secondName,
    this.email,
    this.mobileNumber,
    this.location,
    this.brand,
    this.model,
    this.carplate,
    this.message,
    this.retypePassword,
   });
}

class LoginBaseResponse {
  bool status;
  String message;

  LoginBaseResponse({required this.status, required this.message});
}
