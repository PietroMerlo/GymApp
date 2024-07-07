import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/constant/spaces.dart';
import 'package:gymapp/models/excercise.dart';
import 'package:gymapp/models/workout.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateExercise extends StatelessWidget {
  final NotifierProvider<Workout, List<Exercise>> selectedWorkoutProvider;
  final _formKey = GlobalKey<FormBuilderState>();

  CreateExercise({super.key, required this.selectedWorkoutProvider});

  void onSetsAddRemovePressed(int incrementValue) {
    _formKey.currentState!.fields['sets']!.didChange(
        (int.parse(_formKey.currentState!.fields['sets']!.value) +
                incrementValue)
            .toString());
  }

  void onRepsAddRemovePressed(int incrementValue) {
    _formKey.currentState!.fields['reps']!.didChange(
        (int.parse(_formKey.currentState!.fields['reps']!.value) +
                incrementValue)
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea esercizio'),
      ),
      body: Consumer(builder: (context, ref, child) {
        return FormBuilder(
          key: _formKey,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            _formKey.currentState!.fields['sets']!.value == '0'
                                ? null
                                : onSetsAddRemovePressed(-1),
                        icon: const Icon(Icons.remove),
                      ),
                      kMediumHorizontalSpacing,
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'sets',
                          initialValue: '0',
                          decoration: const InputDecoration(
                            labelText: 'Sets',
                          ),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.integer(),
                            FormBuilderValidators.min(0),
                          ]),
                        ),
                      ),
                      kMediumHorizontalSpacing,
                      IconButton(
                        onPressed: () => onSetsAddRemovePressed(1),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            _formKey.currentState!.fields['reps']!.value == '0'
                                ? null
                                : onRepsAddRemovePressed(-1),
                        icon: const Icon(Icons.remove),
                      ),
                      kMediumHorizontalSpacing,
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'reps',
                          initialValue: '0',
                          decoration:
                              const InputDecoration(labelText: 'Ripetizioni'),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.integer(),
                            FormBuilderValidators.min(0),
                          ]),
                        ),
                      ),
                      kMediumHorizontalSpacing,
                      IconButton(
                        onPressed: () => onRepsAddRemovePressed(1),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  FormBuilderTextField(
                    name: 'weight',
                    decoration: const InputDecoration(
                      labelText: 'Peso',
                      hintText: 'kg',
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.min(0),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'rest',
                    decoration: const InputDecoration(
                      labelText: 'Riposo',
                      hintText: 'Secondi',
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.min(0),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'notes',
                    decoration: const InputDecoration(labelText: 'Note'),
                  ),
                  kLargeVerticalSpacing,
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        ref.read(selectedWorkoutProvider.notifier).addExercise(
                              name: _formKey.currentState!.value['name']
                                  .toString(),
                              sets: int.parse(_formKey
                                  .currentState!.value['sets']
                                  .toString()),
                              reps: int.parse(_formKey
                                  .currentState!.value['reps']
                                  .toString()),
                              weight: int.parse(_formKey
                                  .currentState!.value['weight']
                                  .toString()),
                              rest: int.parse(_formKey
                                  .currentState!.value['rest']
                                  .toString()),
                            );

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Crea esercizio'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
