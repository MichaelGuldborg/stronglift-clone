
import 'package:firebase_auth/firebase_auth.dart';

User requireUser() => FirebaseAuth.instance.currentUser!;
