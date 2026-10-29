part of '../home.dart';

class HomeAbout extends StatelessWidget {
  const HomeAbout({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.cards,
    required this.stats,
  });
  final String id, title, subtitle;
  final List<CardModel> cards;

  /// Key figures, where [CardModel.title] is the value and
  /// [CardModel.subtitle] is the label.
  final List<CardModel> stats;

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Display label
          HomeAbout.introduction(id: id, title: title, subtitle: subtitle),

          // Display key figures
          HomeAbout.statistics(id: id, stats: stats),

          // Display card
          Container(
            padding: const EdgeInsets.all(Constants.spacing * 2.0),
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040.0),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: Constants.spacing,
                runSpacing: Constants.spacing,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: cards.to((index, item) => Animate(
                      autoPlay: false,
                      onInit: Env.controller.animate(id),
                      effects: [
                        SlideEffect(
                          begin: const Offset(0.0, -0.25),
                          end: Offset.zero,
                          delay: Constants.duration * (index + 1),
                          duration: const Duration(milliseconds: 750),
                        ),
                        FadeEffect(
                          delay: Constants.duration * (index + 1),
                          duration: const Duration(milliseconds: 750),
                        ),
                      ],
                      child: HomeAbout.card(item: item),
                    )),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: context.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.color.primary,
                  context.color.primary.withOpacity(0.0),
                ],
              ),
            ),
            height: context.height - kToolbarHeight,
            constraints: BoxConstraints(
                minHeight: context.width < 560.0 ? 650.0 : 455.0),
            padding: const EdgeInsets.all(Constants.spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Display label
                HomeAbout.introduction(
                    id: id, title: title, subtitle: subtitle),

                // Display swiper
                Expanded(
                  child: Animate(
                    autoPlay: false,
                    onInit: Env.controller.animate(id),
                    effects: const [
                      ScaleEffect(
                        begin: Offset(0.75, 0.75),
                        end: Offset(1.0, 1.0),
                        delay: Constants.duration,
                        duration: Duration(milliseconds: 750),
                      ),
                      FadeEffect(
                        delay: Constants.duration,
                        duration: Duration(milliseconds: 750),
                      ),
                    ],
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) =>
                          SingleChildScrollView(
                        clipBehavior: Clip.none,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            children: [HomeAbout.card(item: cards[index])]),
                      ),
                      itemCount: cards.length,
                      autoplay: true,
                      scrollDirection: context.width >= 560.0
                          ? Axis.horizontal
                          : Axis.vertical,
                      autoplayDelay: 6 * 1000,
                      layout: SwiperLayout.STACK,
                      itemWidth: 300.0,
                      itemHeight: context.height.max(260.0),
                      control: SwiperControl(
                        iconNext: Icons.navigate_next_rounded,
                        iconPrevious: Icons.navigate_before_rounded,
                        color: context.color.background,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Display key figures
          HomeAbout.statistics(id: id, stats: stats),
        ],
      );
    }
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
              SlideEffect(
                begin: Offset(0.0, -0.25),
                end: Offset.zero,
                duration: Duration(milliseconds: 750),
              ),
              FadeEffect(
                duration: Duration(milliseconds: 750),
              ),
            ],
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720.0),
              child: MergeSemantics(
                child: Column(
                  children: [
                    // Display title
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

                    // Display subtitle
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

  static Widget statistics({
    required String id,
    required List<CardModel> stats,
  }) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.spacing),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: Constants.spacing,
            runSpacing: Constants.spacing,
            children: stats.to(
              (index, item) => Animate(
                autoPlay: false,
                onInit: Env.controller.animate(id),
                effects: [
                  ScaleEffect(
                    begin: const Offset(0.85, 0.85),
                    end: const Offset(1.0, 1.0),
                    delay: Constants.duration * (index + 1),
                    duration: const Duration(milliseconds: 750),
                  ),
                  FadeEffect(
                    delay: Constants.duration * (index + 1),
                    duration: const Duration(milliseconds: 750),
                  ),
                ],
                child: Container(
                  width: context.width < 560.0 ? 150.0 : 220.0,
                  padding: const EdgeInsets.all(Constants.spacing),
                  decoration: BoxDecoration(
                    color: context.color.background.withOpacity(0.06),
                    borderRadius:
                        BorderRadius.circular(Constants.spacing * 0.5),
                    border: Border.all(
                      color: context.color.background.withOpacity(0.12),
                    ),
                  ),
                  child: MergeSemantics(
                    child: Column(
                      children: [
                        Icon(item.icon, color: context.color.secondary),
                        const SizedBox(height: 8.0),
                        Text(
                          item.title,
                          style: context.text.titleLarge?.copyWith(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          item.subtitle,
                          textAlign: TextAlign.center,
                          style: context.text.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget card({required CardModel item}) {
    return Builder(
      builder: (context) {
        return Container(
          width: 320.0,
          height: 260.0,
          padding: const EdgeInsets.all(Constants.spacing * 1.25),
          decoration: BoxDecoration(
            color: context.color.background,
            borderRadius: BorderRadius.circular(Constants.spacing * 0.75),
            boxShadow: [
              BoxShadow(
                color: context.color.onBackground.withOpacity(0.15),
                blurRadius: 20.0,
                offset: const Offset(0.0, 8.0),
              ),
            ],
          ),
          child: MergeSemantics(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display item icon
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: context.color.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    item.icon,
                    semanticLabel: '${item.title} Icon',
                    size: Constants.spacing * 1.4,
                    color: context.color.primary,
                  ),
                ),

                // Add spacing between icon and title
                Padding(
                  padding: const EdgeInsets.only(
                    top: Constants.spacing,
                    bottom: Constants.spacing * 0.5,
                  ),
                  child: Seo.text(
                    text: item.title,
                    style: TextTagStyle.h4,
                    child: Text(
                      item.title,
                      semanticsLabel: item.title,
                      style: context.text.titleMedium?.copyWith(
                        color: context.color.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Display item subtitle
                Seo.text(
                  text: item.subtitle,
                  style: TextTagStyle.p,
                  child: Text(
                    item.subtitle,
                    semanticsLabel: item.subtitle,
                    style: context.text.bodySmall
                        ?.copyWith(color: context.color.outline),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
