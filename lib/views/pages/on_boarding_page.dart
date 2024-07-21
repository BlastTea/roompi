part of 'pages.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
              child: Image.asset('assets/images/_476871824.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Belajar itu\nmenyenangkan 👋',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyFilledButton(
                onPressed: () => NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => SignUpSelectRolePage(key: homePageKey))),
                child: const Text('Mulai'),
              ),
              const SizedBox(height: 8.0),
              MyFilledButton.tonal(
                onPressed: () => NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => const SignInPage())),
                backgroundColor: kColorWhite,
                foregroundColor: kColorBorder,
                borderColor: kColorBorder,
                child: const Text('Sudah Punya Akun'),
              ),
            ],
          ),
        ),
      );
}
