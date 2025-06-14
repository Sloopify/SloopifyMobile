import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'dart:ui' as ui;

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/location_service.dart';
import '../../../../location/domain/entities/coords_entity.dart';

class LocationMapScreen extends StatefulWidget {
  static const routeName = 'location_map_screen';
  final Function? onPressed;
  final bool? fromAccount;

  const LocationMapScreen({
    super.key,
    this.onPressed,
    this.fromAccount = false,
  });

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  static final CURRENT_LOCATION = 'current_location';

  LatLng? _userCurrentLocationCoords = null;

  late CameraPosition _initialCameraPosition;
  GoogleMapController? _googleMapController;

  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  var _isLoading = true;

  CoordsEntity? selectedLocation;

  BitmapDescriptor? _customIcon;
  String? city;
  String? country;

  Future<void> _loadMarkerIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      AssetsManager.currentLocation,
    );
    setState(() {});
  }

  Future<void> _onLocationSelected() async {
    context.read<AddLocationCubit>().reverseGeocode(selectedLocation!);
    context.read<AddLocationCubit>().setCoordsEntity(selectedLocation);
    context.read<AddLocationCubit>().setPlaceCity(city ?? "");
    context.read<AddLocationCubit>().setPlaceCountry(country ?? "");
  }

  @override
  void initState() {
    super.initState();
    _loadMarkerIcon();
    Marker? _currentLocationMarker;
    fetchLocation(context).then((_) async {
      if (_userCurrentLocationCoords != null) {
        print(
          'my location ${_userCurrentLocationCoords!.latitude}${_userCurrentLocationCoords!.longitude}',
        );
        _initialCameraPosition = CameraPosition(
          target: _userCurrentLocationCoords!,
          zoom: 12.0,
          tilt: 0,
          bearing: 0,
        );
        //marker for the user current location;
        _currentLocationMarker = Marker(
          markerId: MarkerId(CURRENT_LOCATION),
          icon: _customIcon ?? BitmapDescriptor.defaultMarker,
          draggable: false,
          position: _userCurrentLocationCoords!,
        );
      } else {
        _initialCameraPosition = CameraPosition(
          target: LatLng(33.513876686466304, 36.27653299855675),
          zoom: 15,
        );
      }

      setState(() {
        if (_currentLocationMarker != null) {
          _markers.add(_currentLocationMarker!);
        }
        _isLoading = false;
      });
    });
  }

  Future<void> fetchLocation(BuildContext context) async {
    GeoLoc? res = await LocationService.getLocationCoords(context: context);
    Logger().e(res);
    if (res != null) {
      _userCurrentLocationCoords = LatLng(res.lat, res.lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: getCustomAppBar(context: context, title: "Where are you ?"),
          body: SafeArea(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.80,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                gestureRecognizers:
                                    <Factory<OneSequenceGestureRecognizer>>{
                                      Factory<OneSequenceGestureRecognizer>(
                                        () => EagerGestureRecognizer(),
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
                                  Marker _selectedLocationMarker = Marker(
                                    markerId: MarkerId(CURRENT_LOCATION),
                                    draggable: true,
                                    icon:
                                        _customIcon ??
                                        BitmapDescriptor.defaultMarker,
                                    position: position,
                                  );
                                  _googleMapController!.animateCamera(
                                    CameraUpdate.newLatLng(
                                      LatLng(
                                        position.latitude,
                                        position.longitude,
                                      ),
                                    ),
                                  );
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
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16,
                              ),

                              child: CustomElevatedButton(
                                width: MediaQuery.of(context).size.width,
                                backgroundColor: ColorManager.primaryColor,
                                label: 'select location'.tr(),
                                onPressed: () async {
                                  if (selectedLocation != null) {
                                    await _onLocationSelected();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        );
      },
    );
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
