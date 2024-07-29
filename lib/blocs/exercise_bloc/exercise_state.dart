part of '../blocs.dart';

@immutable
abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseError extends ExerciseState {}

class ExerciseDataLoaded extends ExerciseState {
  ExerciseDataLoaded({
    required this.buttonKeys,
    required this.pageControllerAssesment,
    required this.scrollController,
    required this.exercises,
    required this.questionData,
    required this.wrongQuestionData,
    required this.currentActiveIndexes,
    required this.currentQuestionDataIndex,
    required this.selectedAnswerIndex,
    required this.selectedCategoryIndex,
  });

  final List<GlobalKey> buttonKeys;

  final PageController pageControllerAssesment;

  final ScrollController scrollController;

  final List<Exercise> exercises;

  final List<DataSoal> questionData;
  final List<DataSoal> wrongQuestionData;

  final List<int> currentActiveIndexes;
  final int currentQuestionDataIndex;
  final int selectedAnswerIndex;
  final int selectedCategoryIndex;
}
