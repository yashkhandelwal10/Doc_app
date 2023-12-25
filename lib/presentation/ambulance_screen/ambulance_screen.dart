import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yash_s_application1/core/app_export.dart';
import 'package:yash_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:yash_s_application1/widgets/app_bar/appbar_subtitle.dart';
import 'package:yash_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:yash_s_application1/widgets/custom_elevated_button.dart';
import 'package:yash_s_application1/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class AmbulanceScreen extends StatelessWidget {
  AmbulanceScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                height: 724.v,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 1.v),
                child: Stack(alignment: Alignment.center, children: [
                  _buildMap(context),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10.h, 28.v, 10.h, 23.v),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: CustomSearchView(
                                    controller: searchController,
                                    hintText: "Search location, ZIP code..")),
                            SizedBox(height: 63.v),
                            CustomImageView(
                                imagePath: ImageConstant.imgMapPointsImage,
                                height: 331.v,
                                width: 355.h),
                            Spacer(),
                            _buildLocation(context)
                          ])))
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 45.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 21.h, top: 10.v, bottom: 10.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarSubtitle(text: "Ambulance"));
  }

  /// Section Widget
  Widget _buildMap(BuildContext context) {
    return SizedBox(
        height: 710.v,
        width: double.maxFinite,
        child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: 14.4746),
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false));
  }

  /// Section Widget
  Widget _buildLocation(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 14.v),
        decoration: AppDecoration.white
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 5.v),
              Padding(
                  padding: EdgeInsets.only(right: 32.h),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgLocationRed300,
                            height: 26.v,
                            width: 28.h,
                            margin: EdgeInsets.only(top: 3.v, bottom: 11.v)),
                        Expanded(
                            child: Container(
                                width: 255.h,
                                margin: EdgeInsets.only(left: 18.h),
                                child: Text(
                                    "2640 Cabin Creek Rd #102 Alexandria, Virginia(VA), 22314",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(height: 1.50))))
                      ])),
              SizedBox(height: 9.v),
              CustomElevatedButton(text: "Confirm Location")
            ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
