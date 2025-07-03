import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/utils/app_validators.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/places/location_map_screen.dart';

import '../../../../../core/ui/widgets/custom_elevated_button.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({super.key});

  static const routeName = "add_new_place";

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  late TextEditingController cityNameController;
  late TextEditingController countryNameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final state = context
        .read<AddLocationCubit>()
        .state;
    cityNameController = TextEditingController(
      text: state.createPlaceEntity.city,
    );
    countryNameController = TextEditingController(
      text: state.createPlaceEntity.country,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final state = context
        .read<AddLocationCubit>()
        .state;
    cityNameController = TextEditingController(
      text: state.createPlaceEntity.city,
    );
    countryNameController = TextEditingController(
      text: state.createPlaceEntity.country,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Add specific location"),
      body: SafeArea(
        child: BlocListener<AddLocationCubit, AddLocationState>(
          listener: (context, state) {
            buildListener(context, state);
          },
          child: BlocBuilder<AddLocationCubit, AddLocationState>(
            builder: (context, state) {
              print(state.createPlaceEntity.city);
              cityNameController.text = state.createPlaceEntity.city ?? "";
              countryNameController.text =
                  state.createPlaceEntity.country ?? "";
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppPadding.p10,
                        horizontal: AppPadding.p20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Center(
                              child: Image.asset(
                                AssetsManager.addNewPlace,
                                height: 200,
                              ),
                            ),
                            Gaps.vGap2,
                            CustomTextField(
                              validator:
                                  (value) =>
                                  Validator.requiredValidate(
                                    value!,
                                    context,
                                  ),
                              initialValue: state.createPlaceEntity.name,
                              hintText: "place name",
                              withTitle: true,
                              labelText: "PlaceName",
                              onChanged: (value) {
                                context.read<AddLocationCubit>().setPlaceName(
                                  value,
                                );
                              },
                            ),
                            Gaps.vGap2,
                            CustomTextField(
                              initialValue: null,
                              controller: cityNameController,
                              hintText: "city",
                              withTitle: true,
                              labelText: "City",
                              onChanged: (value) {
                                context.read<AddLocationCubit>().setPlaceCity(
                                  value,
                                );
                              },
                            ),
                            Gaps.vGap2,
                            CustomTextField(
                              initialValue: null,
                              controller: countryNameController,
                              hintText: "country",
                              withTitle: true,
                              labelText: "Country",
                              onChanged: (value) {
                                context
                                    .read<AddLocationCubit>()
                                    .setPlaceCountry(value);
                              },
                            ),
                            Gaps.vGap2,
                            Center(
                              child: GestureDetector(
                                onTap:
                                    () =>
                                    Navigator.of(context).pushNamed(
                                      LocationMapScreen.routeName,
                                      arguments: {
                                        "add_location_cubit":
                                        context.read<AddLocationCubit>(),
                                      },
                                    ),
                                child: Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.5,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8,
                                    vertical: AppPadding.p16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: ColorManager.gray600,
                                    ),
                                  ),
                                  child: Text(
                                    "Choose on map",
                                    style: AppTheme.headline3.copyWith(
                                      color: ColorManager.gray600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p50,
                        vertical: AppPadding.p8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 6,
                            color: ColorManager.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: CustomElevatedButton(
                        isLoading:
                        state.addNewPlaceStatus ==
                            AddNewPlaceStatus.loading,
                        label: "Done",
                        onPressed:
                        state.addNewPlaceStatus == AddNewPlaceStatus.loading
                            ? () {}
                            : () {
                          if (!(_formKey.currentState!.validate())) return;
                          context
                              .read<AddLocationCubit>()
                              .createUserPlace();
                        },
                        backgroundColor: ColorManager.primaryColor,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.5,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void buildListener(BuildContext context, AddLocationState state) {
    if (state.addNewPlaceStatus == AddNewPlaceStatus.success) {
      Navigator.of(context).pop();
    } else if (state.addNewPlaceStatus == AddNewPlaceStatus.offline) {
      showSnackBar(context, state.errorMessage, isOffline: true);
    } else if (state.addNewPlaceStatus == AddNewPlaceStatus.error){
      showSnackBar(context, state.errorMessage, isError: true);

    }
  }
}
