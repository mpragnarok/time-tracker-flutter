import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInBloc {
  //  Implement Auth in SignInBloc TODO 1: Add auth constructor
  SignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  //  Implement auth in SignInBloc TODO 2: pass functions as input arguments to other function
  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
//      cannot add any value after the stream is close, so we move it from finally to here
      _setIsLoading(false);
      //  Implement auth in SignInBloc TODO 3: forwarding exception up to the calling code
      rethrow;
    }
  }

  //  Implement auth in SignInBloc TODO 3: sign in method takes a function which returns a future of type User, auth.signInAnonymously is a function type
  Future<User> signInAnonymously() async => _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async => _signIn(auth.signInWithFacebook);
}
