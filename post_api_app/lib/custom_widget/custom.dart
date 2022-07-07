import 'package:flutter/material.dart';
import 'package:post_api_app/custom_widget/widgets/custom_button.dart';
import 'package:post_api_app/custom_widget/widgets/custom_toolbar.dart';

class CustomScreen1 extends StatelessWidget {
  const CustomScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Widgets"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonText: 'First Button',
              onTap: () {},
              buttonColor: Colors.blueAccent,
              textColor: Colors.white,
              val: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  buttonText: "Second Button",
                  onTap: () {},
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.red,
                )),
                Expanded(
                    child: CustomButton(
                  buttonText: "Third Button",
                  onTap: () {},
                  buttonColor: Colors.deepOrangeAccent,
                  val: 10,
                ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              buttonText: 'Fourth Button',
              onTap: () {},
              buttonColor: Colors.red[100],
              textColor: Colors.red,
              val: 40,
            ),
          ],
        ),
      ),
      bottomNavigationBar: newBottom(size: MediaQuery.of(context).size),
    );
  }
}
