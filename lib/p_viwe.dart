import 'dart:async';

import 'package:flutter/material.dart';

import 'main.dart';
import 'splash_screen.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  final String titel;

  final String description;
  final String imageUrl;
  final IconData iconData;
  Data({
    required this.titel,
    required this.description,
    required this.imageUrl,
    required this.iconData,
  });
}

class Pviwe extends StatefulWidget {
  const Pviwe({super.key});

  @override
  State<Pviwe> createState() => _PviweState();
}

class _PviweState extends State<Pviwe> {
  final PageController _controller = PageController(initialPage: 0);
  int carintIndex = 0;
  final List<Data> myData = [
    Data(
        titel: 'Page1',
        description: 'intended to give a mental image of something experienced',
        imageUrl: 'assets/1.jpg',
        iconData: Icons.offline_bolt),
    Data(
        titel: 'Page2',
        description:
            'a statement or account giving the characteristics of someone or something : a',
        imageUrl: 'assets/2.jpg',
        iconData: Icons.camera),
    Data(
        titel: 'Page3',
        description:
            'The review was little more than a description of the film\'s plot',
        imageUrl: 'assets/3.jpg',
        iconData: Icons.tablet_mac_outlined),
    Data(
        titel: 'Page4',
        description:
            'kind or character especially as determined by salient (see SALIENT entry 1 sense 3b) features',
        imageUrl: 'assets/4.jpg',
        iconData: Icons.laptop_chromebook),
  ];
  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(
          seconds: 5,
        ), (timer) {
      if (carintIndex < 3) {
        carintIndex++;
      }
      _controller.animateToPage(
        carintIndex,
        duration: const Duration(
          seconds: 2,
        ),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/h': (ctx) => const MyHomePage(),
        '/s': (ctx) => const SplashPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        body: Builder(builder: (ctx) {
          return PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  carintIndex = value;
                  // if (carintIndex == 3) {
                  //   Future.delayed(const Duration(seconds: 2),
                  //       (() => Navigator.of(ctx).pushReplacementNamed('/s')));
                  // }
                });
              },
              children: myData.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.iconData,
                            size: 130,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            item.titel,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.description,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Indictor(
                        index: carintIndex,
                      ),
                      // PageViewDotIndicator(
                      //   currentItem: carintIndex,
                      //   count: myData.length,
                      //   unselectedColor: Colors.black26,
                      //   selectedColor: Colors.blue,
                      //   duration: const Duration(milliseconds: 200),
                      // ),
                      Builder(builder: (ctx) {
                        return Align(
                          alignment: const Alignment(0, 0.93),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(7.5),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(ctx).pushReplacementNamed('/s');
                                final SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                _prefs.setBool('x', true);
                              },
                              child: const Text('Go To the Home Screen '),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                );
              }).toList());
        }),
      ),
    );
  }
}

class Indictor extends StatelessWidget {
  final int index;
  const Indictor({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.73),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circrlrIndicet(0, index == 0 ? Colors.red : Colors.white),
          circrlrIndicet(1, index == 1 ? Colors.red : Colors.white),
          circrlrIndicet(2, index == 2 ? Colors.red : Colors.white),
          circrlrIndicet(3, index == 3 ? Colors.red : Colors.white),
        ],
      ),
    );
  }

  Widget circrlrIndicet(int i, Color color) {
    return index == i
        ? const Icon(Icons.star)
        : Container(
            margin: const EdgeInsets.all(4),
            width: 15,
            height: 15,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          );
  }
}
//           ...myData.map((item) => Container())
