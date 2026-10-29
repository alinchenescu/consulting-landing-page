part of '../home.dart';

class HomeServices extends StatelessWidget {
  const HomeServices({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.services,
    required this.process,
  });
  final String id, title, subtitle;
  final List<HomeServiceModel> services;
  final List<CardModel> process;

  @override
  Widget build(BuildContext context) {
    return DProvider(
      value: id,
      child: Builder(
        // Even though it seems unnecessary but this conditional is used for restarting the animation
        builder: (context) {
          if (!context.isDesktop) {
            return Column(
              children: [
                // Display label
                HomeServices.introduction(
                    id: id, title: title, subtitle: subtitle),

                // Display cards
                Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Constants.spacing),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: services.to(HomeServices.card),
                      ),
                    ),
                  ),
                ),

                // Display process
                HomeServices.workflow(id: id, steps: process),
              ],
            );
          } else {
            return Column(
              children: [
                // Display label with different tree
                Center(
                    child: HomeServices.introduction(
                        id: id, title: title, subtitle: subtitle)),

                // Display card with different tree
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Constants.spacing),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: services.to(HomeServices.card),
                      ),
                    ),
                  ),
                ),

                // Display process
                HomeServices.workflow(id: id, steps: process),
              ],
            );
          }
        },
      ),
    );
  }

  static Widget introduction({
    required String id,
    required String title,
    required String subtitle,
  }) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.spacing,
            vertical: Constants.spacing * 2.0,
          ),
          child: Animate(
            autoPlay: false,
            onInit: Env.controller.animate(id),
            effects: const [
              // Slide in animation effect
              SlideEffect(
                begin: Offset(0.0, -0.25),
                end: Offset.zero,
                duration: Duration(milliseconds: 750),
              ),

              // Fade in animation effect
              FadeEffect(
                duration: Duration(milliseconds: 750),
              ),
            ],
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720.0),
              child: MergeSemantics(
                child: Column(
                  children: [
                    // Display the title
                    Seo.text(
                      text: title,
                      style: TextTagStyle.h2,
                      child: Text(
                        title,
                        semanticsLabel: title,
                        textAlign: TextAlign.center,
                        style: context.text.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          fontSize: context.isDesktop ? 46.0 : 34.0,
                        ),
                      ),
                    ),

                    // Display the subtitle
                    Seo.text(
                      text: subtitle,
                      style: TextTagStyle.p,
                      child: Text(
                        '\n$subtitle',
                        semanticsLabel: subtitle,
                        style: context.text.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget card(int index, HomeServiceModel item) {
    return Builder(
      builder: (context) {
        final isFeatured = item.isFeatured;
        final foreground =
            isFeatured ? context.color.background : context.color.onBackground;
        final muted = isFeatured
            ? context.color.background.withOpacity(0.7)
            : context.color.outline;

        return Animate(
          autoPlay: false,
          onInit: Env.controller.animate(DProvider.of(context)),
          effects: [
            // Slide in animation effect
            SlideEffect(
              begin: const Offset(-0.25, 0.0),
              end: Offset.zero,
              delay: const Duration(milliseconds: 500) * index,
              duration: const Duration(milliseconds: 750),
            ),

            // Fade in animation effect
            FadeEffect(
              delay: const Duration(milliseconds: 500) * index,
              duration: const Duration(milliseconds: 750),
            ),
          ],
          child: Container(
            width: 270.0,
            padding: const EdgeInsets.all(Constants.spacing * 1.25),
            margin: const EdgeInsets.only(right: Constants.spacing),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.spacing),
              color: isFeatured
                  ? context.color.onBackground
                  : context.color.background,
              border: isFeatured
                  ? Border.all(color: context.color.secondary, width: 2.0)
                  : null,
            ),
            child: MergeSemantics(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display icon and featured badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: isFeatured
                              ? context.color.secondary
                              : context.color.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(item.icon, color: context.color.primary),
                      ),
                      const Spacer(),
                      if (isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: context.color.secondary,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            'Most requested',
                            style: context.text.bodySmall?.copyWith(
                              color: context.color.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Constants.spacing),

                  // Display item title
                  Seo.text(
                    text: item.title,
                    style: TextTagStyle.h3,
                    child: Text(
                      item.title,
                      semanticsLabel: item.title,
                      style: context.text.titleMedium?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Display item description
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Seo.text(
                      text: item.description,
                      style: TextTagStyle.p,
                      child: Text(
                        item.description,
                        semanticsLabel: item.description,
                        style: context.text.bodySmall?.copyWith(color: muted),
                      ),
                    ),
                  ),

                  // Display pricing label
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Constants.spacing,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Display "from" label
                        Text(
                          'from ',
                          style: context.text.bodyMedium?.copyWith(
                            color: muted,
                          ),
                        ),

                        // Display the price
                        Seo.text(
                          text: '\$${item.formattedPrice}',
                          style: TextTagStyle.h4,
                          child: Text(
                            '\$${item.formattedPrice}',
                            semanticsLabel: '${item.formattedPrice} USD',
                            style: context.text.titleLarge?.copyWith(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w900,
                              color: foreground,
                              height: 1.1,
                            ),
                          ),
                        ),

                        // Display the period
                        Text(
                          ' /${item.type.name}',
                          style: context.text.bodyMedium?.copyWith(
                            color: muted,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Display deliverables
                  ...item.benefits.split("\n").to(
                        (index, benefit) => Padding(
                          padding: const EdgeInsets.only(
                              bottom: Constants.spacing * 0.6),
                          child: MergeSemantics(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display benefit checkmark
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, right: Constants.spacing * 0.5),
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 16.0,
                                    semanticLabel: 'Including',
                                    color: context.color.secondary,
                                  ),
                                ),

                                // Display benefit description
                                Expanded(
                                  child: Seo.text(
                                    text: benefit,
                                    style: TextTagStyle.p,
                                    child: Text(
                                      benefit,
                                      semanticsLabel: benefit,
                                      style: context.text.bodySmall?.copyWith(
                                        color: foreground,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  const Spacer(),

                  // Display enquire button
                  Semantics(
                    label: 'Discuss ${item.title}',
                    link: true,
                    child: Seo.link(
                      anchor: 'Discuss this service',
                      href: '/?section=${Env.navigations.last.id}',
                      child: DButton.text(
                        onTap: () => Env.controller.onTap(
                          context,
                          id: Env.navigations.last.id,
                        ),
                        mainAxisSize: MainAxisSize.max,
                        color: isFeatured
                            ? context.color.secondary
                            : context.color.primary,
                        text: 'Discuss this service',
                        style: context.text.bodyMedium?.copyWith(
                          color: isFeatured
                              ? context.color.primary
                              : context.color.background,
                          fontWeight: FontWeight.w600,
                        ),
                        borderRadius:
                            BorderRadius.circular(Constants.spacing * 0.5),
                        margin: const EdgeInsets.only(top: Constants.spacing),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget workflow({
    required String id,
    required List<CardModel> steps,
  }) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Constants.spacing)
              .copyWith(bottom: Constants.spacing * 3.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Constants.spacing,
                ),
                child: Seo.text(
                  text: 'How We Work',
                  style: TextTagStyle.h3,
                  child: Text(
                    'HOW WE WORK',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.color.secondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: Constants.spacing,
                runSpacing: Constants.spacing,
                children: steps.to(
                  (index, item) => Animate(
                    autoPlay: false,
                    onInit: Env.controller.animate(id),
                    effects: [
                      SlideEffect(
                        begin: const Offset(0.0, 0.25),
                        end: Offset.zero,
                        delay: Constants.duration * (index + 4),
                        duration: const Duration(milliseconds: 750),
                      ),
                      FadeEffect(
                        delay: Constants.duration * (index + 4),
                        duration: const Duration(milliseconds: 750),
                      ),
                    ],
                    child: SizedBox(
                      width: 240.0,
                      child: MergeSemantics(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display step number
                            Container(
                              width: 36.0,
                              height: 36.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: context.color.secondary,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: context.text.bodyMedium?.copyWith(
                                  color: context.color.secondary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),

                            // Display step description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        item.icon,
                                        size: 16.0,
                                        color: context.color.background,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        item.title,
                                        style:
                                            context.text.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(item.subtitle,
                                      style: context.text.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
