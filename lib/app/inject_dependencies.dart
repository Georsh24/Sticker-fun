import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';

import 'data/repositories_impl/authentication_repository_impl.dart';
import 'data/repositories_impl/sing_up_repository_impl.dart';
import 'domain/repositories/authentication_repository.dart';
import 'domain/repositories/sign_up_repository.dart';

void injectDependencies() {
  // ignore: unused_local_variable
  var lazyPut = Get.i.lazyPut<AuthentiticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );
  Get.i.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
}
