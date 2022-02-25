import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifter/models/identifiable.dart';

class UserData extends Identifiable {
  @override
  final String id;
  final String firstName;
  final String lastName;
  final String? gender;
  final DateTime? birthDate;
  final String? deviceToken;
  final DateTime? lastActive;

  final ScheduleFrequency frequency;
  // final DateTime? lastWorkoutTime;

  // final List<bool> frequencyDays = [];

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.birthDate,
    this.deviceToken,
    this.lastActive,
    this.frequency = ScheduleFrequency.NONE,
    // this.lastWorkoutTime,
  });

  String get name => '$firstName $lastName';

  String get age {
    if (birthDate == null) return '';
    final diffInDays = DateTime.now().difference(birthDate!).inDays;
    return (diffInDays / 365).floor().toString();
  }

  static UserData serializer(dynamic map) => UserData.fromMap(map);

  factory UserData.fromMap(Map<String, dynamic> map) {
    // print('User.fromMap: ${map['id']}');
    return UserData(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'] ?? 0,
      birthDate: map['birthDate'] == null ? null : (map['birthDate'] as Timestamp).toDate(),
      deviceToken: map['deviceToken'],
      lastActive: map['lastActive'] == null ? null : (map['lastActive'] as Timestamp).toDate(),
      frequency: ScheduleFrequency.values[map['frequency'] ?? 0],
      // lastWorkoutTime: map['lastWorkoutTime'] == null ? null : (map['lastWorkoutTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthDate': birthDate == null ? null : Timestamp.fromDate(birthDate!),
      'deviceToken': deviceToken,
      'lastActive': lastActive == null ? null : Timestamp.fromDate(lastActive!),
      'frequency': frequency.index,
      // 'lastWorkoutTime': lastWorkoutTime == null ? null : Timestamp.fromDate(lastWorkoutTime!),
    };
  }
}

enum ScheduleFrequency {
  NONE,
  X2WEEK,
  X3WEEK,
  X4WEEK,
  X5WEEK,
  X6WEEK,
  EVERYDAY,
  EVERY_OTHER_DAY,
  EVERY_2_DAYS,
}

String frequencyToString(ScheduleFrequency? frequency) {
  if (frequency == null) return '';
  return [
    '',
    '2x/week',
    '3x/week',
    '4x/week',
    '5x/week',
    '6x/week',
    'Everyday',
    'Every Other Day',
    'Every Two Days'
  ][frequency.index];
}
