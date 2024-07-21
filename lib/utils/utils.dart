import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:roompi/models/models.dart';
import 'package:roompi/views/pages/pages.dart';

part 'page_route.dart';

const kFontFamily = 'FeatherBold';

const kColorSurface = Color(0xFFFFFFFF);
const kColorPrimary = Color(0xFF00B351);
const kColorSelected = Color(0xFFD4718D);
const kColorBorder = Color(0xFF288303);
const kColorDivider = kColorBorder;
const kColorTonalBorder = kColorBorder;
const kColorTonalBorderSelected = Color(0xFFB74969);
const kColorBannerBackground = Color(0xFFFEF3E7);

const kColorWhite = Color(0xFFFFFFFF);
const kColorBlack = Color(0xFF000000);
const kColorYellow = Color(0xFFF9ED69);

const kBorderRadius = BorderRadius.all(Radius.circular(12.0));

const kBorderRadiusBanner = BorderRadius.all(Radius.circular(20.0));
const kBannerShadow = [BoxShadow(color: kColorBorder, offset: Offset(0.0, 5.0))];

const kDummyPictureProfileUrl = 'https://avatars.githubusercontent.com/u/116476102?v=4';

const keyToken = 'token';

final GlobalKey<HomePageState> homePageKey = GlobalKey();

User? currentUser;

late GenerativeModel model;
