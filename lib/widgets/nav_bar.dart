import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomisha_test/helpers/assets.dart';
import 'package:tomisha_test/helpers/theme.dart';
import 'package:tomisha_test/widgets/button.dart';

class AppNavBar extends StatefulWidget {
  final GlobalKey<NestedScrollViewState> nestedViewKey;
  const AppNavBar({super.key, required this.nestedViewKey});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  double pixels = 0;
  double maxScrollExtent = 1000;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.nestedViewKey.currentState!.outerController.addListener(
        () => setState(() {
          final position =
              widget.nestedViewKey.currentState!.outerController.position;
          pixels = position.pixels;
          maxScrollExtent = position.maxScrollExtent;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ThemeHelper.isMobile(context);
    final scrolledPassNavbar =
        pixels >= maxScrollExtent - (isMobile ? 60 : 250);

    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      floating: true,
      expandedHeight: 580,
      flexibleSpace: const FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _NavbarHeader(),
      ),
      titleSpacing: 0,
      title: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: [
            if (!scrolledPassNavbar)
              const BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
          ],
        ),
        height: kToolbarHeight,
        margin: EdgeInsets.only(bottom: scrolledPassNavbar ? 0 : 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (scrolledPassNavbar) ...[
              if (!isMobile) ...[
                Text(
                  'Jetzt Klicken',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(width: 20),
              ],
              Center(
                child: FadeIn(
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: isMobile ? null : 250,
                    child: AppButton(
                      onPressed: () {},
                      outline: !isMobile,
                      label: 'Kostenlos Registrieren',
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(width: 10),
            TextButton(onPressed: () {}, child: const Text('Login')),
            const SizedBox(width: 10),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
    );
  }
}

class _NavbarHeader extends StatelessWidget {
  const _NavbarHeader();

  @override
  Widget build(BuildContext context) {
    final isMobile = ThemeHelper.isMobile(context);

    final children = <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: isMobile ? null : 320,
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Deine Job\nwebsite',
              style: isMobile
                  ? Theme.of(context).textTheme.headline3
                  : Theme.of(context).textTheme.headline2,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            if (!isMobile) ...[
              const SizedBox(height: 50),
              AppButton(
                onPressed: () {},
                label: 'Kostenlos Registrieren',
              ),
            ]
          ],
        ),
      ),
      if (isMobile)
        SvgPicture.asset(AppAsssets.appbarBackground)
      else ...[
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: SvgPicture.asset(
              AppAsssets.appbarBackground,
            ),
          ),
        ),
      ]
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEBF4FF), Color(0xFFE6FFFA)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Stack(
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: children,
            )
          else
            Positioned.fill(
              child: Row(
                children: [
                  const Spacer(flex: 2),
                  ...children,
                  const Spacer(flex: 3),
                ],
              ),
            ),
          if (isMobile)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: AppButton(
                  onPressed: () {},
                  label: 'Kostenlos Registrieren',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
