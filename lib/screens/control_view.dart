import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/core/viewmodel/app_language.dart';
import 'package:green_plant/core/viewmodel/home_viewmodel.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/screens/home/home_view.dart';
import 'package:green_plant/screens/home/notification_view.dart';
import 'package:green_plant/widget/coustm_text.dart';

import 'home/add_plants_view.dart';
import 'home/statistics_view.dart';

class ControlView extends StatefulWidget {
  @override
  _ControlViewState createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read(homeViewModel);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: viewModel.userName,
                    color: Colors.black,
                    size: 24,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: viewModel.email,
                    color: Colors.black,
                    size: 24,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('add_planet'.tr),
              onTap: () {
                Get.to(AddPlanetsView());
              },
            ),
            ListTile(
              title: Text('statistics'.tr),
              onTap: () {
                Get.to(OrdinalInitialViewport.withSampleData());
              },
            ),
            GetBuilder<AppLanguage>(
              init: AppLanguage(),
              builder: (controller) {
                return ListTile(
                  title: Text(
                    'change_language'.tr,
                  ),
                  onTap: () async {
                    controller.changeLanguage();
                  },
                );
              },
            ),
            ListTile(
              title: CustomText(
                text: 'Logout'.tr,
                color: Colors.red,
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Color.fromRGBO(230, 250, 246, 1),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: _selectedPagesIndex == 0
              ? HomeView()
              : _selectedPagesIndex == 1
                  ? AddPlanetsView()
                  : SettingsView(),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            semanticLabel: 'MyFarm',
          ),
          Icon(
            Icons.add,
            size: 30,
            semanticLabel: 'Auto',
          ),
          Icon(
            Icons.notification_important_outlined,
            size: 30,
            semanticLabel: '',
          ),
        ],
        index: _selectedPagesIndex,
        onTap: _ontap,
        height: 50,
      ),
    );
  }

  int _selectedPagesIndex = 0;

  void _ontap(int index) {
    setState(() {
      _selectedPagesIndex = index;
    });
  }
}
