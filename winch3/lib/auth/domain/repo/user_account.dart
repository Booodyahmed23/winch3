import '../entites/account_entites.dart';

abstract class AccountRepository {
  Future<Account> signup(
    String password,
    String firstName,
    String secondName,
    String email,
    String retypePassword,
    String mobileNumber,
    String location,
    String brand,
    String model,
    String carplate,
  );
  Future<LoginBaseResponse> remoteLogin(String email, String password);
  Future<LoginBaseResponse>  remoteLogout();
}
