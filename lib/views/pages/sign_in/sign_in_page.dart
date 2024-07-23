part of '../pages.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, stateAuthentication) {
          stateAuthentication as AuthenticationDataLoaded;

          if (kDebugMode) {
            // stateAuthentication.textControllerEmailSignIn.text = dotenv.env['USERNAME_DUMMY_ORANGTUA']!;
            // stateAuthentication.textControllerPasswordSignIn.text = dotenv.env['PASSWORD_DUMMY_ORANGTUA']!;

            // stateAuthentication.textControllerEmailSignIn.text = dotenv.env['USERNAME_DUMMY_REMAJA']!;
            // stateAuthentication.textControllerPasswordSignIn.text = dotenv.env['PASSWORD_DUMMY_REMAJA']!;

            stateAuthentication.textControllerEmailSignIn.text = dotenv.env['USERNAME_DUMMY_MENTOR']!;
            stateAuthentication.textControllerPasswordSignIn.text = dotenv.env['PASSWORD_DUMMY_MENTOR']!;
          }
          
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Masuk',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Mulai jelajahi Roompi', style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Anda bisa masuk sebagai pelajar, orang tua, atau mentor!',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: TextField(
                          controller: stateAuthentication.textControllerEmailSignIn,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: stateAuthentication.textControllerPasswordSignIn,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () => MyApp.authenticationBloc.add(SetSignInPasswordVisible(value: !stateAuthentication.isSignInPasswordVisible)),
                              icon: Icon(!stateAuthentication.isSignInPasswordVisible ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                          obscureText: !stateAuthentication.isSignInPasswordVisible,
                          onEditingComplete: () => MyApp.authenticationBloc.add(SignInPressed()),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MyFilledButton(
                          onPressed: () => MyApp.authenticationBloc.add(SignInPressed()),
                          child: const Text('Masuk'),
                        ),
                      ),
                      // TODO: Implement forgot password
                      // TextButton(
                      //   onPressed: () => NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => const SignInPage())),
                      //   child: const Text('Lupa password?'),
                      // ),
                      const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('dari Roompi'),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
