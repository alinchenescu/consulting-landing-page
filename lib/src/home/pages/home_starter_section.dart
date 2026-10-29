part of '../home.dart';

class HomeStarter extends StatelessWidget {
  const HomeStarter({
    super.key,
    required this.id,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.highlights,
  });
  final String id, eyebrow, title, subtitle;
  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height - (context.isDesktop ? 0.0 : kToolbarHeight),
      constraints: const BoxConstraints(minHeight: 640.0),
      child: Builder(
        builder: (context) {
          if (context.isDesktop) {
            // For desktop layout
            return Padding(
              padding: const EdgeInsets.all(Constants.spacing * 2.0)
                  .copyWith(top: kToolbarHeight),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Animate(
                      effects: const [
                        SlideEffect(
                          begin: Offset(0.0, 0.25),
                          end: Offset.zero,
                          delay: Constants.duration,
                          duration: Duration(milliseconds: 750),
                        ),
                        FadeEffect(
                          delay: Constants.duration,
                          duration: Duration(milliseconds: 750),
                        ),
                      ],
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: HomeStarter.introduction(
                          context,
                          eyebrow: eyebrow,
                          title: title,
                          subtitle: subtitle,
                          highlights: highlights,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Constants.spacing * 2.0),
                  Expanded(
                    child: HomeStarter.thumbnail(),
                  ),
                ],
              ),
            );
          } else {
            // For mobile and tablet layout
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: HomeStarter.thumbnail(),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [
                        context.color.primary,
                        context.color.primary,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(Constants.spacing),
                  child: Animate(
                    effects: const [
                      SlideEffect(
                        begin: Offset(0.0, 0.25),
                        end: Offset.zero,
                        delay: Constants.duration,
                        duration: Duration(milliseconds: 750),
                      ),
                      FadeEffect(
                        delay: Constants.duration,
                        duration: Duration(milliseconds: 750),
                      ),
                    ],
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: HomeStarter.introduction(
                        context,
                        eyebrow: eyebrow,
                        title: title,
                        subtitle: subtitle,
                        highlights: highlights,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  static List<Widget> introduction(
    BuildContext context, {
    required String eyebrow,
    required String title,
    required String subtitle,
    required List<String> highlights,
  }) {
    return [
      MergeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the eyebrow label
            Container(
              margin: const EdgeInsets.only(bottom: Constants.spacing),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: context.color.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: context.color.secondary.withOpacity(0.5),
                ),
              ),
              child: Text(
                eyebrow.toUpperCase(),
                style: context.text.bodySmall?.copyWith(
                  color: context.color.secondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  fontSize: 11.0,
                ),
              ),
            ),

            // Display the title
            Seo.text(
              text: title,
              style: TextTagStyle.h2,
              child: Text(
                title,
                semanticsLabel: title,
                style: context.text.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  fontSize: context.isDesktop ? 52.0 : 36.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Display the subtitle
            Seo.text(
              text: subtitle,
              style: TextTagStyle.p,
              child: Text(
                '\n$subtitle',
                semanticsLabel: subtitle,
                style: context.text.bodyMedium?.copyWith(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),

      // Display call to action buttons
      Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.spacing * 1.5),
        child: Wrap(
          runSpacing: Constants.spacing * 0.5,
          spacing: Constants.spacing * 0.5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Semantics(
              label: 'Book a free consultation',
              link: true,
              child: Seo.link(
                anchor: 'Book a Free Consultation',
                href: '/?section=${Env.navigations.last.id}',
                child: DButton.text(
                  onTap: () => Env.controller.onTap(
                    context,
                    id: Env.navigations.last.id,
                  ),
                  text: 'Book a Free Consultation',
                  color: context.color.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.spacing * 1.25,
                    vertical: Constants.spacing * 0.8,
                  ),
                  borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
                  suffix: Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.0,
                    color: context.color.primary,
                  ),
                  style: context.text.bodyMedium?.copyWith(
                    color: context.color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Semantics(
              label: 'Explore our services',
              link: true,
              child: Seo.link(
                anchor: 'Explore Services',
                href: '/?section=${NavigationModel.services.id}',
                child: DButton.text(
                  onTap: () => Env.controller.onTap(
                    context,
                    id: NavigationModel.services.id,
                  ),
                  text: 'Explore Services',
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.spacing * 1.25,
                    vertical: Constants.spacing * 0.8,
                  ),
                  borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Constants.spacing * 0.5),
                    border: Border.all(
                      color: context.color.background.withOpacity(0.4),
                    ),
                  ),
                  style: context.text.bodyMedium?.copyWith(
                    color: context.color.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Display trust highlights
      Wrap(
        spacing: Constants.spacing,
        runSpacing: Constants.spacing * 0.5,
        children: highlights.to(
          (index, item) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 16.0,
                color: context.color.secondary,
              ),
              const SizedBox(width: 6.0),
              Text(item, style: context.text.bodySmall),
            ],
          ),
        ),
      ),
    ];
  }

  /// Hero illustration built from widgets: a growth chart card with floating
  /// KPI badges. Replaces the original raster thumbnail.
  static Widget thumbnail() {
    return Animate(
      effects: const [
        // Slide in animation effect
        SlideEffect(
          begin: Offset(0.0, -0.25),
          end: Offset.zero,
          delay: Constants.duration,
          duration: Duration(milliseconds: 750),
        ),

        // Fade in animation effect
        FadeEffect(
          delay: Constants.duration,
          duration: Duration(milliseconds: 750),
        ),
      ],
      child: Semantics(
        label: 'Illustration of a business growth dashboard',
        image: true,
        child: Padding(
          padding: const EdgeInsets.all(Constants.spacing),
          child: FittedBox(
            child: SizedBox.square(
              dimension: 460.0,
              child: Builder(builder: (context) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main chart card
                    Positioned(
                      left: 30.0,
                      top: 60.0,
                      right: 30.0,
                      bottom: 60.0,
                      child: Transform.rotate(
                        angle: -0.04,
                        child: HomeStarter.chartCard(context),
                      ),
                    ),

                    // Floating KPI card
                    Positioned(
                      top: 10.0,
                      right: 0.0,
                      child: HomeStarter.floating(
                        offset: 8.0,
                        child: HomeStarter.badge(
                          context,
                          icon: Icons.trending_up_rounded,
                          value: '+38%',
                          label: 'Avg. revenue uplift',
                        ),
                      ),
                    ),

                    // Floating approval card
                    Positioned(
                      bottom: 10.0,
                      left: 0.0,
                      child: HomeStarter.floating(
                        offset: -8.0,
                        delay: const Duration(milliseconds: 900),
                        child: HomeStarter.badge(
                          context,
                          icon: Icons.verified_rounded,
                          value: '96%',
                          label: 'Client satisfaction',
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  static Widget chartCard(BuildContext context) {
    const bars = [0.35, 0.5, 0.42, 0.65, 0.78, 0.95];
    const labels = ['Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6'];

    return Container(
      padding: const EdgeInsets.all(Constants.spacing * 1.25),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.circular(Constants.spacing),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 40.0,
            offset: const Offset(0.0, 20.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Growth Roadmap',
                      style: context.text.titleMedium?.copyWith(
                        color: context.color.onBackground,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Projected performance after engagement',
                      style: context.text.bodySmall?.copyWith(
                        color: context.color.outline,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff1B998B).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'On track',
                  style: context.text.bodySmall?.copyWith(
                    color: const Color(0xff1B998B),
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.spacing),

          // Bar chart, each bar grows in sequence
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars.to(
                (index, value) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FractionallySizedBox(
                            heightFactor: value,
                            alignment: Alignment.bottomCenter,
                            child: Animate(
                              effects: [
                                ScaleEffect(
                                  begin: const Offset(1.0, 0.0),
                                  end: const Offset(1.0, 1.0),
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeOutBack,
                                  delay: Constants.duration * (index + 3),
                                  duration: const Duration(milliseconds: 750),
                                ),
                              ],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: index == bars.length - 1
                                        ? [
                                            context.color.secondary,
                                            context.color.secondary
                                                .withOpacity(0.7),
                                          ]
                                        : [
                                            context.color.primary,
                                            context.color.primary
                                                .withOpacity(0.6),
                                          ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          labels[index],
                          style: context.text.bodySmall?.copyWith(
                            color: context.color.outline,
                            fontSize: 11.0,
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
  }

  static Widget badge(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 24.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: context.color.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: context.color.secondary, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: context.text.titleMedium?.copyWith(
                  color: context.color.onBackground,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              Text(
                label,
                style: context.text.bodySmall?.copyWith(
                  color: context.color.outline,
                  fontSize: 11.0,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Gently bobs [child] up and down forever.
  static Widget floating({
    required Widget child,
    required double offset,
    Duration delay = Duration.zero,
  }) {
    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      effects: [
        MoveEffect(
          begin: Offset.zero,
          end: Offset(0.0, offset),
          delay: delay,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 2400),
        ),
      ],
      child: child,
    );
  }
}
