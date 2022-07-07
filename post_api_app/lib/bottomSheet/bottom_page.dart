import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post_api_app/bottomSheet/bottom_widget.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom Sheet App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(
              "Simple Sheet",
              () => showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(120))),
                context: context,
                builder: (context) => buildsimpleSheet(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            buildButton(
                "Full Screen Sheet",
                () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => buildfullSheet(),
                    )),
            const SizedBox(
              height: 30,
            ),
            buildButton(
              "Scrollable Sheet",
              () => showModalBottomSheet(
                // enableDrag: false,
                // isDismissible: false,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => buildSheet(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
