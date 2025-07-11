part of 'play_audio_cubit.dart';

enum GetAudioStatus { init, loading, success, error, offline }

class PlayAudioState extends Equatable {
  final GetAudioStatus getAudioStatus;
  final int page;
  final bool hasReachedEnd;
  final List<AudioEntity> audioFiles;
  final String errorMessage;
  final int selectedAudioId;
  final String selectedAudioUrl;
  final String selectedAudioImage;
  final String searchKeyWord;
  final String selectedAudioName;

  const PlayAudioState({
    required this.getAudioStatus,
    required this.page,
    required this.errorMessage,
    required this.hasReachedEnd,
    required this.audioFiles,
    required this.selectedAudioImage,
    required this.selectedAudioId,
    required this.selectedAudioUrl,
    required this.searchKeyWord,
    required this.selectedAudioName
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        getAudioStatus,
        page,
        hasReachedEnd,
        audioFiles,
        errorMessage,
        selectedAudioUrl,
        selectedAudioId,
        selectedAudioImage,
        searchKeyWord,
        selectedAudioName
      ];

  factory PlayAudioState.fromEmpty() {
    return PlayAudioState(
      getAudioStatus: GetAudioStatus.init,
      page: 1,
      errorMessage: "",
      hasReachedEnd: false,
      audioFiles: [],
      searchKeyWord: '',
      selectedAudioId: 0,
      selectedAudioImage: '',
      selectedAudioUrl: '',
      selectedAudioName: ''
    );
  }

  PlayAudioState copyWith({
    GetAudioStatus? getAudioStatus,
    int ?page,
    bool? hasReachedEnd,
    List<AudioEntity>? audioFiles,
    String? errorMessage,
     int ?  selectedAudioId,
     String? selectedAudioUrl,
     String ?selectedAudioImage,
     String ?searchKeyWord,
    String? selectedAudioName
  }) {
    return PlayAudioState(
        getAudioStatus: getAudioStatus ?? this.getAudioStatus,
        page: page??this.page,
        errorMessage: errorMessage??this.errorMessage,
        hasReachedEnd: hasReachedEnd??this.hasReachedEnd,
        searchKeyWord: searchKeyWord??this.searchKeyWord,
        selectedAudioId: selectedAudioId??this.selectedAudioId,
        selectedAudioImage: selectedAudioImage??this.selectedAudioImage,
        selectedAudioUrl: selectedAudioUrl??this.selectedAudioUrl,
        selectedAudioName: selectedAudioName??this.selectedAudioName,
        audioFiles: audioFiles??this.audioFiles);
  }
}
