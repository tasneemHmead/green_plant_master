import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/core/viewmodel/add_planet_viemodel.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/widget/coustm_text.dart';
import 'package:green_plant/widget/custom_text_form_field.dart';

class AddPlanetsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addPlanetViwModel);
    return Scaffold(
      body: viewModel.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Add new Plant'.tr,
                  size: 30,
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: "Plant Name".tr,
                  controller: viewModel.planetNameController,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hint: "Sensor Number".tr,
                  controller: viewModel.planetNumberController,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: viewModel.image == null
                      ? IconButton(
                          onPressed: () => viewModel.getImage(),
                          iconSize: 100,
                          icon: Icon(
                            Icons.image,
                            color: primaryColor,
                          ),
                        )
                      : Container(
                          child: Image.file(viewModel.image),
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await viewModel.addNewPlanet();
        },
        child: Icon(
          Icons.assignment_turned_in_sharp,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
