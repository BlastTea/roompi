part of 'pages.dart';

class StoreMeetPage extends StatelessWidget {
  const StoreMeetPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Center(child: Text('Halo')),
    );
  }
}
