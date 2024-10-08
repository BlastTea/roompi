part of 'pages.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  static List<Widget> buildListLeaderboards({
    required BuildContext context,
    required LeaderboardDataLoaded stateLeaderboard,
    bool withTopPadding = true,
  }) =>
      [
        if (withTopPadding) const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
        if (stateLeaderboard.position != null) ...[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Urutan ${currentUser?.role == UserRole.parent ? 'anak' : ''} Anda saat ini di ${stateLeaderboard.position ?? '-'}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
        ],
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList.builder(
            itemBuilder: (context, index) {
              final Leaderboard leaderboard = stateLeaderboard.leaderboards[index];

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    decoration: index + 1 == stateLeaderboard.position
                        ? BoxDecoration(
                            color: kColorWhite.withOpacity(0.2),
                            borderRadius: kBorderRadius,
                          )
                        : null,
                    child: Row(
                      children: [
                        switch (index) {
                          0 => SvgPicture.asset('assets/svgs/bi trophy 1.svg'),
                          1 => SvgPicture.asset('assets/svgs/bi trophy 2.svg'),
                          2 => SvgPicture.asset('assets/svgs/bi trophy 3.svg'),
                          _ => Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: const BoxDecoration(
                                color: kColorBorder,
                                shape: BoxShape.circle,
                              ),
                              child: Center(child: Text('${index + 1}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kColorWhite))),
                            ),
                        },
                        const SizedBox(width: 8.0),
                        // ImageContainer.hero(
                        //   key: UniqueKey(),
                        //   tag: 'Leaderboard $index',
                        //   width: 56.0,
                        //   height: 56.0,
                        //   image: CachedNetworkImageProvider(leaderboard.foto ?? ''),
                        //   containerBackgroundColor: const Color(0xFFA590A7),
                        //   dialogBackgroundColor: const Color(0xFFA590A7),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: SvgPicture.asset('assets/svgs/profile.svg'),
                        //   ),
                        // ),
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: leaderboard.foto ?? '',
                            width: 56.0,
                            height: 56.0,
                            errorWidget: (context, url, error) => Container(
                              color: kColorPrimary,
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/svgs/profile.svg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leaderboard.name ?? '?'),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                SvgPicture.asset('assets/svgs/fire.svg'),
                                const SizedBox(width: 8.0),
                                Text('${leaderboard.star ?? 0} Bintang'),
                                const SizedBox(width: 32.0),
                                SvgPicture.asset('assets/svgs/exp.svg'),
                                const SizedBox(width: 8.0),
                                Text('${leaderboard.exp ?? 0} Exp'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index != 9) const Divider(),
                ],
              );
            },
            itemCount: stateLeaderboard.leaderboards.length,
          ),
        )
      ];

  @override
  Widget build(BuildContext context) => BlocBuilder<LeaderboardBloc, LeaderboardState>(
        builder: (context, stateLeaderboard) {
          if (stateLeaderboard is LeaderboardDataLoaded) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => NavigationHelper.back(),
                  icon: const Icon(Icons.chevron_left),
                ),
                centerTitle: true,
                title: const Text('Leaderboard'),
                foregroundColor: kColorWhite,
                backgroundColor: kColorPrimary,
              ),
              body: RefreshIndicator(
                onRefresh: () {
                  Completer<bool> completer = Completer();
                  MyApp.leaderboardBloc.add(InitializeLeaderboardData(completer: completer));
                  return completer.future;
                },
                child: CustomScrollView(
                  slivers: buildListLeaderboards(
                    context: context,
                    stateLeaderboard: stateLeaderboard,
                  ),
                ),
              ),
            );
          } else if (stateLeaderboard is LeaderboardError) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => NavigationHelper.back(),
                  icon: const Icon(Icons.chevron_left),
                ),
                centerTitle: true,
                title: const Text('Leaderboard'),
                foregroundColor: kColorWhite,
                backgroundColor: kColorSurface,
              ),
              body: ErrorOccuredButton(
                onRetryPressed: () => MyApp.leaderboardBloc.add(InitializeLeaderboardData()),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => NavigationHelper.back(),
                icon: const Icon(Icons.chevron_left),
              ),
              centerTitle: true,
              title: const Text('Leaderboard'),
              foregroundColor: kColorWhite,
              backgroundColor: kColorSurface,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
}
