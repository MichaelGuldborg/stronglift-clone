import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifter/components/buttons/primary_button.dart';
import 'package:lifter/models/exercise.dart';
import 'package:lifter/states/require_user.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseEditPage extends StatefulWidget {
  const ExerciseEditPage({Key? key}) : super(key: key);

  @override
  State<ExerciseEditPage> createState() => _ExerciseEditPageState();
}

class _ExerciseEditPageState extends State<ExerciseEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _data = {};

  @override
  Widget build(BuildContext context) {
    final exercise = ModalRoute.of(context)?.settings.arguments as Exercise?;

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  initialValue: exercise?.name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(label: Text('Name')),
                  onSaved: (String? s) => _data['name'] = s,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  initialValue: exercise?.sets.toString() ?? '3',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(label: Text('Sets')),
                  onSaved: (String? s) => _data['sets'] = s,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  initialValue: exercise?.reps.toString() ?? '8',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(label: Text('Reps')),
                  onSaved: (String? s) => _data['reps'] = s,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  initialValue: exercise?.weight.toString() ?? '0',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(label: Text('Weight')),
                  onSaved: (String? s) => _data['weight'] = s,
                ),
              ),
              PrimaryButton(
                text: 'Save',
                onPressed: () {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  _formKey.currentState?.save();

                  final request = Exercise(
                    id: exercise?.id,
                    name: _data['name'],
                    sets: int.parse(_data['sets']),
                    reps: int.parse(_data['reps']),
                    weight: double.parse(_data['weight']),
                  );


                  Navigator.pop(context, request);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
