import '../entites/account_entites.dart';
import '../repo/user_account.dart';

class signupUsecase {
  AccountRepository _accountRepository;

  signupUsecase(this._accountRepository);

  Future<Account> call(
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
  ) async {
    return await _accountRepository.signup(password, firstName, secondName,
        email, retypePassword, mobileNumber, location, brand, model, carplate);
  }
}
