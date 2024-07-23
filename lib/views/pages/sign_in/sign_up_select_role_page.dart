part of '../pages.dart';

class SignUpSelectRolePage extends StatefulWidget {
  const SignUpSelectRolePage({super.key});

  @override
  State<SignUpSelectRolePage> createState() => _SignUpSelectRolePageState();
}

class _SignUpSelectRolePageState extends State<SignUpSelectRolePage> {
  UserRole? _selectedValue;

  @override
  Widget build(BuildContext context) => Scaffold(
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
            'Mulai mendaftar',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Bergabung dengan Roompi', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 3.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Anda bisa mendaftar sebagai pelajar atau orang tua!',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            const SizedBox(height: 10.0),
            ...[
              UserRole.remaja,
              UserRole.parent,
            ].map(
              (e) => RadioListTile(
                value: e,
                groupValue: _selectedValue,
                title: Text(
                  e.text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                secondary: e.text == 'Pelajar'
                    ? const Icon(
                        Icons.person_3_outlined,
                        size: 30,
                      )
                    : const Icon(
                        Icons.person_4_outlined,
                        size: 30,
                      ),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) => setState(() => _selectedValue = value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyFilledButton(
            onPressed: _selectedValue == null ? null : () => NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => SignUpPage(selectedRole: _selectedValue!))),
            child: const Text('Lanjutkan'),
          ),
        ),
      );
}
