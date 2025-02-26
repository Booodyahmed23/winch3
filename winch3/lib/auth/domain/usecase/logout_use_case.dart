import '../entites/account_entites.dart';
import '../repo/user_account.dart';

class RemoteLogoutUsecase {
  final AccountRepository accountRepository;
  RemoteLogoutUsecase(this.accountRepository);

  Future<LoginBaseResponse> call() async {
    return await accountRepository.remoteLogout();
  }
}
