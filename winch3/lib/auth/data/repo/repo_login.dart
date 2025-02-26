// import '../../domain/entites/account_entites.dart';
// import '../../domain/repo/user_account.dart';
//
// class AccountRepositoryImlp implements AccountRepository {
//    late RemoteLoginDatasource remoteLoginDatasource;
//
//   AccountRepositoryImlp(this.remoteLoginDatasource);
//
//   @override
//   Future<LoginBaseResponse> remoteLogin(String email, String password) async {
//     return await remoteLoginDatasource.remoteLoginUser(email, password);
//   }
//
//   @override
//   Future<LoginBaseResponse> remoteLogout() async {
//     return await remoteLoginDatasource.remoteLogoutUser();
//   }
//   @override
//   Future<Account> signup(
//       String password,
//       String firstName,
//       String secondName,
//       String email,
//       String retypePassword,
//       String mobileNumber,
//       String location,
//       String brand,
//       String model,
//       String carplate) {
//     throw UnimplementedError();
//   }
// }
