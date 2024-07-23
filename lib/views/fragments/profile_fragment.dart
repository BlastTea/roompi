part of 'fragments.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Anda',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ImageContainer.hero(
                  tag: 'Profile picture',
                  width: 48.0,
                  height: 48.0,
                  icon: Icons.person,
                  image: CachedNetworkImageProvider(currentUser?.foto ?? ''),
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  containerBackgroundColor: kColorPrimary,
                  dialogBackgroundColor: kColorPrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/svgs/profile.svg'),
                  ),
                ),
                title: Text(currentUser?.name ?? 'Guest'),
                trailing: const Icon(Icons.chevron_right),
                iconColor: kColorTextBase,
                textColor: kColorTextBase,
                onTap: () => NavigationHelper.to(SlidePageRoute(
                    pageBuilder: (context) => const EditProfilePage())),
              ),
              const SizedBox(height: 10.0),
              if (currentUser?.detail?.mapOrNull(
                      remaja: (value) => value.kodeOrangTua ?? '-',
                      orangTua: (value) => value.kode) !=
                  null) ...[
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('Kode Orang Tua'),
                  subtitle: Text(currentUser?.detail?.mapOrNull(
                          remaja: (value) => value.kodeOrangTua,
                          orangTua: (value) => value.kode) ??
                      '-'),
                  iconColor: kColorTextBase,
                  textColor: kColorTextBase,
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: currentUser?.detail?.mapOrNull(
                                remaja: (value) => value.kodeOrangTua,
                                orangTua: (value) => value.kode) ??
                            '-'));
                    NavigationHelper.clearSnackBars();
                    NavigationHelper.showSnackBar(const SnackBar(
                        content: Text('Kode telah disalin ke Clipboard')));
                  },
                ),
              ],
              Divider(color: Theme.of(context).colorScheme.secondary),
              ListTile(
                leading: const Icon(Icons.key),
                title: const Text('Ganti Password'),
                iconColor: kColorTextBase,
                textColor: kColorTextBase,
                onTap: () => NavigationHelper.to(SlidePageRoute(
                    pageBuilder: (context) => const ChangePasswordPage())),
              ),
              Divider(color: Theme.of(context).colorScheme.secondary),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                iconColor: kColorTextBase,
                textColor: kColorTextBase,
                onTap: () => ApiHelper.signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
