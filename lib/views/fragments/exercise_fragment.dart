part of 'fragments.dart';

class ExerciseFragment extends StatefulWidget {
  const ExerciseFragment({super.key});

  @override
  State<ExerciseFragment> createState() => _ExerciseFragmentState();
}

class _ExerciseFragmentState extends State<ExerciseFragment> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) _animationController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, stateExercise) {
          if (stateExercise is ExerciseDataLoaded) {
            return Scaffold(
              body: DefaultTabController(
                length: stateExercise.exercises.length,
                initialIndex: stateExercise.selectedCategoryIndex,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.viewPaddingOf(context).top,
                      color: kColorPrimary,
                    ),
                    Container(
                      color: kColorPrimary,
                      child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        labelColor: kColorWhite,
                        indicatorColor: kColorWhite,
                        dividerColor: kColorBorder,
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        tabs: stateExercise.exercises.map((e) => Tab(text: e.namaMapel ?? '-')).toList(),
                        onTap: (value) => MyApp.exerciseBloc.add(SetExerciseSelectedCategoryIndex(index: value)),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: List.generate(
                          stateExercise.exercises.length,
                          (categoryIndex) {
                            Exercise exercise = stateExercise.exercises[categoryIndex];

                            return Stack(
                              children: [
                                CustomScrollView(
                                  slivers: List.generate(
                                    exercise.dataBagian?.length ?? 0,
                                    (index) {
                                      ExercisePart part = exercise.dataBagian![index];

                                      return SliverStickyHeader(
                                        // overlapsContent: index == 0,
                                        header: buildContainerHeader(
                                          context: context,
                                          title: part.namaBagian ?? '-',
                                          description: 'Terdapat ${part.dataSubBagian!.length} sublevel dari tiap soal, terdiri dari 5 soal acak',
                                        ),
                                        sliver: buildPartBody(
                                          context: context,
                                          stateExercise: stateExercise,
                                          subsections: part.dataSubBagian!,
                                          categoryIndex: categoryIndex,
                                          partIndex: index,
                                          alignment: index.isOdd ? PartBodyAlignment.left : PartBodyAlignment.right,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (mounted)
                                  AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      try {
                                        // Offset? activeButtonOffset = (stateExercise.buttonKeys[stateExercise.currentActiveIndexes[stateExercise.selectedCategoryIndex]].currentContext?.findRenderObject() as RenderBox?)?.localToGlobal(Offset.zero);
                                        Offset? activeButtonOffset = (stateExercise.buttonKeys[(stateExercise.exerciseLengths[categoryIndex].firstOrNull ?? 0) + stateExercise.currentActiveIndexes[categoryIndex]].currentContext?.findRenderObject() as RenderBox?)?.localToGlobal(Offset.zero);

                                        return Positioned(
                                          top: (activeButtonOffset?.dy ?? 0.0) - 70.0 - 48.0 + (5.0 * CurvedAnimation(parent: _animationController, curve: Curves.easeInOut).value),
                                          left: (activeButtonOffset?.dx ?? 0.0) - 10.0,
                                          child: (activeButtonOffset?.dy ?? 0.0) < 180.0 + 48.0
                                              ? Container()
                                              : Stack(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svgs/bubble message start.svg',
                                                    ),
                                                    Positioned(
                                                      top: 12.0,
                                                      left: stateExercise.currentActiveIndexes[stateExercise.selectedCategoryIndex] > 0 ? 14.0 : 16.0,
                                                      child: Text(
                                                        stateExercise.currentActiveIndexes[stateExercise.selectedCategoryIndex] > 0 ? 'Lanjut' : 'Mulai',
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kColorBorder),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        );
                                      } catch (e) {
                                        return Container();
                                      }
                                    },
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (stateExercise is ExerciseError) {
            return Scaffold(
              body: SafeArea(
                child: ErrorOccuredButton(
                  onRetryPressed: () => MyApp.exerciseBloc.add(InitializeExerciseData()),
                ),
              ),
            );
          }

          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );

  Widget buildContainerHeader({
    required BuildContext context,
    required String title,
    String? mention,
    required String description,
    double? topHeigth,
  }) =>
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: kColorPrimary,
          border: Border(
            bottom: BorderSide(
              width: 5.0,
              color: kColorBorder,
            ),
          ),
        ),
        child: Column(
          children: [
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorWhite),
              child: Text('$title ${(mention?.isNotEmpty ?? false) ? '・ $mention' : ''}'),
            ),
            const SizedBox(height: 8.0),
            Text(description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kColorWhite)),
          ],
        ),
      );

  Widget buildPartBody({
    required BuildContext context,
    required ExerciseDataLoaded stateExercise,
    required List<ExerciseSubsection> subsections,
    required int categoryIndex,
    required int partIndex,
    PartBodyAlignment alignment = PartBodyAlignment.left,
  }) {
    bool isLeft = alignment == PartBodyAlignment.left;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: subsections.length * 120.0 + 160.0,
        child: Stack(
          children: [
            Positioned(
              right: isLeft ? 10.0 : null,
              left: !isLeft ? 10.0 : null,
              top: (subsections.length * 120.0 + 160.0) / 2 - 102.5,
              child: SvgPicture.asset(
                'assets/svgs/${isLeft ? 'curly hair girl' : 'bearded man'}.svg',
                width: 120.0,
                height: 120.0,
              ),
            ),
            ...List.generate(
              subsections.length,
              (index) {
                int continousIndex = stateExercise.exerciseLengths[categoryIndex][partIndex] + index;
                bool isMiddle = !(index == 0 || index == subsections.length - 1);

                return Positioned(
                  top: index == 0 ? 80 : 120.0 * index + 80.0,
                  left: isLeft ? MediaQuery.sizeOf(context).width / 2 - (isMiddle ? 64.0 : 32.0) : null,
                  right: !isLeft ? MediaQuery.sizeOf(context).width / 2 - (isMiddle ? 64.0 : 32.0) : null,
                  child: CircleExerciseButton(
                    key: stateExercise.buttonKeys[continousIndex],
                    svgAsset: ['star', 'padlock', 'book', 'trophy'][index % 4],
                    onPressed: () => MyApp.exerciseBloc.add(ExerciseStartPressed(value: stateExercise.exercises[categoryIndex], categoryIndex: categoryIndex, partIndex: partIndex, index: index)),
                    enabled: continousIndex - (categoryIndex > 0 ? stateExercise.exerciseLengths[categoryIndex].first : 0) <= stateExercise.currentActiveIndexes[categoryIndex],
                    ignorePointer: continousIndex - (categoryIndex > 0 ? stateExercise.exerciseLengths[categoryIndex].first : 0) < stateExercise.currentActiveIndexes[categoryIndex],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum PartBodyAlignment {
  left,
  right,
}
