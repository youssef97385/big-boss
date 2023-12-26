import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bigboss/src/core/common/widgets/button_view.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/routes/router.gr.dart';

// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as webGM;
const DEFAULT_ZOOM = 14.4746;
const KINSHASA_LOCATION = LatLng(36.189399, 44.009306);

class MapPicker extends StatefulWidget {
  LatLng? value;

  MapPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            var maxWidth = constraints.biggest.width;
            var maxHeight = constraints.biggest.height;

            return Stack(
              children: <Widget>[
                SizedBox(
                  height: maxHeight,
                  width: maxWidth,
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: KINSHASA_LOCATION,
                      zoom: DEFAULT_ZOOM,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition newPosition) async {

                      widget.value = newPosition.target;
                    },
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    zoomGesturesEnabled: true,
                    padding: const EdgeInsets.all(0),
                    buildingsEnabled: true,
                    cameraTargetBounds: CameraTargetBounds.unbounded,
                    compassEnabled: true,
                    indoorViewEnabled: false,
                    mapToolbarEnabled: true,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    trafficEnabled: false,
                  ),
                ),
                Positioned(
                  bottom: maxHeight / 2,
                  right: (maxWidth - 30) / 2,
                  child: Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () async {
                        var position = await _determinePosition();
                      },
                      icon: const Icon(Icons.my_location),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: SizedBox(
                        width: 240,
                        height: 60,
                        child: ButtonView(
                          title: "Confirm".tr(),
                          buttonType: ButtonType.soldButton,
                          onClick: () {
                            context.router.replace(AddressDetailsPageAppRouter(
                                latLng: widget.value));
                          },
                          buttonStyle: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.primary),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                        ),
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: DEFAULT_ZOOM)));
    return await Geolocator.getCurrentPosition();
  }
}
