part of '../env.dart';

class NavigationFooter extends StatelessWidget {
  const NavigationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final linkStyle = context.text.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: context.color.background.withOpacity(0.8),
    );

    return Theme(
      data: context.theme.copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: context.color.background.withOpacity(0.15),
        ),
      ),
      child: Container(
        color: context.color.onBackground,
        padding: const EdgeInsets.all(Constants.spacing * 1.5),
        constraints: BoxConstraints(minWidth: context.width),
        child: Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceAround,
              runSpacing: Constants.spacing,
              children: [
                // Navigation Logo & tagline
                MergeSemantics(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NavigationHeader.logo(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          Constants.tagline,
                          style: context.text.bodySmall?.copyWith(
                            color: context.color.background.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu list
                Padding(
                  padding: const EdgeInsets.all(Constants.spacing),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (var navigation in Env.navigations)
                        Semantics(
                          label: navigation.name,
                          link: true,
                          child: Seo.link(
                            anchor: navigation.name,
                            href: '/?section=${navigation.id}',
                            child: DButton.text(
                              onTap: () => Env.controller.onTap(
                                context,
                                id: navigation.id,
                              ),
                              text: navigation.name,
                              style: linkStyle,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Email Button
                Semantics(
                  label: 'Email ${Constants.company}',
                  link: true,
                  child: Seo.link(
                    anchor: Constants.email,
                    href: 'mailto:${Constants.email}',
                    child: DButton.text(
                      onTap: () => launchUrl(
                        Uri(scheme: 'mailto', path: Constants.email),
                      ),
                      text: Constants.email,
                      prefix: Icon(
                        Icons.mail_outline_rounded,
                        size: 16.0,
                        color: context.color.secondary,
                      ),
                      style:
                          linkStyle?.copyWith(color: context.color.secondary),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Constants.spacing),
              child: Container(
                height: 1.0,
                color: context.color.background.withOpacity(0.08),
              ),
            ),

            // Copyright text
            Semantics(
              label: 'Copyright 2026 ${Constants.company}',
              child: Text(
                '© 2026 ${Constants.company}. All rights reserved.',
                textAlign: TextAlign.center,
                style: context.text.bodyMedium?.copyWith(
                  color: context.color.background.withOpacity(0.35),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
