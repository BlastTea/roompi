part of '../blocs.dart';

class MentorMeetBloc extends Bloc<MentorMeetEvent, MentorMeetState> {
  MentorMeetBloc() : super(_mentorMeetDataLoaded) {
    on<SetMentorMeetState>(
        (event, emit) => emit(event.state ?? _mentorMeetDataLoaded));

    on<StoreMeetPressed>((event, emit) async {
      final validationMessage = _validateMeetForm();
      if (validationMessage != null) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(
            SnackBar(content: Text(validationMessage)));
        return;
      }

      showLoadingDialog();

      try {
        await ApiHelper.post(
          pathUrl: dotenv.env['ENDPOINT_MEET_MENTOR_ADD']!,
          body: {
            "topik": _textControllerTopicMeet.text.trim(),
            "deskripsi": _textControllerDescriptionMeet.text.trim(),
            "jam_mulai": _textControllerStartTimeMeet.text.trim(),
            "jam_berakhir": _textControllerEndTimeMeet.text.trim(),
            "tanggal": _textControllerDateMeet.text.trim(),
            "link": _textControllerLinkMeet.text.trim(),
            "materi": _textControllerModuleMeet.text.trim(),
            "total_remaja": _textControllerParticipantCountMeet.text.trim()
          },
        );
      } catch (e) {
        NavigationHelper.back();
        await ApiHelper.handleError(e);
        return;
      }

      NavigationHelper.back();
      NavigationHelper.back();
      NavigationHelper.back();
      NavigationHelper.to(SlidePageRoute(
          pageBuilder: (context) => const StoreMeetSuccessFulPage()));

      await Future.delayed(Durations.medium3);
      _setStateToInitial();
    });
  }

  static final TextEditingController _textControllerTopicMeet =
      TextEditingController();
  static final TextEditingController _textControllerDescriptionMeet =
      TextEditingController();
  static final TextEditingController _textControllerStartTimeMeet =
      TextEditingController();
  static final TextEditingController _textControllerEndTimeMeet =
      TextEditingController();
  static final TextEditingController _textControllerDateMeet =
      TextEditingController();
  static final TextEditingController _textControllerLinkMeet =
      TextEditingController();
  static final TextEditingController _textControllerModuleMeet =
      TextEditingController();
  static final TextEditingController _textControllerParticipantCountMeet =
      TextEditingController();

  static MentorMeetDataLoaded get _mentorMeetDataLoaded => MentorMeetDataLoaded(
        textControllerTopicMeet: _textControllerTopicMeet,
        textControllerDescriptionMeet: _textControllerDescriptionMeet,
        textControllerStartTimeMeet: _textControllerStartTimeMeet,
        textControllerEndTimeMeet: _textControllerEndTimeMeet,
        textControllerDateMeet: _textControllerDateMeet,
        textControllerLinkMeet: _textControllerLinkMeet,
        textControllerModuleMeet: _textControllerModuleMeet,
        textControllerParticipantCountMeet: _textControllerParticipantCountMeet,
      );

  void _setStateToInitial() {
    _textControllerTopicMeet.clear();
    _textControllerDescriptionMeet.clear();
    _textControllerStartTimeMeet.clear();
    _textControllerEndTimeMeet.clear();
    _textControllerDateMeet.clear();
    _textControllerLinkMeet.clear();
    _textControllerModuleMeet.clear();
    _textControllerParticipantCountMeet.clear();
  }

  String? _validateMeetForm() {
    if (_textControllerTopicMeet.text.trim().isEmpty) {
      return 'Topik masih kosong';
    }

    if (_textControllerDescriptionMeet.text.trim().isEmpty) {
      return 'Deskripsi kosong';
    }

    if (_textControllerStartTimeMeet.text.trim().isEmpty) {
      return 'Jam mulai masih kosong';
    }

    if (_textControllerEndTimeMeet.text.trim().isEmpty) {
      return 'Jam berakhir masih kosong';
    }

    if (_textControllerDateMeet.text.trim().isEmpty) {
      return 'Tanggal masih kosong';
    }

    if (_textControllerLinkMeet.text.trim().isEmpty) {
      return 'Link masih kosong';
    }

    if (_textControllerModuleMeet.text.trim().isEmpty) {
      return 'Materi masih kosong';
    }

    if (_textControllerParticipantCountMeet.text.trim().isEmpty) {
      return 'Total paritisipan masih kosong';
    }

    return null;
  }
}
