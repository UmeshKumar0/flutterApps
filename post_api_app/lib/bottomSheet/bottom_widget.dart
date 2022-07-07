import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildButton(
  String text,
  VoidCallback onClicked,
) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
        onPressed: onClicked,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ));

Widget buildSheet() => makeDissmssible(
      child: DraggableScrollableSheet(
        maxChildSize: 0.8,
        minChildSize: 0.5,
        initialChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          padding: const EdgeInsets.all(8.0),
          child: ListView(controller: controller, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://p4.wallpaperbetter.com/wallpaper/745/67/618/jujutsu-kaisen-anime-boys-anime-hd-wallpaper-preview.jpg",
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: buildButton("Close", () => Navigator.of(_).pop()),
                ),
                const SizedBox(
                  height: 130,
                ),
              ],
            ),
          ]),
        ),
      ),
    );

makeDissmssible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Get.back(),
    child: GestureDetector(
      onTap: () {},
      child: child,
    ));

buildfullSheet() => Column(
      children: [
        Center(
          child: ClipOval(
              child: CachedNetworkImage(
            imageUrl:
                "https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557216671.5403_tunyra_n.jpg",
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          )),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "hello",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );

buildsimpleSheet() => SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ClipOval(
                child: CachedNetworkImage(
              imageUrl:
                  "https://miscmedia-9gag-fun.9cache.com/images/thumbnail-facebook/1557216671.5403_tunyra_n.jpg",
              fit: BoxFit.cover,
              height: 150,
              width: 150,
            )),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "hello",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Trust in your gut feeling and listen to what it's telling you about any situation you are in.\n When you're making life-changing decisions that may make you feel overwhelmed, you \nreally need to trust in what's already present and available within you: your own natural \nhoming device, your internal GPS system- your intuition.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
