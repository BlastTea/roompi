part of '../pages.dart';

class SignUpSelectActivityTypePage extends StatefulWidget {
  const SignUpSelectActivityTypePage({super.key});

  @override
  State<SignUpSelectActivityTypePage> createState() => _SignUpSelectActivityTypePageState();
}

class _SignUpSelectActivityTypePageState extends State<SignUpSelectActivityTypePage> {
  ActivityType? _selectedValue;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Silahkan pilih aktivitas',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 16.0),
            ...ActivityType.values.map(
              (e) => RadioListTile(
                value: e,
                groupValue: _selectedValue,
                title: Text(e.text),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) => setState(() => _selectedValue = value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyFilledButton(
            onPressed: _selectedValue == null ? null : () => NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => _selectedValue == ActivityType.pusatKegiatanBelajarMasyarakat ? const SignUpSelectEqualityPackagePage() : SignUpPage(selectedRole: UserRole.remaja, activityType: _selectedValue))),
            child: const Text('Lanjutkan'),
          ),
        ),
      );
}
