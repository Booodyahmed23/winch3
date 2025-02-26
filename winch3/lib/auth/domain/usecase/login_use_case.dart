import '../entites/account_entites.dart';
import '../repo/user_account.dart';

class LoginUsecase {
  AccountRepository _accountRepository;

  LoginUsecase(this._accountRepository);

  Future<LoginBaseResponse> call(String username, String password) async {
    return await _accountRepository.remoteLogin(username, password);
  }
}
