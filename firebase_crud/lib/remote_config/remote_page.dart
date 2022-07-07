// ignore_for_file: deprecated_member_use, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RemoteScreen extends StatefulWidget {
  const RemoteScreen({Key? key}) : super(key: key);

  @override
  State<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends State<RemoteScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Remote Config",
      home: FutureBuilder<RemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          return snapshot.hasData
              ? Home(remoteConfig: snapshot.requireData)
              : Container(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
        },
      ),
    );
  }
}

class Home extends AnimatedWidget {
  final RemoteConfig remoteConfig;
  bool screen = true;
  late bool anima = true;
  Home({required this.remoteConfig}) : super(listenable: remoteConfig);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Remote Cofig",
        ),
      ),
      body: remoteConfig.getBool("Screen")
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sorry This app is in maintainence "),
                SizedBox(
                  height: 40,
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
                    try {
                      await remoteConfig.setConfigSettings(RemoteConfigSettings(
                          fetchTimeout: Duration(seconds: 10),
                          minimumFetchInterval: Duration.zero));
                      await remoteConfig.fetchAndActivate();
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  icon: Icon(Icons.replay_circle_filled_sharp),
                  label: Text("Refresh"),
                )
              ],
            ))
          : Container(
              color: Colors.yellow[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 30, left: 40),
                child: Column(
                  children: [
                    Image.network(
                      remoteConfig.getString("TestImage"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      remoteConfig.getString("TestText"),
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                    Container(
                      color: Colors.grey[300],
                      child: Column(children: [
                        Text(remoteConfig.lastFetchStatus.toString()),
                        Text(remoteConfig.lastFetchTime.toString()),
                      ]),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        try {
                          await remoteConfig.setConfigSettings(
                              RemoteConfigSettings(
                                  fetchTimeout: Duration(seconds: 10),
                                  minimumFetchInterval: Duration.zero));
                          await remoteConfig.fetchAndActivate();
                          anima = false;
                          Future.delayed(const Duration(milliseconds: 500), () {
                            anima = true;
                          });
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      icon: anima
                          ? Icon(Icons.replay_circle_filled_sharp)
                          : TweenAnimationBuilder(
                              tween: Tween<double>(begin: 2 * math.pi, end: 0),
                              duration: Duration(seconds: 2),
                              builder: (_, double angle, __) {
                                return Transform.rotate(
                                  angle: angle,
                                  child: Icon(Icons.replay_circle_filled_sharp),
                                );
                              }),
                      label: Text("Refresh"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.fetch();
  await remoteConfig.activate();
  print(remoteConfig.getString("Text"));
  return remoteConfig;
}
