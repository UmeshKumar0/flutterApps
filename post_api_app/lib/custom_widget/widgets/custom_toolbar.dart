// ignore_for_file: sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';

class ToolbarScreen extends StatefulWidget {
  const ToolbarScreen({Key? key}) : super(key: key);

  @override
  State<ToolbarScreen> createState() => _ToolbarScreenState();
}

class _ToolbarScreenState extends State<ToolbarScreen> {
  late BuildContext snackContext;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(body: bottomToolbar(size: size));
  }
}

class bottomToolbar extends StatelessWidget {
  const bottomToolbar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: newBottom(size: size),
        )
      ],
    );
  }
}

class newBottom extends StatelessWidget {
  static bool c = true;
  const newBottom({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 70,
      color: c ? Colors.black : Colors.white,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: MyCustomPainter(),
          ),
          Center(
            heightFactor: 0.5,
            child: FloatingActionButton(
              onPressed: () {
                c = true;
              },
              backgroundColor: Colors.yellow[900],
              child: const Icon(Icons.shopping_basket),
              elevation: 0.1,
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('Home is clicked'),
                      backgroundColor: Colors.black,
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.amberAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('Bookmark is clicked'),
                      backgroundColor: Colors.black,
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon:
                      const Icon(Icons.bookmark_add, color: Colors.amberAccent),
                ),
                Container(
                  width: size.width * 0.20,
                ),
                IconButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('Notification is clicked'),
                      backgroundColor: Colors.black,
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(Icons.notifications_active,
                      color: Colors.amberAccent),
                ),
                IconButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('Menu is clicked'),
                      backgroundColor: Colors.black,
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(Icons.restaurant_menu,
                      color: Colors.amberAccent),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.white60, 9, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
