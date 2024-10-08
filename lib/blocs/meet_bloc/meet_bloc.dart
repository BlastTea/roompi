part of '../blocs.dart';

class MeetBloc extends Bloc<MeetEvent, MeetState> {
  MeetBloc() : super(MeetInitial()) {
    on<SetMeetState>((event, emit) => emit(event.state ?? _meetDataLoaded));

    on<SetMeetToInitial>((event, emit) {
      _meets.clear();

      emit(MeetInitial());
    });

    on<InitializeMeetData>((event, emit) async {
      if (event.completer == null) emit(MeetInitial());

      try {
        if (currentUser?.role == UserRole.remaja) {
          _meets = await ApiHelper.get(pathUrl: dotenv.env['ENDPOINT_MEET']!)
              .then((value) => (value['data'] as List)
                  .map((e) => Meet.fromJson(e))
                  .toList());
        } else {
          _meets = await ApiHelper.get(
                  pathUrl: dotenv.env['ENDPOINT_MEET_MENTOR_LIST']!)
              .then((value) => (value['data'] as List)
                  .map((e) => Meet.fromJson(e))
                  .toList());
        }
      } catch (e) {
        event.completer?.complete(false);
        ApiHelper.handleError(e);
        return;
      }

      event.completer?.complete(true);
      emit(_meetDataLoaded);
    });

    on<PublishMeetPressed>((event, emit) async {
      try {
        await ApiHelper.post(
          pathUrl:
              '${dotenv.env['ENDPOINT_MEET_MENTOR_PUBLISH']}/${event.meetId}',
        );
      } catch (e) {
        NavigationHelper.back();
        await ApiHelper.handleError(e);
        return;
      }
    });
  }

  List<Meet> _meets = [];

  MeetDataLoaded get _meetDataLoaded => MeetDataLoaded(
        meets: _meets,
      );
}
