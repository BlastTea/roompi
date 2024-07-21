import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:roompi/models/models.dart';
import 'package:roompi/services/services.dart';
import 'package:roompi/utils/utils.dart';
import 'package:roompi/views/pages/pages.dart';
import 'package:m_widget/m_widget.dart';
import 'package:http/http.dart' as http;
import 'package:roompi/views/widgets/widgets.dart';

part 'authentication_bloc/authentication_bloc.dart';
part 'authentication_bloc/authentication_event.dart';
part 'authentication_bloc/authentication_state.dart';

part 'leaderboard_bloc/leaderboard_bloc.dart';
part 'leaderboard_bloc/leaderboard_event.dart';
part 'leaderboard_bloc/leaderboard_state.dart';

part 'exercise_bloc/exercise_bloc.dart';
part 'exercise_bloc/exercise_event.dart';
part 'exercise_bloc/exercise_state.dart';

part 'meet_bloc/meet_bloc.dart';
part 'meet_bloc/meet_event.dart';
part 'meet_bloc/meet_state.dart';

part 'history_exercise_bloc/history_exercise_bloc.dart';
part 'history_exercise_bloc/history_exercise_event.dart';
part 'history_exercise_bloc/history_exercise_state.dart';

part 'edit_profile_bloc/edit_profile_bloc.dart';
part 'edit_profile_bloc/edit_profile_event.dart';
part 'edit_profile_bloc/edit_profile_state.dart';

part 'chatbot_bloc/chatbot_bloc.dart';
part 'chatbot_bloc/chatbot_event.dart';
part 'chatbot_bloc/chatbot_state.dart';

part 'change_password_bloc/change_password_bloc.dart';
part 'change_password_bloc/change_password_event.dart';
part 'change_password_bloc/change_password_state.dart';
