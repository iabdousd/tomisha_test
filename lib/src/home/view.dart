import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tomisha_test/helpers/assets.dart';
import 'package:tomisha_test/helpers/theme.dart';
import 'package:tomisha_test/widgets/nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  final nestedViewKey = GlobalKey<NestedScrollViewState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        key: nestedViewKey,
        headerSliverBuilder: (context, _) => [
          AppNavBar(nestedViewKey: nestedViewKey),
        ],
        body: Scrollbar(
          child: ListView(
            padding: MediaQuery.of(context).padding.add(
                  const EdgeInsets.symmetric(vertical: 40),
                ),
            children: [
              Center(child: _TabBar(tabController: tabController)),
              AnimatedBuilder(
                animation: tabController,
                builder: (context, _) => IndexedStack(
                  index: tabController.index,
                  children: const [
                    _HomeViewTab(
                      title: 'Drei einfache Schritte zu deinem neuen Job',
                      titles: [
                        'Erstellen dein Lebenslauf',
                        'Erstellen dein Lebenslauf',
                        'Mit nur einem Klick bewerben',
                      ],
                      images: [
                        AppAsssets.homeTab1Image1,
                        AppAsssets.homeTab1Image2,
                        AppAsssets.homeTab1Image3,
                      ],
                    ),
                    _HomeViewTab(
                      title: 'Drei einfache Schritte zu deinem neuen Job',
                      titles: [
                        'Erstellen dein Unternehmensprofil',
                        'Erstellen ein Jobinserat',
                        'Wähle deinen neuen Mitarbeiter aus',
                      ],
                      images: [
                        AppAsssets.homeTab2Image1,
                        AppAsssets.homeTab2Image2,
                        AppAsssets.homeTab2Image3,
                      ],
                    ),
                    _HomeViewTab(
                      title: 'Drei einfache Schritte zu deinem neuen Job',
                      titles: [
                        'Erstellen dein Unternehmensprofil',
                        'Erhalte Vermittlungs- angebot von Arbeitgeber',
                        'Vermittlung nach Provision oder Stundenlohn',
                      ],
                      images: [
                        AppAsssets.homeTab3Image1,
                        AppAsssets.homeTab3Image2,
                        AppAsssets.homeTab3Image3,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final TabController tabController;
  const _TabBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Arbeitnehmer',
      'Arbeitgeber',
      'Temporärbüro',
    ];

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) => SizedBox(
        height: 40,
        child: ListView.builder(
          itemCount: tabs.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemBuilder: (context, index) => InkWell(
            onTap: () => tabController.animateTo(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: index == tabController.index
                    ? const Color(0xFF81E6D9)
                    : Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).dividerTheme.color!,
                ),
                borderRadius: index == 0
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )
                    : index == tabs.length - 1
                        ? const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )
                        : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.center,
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: index != tabController.index
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeViewTab extends StatelessWidget {
  final String title;
  final List<String> titles;
  final List<String> images;

  const _HomeViewTab({
    required this.title,
    required this.titles,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30)
              .copyWith(bottom: 15),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: TabSection1.height + TabSection2.height + TabSection3.height,
          child: Stack(
            children: [
              TabSection1(
                title: titles[0],
                image: images[0],
              ),
              Positioned(
                top: TabSection1.height - 20,
                left: 0,
                right: 0,
                child: TabSection2(title: titles[1], image: images[1]),
              ),
              Positioned(
                top: TabSection1.height + TabSection2.height - 40,
                left: 0,
                right: 0,
                child: TabSection3(title: titles[2], image: images[2]),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TabSection1 extends StatelessWidget {
  final String title, image;
  const TabSection1({super.key, required this.title, required this.image});

  static const height = 300.0;

  @override
  Widget build(BuildContext context) {
    final isMobile = ThemeHelper.isMobile(context);
    final width = MediaQuery.of(context).size.width;
    final horzPadding = isMobile ? 24.0 : width * .15;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: isMobile ? null : 0,
            left: horzPadding - 30,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.outline,
              ),
              width: 208,
              height: 208,
            ),
          ),
          Positioned(
            left: horzPadding,
            right: isMobile ? horzPadding : width / 2,
            top: isMobile ? null : 0,
            bottom: isMobile ? 32 : 0,
            child: Row(
              crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.end : CrossAxisAlignment.center,
              children: [
                const Text(
                  '1. ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 130,
                    height: .4,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            bottom: isMobile ? null : 32,
            left: isMobile ? 0 : width / 2,
            right: isMobile ? 0 : null,
            child: Center(child: SvgPicture.asset(image)),
          ),
        ],
      ),
    );
  }
}

class TabSection2 extends StatelessWidget {
  final String title, image;
  const TabSection2({super.key, required this.title, required this.image});

  static const height = 380.0;

  @override
  Widget build(BuildContext context) {
    final isMobile = ThemeHelper.isMobile(context);
    final width = MediaQuery.of(context).size.width;
    final horzPadding = isMobile ? 24.0 : width * .15;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(reverse: true),
            child: ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE6FFFA),
                      Color(0xFFEBF4FF),
                    ],
                  ),
                ),
                height: height,
              ),
            ),
          ),
          Positioned(
            top: isMobile ? null : 50,
            bottom: 50,
            left: isMobile ? 0 : horzPadding,
            right: isMobile ? 0 : width / 2,
            child: isMobile
                ? SvgPicture.asset(image)
                : Center(child: SvgPicture.asset(image)),
          ),
          Positioned(
            left: isMobile ? horzPadding : width / 2,
            right: horzPadding,
            top: 120,
            bottom: isMobile ? null : 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '2. ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 130,
                    height: .4,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabSection3 extends StatelessWidget {
  final String title, image;
  const TabSection3({super.key, required this.title, required this.image});

  static const height = 360.0;

  @override
  Widget build(BuildContext context) {
    final isMobile = ThemeHelper.isMobile(context);
    final width = MediaQuery.of(context).size.width;
    final horzPadding = isMobile ? 24.0 : width * .15;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: isMobile ? null : -32,
            left: horzPadding - 74,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.outline,
              ),
              width: 304,
              height: 304,
            ),
          ),
          Positioned(
            top: isMobile ? null : 32,
            bottom: 32,
            left: isMobile ? 0 : width / 2,
            right: isMobile ? 0 : null,
            child: Center(child: SvgPicture.asset(image)),
          ),
          Positioned(
            left: horzPadding,
            right: isMobile ? horzPadding : width / 2,
            top: 0,
            bottom: isMobile ? null : 0,
            child: Row(
              children: [
                const Text(
                  '3. ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 130,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
