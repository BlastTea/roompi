part of '../blocs.dart';

@immutable
abstract class ExerciseEvent {}

class SetExerciseState extends ExerciseEvent {
  SetExerciseState([this.state]);

  final ExerciseState? state;
}

class SetExerciseToInitial extends ExerciseEvent {}

class SetAssessmentToInitial extends ExerciseEvent {
  SetAssessmentToInitial({
    this.completer,
    this.withMessage = true,
  });

  final Completer<bool>? completer;
  final bool withMessage;
}

class InitializeExerciseData extends ExerciseEvent {
  InitializeExerciseData({
    this.completer,
    this.withLoadingDialog = false,
  });

  final Completer<bool>? completer;
  final bool withLoadingDialog;
}

class SetExerciseSelectedCategoryIndex extends ExerciseEvent {
  SetExerciseSelectedCategoryIndex({required this.index});

  final int index;
}

class ExerciseStartPressed extends ExerciseEvent {
  ExerciseStartPressed({
    required this.value,
    required this.categoryIndex,
    required this.partIndex,
    required this.index,
  });

  final Exercise value;
  final int categoryIndex;
  final int partIndex;
  final int index;
}

class SetSelectedAssessmentAnswer extends ExerciseEvent {
  SetSelectedAssessmentAnswer({required this.value});

  final int value;
}

class CheckAssessmentAnswer extends ExerciseEvent {}
