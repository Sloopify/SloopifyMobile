import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'dart:ui' as ui;

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/utils/location_service.dart';
import '../../domain/entities/coords_entity.dart';

class LocationMapScreen extends StatefulWidget {
  static const routeName = 'location_map_screen';
  final Function? onPressed;
  final bool? fromAccount;

  const LocationMapScreen(
      {super.key, this.onPressed, this.fromAccount = false});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  final int maxRadiusKM = 5;
  static final CURRENT_LOCATION = 'current_location';
  static final PREVIOUS_LOCATION = 'previous_location';
  static final NEW_SELECTED_LOCATION = 'new_selected_location';

  LatLng? _userPreviousLocationCoords = null;
  LatLng? _userCurrentLocationCoords = null;

  late CameraPosition _initialCameraPosition;
  GoogleMapController? _googleMapController;

  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  var _isLoading = true;

  CoordsEntity? selectedLocation;

  Future<Uint8List> _createCustomMarkerBitmap(String text, [Color? c]) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = c ?? ColorManager.black;

    final TextPainter textPainter = TextPainter(
      textDirection: ui.TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500,color: ColorManager.white)

      ),
    );

    textPainter.layout();
    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;

    final double width = textWidth + 2 * AppPadding.p8;
    final double height = textHeight + 2 * AppPadding.p8;
    final double triangleHeight = 40.0.h;

    // Draw the background
    final RRect rRect =
    RRect.fromLTRBR(0, 0, width, height, Radius.circular(AppRadius.r12));
    canvas.drawRRect(rRect, paint);

    // Draw the text
    textPainter.paint(canvas, Offset(AppPadding.p8, AppPadding.p8));

    // Draw the triangle
    final Path trianglePath = Path()
      ..moveTo(width / 2 - triangleHeight / 2, height)
      ..lineTo(width / 2 + triangleHeight / 2, height)
      ..lineTo(width / 2, height + triangleHeight)
      ..close();
    canvas.drawPath(trianglePath, paint);

    final ui.Image image = await pictureRecorder.endRecording().toImage(
      width.toInt(),
      (height + triangleHeight).toInt(),
    );

    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    Marker? _currentLocationMarker;
    Marker? _previousLocationMarker;

    fetchLocation(context).then((_) async {
      if (_userCurrentLocationCoords != null) {
        print('my location ${_userCurrentLocationCoords!.latitude}${_userCurrentLocationCoords!.longitude}');
        _initialCameraPosition = CameraPosition(
          target: _userCurrentLocationCoords!,
          zoom: 12.0,
          tilt: 0,
          bearing: 0,
        );
        //marker for the user current location
        final Uint8List _currentLocationMarkerIcon =
        await _createCustomMarkerBitmap("you are here now ".tr());
        _currentLocationMarker = Marker(
            markerId: MarkerId(CURRENT_LOCATION),
            icon: BitmapDescriptor.fromBytes(_currentLocationMarkerIcon),
            draggable: false,
            position: _userCurrentLocationCoords!);
      } else {
        _initialCameraPosition = CameraPosition(
            target: LatLng(
              33.513876686466304,
              36.27653299855675,
            ),
            zoom: 15);
      }
      //marker for the user previous selected location
      if (_userPreviousLocationCoords != null) {
        final Uint8List _previousLocationMarkerIcon =
        await _createCustomMarkerBitmap(
            "your last location".tr(), Colors.blue);
        _previousLocationMarker = Marker(
            markerId: MarkerId(PREVIOUS_LOCATION),
            icon: BitmapDescriptor.fromBytes(_previousLocationMarkerIcon),
            draggable: false,
            position: _userPreviousLocationCoords!);
      }
      setState(() {
        if (_currentLocationMarker != null) {
          _markers.add(_currentLocationMarker!);
          // _circles.add(
          //   Circle(
          //     circleId: CircleId('maxRadiusCircle'),
          //     center: LatLng(_userCurrentLocationCoords!.latitude,
          //         _userCurrentLocationCoords!.longitude),
          //     radius: maxRadiusKM * 1000.r,
          //     // Radius in meters
          //     fillColor: Colors.orange.withOpacity(0.3),
          //     strokeColor: Colors.orange,
          //     strokeWidth: 1,
          //   ),
          // );
        }
        if (_previousLocationMarker != null) {
          _markers.add(_previousLocationMarker!);
        }
        _isLoading = false;
      });
    });
  }

  Future<void> fetchLocation(BuildContext context) async {
    if (false) {
      _userPreviousLocationCoords = LatLng(
        33.513876686466304,
        36.27653299855675,
      );
    }
    GeoLoc? res = await LocationService.getLocationCoords(
      context: context,
    );
    Logger().e(res);
    if (res != null) {
      _userCurrentLocationCoords = LatLng(res.lat, res.lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: getCustomAppBar(context: context,title: "Where are you ?"),
        body: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height:
                         MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      gestureRecognizers:
                      <Factory<OneSequenceGestureRecognizer>>{
                         Factory<OneSequenceGestureRecognizer>(
                              () =>  EagerGestureRecognizer(),
                        ),
                      },
                      zoomControlsEnabled: false,
                      onMapCreated: ((controller) {
                        _googleMapController = controller;
                      }),
                      initialCameraPosition: _initialCameraPosition,
                      markers: _markers,
                      circles: _circles,
                      onTap: (position) async {
                        if (_markers.contains(_markers.where(
                                (element) =>
                            element.markerId ==
                                NEW_SELECTED_LOCATION))) {
                          //remove the pre selected location when the use click at a new place
                          _markers.remove(_markers.where((element) =>
                          element.markerId ==
                              NEW_SELECTED_LOCATION));
                        }

                        final Uint8List _selectedLocationMarkerIcon =
                        await _createCustomMarkerBitmap(
                            "your new location".tr(),
                            Colors.green);

                        Marker _selectedLocationMarker = Marker(
                            markerId: MarkerId(NEW_SELECTED_LOCATION),
                            draggable: true,
                            icon: BitmapDescriptor.fromBytes(
                                _selectedLocationMarkerIcon),
                            position: position);
                        _googleMapController!.animateCamera(
                            CameraUpdate.newLatLng(LatLng(
                              position.latitude,
                              position.longitude,
                            )));
                        setState(() {
                          _markers.add(_selectedLocationMarker);
                          selectedLocation = CoordsEntity(
                            lat: position.latitude,
                            lng: position.longitude,
                          );
                        });
                      },
                    ),
                  ),
                  Gaps.vGap2,
                  Padding(
                    padding: widget.fromAccount!
                        ? EdgeInsets.symmetric(
                        horizontal: AppPadding.p16)
                        : EdgeInsets.zero,
                    child: CustomElevatedButton(
                      width: MediaQuery.of(context).size.width,
                        backgroundColor: ColorManager.primaryColor,
                        label: 'select location'.tr(),
                        onPressed: () {
                          if (selectedLocation == null) {
                           // _showConfirmationDialog(context);
                          } else {
                        //    double distance =
                            // LocationService.calculateDistanceInKilo(
                            //   lat1:
                            //   _userCurrentLocationCoords?.latitude?? 33.513876686466304,
                            //   lat2: selectedLocation?.lat?? 33.513876686466304,
                            //   lng1:
                            //   _userCurrentLocationCoords?.longitude??36.27653299855675,
                            //   lng2: selectedLocation?.lng??36.27653299855675,
                            // );
                            //
                            // BlocProvider.of<AddLocationCubit>(context)
                            //     .setLocation(
                            //     selectedLocation!,
                            //     context
                            //         .read<AuthRepo>()
                            //         .getUserId()!);
                          }
                        }

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }


  // void _showConfirmationDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (c) {
  //       return BlocProvider.value(
  //         value: context.read<AddLocationCubit>(),
  //         child: AlertDialog(
  //           title: Text(
  //             'confirm_location'.tr(),
  //             style: TextStyle(fontSize: AppFontSize.f12),
  //             textAlign: TextAlign.center,
  //           ),
  //           content: Text(
  //             'click_yes_to_confirm_location'.tr(),
  //             style: TextStyle(fontSize: AppFontSize.f12),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 // BlocProvider.of<AddLocationCubit>(context).setLocation(
  //                 //     CoordsEntity(
  //                 //       lat: _userCurrentLocationCoords!.latitude,
  //                 //       lng: _userCurrentLocationCoords!.longitude,
  //                 //     ),
  //                 //     context.read<AuthRepo>().getUserId()!);
  //                 Navigator.pop(context);
  //               },
  //               child: Text(
  //                 'yes'.tr(),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text(
  //                 'no'.tr(),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _buildListener(AddLocationState state, BuildContext context) {
  //   if (state.addLocationStatus == AddLocationStatus.loading) {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return Dialog(
  //             child: LoadingContentDialog(text: 'saving_your_location'.tr()));
  //       },
  //     );
  //   } else if (state.addLocationStatus == AddLocationStatus.noInternet) {
  //     Navigator.pop(context);
  //     showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return Dialog(
  //             child: ErrorContentDialog(
  //               onPressed: () {
  //                 BlocProvider.of<AddLocationCubit>(context).setLocation(
  //                     selectedLocation!, context.read<AuthRepo>().getUserId()!);
  //               },
  //               text: 'no_internet_connection'.tr(),
  //             ));
  //       },
  //     );
  //     Future.delayed(const Duration(seconds: 1), () {
  //       // Navigator.pop(context);
  //       Navigator.pop(context);
  //     });
  //   } else if (state.addLocationStatus == AddLocationStatus.networkError) {
  //     Navigator.pop(context);
  //     showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return Dialog(
  //             child: ErrorContentDialog(
  //               onPressed: () {
  //               },
  //               text: AppStrings.networkError,
  //             ));
  //       },
  //     );
  //     Future.delayed(const Duration(seconds: 1), () {
  //       //    Navigator.pop(context);
  //       Navigator.pop(context);
  //     });
  //   } else if (state.addLocationStatus == AddLocationStatus.done) {
  //     Navigator.pop(context);
  //     showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return Dialog(
  //             child: DoneContentDialog(
  //               onPressed: () {
  //                 if (widget.fromAccount!) {
  //                   Navigator.pop(context);
  //                 } else {
  //                   widget.onPressed!();
  //                 }
  //               },
  //               title: 'your_location_updated_successfully'.tr(),
  //               subTitle: widget.fromAccount == true
  //                   ? ''
  //                   : 'please_click_next_to_proceed'.tr(),
  //             ));
  //       },
  //     );
  //   }
  // }
}
