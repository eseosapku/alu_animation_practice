import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BouncingAnimationDemo(),
    );
  }
}

class BouncingAnimationDemo extends StatefulWidget {
  @override
  _BouncingAnimationDemoState createState() => _BouncingAnimationDemoState();
}

class _BouncingAnimationDemoState extends State<BouncingAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
      setState(() {});
    });

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.5, 0.0),
    ).chain(CurveTween(curve: Curves.elasticInOut)).animate(_controller);

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).chain(CurveTween(curve: Curves.easeIn)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startBounce() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Practice Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _startBounce,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.red,
                child: const Center(
                  child: FlutterLogo(size: 75),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
