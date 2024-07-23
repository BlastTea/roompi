part of 'pages.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.viewPaddingOf(context).top * 3),
              child: Image.asset('assets/images/16874.jpg'),
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
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Belajar adalah jendela dunia, jelajahi duniamu bersama Roompi sekarang!',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyFilledButton(
                onPressed: () => NavigationHelper.to(SlidePageRoute(
                    pageBuilder: (context) =>
                        SignUpSelectRolePage(key: homePageKey))),
                child: const Text('Mulai'),
              ),
              const SizedBox(height: 10.0),
              MyFilledButton.tonal(
                onPressed: () => NavigationHelper.to(SlidePageRoute(
                    pageBuilder: (context) => const SignInPage())),
                backgroundColor: kColorWhite,
                foregroundColor: kColorBorder,
                borderColor: kColorBorder,
                child: const Text('Sudah Punya Akun'),
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('dari Roompi'),
                  )),
            ],
          ),
        ),
      );
}
