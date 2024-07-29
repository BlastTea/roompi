part of 'pages.dart';

class StoreMeetPage extends StatefulWidget {
  const StoreMeetPage({super.key});

  @override
  State<StoreMeetPage> createState() => _StoreMeetPageState();
}

class _StoreMeetPageState extends State<StoreMeetPage> {
  // TextEditingController _controllerJamMulai = TextEditingController();
  // TextEditingController _controllerJamBerakhir = TextEditingController();
  // TextEditingController _controllerTanggal = TextEditingController();

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final selectedTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final formattedTime =
          "${selectedTime.year}-${selectedTime.month.toString().padLeft(2, '0')}-${selectedTime.day.toString().padLeft(2, '0')} ${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
      controller.text = formattedTime;
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentorMeetBloc, MentorMeetState>(
      builder: (context, state) {
        state as MentorMeetDataLoaded;
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buat Meet',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Yuk, buat meet',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextField(
                      controller: state.textControllerTopicMeet,
                      decoration: const InputDecoration(
                          labelText: 'Topik',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Yuk, masukan topik'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextField(
                      controller: state.textControllerDescriptionMeet,
                      decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Yuk, masukan deskripsi'),
                      textInputAction: TextInputAction.next,
                      maxLines: 10,
                      minLines: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                              controller: state.textControllerStartTimeMeet,
                              decoration: const InputDecoration(
                                  labelText: 'Jam Mulai',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Jam Mulai'),
                              textInputAction: TextInputAction.next,
                              onTap: () async {
                                await _selectTime(context, state.textControllerStartTimeMeet);
                              },
                              readOnly: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: state.textControllerEndTimeMeet,
                              decoration: const InputDecoration(
                                  labelText: 'Jam Berakhir',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Jam Berakhir'),
                              textInputAction: TextInputAction.next,
                              onTap: () async {
                                await _selectTime(
                                    context, state.textControllerEndTimeMeet);
                              },
                              readOnly: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextField(
                      controller: state.textControllerDateMeet,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Isi tanggalnya ya!',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        await _selectDate(context, state.textControllerDateMeet);
                      },
                      readOnly: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextField(
                      controller: state.textControllerLinkMeet,
                      decoration: const InputDecoration(
                          labelText: 'Link',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'https://meet.google.com/wxax-aocp-mcsx'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextField(
                      controller: state.textControllerModuleMeet,
                      decoration: const InputDecoration(
                          labelText: 'Materi',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'https://drive.google.com/.../preview'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: state.textControllerParticipantCountMeet,
                      decoration: const InputDecoration(
                          labelText: 'Total Remaja',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Berapa maksimal partisipannya?'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: MyFilledButton(
                      onPressed: () =>
                          MyApp.mentorMeetBloc.add(StoreMeetPressed()),
                      child: const Text('Simpan'),
                    ),
                  ),
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
        );
      },
    );
  }
}
