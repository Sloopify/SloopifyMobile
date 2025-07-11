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
  final int page;
  final bool hasReachedEnd;
  final bool fromStory;
  final String selectedCityName;
  final String selectedCountryName;

  const AddLocationState({
    required this.addNewPlaceStatus,
    required this.getUserPlacesStatus,
    required this.createPlaceEntity,
    required this.errorMessage,
    required this.places,
    required this.searchKeyWord,
    required this.selectedLocationId,
    required this.page,
    required this.hasReachedEnd,
    required this.fromStory,
    required this.selectedCityName,
    required this.selectedCountryName
  });

  factory AddLocationState.empty() {
    return AddLocationState(
      hasReachedEnd: true,
        page: 1,
      addNewPlaceStatus: AddNewPlaceStatus.init,
      getUserPlacesStatus: GetUserPlacesStatus.init,
      places: [],
      createPlaceEntity: CreatePlaceEntity(),
      errorMessage: "",
      searchKeyWord: "",
      selectedLocationId: 0,
      fromStory: false,
      selectedCityName: '',
      selectedCountryName: ''
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
    hasReachedEnd,
    page,
    fromStory,
    selectedCountryName,
    selectedCityName
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
    int ? page,
    bool ? hasReachedEnd,
    bool? fromStory,
   String? selectedCountryName,
   String? selectedCityName
  }) {
    return AddLocationState(
      selectedCityName: selectedCityName??this.selectedCityName,
      selectedCountryName: selectedCountryName??this.selectedCountryName,
      hasReachedEnd: hasReachedEnd??this.hasReachedEnd,
      page: page??this.page,
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
      fromStory: fromStory??this.fromStory
    );
  }
}
