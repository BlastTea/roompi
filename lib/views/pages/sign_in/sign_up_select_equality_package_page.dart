part of '../pages.dart';

class SignUpSelectEqualityPackagePage extends StatefulWidget {
  const SignUpSelectEqualityPackagePage({super.key});

  @override
  State<SignUpSelectEqualityPackagePage> createState() => _SignUpSelectEqualityPackagePageState();
}

class _SignUpSelectEqualityPackagePageState extends State<SignUpSelectEqualityPackagePage> {
  EqualityPackageType? _selectedValue;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Pilih paket kesetaraan',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 16.0),
            ...EqualityPackageType.values.map(
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
            onPressed: _selectedValue == null ? null : () => NavigationHelper.to(SlidePageRoute(pageBuilder: (context) => SignUpPage(selectedRole: UserRole.remaja, activityType: ActivityType.pusatKegiatanBelajarMasyarakat, equalityPackageType: _selectedValue))),
            child: const Text('Lanjutkan'),
          ),
        ),
      );
}
