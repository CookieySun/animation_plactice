import 'package:animation_plactice/second.dart';
import 'package:flutter/material.dart';

import 'main.dart';

/// This is the main application widget.
// class ThirdApp extends StatelessWidget {
//   const ThirdApp({Key? key}) : super(key: key);
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//       routes: {
//         "/MyApp": (BuildContext context) => MyApp(),
//         "/LogoApp": (BuildContext context) => LogoApp(),
//       },
//     );
//   }
// }

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Cubic(1, 0.1, 0.1, 1),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: const Center(
          child: FlutterLogo(size: 200.0),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/MyApp");
            },
            child: Icon(Icons.arrow_left),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/LogoApp");
            },
            child: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
