import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifter/models/user.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/states/require_user.dart';

class FirestoreRef {
  static CollectionReference<UserData> get users => FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (snapshot, _) => UserData.fromMap({...snapshot.data()!, 'id': snapshot.id}),
        toFirestore: (model, _) => model.toMap(),
      );

  static CollectionReference<Workout> get workouts {
    final user = requireUser();
    return FirebaseFirestore.instance.collection('users/${user.uid}/workouts').withConverter(
          fromFirestore: (snapshot, _) => Workout.fromMap({...snapshot.data()!, 'id': snapshot.id}),
          toFirestore: (model, _) => model.toMap(),
        );
  }

  static CollectionReference<Workout> get history {
    final user = requireUser();
    return FirebaseFirestore.instance.collection('users/${user.uid}/history').withConverter(
      fromFirestore: (snapshot, _) => Workout.fromMap({...snapshot.data()!, 'id': snapshot.id}),
      toFirestore: (model, _) => model.toMap(),
    );
  }
}
