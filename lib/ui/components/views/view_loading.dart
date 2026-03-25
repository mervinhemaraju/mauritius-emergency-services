import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0.9, end: 1.3).animate(_controller1);
    _animation2 = Tween<double>(begin: 0.9, end: 1.3).animate(_controller2);
    _animation3 = Tween<double>(begin: 0.9, end: 1.3).animate(_controller3);

    _startAnimations();
  }

  void _startAnimations() async {
    while (true) {
      await _controller1.forward();
      await _controller1.reverse();
      await _controller2.forward();
      await _controller2.reverse();
      await _controller3.forward();
      await _controller3.reverse();
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.0,
          children: [
            ScaleTransition(
              scale: _animation1,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            ScaleTransition(
              scale: _animation2,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        ScaleTransition(
          scale: _animation3,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}
