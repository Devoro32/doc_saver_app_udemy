import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class UserInfoProvider extends ChangeNotifier {
  String _userName = '';
  String get userName => _userName;

  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;
  //String userId = FirebaseAuth.instance.currentUser!.uid;
  getUserName() async {
    //two methods to get data from the database 1 stream 2. get method
    await _firebaseDatabase
        .ref()
        .child('user_info/${user!.uid}')
        //.child('user_info/$userId')
        .get()
        .then((value) {
      print(value.value); //->{username: Edane Barton}
      _userName = (value.value as Map)['username'].toString();
      notifyListeners();
    });
  }

  updateUsername(String username, BuildContext context) async {
    await _firebaseDatabase
        .ref()
        //.child('user_info/$userId')
        .child('user_info/${user!.uid}')
        .update({'username': username}).then((value) {
      _userName = username;
      notifyListeners();
      Navigator.of(context).pop();
    });
  }
}
