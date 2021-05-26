import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/core/database/Helper.dart';
import 'package:green_plant/core/services/notification_service.dart';
import 'package:green_plant/core/viewmodel/home_viewmodel.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/models/add_planet_model.dart';
import 'package:green_plant/models/notification_model.dart';
import 'package:green_plant/widget/coustm_text.dart';

class PlanetDetails extends ConsumerWidget {
  final String id;

  PlanetDetails(this.id);
  void addNotificationToDatabase(name, body, image) async {
    var dbHelper = DatabaseHelper.db;
    dbHelper.insert(NotificationModel(name: name, body: body, image: image));
  }

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(streamDetails(id));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(230, 250, 246, 1),
      ),
      backgroundColor: Color.fromRGBO(230, 250, 246, 1),
      body: viewModel.when(
        data: (value) {
          AddPlanetModel addPlanetModelDetails =
              AddPlanetModel.fromMap(value.snapshot.value, value.snapshot.key);
          NotificationService().showNotification(
            addPlanetModelDetails.name,
            "Moisture = " + addPlanetModelDetails.soil_mosture.toString(),
          );
          addNotificationToDatabase(
              addPlanetModelDetails.name,
              "Moisture = " + addPlanetModelDetails.soil_mosture.toString(),
              addPlanetModelDetails.image);

          return Center(
            child: Container(
              width: Get.width * 0.8,
              height: Get.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        addPlanetModelDetails.image,
                        height: 150,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        size: 30,
                        text: addPlanetModelDetails.name,
                        color: primaryColor.withOpacity(0.9),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CustomText(
                            size: 30,
                            text: 'Moisture',
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.green,
                                width: 20,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  addPlanetModelDetails.soil_mosture == 1
                                      ? 'images/wet.png'
                                      : 'images/dry.png',
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                    text:
                                        addPlanetModelDetails.soil_mosture == 1
                                            ? 'Wet'
                                            : 'Dry'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomText(
                            size: 30,
                            text: 'PH',
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.green,
                                width: 20,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/ph.png',
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                    text: addPlanetModelDetails.ph_reading
                                        .toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (_, __) {},
      ),
    );
  }
}
