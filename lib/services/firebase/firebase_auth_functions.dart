import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifter/models/register_request.dart';
import 'package:lifter/models/user.dart';
import 'package:lifter/services/firebase/firestore_ref.dart';
import 'package:lifter/states/require_user.dart';

class FirebaseAuthFunctions {
  static Future<UserData?> registerUser(RegisterRequest request) async {
    // register user credentials
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );

    // set user information
    final currentUser = requireUser();
    // final deviceToken = await FirebaseMessaging.instance.getToken();
    final user = UserData(
      id: currentUser.uid,
      firstName: request.firstName,
      lastName: request.lastName,
      gender: request.gender,
      birthDate: request.birthDate,
      lastActive: DateTime.now(),
    );

    await currentUser.updateDisplayName(user.name);
    await FirestoreRef.users.doc(currentUser.uid).set(user);

    return user;
  }

  static Future<String?> updateDeviceToken() async {
    return '';
    // const updateTimeKey = 'device-token-last-update-time';
    // const deviceTokenKey = 'device-token';
    //
    // if (kDebugMode) {
    //   final deviceToken = await FirebaseMessaging.instance.getToken();
    //   log('deviceToken:\n$deviceToken');
    // }
    //
    // // skip if device id was update within 24 hours
    // final lastUpdateTime = await SharedPrefs.getDateTime(updateTimeKey);
    // if (lastUpdateTime != null && lastUpdateTime.difference(DateTime.now()).inDays < 1) {
    //   return await SharedPrefs.getString(deviceTokenKey);
    // }
    //
    // final deviceToken = await FirebaseMessaging.instance.getToken();
    // if (deviceToken == null || deviceToken.isEmpty) return null;
    // await updateUser({
    //   'deviceToken': deviceToken,
    //   'lastActive': Timestamp.now(),
    // });
    // await SharedPrefs.setDateTime(updateTimeKey, DateTime.now());
    // await SharedPrefs.setString(deviceTokenKey, deviceToken);
    // return deviceToken;
  }

  static Future<void> updateUser(Map<String, dynamic> data) async {
    final currentUser = requireUser();

    if (data['name'] != null) {
      currentUser.updateDisplayName(data['name']);
      data.remove('name');
    }

    await FirestoreRef.users.doc(currentUser.uid).update(data);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
