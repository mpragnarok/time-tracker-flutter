import 'package:flutter/material.dart';
import 'auth.dart';

// AuthProvider
class AuthProvider extends InheritedWidget {
  // AuthProvider TODO 2: Provide access to Auth object
  AuthProvider({
    @required this.auth,
    @required this.child,
  });

  final AuthBase auth;
  //  AuthProvider TODO 4: Add a child widget
  final Widget child;
// AuthProvider TODO 1: Implement updateShouldNotify
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

//   final auth = AuthProvider.of(context);
  // AuthProvider TODO 3: Implement .of(context) method
  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();

    return provider.auth;
  }
}
