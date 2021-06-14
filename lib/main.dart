import 'package:flutter/material.dart';

void main() => runApp(LogoApp());

// class AnimatedLogo extends AnimatedWidget {
//   // Make the Tweens static because they don't change.
//   static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
//   static final _sizeTween = Tween<double>(begin: 0, end: 300);
//
//   AnimatedLogo({Key? key, required Animation<double> animation})
//       : super(key: key, listenable: animation);
//
//   Widget build(BuildContext context) {
//     final animation = listenable as CurvedAnimation;
//     return Center(
//       child: Opacity(
//         opacity: _opacityTween.evaluate(animation),
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 10),
//           height: _sizeTween.evaluate(animation),
//           width: _sizeTween.evaluate(animation),
//           child: FlutterLogo(),
//         ),
//       ),
//     );
//   }
// }
//
// class LogoApp extends StatefulWidget {
//   _LogoAppState createState() => _LogoAppState();
// }
//
// class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
//   late Animation<double> animation;
//   late AnimationController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(duration: const Duration(seconds: 5), vsync: this);
//     animation =
//         CurvedAnimation(parent: controller, curve: Cubic(0.5, 0.1, 0.1, 1))
//           ..addStatusListener((status) {
//             if (status == AnimationStatus.completed) {
//               controller.reset();
//             } else if (status == AnimationStatus.dismissed) {
//               controller.forward();
//             }
//           });
//     controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) => AnimatedLogo(animation: animation);
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    // controller = AnimationController(
    //   duration: const Duration(seconds: 10),
    //   vsync: this,
    // );
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
    opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);
    animation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) => GrowTransition(
        child: LogoWidget(),
        animation: animation,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// class AnimatedLogo extends AnimatedWidget {
//   AnimatedLogo({Key? key, required Animation<double> animation})
//       : super(key: key, listenable: animation);
//
//   Widget build(BuildContext context) {
//     final animation = listenable as Animation<double>;
//     return Center(
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10),
//         height: animation.value,
//         width: animation.value,
//         child: FlutterLogo(),
//       ),
//     );
//   }
// }

class GrowTransition extends StatelessWidget {
  GrowTransition({required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
          child: child,
        ),
      );
}

class LogoWidget extends StatelessWidget {
  Widget build(BuildContext context) => FlutterLogo();
}
