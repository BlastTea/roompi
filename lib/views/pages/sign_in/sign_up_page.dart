part of '../pages.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    super.key,
    required this.selectedRole,
  });

  final UserRole selectedRole;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, stateAuthentication) {
          stateAuthentication as AuthenticationDataLoaded;

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
                'Daftar',
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
                        child: Text('Lengkapi data diri',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Pastikan untuk mengingat semua data diri yang Anda inputkan, ya!',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller:
                              stateAuthentication.textControllerUsernameSignUp,
                          decoration: InputDecoration(
                            labelText: selectedRole == UserRole.remaja
                                ? 'Username'
                                : 'Nama Lengkap',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller:
                              stateAuthentication.textControllerNameSignup,
                          decoration: const InputDecoration(
                            labelText: 'Nama',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller:
                              stateAuthentication.textControllerEmailSignUp,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller:
                              stateAuthentication.textControllerPasswordSignUp,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () => MyApp.authenticationBloc.add(
                                  SetSignUpPasswordVisible(
                                      value: !stateAuthentication
                                          .isSignUpPasswordVisible)),
                              icon: Icon(
                                  !stateAuthentication.isSignUpPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                            ),
                          ),
                          obscureText:
                              !stateAuthentication.isSignUpPasswordVisible,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: stateAuthentication
                              .focusNodePasswordConfirmation.requestFocus,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          focusNode:
                              stateAuthentication.focusNodePasswordConfirmation,
                          controller: stateAuthentication
                              .textControllerPasswordConfirmationSignUp,
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi Password',
                            suffixIcon: IconButton(
                              onPressed: () => MyApp.authenticationBloc.add(
                                  SetSignUpPasswordConfirmationVisible(
                                      value: !stateAuthentication
                                          .isSignUpPasswordConfirmationVisible)),
                              icon: Icon(!stateAuthentication
                                      .isSignUpPasswordConfirmationVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          obscureText: !stateAuthentication
                              .isSignUpPasswordConfirmationVisible,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MyFilledButton(
                          onPressed: () => MyApp.authenticationBloc
                              .add(SignUpPressed(role: selectedRole)),
                          child: const Text('Daftar'),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
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
