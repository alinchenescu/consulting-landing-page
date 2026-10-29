part of '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Background.parallax(
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: Env.controller.node,
          onKey: Env.controller.onKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: NavigationHeader(),
            drawer: NavigationDrawer.of(context),
            body: InteractiveScrollViewer(
              scrollToId: Env.controller.instance,
              scrollDirection: Axis.vertical,
              children: [
                ...Env.navigations.to(HomePage.scrollContent),
                ScrollContent(
                  id: 'footer',
                  child: const NavigationFooter(),
                )
              ],
            ),
            floatingActionButton: HomePage.floatingButton(),
          ),
        ),
      ),
    );
  }

  static Widget floatingButton() {
    return ValueListenableBuilder(
      valueListenable: Env.controller,
      builder: (_, value, child) {
        return TweenAnimationBuilder(
          tween: Tween(end: value == Env.navigations.first.id ? 1.0 : 0.0),
          duration: Constants.duration,
          builder: (_, value, child) {
            return Transform.translate(
              offset: Offset(0.0, value * kToolbarHeight * 2.0),
              child: child,
            );
          },
          child: child,
        );
      },
      child: Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Hide the consultation shortcut once the contact form is visible
              ValueListenableBuilder(
                valueListenable: Env.controller,
                builder: (_, value, child) {
                  final isHidden = value == Env.navigations.last.id;
                  return IgnorePointer(
                    ignoring: isHidden,
                    child: AnimatedOpacity(
                      opacity: isHidden ? 0.0 : 1.0,
                      duration: Constants.duration,
                      child: child,
                    ),
                  );
                },
                child: Semantics(
                  label: 'Book a free 30-minute consultation',
                  link: true,
                  child: DButton(
                    onTap: () => Env.controller.onTap(
                      context,
                      id: Env.navigations.last.id,
                    ),
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.color.secondary,
                        borderRadius: BorderRadius.circular(kToolbarHeight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 16.0,
                            offset: const Offset(0.0, 6.0),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: kToolbarHeight * 0.85,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 18.0,
                            color: context.color.primary,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Free 30-min consultation',
                            style: context.text.bodyMedium?.copyWith(
                              color: context.color.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Constants.spacing * 0.5),
              FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: context.color.background,
                foregroundColor: context.color.primary,
                onPressed: () => Env.controller.onTap(
                  context,
                  id: Env.navigations.first.id,
                ),
                child: Seo.link(
                  anchor: 'Go back to top',
                  href: '/?section=${Env.navigations.first.id}',
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    semanticLabel: 'Go back to top',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static ScrollContent scrollContent(
    int index,
    NavigationModel item,
  ) {
    return ScrollContent(
        id: item.id,
        child: [
          // HomeStarter Section: Hero introduction
          HomeStarter(
            id: item.id,
            eyebrow: Constants.tagline,
            title: 'Clarity for complex decisions. Results that last.',
            subtitle:
                'We partner with leadership teams to sharpen strategy, streamline operations and lead change with confidence — turning ambitious plans into measurable growth.',
            highlights: const [
              '120+ organisations advised',
              'Senior-led engagements',
              'Results-based pricing available',
            ],
          ),

          // HomeAbout Section: Who we are
          HomeAbout(
            id: item.id,
            title: 'Independent advice, built on experience',
            subtitle:
                'Founded in 2011, ${Constants.company} is an independent consultancy of former operators, strategists and industry specialists. We work side by side with our clients, combining rigorous analysis with practical know-how to deliver change that sticks.',
            stats: const [
              CardModel(
                icon: Icons.history_edu_rounded,
                title: '15+',
                subtitle: 'Years of advisory experience',
              ),
              CardModel(
                icon: Icons.handshake_rounded,
                title: '120+',
                subtitle: 'Clients across 14 industries',
              ),
              CardModel(
                icon: Icons.groups_rounded,
                title: '45',
                subtitle: 'Senior consultants & specialists',
              ),
              CardModel(
                icon: Icons.thumb_up_alt_rounded,
                title: '96%',
                subtitle: 'Clients who would recommend us',
              ),
            ],
            cards: const [
              CardModel(
                icon: Icons.track_changes_rounded,
                title: 'Our Mission',
                subtitle:
                    'To help organisations make better decisions, faster — and to build the internal capability they need to keep improving long after we leave.',
              ),
              CardModel(
                icon: Icons.person_search_rounded,
                title: 'Senior Expertise',
                subtitle:
                    'Every engagement is led by a partner with 15+ years of hands-on industry experience. No hand-offs to junior teams once the contract is signed.',
              ),
              CardModel(
                icon: Icons.analytics_rounded,
                title: 'Evidence-Based',
                subtitle:
                    'Our recommendations are grounded in data, benchmarks and direct conversations with your customers, employees and partners — not generic frameworks.',
              ),
              CardModel(
                icon: Icons.verified_user_rounded,
                title: 'Independent & Objective',
                subtitle:
                    'We have no software to sell and no vendor partnerships to protect. Our only incentive is the success of your business.',
              ),
              CardModel(
                icon: Icons.diversity_3_rounded,
                title: 'True Partnership',
                subtitle:
                    'We embed with your team, share knowledge openly and co-create solutions, so your people own the outcome and the momentum continues.',
              ),
              CardModel(
                icon: Icons.insights_rounded,
                title: 'Measurable Impact',
                subtitle:
                    'Each project starts with clear KPIs agreed upfront. We track progress transparently and report on the value delivered, not just the hours spent.',
              ),
            ],
          ),

          // HomeServices Section: What we offer
          HomeServices(
            id: item.id,
            title: 'Services tailored to your next stage of growth',
            subtitle:
                'From a focused diagnostic to a full transformation programme, choose the level of support that fits your ambition. Every engagement is scoped to your needs.',
            services: const [
              HomeServiceModel(
                icon: Icons.explore_rounded,
                title: 'Business Strategy',
                description:
                    'Define where to play and how to win with a strategy your whole organisation can execute.',
                price: 8500,
                benefits:
                    "Market & competitor analysis\nGrowth opportunity assessment\n3-year strategic roadmap\nBoard-ready presentation",
                type: HomeServiceType.project,
              ),
              HomeServiceModel(
                icon: Icons.precision_manufacturing_rounded,
                title: 'Operational Excellence',
                description:
                    'Remove waste, cut costs and improve service levels across your core processes.',
                price: 12000,
                benefits:
                    "End-to-end process diagnostics\nLean & cost-reduction programme\nKPI dashboards & governance\nTeam coaching on the ground",
                type: HomeServiceType.project,
                isFeatured: true,
              ),
              HomeServiceModel(
                icon: Icons.hub_rounded,
                title: 'Digital Transformation',
                description:
                    'Modernise how you work with technology choices driven by business value.',
                price: 6500,
                benefits:
                    "Digital maturity assessment\nTechnology & vendor selection\nChange management & training\nProgramme management office",
                type: HomeServiceType.month,
              ),
              HomeServiceModel(
                icon: Icons.account_balance_rounded,
                title: 'Financial Advisory',
                description:
                    'Strengthen financial performance and prepare for investment, M&A or restructuring.',
                price: 4000,
                benefits:
                    "Financial health check\nForecasting & scenario modelling\nDue diligence support\nInvestor & lender readiness",
                type: HomeServiceType.engagement,
              ),
            ],
            process: const [
              CardModel(
                icon: Icons.search_rounded,
                title: 'Discover',
                subtitle:
                    'We listen, gather data and understand your context and goals.',
              ),
              CardModel(
                icon: Icons.biotech_rounded,
                title: 'Diagnose',
                subtitle:
                    'We identify root causes and quantify the size of the prize.',
              ),
              CardModel(
                icon: Icons.architecture_rounded,
                title: 'Design',
                subtitle:
                    'We co-create a practical plan with clear owners and milestones.',
              ),
              CardModel(
                icon: Icons.rocket_launch_rounded,
                title: 'Deliver',
                subtitle:
                    'We support implementation and measure the results achieved.',
              ),
            ],
          ),

          // HomeContact Section: Get in touch
          HomeContact(
            id: item.id,
            title: "Let's talk about your goals",
            subtitle:
                'Book a free, no-obligation 30-minute consultation. We will listen to your challenges and share an honest view on how we can help.',
            details: const [
              CardModel(
                icon: Icons.mail_outline_rounded,
                title: 'Email',
                subtitle: Constants.email,
              ),
              CardModel(
                icon: Icons.phone_in_talk_rounded,
                title: 'Phone',
                subtitle: Constants.phone,
              ),
              CardModel(
                icon: Icons.location_on_outlined,
                title: 'Office',
                subtitle: Constants.address,
              ),
              CardModel(
                icon: Icons.schedule_rounded,
                title: 'Office hours',
                subtitle: Constants.hours,
              ),
            ],
            faqs: const [
              CardModel(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'What happens during the free consultation?',
                subtitle:
                    'A 30-minute video call with a senior consultant. We discuss your objectives and challenges, and you leave with initial recommendations — with no obligation to continue.',
              ),
              CardModel(
                icon: Icons.timelapse_rounded,
                title: 'How long does a typical engagement last?',
                subtitle:
                    'Diagnostics usually take 3–6 weeks. Strategy projects run 6–12 weeks, while transformation programmes are typically delivered over 3–12 months in clearly defined phases.',
              ),
              CardModel(
                icon: Icons.payments_outlined,
                title: 'How is pricing structured?',
                subtitle:
                    'We offer fixed-fee projects, monthly retainers and, where appropriate, results-based fees linked to the KPIs we agree together. You always receive a detailed proposal before work begins.',
              ),
              CardModel(
                icon: Icons.business_rounded,
                title: 'Do you work with small and mid-sized businesses?',
                subtitle:
                    'Yes. Around half of our clients are SMEs and family-owned businesses. We scale our team and approach to match your size and budget.',
              ),
              CardModel(
                icon: Icons.lock_outline_rounded,
                title: 'How do you handle confidential information?',
                subtitle:
                    'All engagements are covered by a mutual NDA. Client data is stored in encrypted systems, access is limited to the project team, and it is deleted at the end of the engagement on request.',
              ),
              CardModel(
                icon: Icons.public_rounded,
                title: 'Can you work with teams in other countries?',
                subtitle:
                    'Absolutely. We regularly support clients across North America and Europe, working remotely or on-site depending on what the project needs.',
              ),
            ],
          ),
        ][index]);
  }
}
