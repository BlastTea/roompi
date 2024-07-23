part of 'fragments.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.viewPaddingOf(context).top)),
          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageContainer.hero(
                    tag: 'home profile',
                    width: 40.0,
                    height: 40.0,
                    image: CachedNetworkImageProvider(currentUser?.foto ?? ''),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    containerBackgroundColor: kColorPrimary,
                    dialogBackgroundColor: kColorPrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/svgs/profile.svg'),
                    ),
                  ),
                  if (currentUser?.role == UserRole.remaja)
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/fire.svg'),
                        const SizedBox(width: 8.0),
                        Text('${(currentUser!.detail as Remaja).star} Bintang'),
                        const SizedBox(width: 32.0),
                        SvgPicture.asset('assets/svgs/exp.svg'),
                        const SizedBox(width: 8.0),
                        Text('${(currentUser!.detail as Remaja).exp} Exp'),
                      ],
                    )
                  else ...[
                    const SizedBox(width: 16.0),
                    Expanded(
                        child: Text('Halo, ${currentUser?.name ?? 'Guest'}! 👋',
                            style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ],
              ),
            ),
          ),
          if (currentUser?.role == UserRole.remaja) ...[
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                    'Selamat datang, ${currentUser?.name ?? 'Guest'}! 👋',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: BannerContainer(
                  title: const Text('Chat dengan AI'),
                  subtitle: Text(
                      'Tingkatkan pengetahuan Anda dengan bertanya ke AI secara efektif!',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: kColorWhite)),
                  actions: [
                    TextButton(
                      onPressed: () => NavigationHelper.to(SlidePageRoute(
                          pageBuilder: (context) => const ChatbotPage())),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Chat Sekarang',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: kColorWhite),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Icon(
                      Icons.forum,
                      color: kColorWhite,
                      size: 17.0,
                    )
                  ],
                  image: Image.asset('assets/images/hero-img.png'),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Flexible(
                      child: MyFilledButton.tonal(
                        onPressed: () =>
                            homePageKey.currentState?.setSelectedIndex(1),
                        icon: SvgPicture.asset(
                          'assets/svgs/exercise.svg',
                          height: 25,
                          width: 25,
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: kColorWhite),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        backgroundColor: kColorPrimary,
                        borderColor: kColorBorder,
                        minHorizontalPadding: 5.0,
                        pressedBottomBorderWidth: 0.0,
                        bottomBorderOnly: true,
                        child: const Text('Latihan'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      child: MyFilledButton.tonal(
                        onPressed: () =>
                            homePageKey.currentState?.setSelectedIndex(2),
                        icon: SvgPicture.asset(
                          'assets/svgs/meet.svg',
                          height: 25,
                          width: 25,
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: kColorWhite),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        backgroundColor: kColorPrimary,
                        borderColor: kColorBorder,
                        minHorizontalPadding: 8.0,
                        pressedBottomBorderWidth: 0.0,
                        bottomBorderOnly: true,
                        child: const Text('Meet'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text('Cek Leaderboard',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: MyFilledButton.tonal(
                  onPressed: () => NavigationHelper.to(SlidePageRoute(
                      pageBuilder: (context) => const LeaderboardPage())),
                  // icon: SvgPicture.asset('assets/svgs/chest.svg'),
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: kColorPrimary,
                  borderColor: kColorBorder,
                  minHorizontalPadding: 10.0,
                  pressedBottomBorderWidth: 0.0,
                  bottomBorderOnly: true,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 32.0 - 50.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Leaderboard Anda!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: kColorWhite),
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(Icons.leaderboard_outlined,
                                color: kColorWhite),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          // 'You\'ve Reached a Great Milestone! Celebrate Your Victory.',
                          'Anda telah mencapai tonggak sejarah yang luar biasa!',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: kColorWhite),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text('Yuk, belajar bareng kita!',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: ListTile(
                  leading: SvgPicture.asset('assets/svgs/forums.svg'),
                  title: const Text('Belajar tanpa bosan!'),
                  subtitle: const Text(
                      'Lebih dari 60.200 latihan interaktif yang menyenangkan'),
                  textColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                    child: Divider(
                        color: Theme.of(context).colorScheme.secondary))),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: ListTile(
                  leading: SvgPicture.asset('assets/svgs/word card.svg'),
                  title: const Text('Menambah pengetahuan'),
                  subtitle: const Text(
                      'Menyediakan berbagai macam pembelajaran sesuai kebutuhan Anda!'),
                  textColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                    child: Divider(
                        color: Theme.of(context).colorScheme.secondary))),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: ListTile(
                  leading: SvgPicture.asset('assets/svgs/watch.svg'),
                  title: const Text('Membentuk kebiasaan belajar'),
                  subtitle: const Text(
                      'Pengingat cerdas, tantangan menyenangkan, dan lainnya'),
                  textColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
          ] else ...[
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text('Leaderboard',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
            BlocBuilder<LeaderboardBloc, LeaderboardState>(
              builder: (context, stateLeaderboard) {
                if (stateLeaderboard is LeaderboardDataLoaded) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    sliver: SliverFillRemaining(
                      child: CustomScrollView(
                        primary: false,
                        slivers: LeaderboardPage.buildListLeaderboards(
                          context: context,
                          stateLeaderboard: stateLeaderboard,
                          withTopPadding: false,
                        ),
                      ),
                    ),
                  );
                } else if (stateLeaderboard is LeaderboardError) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: ErrorOccuredButton(
                      onRetryPressed: () => MyApp.leaderboardBloc
                          .add(InitializeLeaderboardData()),
                    ),
                  );
                }

                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ],
      );
}
