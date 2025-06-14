import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/create_place_use_case.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/get_all_user_places_use_case.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/search_places.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/update_place_use_caes.dart';
import 'package:sloopify_mobile/features/location/domain/entities/coords_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/get_user_place_by_id_use_case.dart';

part 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  final GetAllUserPlacesUseCase getAllUserPlacesUseCase;
  final GetUserPlaceByIdUseCase getUserPlaceByIdUseCase;
  final SearchPlaces searchPlaces;
  final CreatePlaceUseCase createPlaceUseCase;
  final UpdatePlaceUseCase updatePlaceUseCase;

  AddLocationCubit({
    required this.updatePlaceUseCase,
    required this.createPlaceUseCase,
    required this.searchPlaces,
    required this.getUserPlaceByIdUseCase,
    required this.getAllUserPlacesUseCase,
  }) : super(AddLocationState.empty());

  setSearchPlaces(String value) {
    emit(
      state.copyWith(
        searchKeyWord: value,
        getUserPlacesStatus: GetUserPlacesStatus.init,
        addNewPlaceStatus: AddNewPlaceStatus.init,
      ),
    );
  }

  selectLocation(int value) {
    emit(
      state.copyWith(
        selectedLocationId: value,
        getUserPlacesStatus: GetUserPlacesStatus.init,
        addNewPlaceStatus: AddNewPlaceStatus.init,
      ),
    );
  }

  setPlaceName(String placeName) {
    emit(
      state.copyWith(
        name: placeName,
        addNewPlaceStatus: AddNewPlaceStatus.init,
        getUserPlacesStatus: GetUserPlacesStatus.init,
      ),
    );
  }

  setPlaceCity(String? cityName) {
    emit(
      state.copyWith(
        city: cityName,
        addNewPlaceStatus: AddNewPlaceStatus.init,
        getUserPlacesStatus: GetUserPlacesStatus.init,
      ),
    );
  }

  setPlaceCountry(String? countryName) {
    emit(
      state.copyWith(
        country: countryName,
        addNewPlaceStatus: AddNewPlaceStatus.init,
        getUserPlacesStatus: GetUserPlacesStatus.init,
      ),
    );
  }

  setCoordsEntity(CoordsEntity? coords) {
    emit(
      state.copyWith(
        latitude: coords?.lat.toString(),
        longitude: coords?.lng.toString(),
        addNewPlaceStatus: AddNewPlaceStatus.init,
        getUserPlacesStatus: GetUserPlacesStatus.init,
      ),
    );
  }

  getAllUserPlaces() async {
    emit(state.copyWith(getUserPlacesStatus: GetUserPlacesStatus.loading));
    final res = await getAllUserPlacesUseCase.call();
    res.fold(
      (l) {
        _mapFailureGetPlacesToState(emit, l, state);
      },
      (data) {
        emit(
          state.copyWith(
            places: data,
            getUserPlacesStatus: GetUserPlacesStatus.success,
          ),
        );
      },
    );
  }

  searchUserPlaces() async {
    emit(state.copyWith(getUserPlacesStatus: GetUserPlacesStatus.loading));
    final res = await searchPlaces.call(search: state.searchKeyWord);
    res.fold(
      (l) {
        _mapFailureGetPlacesToState(emit, l, state);
      },
      (data) {
        emit(
          state.copyWith(
            places: data,
            getUserPlacesStatus: GetUserPlacesStatus.success,
          ),
        );
      },
    );
  }

  createUserPlace() async {
    emit(state.copyWith(addNewPlaceStatus: AddNewPlaceStatus.loading));
    final res = await createPlaceUseCase.call(createPlaceEntity:state.createPlaceEntity);
    res.fold(
          (l) {
            _mapFailureCreatePlacesToState(emit, l, state);
      },
          (data) {
        emit(
          state.copyWith(
            getUserPlacesStatus: GetUserPlacesStatus.init,
            addNewPlaceStatus: AddNewPlaceStatus.success
          ),
        );
      },
    );
  }

  Future<void> reverseGeocode(CoordsEntity position) async {
    String _apiKey = "db730ff3928140129d292c4d53e859fd";
    final url = Uri.parse(
      'https://api.opencagedata.com/geocode/v1/json?q=${position.lat}+${position.lng}&key=$_apiKey&language=en&pretty=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final components = json['results'][0]['components'];
      print("ccccccccccccccomponenets ${components}");

      emit(
        state.copyWith(
          city: components['state'] ?? '',
          country: components['country'],
        ),
      );
    } else {
      print('Failed to reverse geocode');
    }
  }

  _mapFailureGetPlacesToState(emit, Failure f, AddLocationState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getUserPlacesStatus: GetUserPlacesStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getUserPlacesStatus: GetUserPlacesStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
  _mapFailureCreatePlacesToState(emit, Failure f, AddLocationState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            addNewPlaceStatus: AddNewPlaceStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            addNewPlaceStatus: AddNewPlaceStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
