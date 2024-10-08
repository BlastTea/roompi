part of '../blocs.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(_authenticationDataLoaded) {
    on<SetAuthenticationState>((event, emit) => emit(event.state ?? _authenticationDataLoaded));

    on<SetSignInPasswordVisible>((event, emit) {
      _isSignInPasswordVisible = event.value;
      emit(_authenticationDataLoaded);
    });

    on<SetSignUpPasswordVisible>((event, emit) {
      _isSignUpPasswordVisible = event.value;
      emit(_authenticationDataLoaded);
    });

    on<SetSignUpPasswordConfirmationVisible>((event, emit) {
      _isSignUpPasswordConfirmationVisible = event.value;
      emit(_authenticationDataLoaded);
    });

    on<SignInPressed>((event, emit) async {
      if (_textControllerEmailSignIn.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(const SnackBar(content: Text('Email masih kosong')));
        return;
      }

      if (_textControllerPasswordSignIn.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(const SnackBar(content: Text('Password masih kosong')));
        return;
      }

      showLoadingDialog();

      try {
        await ApiHelper.signIn(
          email: _textControllerEmailSignIn.text.trim(),
          password: _textControllerPasswordSignIn.text.trim(),
        );
      } catch (e) {
        NavigationHelper.back();
        await ApiHelper.handleError(e);
        return;
      }

      while (NavigationHelper.canGoBack()) {
        NavigationHelper.back();
      }
      NavigationHelper.toReplacement(SlidePageRoute(pageBuilder: (context) => HomePage(key: homePageKey)));

      await Future.delayed(Durations.medium3);
      _setStateToInitial();
    });

    on<SignUpPressed>((event, emit) async {
      if (_textControllerUsernameSignUp.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(SnackBar(content: Text('${event.role == UserRole.remaja ? 'Username' : 'Nama Lengkap'} masih kosong')));
        return;
      }

      if (_textControllerNameSignUp.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(const SnackBar(content: Text('Nama masih kosong')));
        return;
      }

      if (_textControllerEmailSignUp.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(const SnackBar(content: Text('Email masih kosong')));
        return;
      }

      if (_textControllerPasswordSignUp.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(const SnackBar(content: Text('Password masih kosong')));
        return;
      }

      if (_textControllerPasswordConfirmationSignUp.text.trim().isEmpty) {
        NavigationHelper.clearSnackBars();
        NavigationHelper.showSnackBar(const SnackBar(content: Text('Konfirmasi Password masih kosong')));
        return;
      }

      showLoadingDialog();

      try {
        await ApiHelper.post(
          pathUrl: dotenv.env[switch (event.role) {
            UserRole.remaja => 'ENDPOINT_REGISTER_REMAJA',
            UserRole.parent => 'ENDPOINT_REGISTER_PARENT',
            _ => 'ENDPOINT_REGISTER_REMAJA',
          }]!,
          body: {
            (event.role == UserRole.remaja ? 'username' : 'nama_lengkap'): _textControllerUsernameSignUp.text.trim(),
            'name': _textControllerNameSignUp.text.trim(),
            'email': _textControllerEmailSignUp.text.trim(),
            'password': _textControllerPasswordSignUp.text.trim(),
            'konfirmasi_password': _textControllerPasswordConfirmationSignUp.text.trim(),
            // 'konfirmasi_password': _textControllerPasswordConfirmationSignUp.text.trim(),
            if (event.role == UserRole.remaja) 'role': event.role.value,
            if (event.role == UserRole.remaja) 'activity_id': event.activityType?.id,
            if (event.role == UserRole.remaja) 'paket_id': event.equalityPackageType?.id,
          },
          ignoreAuthorization: true,
        );
      } catch (e) {
        NavigationHelper.back();
        await ApiHelper.handleError(e);
        return;
      }

      if (event.activityType != null) NavigationHelper.back();

      if (event.equalityPackageType != null) NavigationHelper.back();

      NavigationHelper.back();
      NavigationHelper.back();
      NavigationHelper.back();
      NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => const SignUpSuccessfulPage()));

      await Future.delayed(Durations.medium3);
      _setStateToInitial();
    });
  }

  static final FocusNode _focusNodePasswordConfirmation = FocusNode();

  static final TextEditingController _textControllerUsernameSignUp = TextEditingController();
  static final TextEditingController _textControllerNameSignUp = TextEditingController();
  static final TextEditingController _textControllerEmailSignUp = TextEditingController();
  static final TextEditingController _textControllerPasswordSignUp = TextEditingController();
  static final TextEditingController _textControllerPasswordConfirmationSignUp = TextEditingController();
  static final TextEditingController _textControllerEmailSignIn = TextEditingController();
  static final TextEditingController _textControllerPasswordSignIn = TextEditingController();

  static bool _isSignInPasswordVisible = false;
  static bool _isSignUpPasswordVisible = false;
  static bool _isSignUpPasswordConfirmationVisible = false;

  static AuthenticationDataLoaded get _authenticationDataLoaded => AuthenticationDataLoaded(
        focusNodePasswordConfirmation: _focusNodePasswordConfirmation,
        textControllerUsernameSignUp: _textControllerUsernameSignUp,
        textControllerNameSignup: _textControllerNameSignUp,
        textControllerEmailSignUp: _textControllerEmailSignUp,
        textControllerPasswordSignUp: _textControllerPasswordSignUp,
        textControllerPasswordConfirmationSignUp: _textControllerPasswordConfirmationSignUp,
        textControllerEmailSignIn: _textControllerEmailSignIn,
        textControllerPasswordSignIn: _textControllerPasswordSignIn,
        isSignInPasswordVisible: _isSignInPasswordVisible,
        isSignUpPasswordVisible: _isSignUpPasswordVisible,
        isSignUpPasswordConfirmationVisible: _isSignUpPasswordConfirmationVisible,
      );

  void _setStateToInitial() {
    _textControllerUsernameSignUp.clear();
    _textControllerNameSignUp.clear();
    _textControllerEmailSignUp.clear();
    _textControllerPasswordSignUp.clear();
    _textControllerPasswordConfirmationSignUp.clear();
    _textControllerEmailSignIn.clear();
    _textControllerPasswordSignIn.clear();

    _isSignInPasswordVisible = false;
    _isSignUpPasswordVisible = false;
    _isSignUpPasswordConfirmationVisible = false;
  }
}
