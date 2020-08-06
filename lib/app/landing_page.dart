import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChanged.listen((user) {
//      if user is null it'll print "user: null"
      print('user: ${user?.uid}');
    });
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: widget.auth.onAuthStateChanged,
        builder: (context, snapshot) {
          snapshot.connectionState
          if (snapshot.hasData) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: widget.auth,
//      Same as: onSignIn: (user) => _updateUser(user), onSignIn and _updateUser have the same signature(FirebaseUser)
                onSignIn: _updateUser,
              );
            }
            return HomePage(
              auth: widget.auth,
              onSignOut: () => _updateUser(null),
            );
          } else {
//            Spinner
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
