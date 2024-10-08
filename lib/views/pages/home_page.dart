part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _textControllerParentCode = TextEditingController();

  int _selectedIndex = 0;

  void setSelectedIndex(int index) => setState(() => _selectedIndex = index);

  Future<void> _handleSubmitParentCode() async {
    if (_textControllerParentCode.text.trim().isEmpty) {
      NavigationHelper.clearSnackBars();
      NavigationHelper.showSnackBar(const SnackBar(content: Text('Kode Orang Tua masih kosong')));
      return;
    }

    showLoadingDialog();

    try {
      await ApiHelper.post(
        pathUrl: dotenv.env['ENDPOINT_LINKED']!,
        body: {
          'kode_orang_tua': _textControllerParentCode.text.trim(),
        },
      );
    } catch (e) {
      NavigationHelper.back();
      ApiHelper.handleError(e);
      return;
    }

    try {
      await ApiHelper.signInWithToken();

      if (currentUser != null) {
        setState(() {});
      }
    } catch (e) {
      NavigationHelper.back();
      ApiHelper.handleError(e);
      return;
    }

    NavigationHelper.back();
  }

  @override
  Widget build(BuildContext context) => currentUser?.role == UserRole.remaja && currentUser?.detail?.mapOrNull(remaja: (value) => value.kodeOrangTua) == null
      ? Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: const IconButton(
              onPressed: ApiHelper.signOut,
              icon: Icon(Icons.logout),
              tooltip: 'Logout',
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kode Orang Tua',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Yuk, kaitkan dengan akun orang tua!',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: _textControllerParentCode,
                    decoration: const InputDecoration(
                      labelText: 'Masukkan Kode Orang Tua',
                    ),
                    onSubmitted: (value) => _handleSubmitParentCode(),
                  ),
                  const SizedBox(height: 16.0),
                  MyFilledButton(
                    onPressed: _handleSubmitParentCode,
                    child: const Text('Kirim'),
                  ),
                ],
              ),
            ),
          ),
        )
      : Scaffold(
          body: [
            const HomeFragment(),
            if (currentUser?.role == UserRole.remaja) const ExerciseFragment() else if (currentUser?.role == UserRole.mentor) const MeetFragment() else const HistoryExerciseFragment(),
            if (currentUser?.role == UserRole.remaja) const MeetFragment(),
            const ProfileFragment(),
          ][_selectedIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarTheme.of(context).copyWith(labelTextStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.bodySmall?.copyWith(color: kColorBorder))),
            child: MyNavigationBar(
              backgroundColor: kColorWhite,
              indicatorShape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
              elevation: 8.0,
              indicatorColor: kColorTonalBorder,
              destinations: [
                MyNavigationDestination(
                  selectedIcon: SvgPicture.asset(
                    'assets/svgs/home_selected.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                  icon: SvgPicture.asset(
                    'assets/svgs/home_unselected.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                  label: 'Beranda',
                ),
                MyNavigationDestination(
                  selectedIcon: SvgPicture.asset(
                    currentUser?.role == UserRole.remaja
                        ? 'assets/svgs/exercise_selected.svg'
                        : currentUser?.role == UserRole.parent
                            ? 'assets/svgs/exercise_selected.svg'
                            : 'assets/svgs/meet_selected.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                  icon: SvgPicture.asset(
                    currentUser?.role == UserRole.remaja
                        ? 'assets/svgs/exercise_unselected.svg'
                        : currentUser?.role == UserRole.parent
                            ? 'assets/svgs/exercise_unselected.svg'
                            : 'assets/svgs/meet_unselected.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                  label: currentUser?.role == UserRole.remaja
                      ? 'Latihan'
                      : currentUser?.role == UserRole.parent
                          ? 'Laporan'
                          : 'Meet',
                ),
                if (currentUser?.role == UserRole.remaja)
                  MyNavigationDestination(
                    selectedIcon: SvgPicture.asset(
                      'assets/svgs/meet_selected.svg',
                      width: 30.0,
                      height: 30.0,
                    ),
                    icon: SvgPicture.asset(
                      'assets/svgs/meet_unselected.svg',
                      width: 30.0,
                      height: 30.0,
                    ),
                    label: 'Meet',
                  ),
                MyNavigationDestination(
                  selectedIcon: SvgPicture.asset(
                    'assets/svgs/profile_selected.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                  icon: SvgPicture.asset(
                    'assets/svgs/profile_unselected.svg',
                    width: 30.0,
                    height: 30.0,
                  ),
                  label: 'Profil',
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: setSelectedIndex,
            ),
          ),
        );
}
