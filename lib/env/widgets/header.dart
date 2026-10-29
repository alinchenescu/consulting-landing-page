part of '../env.dart';

class NavigationHeader extends AppBar {
  NavigationHeader({
    super.key,
    super.backgroundColor = Colors.transparent,
    this.selectionColor,
  });

  final Color? selectionColor;

  @override
  bool get automaticallyImplyLeading => false;

  @override
  Widget? get flexibleSpace => Hero(
        tag: '#Header',
        child: Builder(builder: (context) {
          return DChangeBuilder(
            value: Env.controller.scroll,
            builder: (context, value, child) {
              // Calculate the scroll progress
              double position() {
                if (value.hasClients) return value.offset;
                return 0.0;
              }

              double progress = position().max(kToolbarHeight) / kToolbarHeight;

              return Theme(
                data: context.theme.copyWith(
                  textSelectionTheme: context.theme.textSelectionTheme.copyWith(
                    selectionColor: selectionColor ??
                        Color.lerp(
                          context.color.onBackground,
                          context.color.background,
                          progress,
                        )?.withOpacity(0.25),
                  ),
                ),
                child: Container(
                  color: Color.lerp(
                    context.color.primary.withOpacity(progress),
                    context.color.onBackground,
                    progress,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: !context.isDesktop ? 0.0 : Constants.spacing,
                    right: Constants.spacing,
                  ),
                  child: child,
                ),
              );
            },
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              if (!context.isDesktop)
                Semantics(
                  label: 'Open Menu',
                  link: true,
                  child: DButton(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    padding: const EdgeInsets.all(Constants.spacing * 0.75),
                    color: Colors.transparent,
                    child: Icon(Icons.menu, color: context.color.background),
                  ),
                ),
              NavigationHeader.logo(),
              context.isDesktop
                  ? Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Display navigation buttons for desktop
                          for (var navigation in Env.navigations)
                            Semantics(
                              label: navigation.name,
                              link: true,
                              child: Seo.link(
                                anchor: navigation.name,
                                href: '/?section=${navigation.id}',
                                child: DButton.text(
                                  text: navigation.name,
                                  color: Colors.transparent,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: context.color.background,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onTap: () => Env.controller.onTap(
                                    context,
                                    id: navigation.id,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const Spacer(),
              Theme(
                data: context.theme,
                child: Semantics(
                  label: 'Book a consultation',
                  link: true,
                  child: Seo.link(
                    anchor: 'Book a Call',
                    href: '/?section=${Env.navigations.last.id}',
                    child: DButton.text(
                      text: 'Book a Call',
                      color: context.color.secondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      borderRadius: BorderRadius.circular(20.0),
                      style: context.text.bodyMedium?.copyWith(
                        color: context.color.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      onTap: () => Env.controller.onTap(
                        context,
                        id: Env.navigations.last.id,
                      ),
                    ),
                  ),
                ),
              )
            ]),
          );
        }),
      );

  static Widget logo() {
    return Builder(builder: (context) {
      return Seo.text(
        text: Constants.company,
        style: TextTagStyle.h1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo mark
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: context.color.secondary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.insights_rounded,
                size: 18.0,
                color: context.color.primary,
              ),
            ),
            const SizedBox(width: 10.0),

            // Logo wordmark
            Text(
              Constants.brand,
              semanticsLabel: '${Constants.company} Logo',
              style: context.text.titleLarge?.copyWith(
                color: context.color.background,
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      );
    });
  }
}
