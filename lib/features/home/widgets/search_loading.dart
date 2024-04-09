import 'package:flutter/material.dart';

class SearchLoadingNotifier with ChangeNotifier {
  SearchLoadingNotifier({
    this.loading = false,
  });

  bool loading;

  void start() {
    loading = true;
    notifyListeners();
  }

  void stop() {
    loading = false;
    notifyListeners();
  }
}

class SearchLoading extends StatefulWidget {
  const SearchLoading({
    required this.onPressed,
    required this.notifier,
    super.key,
  });

  final void Function() onPressed;
  final SearchLoadingNotifier notifier;

  @override
  State<SearchLoading> createState() => _SearchLoadingState();
}

class _SearchLoadingState extends State<SearchLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleDownAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleDownAnimation = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    widget.notifier.addListener(_notifierListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.notifier.removeListener(_notifierListener);
    super.dispose();
  }

  void _notifierListener() {
    if (widget.notifier.loading) {
      _controller.forward();
    } else {
      _controller.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          ScaleTransition(
            scale: _scaleDownAnimation,
            child: const Icon(Icons.search),
          ),
          ScaleTransition(
            scale: _controller,
            child: const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
