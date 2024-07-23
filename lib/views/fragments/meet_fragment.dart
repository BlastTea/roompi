part of 'fragments.dart';

class MeetFragment extends StatelessWidget {
  const MeetFragment({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MeetBloc, MeetState>(
        builder: (context, stateMeet) {
          if (stateMeet is MeetDataLoaded) {
            return currentUser?.role == UserRole.remaja
                ? Scaffold(
                    appBar: AppBar(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'List Kelas Tersedia',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            'Yuk, ikuti meet bersama mentor',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          )
                        ],
                      ),
                    ),
                    body: RefreshIndicator(
                      onRefresh: () {
                        Completer<bool> completer = Completer();
                        MyApp.meetBloc
                            .add(InitializeMeetData(completer: completer));
                        return completer.future;
                      },
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 15),
                          ),
                          SliverPadding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            sliver: SliverList.builder(
                              itemBuilder: (context, index) {
                                Meet meet = stateMeet.meets[index];

                                return buildMeetList(
                                  context: context,
                                  meet: meet,
                                );
                              },
                              itemCount: stateMeet.meets.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'List Kelas Anda',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            'Yuk, mengajar pelajar Anda',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          )
                        ],
                      ),
                    ),
                    body: RefreshIndicator(
                        onRefresh: () {
                          Completer<bool> completer = Completer();
                          MyApp.meetBloc
                              .add(InitializeMeetData(completer: completer));
                          return completer.future;
                        },
                        child: CustomScrollView(
                          slivers: [
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 15),
                            ),
                            SliverPadding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              sliver: SliverList.builder(
                                itemBuilder: (context, index) {
                                  Meet meet = stateMeet.meets[index];
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: kColorPrimary,
                                          borderRadius: kBorderRadiusBanner,
                                          boxShadow: kBannerShadow,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    meet.topik ?? '-',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                            color: kColorWhite),
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Text(
                                                    meet.deskripsi ?? '-',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: kColorWhite),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .date_range_outlined,
                                                            size: 17.0,
                                                            color: kColorWhite,
                                                          ),
                                                          const SizedBox(
                                                              width: 8.0),
                                                          Text(
                                                            meet.tanggal?.toFormattedDate(
                                                                    withMonthName:
                                                                        true) ??
                                                                '-',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color:
                                                                        kColorWhite),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 4.0),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.schedule,
                                                            size: 17.0,
                                                            color: kColorWhite,
                                                          ),
                                                          const SizedBox(
                                                              width: 8.0),
                                                          Text(
                                                            '${TimeOfDay.fromDateTime(meet.jamMulai ?? DateTime.now()).toFormattedString()} - ${TimeOfDay.fromDateTime(meet.jamBerakhir ?? DateTime.now()).toFormattedString()}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color:
                                                                        kColorWhite),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  FilledButton(
                                                    onPressed: () {
                                                      
                                                    },
                                                    style:
                                                        FilledButton.styleFrom(
                                                      backgroundColor: meet
                                                                  .status ==
                                                              MeetStatus
                                                                  .sudahDipublish
                                                          ? kColorSecondary
                                                          : kColorBorder,
                                                      foregroundColor:
                                                          kColorWhite,
                                                    ),
                                                    child: Text(meet.status ==
                                                            MeetStatus
                                                                .sudahDipublish
                                                        ? 'Dipublikasi'
                                                        : 'Publikasi'),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  );
                                },
                                itemCount: stateMeet.meets.length,
                              ),
                            ),
                          ],
                        )),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () => NavigationHelper.to(SlidePageRoute(
                          pageBuilder: (context) => const StoreMeetPage())),
                      foregroundColor: kColorWhite,
                      backgroundColor: kColorPrimary,
                      child: const Icon(Icons.add),
                    ),
                  );
          } else if (stateMeet is MeetError) {
            return SafeArea(
              child: ErrorOccuredButton(
                onRetryPressed: () => MyApp.meetBloc.add(InitializeMeetData()),
              ),
            );
          }

          return const SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );

  Widget buildMeetList({
    required BuildContext context,
    required Meet meet,
  }) =>
      Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: kColorPrimary,
              borderRadius: kBorderRadiusBanner,
              boxShadow: kBannerShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meet.topik ?? '-',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kColorWhite),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        meet.deskripsi ?? '-',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: kColorWhite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range_outlined,
                                size: 17.0,
                                color: kColorWhite,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                meet.tanggal?.toFormattedDate(
                                        withMonthName: true) ??
                                    '-',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: kColorWhite),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 17.0,
                                color: kColorWhite,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '${TimeOfDay.fromDateTime(meet.jamMulai ?? DateTime.now()).toFormattedString()} - ${TimeOfDay.fromDateTime(meet.jamBerakhir ?? DateTime.now()).toFormattedString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: kColorWhite),
                              ),
                            ],
                          ),
                        ],
                      ),
                      FilledButton(
                        onPressed: () => NavigationHelper.to(SlidePageRoute(
                            pageBuilder: (context) =>
                                DetailMeetPage(meet: meet))),
                        style: FilledButton.styleFrom(
                          backgroundColor: kColorBorder,
                          foregroundColor: kColorWhite,
                        ),
                        child: const Text('Bergabung'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      );
}
