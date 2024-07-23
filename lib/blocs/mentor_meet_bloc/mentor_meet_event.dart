part of '../blocs.dart';

@immutable
abstract class MentorMeetEvent {}

class SetMentorMeetState extends MentorMeetEvent {
  SetMentorMeetState([this.state]);

  final MentorMeetState? state;
}

class StoreMeetPressed extends MentorMeetEvent {}
