part of 'add_location_cubit.dart';

enum GetUserPlacesStatus { init, loading, success, error, offline }

enum AddNewPlaceStatus { init, loading, success, error, offline }

class AddLocationState extends Equatable {
  final CreatePlaceEntity createPlaceEntity;
  final GetUserPlacesStatus getUserPlacesStatus;
  final String errorMessage;
  final AddNewPlaceStatus addNewPlaceStatus;
  final List<PlaceEntity> places;
  final String searchKeyWord;
  final int selectedLocationId;

  const AddLocationState({
    required this.addNewPlaceStatus,
    required this.getUserPlacesStatus,
    required this.createPlaceEntity,
    required this.errorMessage,
    required this.places,
    required this.searchKeyWord,
    required this.selectedLocationId,
  });

  factory AddLocationState.empty() {
    return AddLocationState(
      addNewPlaceStatus: AddNewPlaceStatus.init,
      getUserPlacesStatus: GetUserPlacesStatus.init,
      places: [],
      createPlaceEntity: CreatePlaceEntity(),
      errorMessage: "",
      searchKeyWord: "",
      selectedLocationId: 0,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    createPlaceEntity,
    getUserPlacesStatus,
    errorMessage,
    addNewPlaceStatus,
    places,
    searchKeyWord,
    selectedLocationId,
  ];

  AddLocationState copyWith({
    int? id,
    String? name,
    String? city,
    String? country,
    String? latitude,
    String? longitude,
    String? status,
    GetUserPlacesStatus? getUserPlacesStatus,
    String? errorMessage,
    AddNewPlaceStatus? addNewPlaceStatus,
    List<PlaceEntity>? places,
    String? searchKeyWord,
    int? selectedLocationId,
  }) {
    return AddLocationState(
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      searchKeyWord: searchKeyWord ?? this.searchKeyWord,
      addNewPlaceStatus: addNewPlaceStatus ?? this.addNewPlaceStatus,
      getUserPlacesStatus: getUserPlacesStatus ?? this.getUserPlacesStatus,
      createPlaceEntity: createPlaceEntity.copWith(
        longitude: longitude ?? createPlaceEntity.longitude,
        city: city ?? createPlaceEntity.city,
        country: country ?? createPlaceEntity.country,
        name: name ?? createPlaceEntity.name,
        id: id ?? createPlaceEntity.id,
        status: status ?? createPlaceEntity.status,
        latitude: latitude ?? createPlaceEntity.latitude,
      ),
      errorMessage: errorMessage ?? this.errorMessage,
      places: places ?? this.places,
    );
  }
}
