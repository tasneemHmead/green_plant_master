import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/core/viewmodel/home_viewmodel.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/screens/planet_details/planet_details.dart';
import 'package:green_plant/widget/button/custom_buttom.dart';
import 'package:green_plant/widget/coustm_text.dart';

class HomeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(homeViewModel);
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 250, 246, 1),
      body: viewModel.getAllPlanet.length == 0
          ? Center(
              child: CustomText(
                text: 'لا يوجد اي نباتات',
              ),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'myـPlanet'.tr,
                      size: 40,
                      color: primaryColor,
                    ),
                    viewModel.getAllPlanet.length == 0
                        ? Container()
                        : Container(
                            height: 400,
                            padding: EdgeInsets.all(20),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 250,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(PlanetDetails(viewModel
                                                .getAllPlanet[index].key));
                                          },
                                          child: Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(4.0, 4.0),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  viewModel.getAllPlanet[index]
                                                      .image,
                                                  height: 150,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                CustomText(
                                                  text: viewModel
                                                      .getAllPlanet[index].name,
                                                  color: primaryColor
                                                      .withOpacity(0.9),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      CustomButton(
                                        onPress: () async {
                                          await viewModel.delete(index);
                                        },
                                        text: "Delete",
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: viewModel.getAllPlanet.length,
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CustomText(
                              text: 'temperature',
                              size: 24,
                              color: primaryColor,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/temperature.png',
                                  height: 40,
                                  width: 40,
                                ),
                                CustomText(
                                  text: viewModel.getAllPlanet.length == 0
                                      ? ''
                                      : viewModel
                                          .getAllPlanet[0].sensor_temperature
                                          .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: 'Humidity',
                              size: 24,
                              color: primaryColor,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/water.png',
                                  height: 40,
                                  width: 40,
                                ),
                                CustomText(
                                  text: viewModel.getAllPlanet.length == 0
                                      ? ''
                                      : viewModel
                                          .getAllPlanet[0].sensor_humidity
                                          .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
