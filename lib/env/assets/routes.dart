part of '../env.dart';

class Routes {
  static GoRoute home = GoRoute(
      path: '/',
      builder: (context, state) {
        FocusScope.of(context).requestFocus(Env.controller.node);

        return DLogWidget(
          'http://localhost${state.uri}',
          child: Seo.head(tags: const [
            MetaTag(
              name: 'title',
              content: '${Constants.company} | ${Constants.tagline}',
            ),
            LinkTag(rel: 'canonical', href: Constants.website)
          ], child: const HomePage()),
        );
      });

  static GoRoute error = GoRoute(
      path: '/error',
      builder: (context, state) {
        if (kIsWeb) {
          MetaSEO()
            ..ogTitle(ogTitle: '${Constants.company} : Page Not Found')
            ..description(description: 'The requested page could not be found.')
            ..keywords(
                keywords: 'Consulting, Strategy, Advisory, '
                    'Management Consulting, 404')
            ..author(author: Constants.company)
            ..ogDescription(
                ogDescription: 'The requested page could not be found.');
        }
        return DLogWidget(
          'http://localhost${state.uri}',
          child: Seo.head(
            tags: [
              const MetaTag(
                name: 'title',
                content: '${Constants.company} : Page Not Found',
              ),
              LinkTag(
                rel: 'canonical',
                href: '${Constants.website}${state.uri}',
              )
            ],
            child: ErrorPage(model: ErrorModel.error404),
          ),
        );
      });
}
