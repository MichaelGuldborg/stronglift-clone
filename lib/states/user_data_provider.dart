import 'package:flutter/material.dart';
import 'package:lifter/models/user.dart';
import 'package:lifter/services/firebase/firestore_ref.dart';
import 'package:lifter/states/future_map_notifier.dart';
import 'package:lifter/states/require_user.dart';
import 'package:provider/provider.dart';

UserData? useCurrentUser(BuildContext context) {
  final provider = UserDataProvider.of(context);
  return provider.currentUser;
}

class UserDataProvider extends FutureMapNotifier<UserData> {
  static UserDataProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<UserDataProvider>(context, listen: listen);
  }

  static Future<UserData?> _fetch(String uid) async {
    final response = await FirestoreRef.users.doc(uid).get();
    return response.data();
  }

  UserDataProvider() : super(fetch: _fetch);

  UserData? get currentUser {
    final currentUser = requireUser();
    return get(currentUser.uid);
  }
}
