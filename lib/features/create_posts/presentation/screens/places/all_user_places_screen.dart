import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../blocs/create_post_cubit/create_post_cubit.dart';
import 'add_new_place.dart';

class AllUserPlacesScreen extends StatelessWidget {
  const AllUserPlacesScreen({super.key});

  static const routeName = " All_user_places";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Where are you ?"),
      body: SafeArea(
        child: BlocBuilder<AddLocationCubit, AddLocationState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p20,
                    vertical: AppPadding.p10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: "Search for places",
                              withTitle: false,
                              onChanged: (value) {
                                context
                                    .read<AddLocationCubit>()
                                    .setSearchPlaces(value);
                              },
                            ),
                          ),
                          Gaps.hGap2,
                          SizedBox(
                            width: 70,
                            height: 50,
                            child: CustomElevatedButton(
                              label: "Find",
                              onPressed: () {
                                context
                                    .read<AddLocationCubit>()
                                    .searchUserPlaces();
                              },
                              backgroundColor: ColorManager.primaryColor
                                  .withOpacity(0.3),
                              borderSide: BorderSide(
                                color: ColorManager.primaryColor.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap3,
                      GestureDetector(
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              AddNewPlace.routeName,
                              arguments: {
                                "add_location_cubit":
                                    context.read<AddLocationCubit>(),
                              },
                            ),
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetsManager.addNewLocation),
                            Text(
                              "Add specific location",
                              style: AppTheme.headline4.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.vGap3,
                      if (state.getUserPlacesStatus ==
                          GetUserPlacesStatus.loading) ...[
                        Center(child: CircularProgressIndicator()),
                      ] else if (state.getUserPlacesStatus ==
                          GetUserPlacesStatus.offline) ...[
                        Center(
                          child: Text(
                            "you are offline",
                            style: AppTheme.headline4,
                          ),
                        ),
                      ] else if (state.getUserPlacesStatus ==
                          GetUserPlacesStatus.error) ...[
                        Center(
                          child: Text(
                            "some thing went error, please try again later!",
                            style: AppTheme.headline4,
                          ),
                        ),
                      ] else
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: state.places.length,
                            itemBuilder: (context, index) {
                              return _buildPlaceItem(
                                state.places[index],
                                context,
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Gaps.vGap2;
                            },
                          ),
                        ),
                      Gaps.vGap8,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 60,
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
                      label: "Done",
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<CreatePostCubit>().setLocationId(state.selectedLocationId);
                      },
                      backgroundColor: ColorManager.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlaceItem(PlaceEntity place, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AddLocationCubit>().selectLocation(place.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsManager.location2),
          Gaps.hGap1,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name,
                style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                '${place.country},${place.city}',
                style: AppTheme.headline4.copyWith(
                  color: ColorManager.textGray3,
                ),
              ),
            ],
          ),
          Spacer(),
          if (context.read<AddLocationCubit>().state.selectedLocationId ==
              place.id)
            Icon(Icons.check, color: ColorManager.primaryColor),
        ],
      ),
    );
  }
}
