import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post_api_app/custom_listviewbuilder/custom_list.dart';

import 'package:post_api_app/custom_widget/widgets/custom_toolbar.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class InteractiveScreen extends StatefulWidget {
  const InteractiveScreen({Key? key}) : super(key: key);

  @override
  State<InteractiveScreen> createState() => _InteractiveScreenState();
}

class _InteractiveScreenState extends State<InteractiveScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(title: const Text("Interactive View")),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                width: double.maxFinite,
                height: 500,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ZoomOverlay(
                      minScale: 0.5, // optional
                      maxScale: 3.0, // optional
                      twoTouchOnly: true,
                      animationDuration: const Duration(milliseconds: 300),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://sysfilessacbe149174fee.blob.core.windows.net/public-container/clients/worthingtheatres/files/0341efaa-320d-4d40-ac3c-24d30f482a51.jpg",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
            
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.red, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    ZoomOverlay(
                      minScale: 0.5, // optional
                      maxScale: 3.0, // optional
                      twoTouchOnly: true,
                      animationDuration: const Duration(milliseconds: 300),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://www.hdwallpapers.in/download/blue_eyes_boy_jujutsu_kaisen_white_hair_satoru_gojo_school_uniform_4k_hd_jujutsu_kaisen-1280x720.jpg",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.purple, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // Image.network(
                      // "https://www.hdwallpapers.in/download/blue_eyes_boy_jujutsu_kaisen_white_hair_satoru_gojo_school_uniform_4k_hd_jujutsu_kaisen-1280x720.jpg"),
                    ),
                    ZoomOverlay(
                      minScale: 0.5, // optional
                      maxScale: 3.0, // optional
                      twoTouchOnly: true,
                      animationDuration: const Duration(milliseconds: 300),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://images3.alphacoders.com/111/thumb-1920-1116286.jpg",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.red, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 32,
              child: Text(
                "List",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Expanded(
              child: CustomListView(),
            )
          ],
        ),
      ),
      bottomNavigationBar: newBottom(size: MediaQuery.of(context).size),
    );
  }
}
