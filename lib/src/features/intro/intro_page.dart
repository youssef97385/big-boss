import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../core/common/widgets/button_view.dart';
import '../../core/constants/const.dart';
import 'curve_clipper.dart';
import 'slider_data.dart';

class IntroductionSlides extends StatefulWidget {
  @override
  _IntroductionSlidesState createState() => _IntroductionSlidesState();
}

class _IntroductionSlidesState extends State<IntroductionSlides> {
  List<PageViewModel> pageViewModel = [];

  @override
  Widget build(BuildContext context) {
    return OnBoardingPage();
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  List<PageViewModel> pageViewModel = [];

  @override
  void initState() {
    super.initState();
    const TextStyle subtitleStyle = TextStyle(
      height: 1.2,
      fontSize: 18,
      color: Colors.black,
      fontFamily: 'RabarMedium',
    );

    PageDecoration pageDecoration = const PageDecoration(
      imageFlex: 1,
      bodyFlex: 0,
      bodyAlignment: Alignment.bottomCenter,
    );
    setData(pageDecoration);
  }

  void setData(PageDecoration pageDecoration) {
    for (final element in slidesDataEn) {
      pageViewModel.add(
        PageViewModel(
          title: element.title,
          body: element.description,
          image: _buildImage(element.pathImage),
          decoration: pageDecoration,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 700,
            child: SafeArea(
              child: IntroductionScreen(
                key: introKey,
                pages: pageViewModel,
                onDone: () =>    context.router.replaceNamed('main'),
                onSkip: () =>    context.router.replaceNamed('main'),
                showSkipButton: true,
                nextFlex: 0,
                globalBackgroundColor:
                Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                skip: const SizedBox(),
                next: const SizedBox(),
                done: const SizedBox(),
                dotsContainerDecorator: const BoxDecoration(
                  borderRadius: BorderRadius.zero,
                ),
                dotsDecorator: DotsDecorator(
                  size: const Size(10.0, 10.0),
                  color:
                  Theme
                      .of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.5),
                  activeColor: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  activeSize: const Size(22.0, 10.0),
                  shape: const RoundedRectangleBorder(),
                  activeShape: const RoundedRectangleBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: ButtonView(
              buttonType: ButtonType.soldButton,
              onClick: () {
                context.router.replaceNamed('main');
              },
              title: 'Start Now',
              width: 327,

            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(String assetName ,) {
    return ClipPath(
        clipper: CurveClipper(),
        child: Stack(
          children: [
            Container(
              color: kBlueColorLight,
            ),

            Positioned.fill(bottom: 0, child: Image.asset(assetName)),
          ],
        ));
  }
}
