part of '../home.dart';

class HomeContact extends StatelessWidget {
  const HomeContact({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.faqs,
  });
  final String id, title, subtitle;

  /// Contact channels, where [CardModel.title] is the label and
  /// [CardModel.subtitle] is the value.
  final List<CardModel> details;
  final List<CardModel> faqs;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: context.height - kToolbarHeight,
      ),
      child: DProvider(
        value: id,

        // Even though it seems unnecessary but this conditional is used for restarting the animation
        child: Builder(
          builder: (context) {
            if (!context.isDesktop) {
              return Column(
                children: [
                  // Display the contact introduction section
                  HomeContact.introduction(
                      id: id, title: title, subtitle: subtitle),

                  // Display contact details and form stacked
                  Padding(
                    padding: const EdgeInsets.all(Constants.spacing),
                    child: Column(
                      children: [
                        ...details.to(HomeContact.detail),
                        const SizedBox(height: Constants.spacing),
                        HomeContact.form(),
                      ],
                    ),
                  ),

                  // Display FAQ cards in a wrapped layout
                  HomeContact.faq(faqs: faqs),
                ],
              );
            } else {
              return Column(
                children: [
                  // Display the contact introduction section
                  Center(
                      child: HomeContact.introduction(
                          id: id, title: title, subtitle: subtitle)),

                  // Display contact details next to the form
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1080.0),
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.spacing * 2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: details.to(HomeContact.detail),
                              ),
                            ),
                            const SizedBox(width: Constants.spacing * 2.0),
                            Expanded(flex: 3, child: HomeContact.form()),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Display FAQ cards in a wrapped layout
                  Center(child: HomeContact.faq(faqs: faqs)),
                ],
              );
            }
          },
        ),
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
        // Animate the introduction with slide and fade effects
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
                    // Display the title with specific styling
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

                    // Display the subtitle with specific styling
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

  static Widget detail(int index, CardModel item) {
    return Builder(
      builder: (context) {
        return Animate(
          autoPlay: false,
          onInit: Env.controller.animate(DProvider.of(context)),
          effects: [
            SlideEffect(
              begin: const Offset(-0.15, 0.0),
              end: Offset.zero,
              delay: Constants.duration * (index + 1),
              duration: const Duration(milliseconds: 750),
            ),
            FadeEffect(
              delay: Constants.duration * (index + 1),
              duration: const Duration(milliseconds: 750),
            ),
          ],
          child: Container(
            margin: const EdgeInsets.only(bottom: Constants.spacing * 0.75),
            padding: const EdgeInsets.all(Constants.spacing),
            decoration: BoxDecoration(
              color: context.color.background.withOpacity(0.06),
              borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
              border: Border.all(
                color: context.color.background.withOpacity(0.12),
              ),
            ),
            child: MergeSemantics(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: context.color.secondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(item.icon, color: context.color.secondary),
                  ),
                  const SizedBox(width: Constants.spacing * 0.75),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title.toUpperCase(),
                          style: context.text.bodySmall?.copyWith(
                            fontSize: 11.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Seo.text(
                          text: item.subtitle,
                          style: TextTagStyle.p,
                          child: Text(
                            item.subtitle,
                            semanticsLabel: item.subtitle,
                            style: context.text.bodyMedium?.copyWith(
                              color: context.color.background,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

  static Widget form() {
    return Builder(
      builder: (context) {
        return Animate(
          autoPlay: false,
          onInit: Env.controller.animate(DProvider.of(context)),
          effects: [
            SlideEffect(
              begin: const Offset(0.0, 0.15),
              end: Offset.zero,
              delay: Constants.duration * 2,
              duration: const Duration(milliseconds: 750),
            ),
            FadeEffect(
              delay: Constants.duration * 2,
              duration: const Duration(milliseconds: 750),
            ),
          ],
          child: const HomeContactForm(),
        );
      },
    );
  }

  static Widget faq({required List<CardModel> faqs}) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Constants.spacing * 2.0)
              .copyWith(top: Constants.spacing),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Constants.spacing),
                  child: Seo.text(
                    text: 'Frequently Asked Questions',
                    style: TextTagStyle.h3,
                    child: Text(
                      'FREQUENTLY ASKED QUESTIONS',
                      style: context.text.bodyMedium?.copyWith(
                        color: context.color.secondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
                Wrap(
                  spacing: Constants.spacing,
                  runSpacing: Constants.spacing,
                  direction: Axis.horizontal,
                  children: faqs.to(HomeContact.card),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget card(int index, CardModel item) {
    return LayoutBuilder(
      builder: (context, constraint) {
        // Calculate the maximum width for the card
        double width = (constraint.maxWidth * 0.5 - (Constants.spacing * 0.5));

        return Animate(
          autoPlay: false,
          onInit: Env.controller.animate(DProvider.of(context)),
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
          child: Container(
            constraints: BoxConstraints(
              maxWidth: width < 300.0 ? constraint.maxWidth : width,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: context.color.background,
              borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
            ),
            child: MergeSemantics(
              child: DTileWrapper(
                (isExpanded) => ExpansionTile(
                  leading: Icon(item.icon, color: context.color.primary),
                  trailing: Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: context.color.primary,
                  ),
                  title: Seo.text(
                    text: item.title,
                    style: TextTagStyle.h4,
                    child: Text(
                      item.title,
                      semanticsLabel: item.title,
                      style: context.text.bodyMedium?.copyWith(
                        color: context.color.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      color: context.color.surface,
                      padding: const EdgeInsets.all(Constants.spacing),
                      child: Row(
                        children: [
                          Expanded(
                            child: Seo.text(
                              text: item.subtitle,
                              style: TextTagStyle.p,
                              child: Text(
                                item.subtitle,
                                semanticsLabel: item.subtitle,
                                textAlign: TextAlign.start,
                                style: context.text.bodySmall?.copyWith(
                                  color: context.color.outline,
                                ),
                              ),
                            ),
                          ),
                        ],
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
}

/// Consultation request form. On submit it validates the input and opens the
/// visitor's mail client with a pre-filled message; nothing is stored or sent
/// by the page itself.
class HomeContactForm extends StatefulWidget {
  const HomeContactForm({super.key});

  @override
  State<HomeContactForm> createState() => _HomeContactFormState();
}

class _HomeContactFormState extends State<HomeContactForm> {
  final _key = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _company = TextEditingController();
  final _message = TextEditingController();
  String _topic = _topics.first;

  static const _topics = [
    'Business Strategy',
    'Operational Excellence',
    'Digital Transformation',
    'Financial Advisory',
    'Something else',
  ];

  static final _namePattern = RegExp(r"^[\p{L} .'-]{2,80}$", unicode: true);
  static final _emailPattern =
      RegExp(r'^[A-Za-z0-9._%+-]{1,64}@[A-Za-z0-9.-]{1,180}\.[A-Za-z]{2,24}$');

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _company.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_key.currentState?.validate() ?? false)) return;

    final body = 'Name: ${_name.text.trim()}\n'
        'Company: ${_company.text.trim().isEmpty ? '-' : _company.text.trim()}\n'
        'Email: ${_email.text.trim()}\n'
        'Topic: $_topic\n\n'
        '${_message.text.trim()}';
    final uri = Uri(
      scheme: 'mailto',
      path: Constants.email,
      query: 'subject=${Uri.encodeComponent('Consultation request: $_topic')}'
          '&body=${Uri.encodeComponent(body)}',
    );

    final messenger = ScaffoldMessenger.of(context);
    bool launched = false;
    try {
      launched = await launchUrl(uri);
    } on PlatformException {
      launched = false;
    }

    messenger.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(launched
          ? 'Your email app has been opened with your request. '
              'Just press send and we will reply within one business day.'
          : 'We could not open your email app. '
              'Please write to us at ${Constants.email}.'),
    ));
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: context.color.surface,
      counterText: '',
      labelStyle: context.text.bodyMedium?.copyWith(
        color: context.color.outline,
      ),
      hintStyle: context.text.bodyMedium?.copyWith(
        color: context.color.outline.withOpacity(0.6),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
        borderSide: BorderSide(color: context.color.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
        borderSide: BorderSide(color: context.color.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fieldStyle = context.text.bodyMedium?.copyWith(
      color: context.color.onBackground,
    );
    const gap = SizedBox(height: Constants.spacing * 0.75);

    return Container(
      padding: const EdgeInsets.all(Constants.spacing * 1.5),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.circular(Constants.spacing),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30.0,
            offset: const Offset(0.0, 12.0),
          ),
        ],
      ),
      child: Theme(
        data: context.theme.copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: context.color.primary,
            selectionColor: context.color.primary.withOpacity(0.2),
          ),
        ),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Request a free consultation',
                style: context.text.titleMedium?.copyWith(
                  color: context.color.onBackground,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                  bottom: Constants.spacing,
                ),
                child: Text(
                  'Tell us about your challenge. A senior consultant will '
                  'get back to you within one business day.',
                  style: context.text.bodySmall?.copyWith(
                    color: context.color.outline,
                  ),
                ),
              ),
              TextFormField(
                controller: _name,
                style: fieldStyle,
                maxLength: 80,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                decoration: _decoration('Full name'),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Please enter your name.';
                  if (!_namePattern.hasMatch(text)) {
                    return 'Please use letters only (2–80 characters).';
                  }
                  return null;
                },
              ),
              gap,
              TextFormField(
                controller: _email,
                style: fieldStyle,
                maxLength: 254,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: _decoration('Work email'),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Please enter your email.';
                  if (!_emailPattern.hasMatch(text)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              gap,
              TextFormField(
                controller: _company,
                style: fieldStyle,
                maxLength: 100,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.organizationName],
                decoration: _decoration('Company (optional)'),
              ),
              gap,
              DropdownButtonFormField<String>(
                value: _topic,
                style: fieldStyle,
                dropdownColor: context.color.background,
                decoration: _decoration('How can we help?'),
                items: _topics
                    .map((topic) =>
                        DropdownMenuItem(value: topic, child: Text(topic)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _topic = value);
                },
              ),
              gap,
              TextFormField(
                controller: _message,
                style: fieldStyle,
                minLines: 4,
                maxLines: 6,
                maxLength: 2000,
                decoration: _decoration(
                  'Message',
                  hint: 'Briefly describe your goals and timeline',
                ),
                validator: (value) {
                  final length = value?.trim().length ?? 0;
                  if (length < 20) {
                    return 'Please share a little more detail (20+ characters).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Constants.spacing),
              Semantics(
                label: 'Send consultation request',
                button: true,
                child: DButton.text(
                  onTap: _submit,
                  text: 'Send Request',
                  mainAxisSize: MainAxisSize.max,
                  color: context.color.primary,
                  padding: const EdgeInsets.all(Constants.spacing * 0.8),
                  borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
                  suffix: Icon(
                    Icons.send_rounded,
                    size: 18.0,
                    color: context.color.secondary,
                  ),
                  style: context.text.bodyMedium?.copyWith(
                    color: context.color.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
