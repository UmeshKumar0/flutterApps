// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class PinchZoomImage extends StatefulWidget {
  const PinchZoomImage({Key? key}) : super(key: key);

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController =
      TransformationController();
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  final double minScale = 1;
  final double maxScale = 4;
  OverlayEntry? entry;
  double scale = 5;

  var status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _transformationController = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )
      ..addListener(() {
        _transformationController.value = animation!.value;
      })
      ..addListener(() {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _transformationController.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Builder buildImage() {
    return Builder(
        builder: (context) => InteractiveViewer(
              transformationController: _transformationController,
              clipBehavior: Clip.none,
              minScale: minScale,
              maxScale: maxScale,
              onInteractionStart: (details) {
                if (details.pointerCount < 2) return;
                if (entry == null) showOverlay(context);
              },
              onInteractionUpdate: (details) {
                if (entry == null) return;
                this.scale = details.scale;
                entry!.markNeedsBuild();
              },
              onInteractionEnd: (details) {
                resetAnimation();
              },
              child: AspectRatio(
                aspectRatio: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://images.wallpapersden.com/image/download/jujutsu-kaisen-satoru-gojo_bGtubmuUmZqaraWkpJRmZ21lrWxnZQ.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ));
  }

  void showOverlay(BuildContext context) {
    final renderbox = context.findRenderObject()! as RenderBox;
    final offset = renderbox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    entry = OverlayEntry(
      builder: (context) {
        final opacity = ((scale - 1) / (maxScale - 1)).clamp(0, 1).toDouble();
        return Stack(
          children: <Widget>[
            Positioned.fill(
                child: Opacity(
              opacity: opacity,
              child: Container(
                color: Colors.black54,
              ),
            )),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              width: size.width - 39,
              child: buildImage(),
            ),
          ],
        );
      },
    );

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.ease),
    );
    animationController.forward(from: 0);
  }
}
