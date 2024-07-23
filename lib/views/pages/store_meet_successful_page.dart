part of 'pages.dart';

class StoreMeetSuccessFulPage extends StatelessWidget {
  const StoreMeetSuccessFulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/success_auth.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Selamat!',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Meet berhasil dibuat! Yuk, mulai mulai publikasikan!',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyFilledButton(
                onPressed: () {
                  NavigationHelper.back();
                  NavigationHelper.to(SlidePageRoute(
                      pageBuilder: (context) => const HomeFragment()));
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
