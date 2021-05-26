import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/models/add_planet_model.dart';
import 'package:green_plant/screens/control_view.dart';
import 'package:image_picker/image_picker.dart';

final addPlanetViwModel =
    ChangeNotifierProvider.autoDispose<AddPlanetsViewModel>(
        (ref) => AddPlanetsViewModel());

class AddPlanetsViewModel extends ChangeNotifier {
  TextEditingController planetNameController = TextEditingController();
  TextEditingController planetNumberController = TextEditingController();

  File image;
  final picker = ImagePicker();
  String downloadUrl;
  bool isLoading = false;

  addNewPlanet() async {
    isLoading = true;
    notifyListeners();
    downloadUrl = '';
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference();
    if (image != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        await storage.ref('uploads/${image.path}').putFile(image);
        downloadUrl =
            await storage.ref('uploads/${image.path}').getDownloadURL();
      } on FirebaseException catch (e) {
        print(e.toString());
      }
    }
    databaseReference.child(planetNumberController.text.toString() + " P").set(
          AddPlanetModel(
            float_switch: 0,
            ph_reading: 2.2,
            relay: 1,
            sensor_humidity: -1,
            sensor_temperature: -1,
            soil_mosture: 0,
            image: downloadUrl != ''
                ? downloadUrl
                : "https://www.ikea.com/eg/en/images/products/fejka-artificial-potted-plant-in-outdoor-monstera__0614197_pe686822_s5.jpg",
            name: planetNameController.text,
          ).toMap(),
        );
    planetNameController.text = '';
    planetNumberController.text = '';

    image = null;
    downloadUrl = '';
    isLoading = false;
    notifyListeners();
    Get.offAll(ControlView());
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }
}
