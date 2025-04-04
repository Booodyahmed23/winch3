import '../../domain/entites/account_entites.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteLoginDatasource {
  Future<LoginBaseResponse> remoteLoginUser(String email, String password);
  Future<LoginBaseResponse> remoteLogoutUser();
}

class RemoteLoginDatasourceImpl implements RemoteLoginDatasource {
  @override
  Future<LoginBaseResponse> remoteLoginUser(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return LoginBaseResponse(status: true, message: "successfully login");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoginBaseResponse(status: false, message: 'User not found');
      } else if (e.code == 'wrong-password') {
        return LoginBaseResponse(status: false, message: "Wrong password");
      } else if (e.code == 'invalid-email') {
        return LoginBaseResponse(status: false, message: "Invalid email");
      }
    } catch (e) {
      return LoginBaseResponse(status: false, message: e.toString());
    }
    return LoginBaseResponse(status: false, message: "Server Error");
  }

  @override
  Future<LoginBaseResponse> remoteLogoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return LoginBaseResponse(status: true, message: "Logout Successfully");
    } catch (e) {
      return LoginBaseResponse(status: false, message: e.toString());
    }
  }
}
