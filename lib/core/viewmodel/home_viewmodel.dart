import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_plant/core/database/Helper.dart';
import 'package:green_plant/core/services/notification_service.dart';
import 'package:green_plant/models/add_planet_model.dart';
import 'package:green_plant/models/notification_model.dart';
import 'package:green_plant/models/user_models.dart';

final homeViewModel =
    ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  List<AddPlanetModel> getAllPlanet = [];
  AddPlanetModel addPlanetModelDetails;
  String userName = '';
  String email = '';

  HomeViewModel() {
    getInitPlanet();
    getName();
  }

  void getInitPlanet() async {
    var recentJobsRef = FirebaseDatabase.instance.reference();

    recentJobsRef.onValue.listen((Event event) async {
      getAllPlanet = [];
      if (event.snapshot.value != null) {
        event.snapshot.value.forEach((key, values) {
          getAllPlanet.add(AddPlanetModel.fromMap(values, key));
        });
        notifyListeners();
        NotificationService().showNotification(
          getAllPlanet[0].name,
          "PH = " + getAllPlanet[0].ph_reading.toString(),
        );
        addNotificationToDatabase(
            getAllPlanet[0].name,
            "PH = " + getAllPlanet[0].ph_reading.toString(),
            getAllPlanet[0].image.toString());
      }
    });
  }

  void addNotificationToDatabase(name, body, image) async {
    var dbHelper = DatabaseHelper.db;
    dbHelper.insert(NotificationModel(
      name: name,
      body: body,
      image: image,
    ));
  }

  void getName() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      UserModel userModel = UserModel.fromSnapshot(value);
      userName = userModel.name;
      email = userModel.email;
      notifyListeners();
    });
  }

  delete(int index) async {
    FirebaseDatabase.instance
        .reference()
        .child(getAllPlanet[index].key)
        .remove();
    if (index == 0) {
      getAllPlanet = [];
    }
    notifyListeners();
  }
}

final streamDetails = StreamProvider.family<Event, String>((ref, key) {
  var recentJobsRef = FirebaseDatabase.instance.reference();

  return recentJobsRef.child(key).onValue;
});
