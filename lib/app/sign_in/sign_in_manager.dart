import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInManger {
  SignInManger({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
//      cannot add any value after the stream is close, so we move it from finally to here
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async => _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async => _signIn(auth.signInWithFacebook);
}
