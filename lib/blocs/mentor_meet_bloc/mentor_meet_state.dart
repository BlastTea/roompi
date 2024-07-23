part of '../blocs.dart';

@immutable
abstract class MentorMeetState {}

class MentorMeetDataLoaded extends MentorMeetState {
  MentorMeetDataLoaded({
    required this.textControllerTopicMeet,
    required this.textControllerDescriptionMeet,
    required this.textControllerStartTimeMeet,
    required this.textControllerEndTimeMeet,
    required this.textControllerDateMeet,
    required this.textControllerLinkMeet,
    required this.textControllerModuleMeet,
    required this.textControllerParticipantCountMeet,
  });

  final TextEditingController textControllerTopicMeet;
  final TextEditingController textControllerDescriptionMeet;
  final TextEditingController textControllerStartTimeMeet;
  final TextEditingController textControllerEndTimeMeet;
  final TextEditingController textControllerDateMeet;
  final TextEditingController textControllerLinkMeet;
  final TextEditingController textControllerModuleMeet;
  final TextEditingController textControllerParticipantCountMeet;
}
