import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lethologica_app/features/home/home.dart';
import 'package:lethologica_app/gen/assets.gen.dart';
import 'package:lethologica_app/gen/fonts.gen.dart';
import 'package:lethologica_dictionary/lethologica_dictionary.dart';
import 'package:lethologica_theme/lethologica_theme.dart';
import 'package:lottie/lottie.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Lethologica',
          style: context.textTheme.headlineMedium!
              .copyWith(fontFamily: FontFamily.cookie),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: twice),
              child: _HelpAnimatedTile(
                text: 'Quickly remove a word from your vocabulary by '
                    'swiping it from right to left.',
                lottieAsset: Assets.swipeLeft.path,
                height: 120,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: twice),
              child: _HelpAnimatedTile(
                text: 'Copy a word into your clipboard '
                    'for later use by holding tap.',
                lottieAsset: Assets.holdTap.path,
                height: 80,
              ),
            ),
            PaddingVertical(twice),
            Padding(
              padding: EdgeInsets.only(left: twice),
              child: Text(
                'Try it',
                style: context.textTheme.headlineMedium!
                    .copyWith(fontFamily: FontFamily.cookie),
              ),
            ),
            _HelpPlaygroundSection(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class _HelpAnimatedTile extends StatelessWidget {
  const _HelpAnimatedTile({
    required this.text,
    required this.lottieAsset,
    this.height = 100,
  });

  final String text;
  final String lottieAsset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(text),
        ),
        Lottie.asset(
          lottieAsset,
          height: height,
          delegates: LottieDelegates(
            values: [
              ValueDelegate.colorFilter(
                ['**'],
                value: ColorFilter.mode(
                  context.colorScheme.onBackground,
                  BlendMode.src,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HelpPlaygroundSection extends StatelessWidget {
  const _HelpPlaygroundSection({
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: _controller,
          child: const Text('where has it gone now?'),
        ),
        FadeTransition(
          opacity: _controller.drive(Tween<double>(begin: 1, end: 0)),
          child: Material(
            shape: Border.all(color: context.colorScheme.onPrimary),
            child: WordTile(
              onDismissed: _controller.forward,
              word: Word.empty.copyWith(
                word: 'Lethologica',
                meanings: [
                  const Meaning(
                    partOfSpeech: 'noun',
                    definitions: [
                      Definition(
                        definition: 'Speedy sidekick for your wonder of words. '
                            'Look up and save words into your pocket vocabulary with ease.',
                        example: 'I had to use Lethologica for my assignment',
                        synonyms: ['Lightweight Dictionary'],
                        antonyms: [],
                      ),
                    ],
                  ),
                ],
                timeAdded: DateTime.now(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
