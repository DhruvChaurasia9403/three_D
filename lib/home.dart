import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';
import 'package:three_d/InvertedCircleClipper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  O3DController o3dController = O3DController();
  PageController mainPageController = PageController();
  PageController textsPageController = PageController();
  ScrollController listViewController = ScrollController();
  ValueNotifier<double> blurIntensity = ValueNotifier<double>(0.0);
  int page = 0;

  @override
  void initState() {
    super.initState();
    listViewController.addListener(() {
      blurIntensity.value = (listViewController.offset / 100).clamp(0.0, 10.0);
    });
  }

  @override
  void dispose() {
    listViewController.dispose();
    blurIntensity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<double>(
          valueListenable: blurIntensity,
          builder: (context, value, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF2C003E), // Deep Royal Purple (Luxury & Depth)
                          Color(0xFF6A0DAD), // Vibrant Violet (Premium & Energetic)
                          Color(0xFF1C1C1C), // Rich Black (Elegance & Power)
                          Color(0xFFD6C6E1), // Soft White-Purple (Subtle Luxury)
                          Color(0xFF0047AB), // Royal Blue (Trust & Strength)
                        ],
                        stops: [0.0, 0.2, 0.5, 0.75, 1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  O3D(
                    src: 'assets/demoness.glb', // Demoness Model
                    controller: o3dController,
                    ar: false,
                    autoPlay: true,
                    autoRotate: false,
                    cameraControls: false,
                    cameraTarget: CameraTarget(-0.25, 1.5, 0.5), // Adjust positioning
                    cameraOrbit: CameraOrbit(0, 90, 1), // Adjust the size and angle
                  ),
                  Container(
                    width: 100,
                    height: double.infinity,
                    margin: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.transparent // Royal Blue (Trust & Strength)
                          ],
                          stops: [0.0, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PageView(
                          controller: textsPageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Daily goals"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text("87"),
                                        ),
                                      ),
                                      Transform.translate(
                                          offset: const Offset(0, 20),
                                          child: const Text("%"))
                                    ],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(Icons.local_fire_department_outlined,
                                          color: Colors.red),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("1,840"),
                                            Text(
                                              "calories",
                                              style:
                                              TextStyle(fontSize: 12, color: Colors.grey),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(Icons.do_not_step, color: Colors.purple),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("3,480"),
                                            Text(
                                              "steps",
                                              style:
                                              TextStyle(fontSize: 12, color: Colors.grey),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(Icons.hourglass_bottom,
                                          color: Colors.lightBlueAccent),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("6.5"),
                                            Text(
                                              "hours",
                                              style:
                                              TextStyle(fontSize: 12, color: Colors.grey),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Journal"),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Transform.translate(
                                          offset: const Offset(0, 20),
                                          child: const Text("<")),
                                      const Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text("12"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "July 2020",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Queen"),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Demon"),
                                  ),
                                ),
                                Text(
                                  "20000 years old",
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PageView(
                    controller: mainPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        controller: listViewController,
                        padding: EdgeInsets.fromLTRB(12, height * 0.8, 12, 100),
                        itemCount: 10,
                        itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15.0),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/image1.jpg',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            title: const Text(
                              'A simple way to stay healthy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: const Text(
                              'Dr Drake',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        controller: listViewController,
                        padding: EdgeInsets.fromLTRB(12, height * 0.8, 12, 100),
                        itemCount: 10,
                        itemBuilder: (context, index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/image2.jpg',
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('10:24',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12
                                          ),
                                        ),
                                        Text('Morning walk',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('2 km in 30min',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Icon(Icons.directions_walk_rounded,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: InvertedCircleClipper(),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            color: Colors.grey.withOpacity(0.5), // Adjust the opacity as needed
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: page,
          onTap: (page) {
            mainPageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
            textsPageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);

            if (page == 0) {
              o3dController.cameraTarget(1, 1.5, 1.5);
              o3dController.cameraOrbit(0, 90, 1);
            } else if (page == 1) {
              o3dController.cameraTarget(0.5, 1.5, -.3);// Adjust the positioning
              o3dController.cameraOrbit(-90, 90, 10);// Adjust the size and angle
            } else if (page == 2) {
              o3dController.cameraTarget(0, 2.5, 0);
              o3dController.cameraOrbit(0, 90, -3);
            }

            setState(() {
              this.page = page;
            });
          },

          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'home1'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined), label: 'home2'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'home3'),
          ]),
    );
  }
}