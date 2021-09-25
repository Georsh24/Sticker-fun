import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/authentication_repository.dart';

class SessionController extends SimpleNotifier{
  User? _user;
  User? get user => _user;

  final _auth = Get.i.find<AuthentiticationRepository>();

  void setUser(User user){
    _user = user;
    notify();
  }

  Future<void> signOut()async{
    await _auth.singOut();
    _user = null;
  }
  @override
  void dispose() {
      print("sesion controller dispose");
    super.dispose();
  }
}


final sessionProvider = SimpleProvider(
  (_) => SessionController(),
  autoDispose: false,
);