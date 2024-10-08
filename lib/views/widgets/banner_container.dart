part of 'widgets.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.image,
  });

  final Widget? title;
  final Widget? subtitle;
  final List<Widget>? actions;
  final Widget? image;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: const BoxDecoration(
          color: kColorPrimary,
          borderRadius: kBorderRadiusBanner,
          boxShadow: kBannerShadow,
        ),
        child: image != null
            ? Row(
                children: [
                  Expanded(
                    child: body(context),
                  ),
                  SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: image,
                  ),
                ],
              )
            : body(context),
      );

  Widget body(BuildContext context) => DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorWhite),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) title!,
            const SizedBox(height: 8.0),
            if (subtitle != null)
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kColorWhite),
                child: subtitle!,
              ),
            const SizedBox(height: 8.0),
            if (actions != null)
              Row(
                children: actions!,
              ),
          ],
        ),
      );
}
