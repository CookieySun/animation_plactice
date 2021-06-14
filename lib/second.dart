import 'package:animation_plactice/third.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/MyApp": (BuildContext context) => MyApp(),
        "/LogoApp": (BuildContext context) => LogoApp(),
        "/ThirdApp": (BuildContext context) => MyStatefulWidget(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SizeTransition(
        sizeFactor: _animationController,
        axisAlignment: -1,
        axis: Axis.horizontal,
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: Container(color: Colors.green),
          ),
        ),
      ),
      floatingActionButton: Column(
          mainAxisAlignment:MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/LogoApp");
            },
            child: Icon(Icons.arrow_left),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/ThirdApp");
            },
            child: Icon(Icons.arrow_right),
          )
        ],
      ),
      // body: /*Center(*/
      //   /*child:*/ Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //   /*child:*/ SizeTransition(
      //     sizeFactor: _animationController,
      //     child: Center(
      //         child: SizedBox(
      //             width: 50,
      //             height: 50,
      //             child: Container(color: Colors.green))),
      //   ),
      //     ],
      //   ),
      // ),
    );
  }
}
