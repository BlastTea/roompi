import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:m_widget/m_widget.dart';
import 'package:roompi/blocs/blocs.dart';
import 'package:roompi/services/services.dart';
import 'package:roompi/utils/utils.dart';
import 'package:roompi/views/pages/pages.dart';
import 'package:roompi/views/widgets/widgets.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load();

  await MWidget.initialize(
    defaultLanguage: LanguageType.indonesiaIndonesian,
    defaultTheme: ThemeValue(
      themeMode: ThemeMode.light,
      color: kColorPrimary,
      withCustomColors: true,
      useDynamicColors: true,
    ),
  );

  try {
    await ApiHelper.signInWithToken();
  } catch (e) {
    ApiHelper.handleError(e);
  }

  model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: dotenv.env['GEMINI_API_KEY']!,
    safetySettings: [
      SafetySetting(
        HarmCategory.dangerousContent,
        HarmBlockThreshold.none,
      ),
      SafetySetting(
        HarmCategory.harassment,
        HarmBlockThreshold.none,
      ),
      SafetySetting(
        HarmCategory.hateSpeech,
        HarmBlockThreshold.none,
      ),
      SafetySetting(
        HarmCategory.sexuallyExplicit,
        HarmBlockThreshold.none,
      ),
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static AuthenticationBloc authenticationBloc = AuthenticationBloc();
  static LeaderboardBloc leaderboardBloc = LeaderboardBloc();
  static ExerciseBloc exerciseBloc = ExerciseBloc();
  static MeetBloc meetBloc = MeetBloc();
  static HistoryExerciseBloc historyExerciseBloc = HistoryExerciseBloc();
  static EditProfileBloc editProfileBloc = EditProfileBloc();
  static ChatbotBloc chatbotBloc = ChatbotBloc();
  static ChangePasswordBloc changePasswordBloc = ChangePasswordBloc();

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authenticationBloc),
        BlocProvider(create: (context) => leaderboardBloc),
        BlocProvider(create: (context) => exerciseBloc),
        BlocProvider(create: (context) => meetBloc),
        BlocProvider(create: (context) => historyExerciseBloc),
        BlocProvider(create: (context) => editProfileBloc),
        BlocProvider(create: (context) => chatbotBloc),
        BlocProvider(create: (context) => changePasswordBloc),
      ],
      child: RoompiMaterialApp(
        title: 'ROOOMPI',
        home: currentUser != null
            ? HomePage(key: homePageKey)
            : const OnBoardingPage1(),
      ),
    );
  }
}
