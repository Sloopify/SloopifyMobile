import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/core/utils/location_service.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/media_story.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/create_my_story_use_case.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/ui/widgets/text_editor_widget.dart';
import '../../../../../core/utils/helper/postioned_element_story_theme.dart';
import '../../../../create_posts/domain/entities/media_entity.dart';
import '../../../domain/entities/all_positioned_element.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/poll_entity_option.dart';
import '../../../domain/entities/story_entity.dart';
import '../../../domain/entities/text_properties_story.dart';

class StoryEditorCubit extends Cubit<StoryEditorState> {
  final CreateMyStoryUseCase createMyStoryUseCase;

  StoryEditorCubit({required this.createMyStoryUseCase})
    : super(const StoryEditorState());
  final Uuid _uuid = const Uuid();

  createStory() async {
    emit(state.copyWith(createStoryStatus: CreateStoryStatus.loading));
    final res = await createMyStoryUseCase.call(storyEntity: toStoryEntity());
    res.fold(
      (l) {
        _mapFailureCreateStoryToState(emit, l, state);
      },
      (r) {
        emit(state.copyWith(createStoryStatus: CreateStoryStatus.success));
      },
    );
  }

  void toggleSelection(AssetEntity asset) {
    final updated = List<AssetEntity>.from(state.selectedMedia);
    if (updated.contains(asset)) {
      updated.remove(asset);
    } else {
      if (updated.length <= 8) {
        updated.add(asset);
      }
    }
    emit(state.copyWith(selectedMedia: updated));

  }

  selectOneMedia(AssetEntity asset) async {
    final file = await asset.file;
    final MediaStory mediaStory = MediaStory(
      file: file,
      isVideoFile: asset.type == AssetType.video,
      id: Uuid().v4(),
    );
    emit(state.copyWith(selectedMedia: [...state.selectedMedia, asset]));
    final List<MediaStory> media = List.from(state.mediaFiles ?? []);
    media.add(mediaStory);
    emit(state.copyWith(mediaFiles: media));
  }

  void updateSingleMedia(MediaStory updatedMedia) {
    final List<MediaStory> current = List.from(state.mediaFiles ?? []);
    final index = current.indexWhere((e) => e.id == updatedMedia.id);
    if (index != -1) {
      current[index] = updatedMedia;
      emit(state.copyWith(mediaFiles: current));
    }
  }

  // void toggleVideoMute(MediaStory updatedMedia) {
  //   final List<MediaStory> current = List.from(state.mediaFiles ?? []);
  //   final index = current.indexWhere((e) => e.id == updatedMedia.id);
  //   if (index != -1) {
  //     current[index] = updatedMedia;
  //     current[index].copyWith(isVideoMuted: !(updatedMedia.isVideoFile));
  //     emit(state.copyWith(mediaFiles: current));
  //   }
  // }
  void onUpdateAttributeOneMedia(double scale, Offset offset, double rotation) {
    final currentOne = state.mediaFiles!.first;
    final updatedMedia = currentOne.copyWith(
      scale: scale,
      rotateAngle: rotation,
      offset: offset,
    );
    emit(state.copyWith(selectedEditedMedia: updatedMedia));
    List<MediaStory> elements = List.from(state.mediaFiles ?? []);
    elements.add(updatedMedia);
  }

  void clearSelection() => emit(state.copyWith(selectedMedia: []));

  void updateContent(String content) {
    emit(state.copyWith(content: content));
  }

  void setStoryAudience(StoryAudience privacy) {
    emit(state.copyWith(privacy: privacy));
  }
  void setListOfFriendsExcept(List<int> friends) {
    emit(state.copyWith(friendExcept: friends));
  }
  void setListOfSpecificFriends(List<int> friends) {
    emit(state.copyWith(specificFriends: friends));
  }
  void updateTextProperties({
    Color? color,
    String? fontType,
    bool? bold,
    bool? italic,
    bool? underline,
    String? alignment,
  }) {
    final currentTextProperties =
        state.textProperties ?? TextPropertiesForStory.empty();
    emit(
      state.copyWith(
        textProperties: currentTextProperties.copyWith(
          color: color,
          fontType: fontType,
          bold: bold,
          italic: italic,
          underline: underline,
          alignment: alignment,
        ),
      ),
    );
  }

  addTextElement({required List<PositionedTextElement> newElement}) {
    emit(state.copyWith(textElements: newElement));
  }
  void updateTextElement(PositionedTextElement element){
    final updatedList = List<PositionedTextElement>.from(
      state.textElements??[],
    );

    final index = updatedList.indexWhere(
          (e) => e.id == element.id,
    );
    if (index != -1) {
      updatedList[index]=element;
      state.textElements![index]=element;
      emit(state.copyWith(textElements: updatedList));
    }
  }
  updateOneTextElement({required PositionedTextElement newElement}) {
    emit(state.copyWith(textElement: newElement));
  }
  void setBackGroundGradiant(GradientBackground gradiant) {
    emit(
      state.copyWith(
        backgroundColors: gradientToArray(gradiant),
        gradiant: gradiant,
      ),
    );
  }

  void toggleVideoMute() {
    emit(state.copyWith(isVideoMuted: !state.isVideoMuted));
  }

  void updateSpecificFriends(List<int> friends) {
    emit(state.copyWith(specificFriends: friends));
  }

  void updateFriendExcept(List<int> friends) {
    emit(state.copyWith(friendExcept: friends));
  }

  void addLocationElement({
    required int id,
    required String cityName,
    required String countryName,
    Offset? offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = PositionedElementWithLocationId(
      countryName: countryName,
      cityName: cityName,
      scale: scale,
      id: Uuid().v4(),
      offset: offset,
      positionedElementStoryTheme: theme,
      size: size,
      rotation: rotation,
      locationId: id,
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }

  void addMentionElement({required int friendId, required String friendName,required Offset offset}) {
    final newElement = PositionedMentionElement(
      id: Uuid().v4(),
      friendId: friendId,
      friendName: friendName,rotation: 0.0,
      scale: 1.0,offset: offset
    );
    List<PositionedElement> newList = List.from(state.positionedElements);
    newList.add(newElement);
    emit(state.copyWith(positionedElements: newList));
  }

  void addClockElement({
    Offset? offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = ClockElement(
      scale: scale,
      dateTime: DateTime.now(),
      id: Uuid().v4(),
      offset: offset,
      positionedElementStoryTheme: theme,
      size: size,
      rotation: rotation,
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }

  void addFeelingElement({
    required int feelingId,
    required String feelingName,
    Offset? offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
    required String feelingIcon,
  }) {
    final newElement = FeelingElement(
      feelingIcon: feelingIcon,
      scale: scale,
      id: Uuid().v4(),
      feelingId: feelingId,
      offset: offset,
      positionedElementStoryTheme: theme,
      size: size,
      rotation: rotation,
      feelingName: feelingName,
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }

  Future<void> addTemperatureElement(TemperatureElement newElement) async {
    final List<PositionedElement> updatedList= List.from(state.positionedElements);
    updatedList.add(newElement);
    emit(
      state.copyWith(
        positionedElements: updatedList,
      ),
    );
  }

  void addAudioElement({
    required int audioId,
    required String audioUrl,
    Offset? offset,
    required String audioName,
    required String audioImage,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = AudioElement(
      audioUrl: audioUrl,
      audioImage: audioImage,
      audioName: audioName,
      scale: scale,
      id: Uuid().v4(),
      audioId: audioId,
      offset: offset,
      positionedElementStoryTheme: theme,
      size: size,
      rotation: rotation,
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }
  updatePollElement(Poll poll){
    print('poll ${poll}');
    final pollCreated = state.positionedElements.where((e)=>e is PollElement).first;
   final newPoll= (pollCreated as PollElement).copyWith(poll: poll);
    List<PositionedElement> elements = List.from(state.positionedElements);
    int index = elements.indexWhere((e) => e.id == newPoll.id);
    if (index != -1) {
      elements[index] = newPoll;
      state.positionedElements[index]=newPoll;
      emit(state.copyWith(positionedElements: elements));
    }
  }

  void addPollElement({
     Offset ? offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = PollElement(
      poll: Poll.fromEmpty(),
      scale: scale,
      id: Uuid().v4(),
      offset: offset,
      positionedElementStoryTheme: theme,
      size: size,
      rotation: rotation,
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }


  void addStickerElement({
    required String gifUrl,
    Offset? offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = StickerElement(
      scale: scale,
      id: Uuid().v4(),
      gifUrl: gifUrl,
      offset: offset,
      positionedElementStoryTheme: theme,
      size: size,
      rotation: rotation,
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }

  void addDrawingElement(List<DrawingElement> elements) {
    emit(state.copyWith(drawingElements: elements));
  }

  void clearDrawing() {
    emit(state.copyWith(drawingElements: []));
  }

  void undoDrawing() {
    if (state.drawingElements.isNotEmpty) {
      List<DrawingElement> updatedDrawingElements = List.from(
        state.drawingElements,
      )..removeLast();
      emit(state.copyWith(drawingElements: updatedDrawingElements));
    }
  }

  void changeDrawingColor(Color color) {
    emit(state.copyWith(drawingColor: color));
  }

  void changeStrokeWidth(double width) {
    emit(state.copyWith(drawingWidth: width));
  }

  void changeCurrentDrawingLine(DrawingElement element) {
    emit(state.copyWith(currentLine: element));
  }

  void addDrawLine(DrawingElement element) {
    final newList = [...state.drawingElements, element];
    emit(state.copyWith(drawingElements: newList));
  }

  void updateSelectedPositioned(PositionedElement element) {
    List<PositionedElement> elements = List.from(state.positionedElements);
    int index = elements.indexWhere((e) => e.id == element.id);
    emit(state.copyWith(currentOne: element));
    if (index != -1) {
      elements[index] = element;
      emit(state.copyWith(positionedElements: elements));
    }
  }

  void togglePositionedTheme(PositionedElementStoryTheme theme) {
    List<PositionedElement> elements = List.from(state.positionedElements);
    final newElement = state.currentElement?.copyWith(
      positionedElementStoryTheme: theme,
    );
    emit(state.copyWith(currentOne: newElement));
    int index = elements.indexWhere((e) => e.id == newElement?.id);
    if (index != -1) {
      elements[index] = newElement!;
      emit(state.copyWith(positionedElements: elements));
    }
  }

  clearAll() {
    emit(StoryEditorState());
  }

  void removePositionedElement(String id) {
    final List<PositionedElement> current = state.positionedElements;
    current.removeWhere((element) => element.id == id);
    emit(state.copyWith(positionedElements: current));
  }
  void removeTextElement(String id) {
    final List<PositionedTextElement> current = state.textElements??[];
    current.removeWhere((element) => element.id == id);
    emit(state.copyWith(textElements: current));
  }
  // Method to convert current state to StoryEntity for backend submission
  StoryEntity toStoryEntity() {
    PositionedElementWithLocationId? locationElement;
    List<PositionedMentionElement> mentionsElements = [];
    ClockElement? clockElement;
    FeelingElement? feelingElement;
    TemperatureElement? temperatureElement;
    AudioElement? audioElement;
    PollElement? pollElement;
    StickerElement? stickerElement;
    print('sssssssssssss${state.positionedElements}');
    for (var element in state.positionedElements) {
      if (element is PositionedElementWithLocationId) {
        locationElement = element;
      } else if (element is PositionedMentionElement) {
        mentionsElements.add(element);
      } else if (element is ClockElement) {
        clockElement = element;
      } else if (element is FeelingElement) {
        feelingElement = element;
      } else if (element is TemperatureElement) {
        temperatureElement = element;
      } else if (element is AudioElement) {
        audioElement = element;
      } else if (element is PollElement) {
        pollElement = element;
      } else if (element is StickerElement) {
        stickerElement = element; // Assuming only one sticker/gif for now based
      }
    }

    return StoryEntity(
      isVideoMuted: state.isVideoMuted,
      backgroundColor: state.backgroundColors,
      privacy: state.privacy,
      specificFriends:
          state.specificFriends.isEmpty ? null : state.specificFriends,
      friendExcept: state.friendExcept.isEmpty ? null : state.friendExcept,
      locationElement: locationElement,
      mentionsElements: mentionsElements.isEmpty ? null : mentionsElements,
      clockElement: clockElement,
      feelingElement: feelingElement,
      temperatureElement: temperatureElement,
      audioElement: audioElement,
      pollElement: pollElement,
      stickerElement: stickerElement,
      positionedTextElements: state.textElements,
      mediaFiles: state.mediaFiles,
      lines: state.drawingElements,
    );
  }

  Future<List<MediaStory>> convertToOrderedMediaEntities(
    List<AssetEntity> selectedAssets,
    List<MediaStory> previousEntities,
  ) async {
    final List<MediaStory> result = [];

    for (int i = 0; i < selectedAssets.length; i++) {
      final asset = selectedAssets[i];
      final file = await asset.file;

      // Try to preserve previous editing info if exists
      final existing = previousEntities.firstWhere(
        (e) => e.file?.path == file?.path,
        orElse:
            () => MediaStory(
              id: Uuid().v4(),
              file: file!,
              order: i + 1,
              isVideoFile: asset.type == AssetType.video,
            ),
      );

      final updated = existing.copyWith(file: file, order: i + 1);

      result.add(updated);
    }

    return result;
  }

  void setFinalListOfMediaFiles(List<MediaStory> media) {
    emit(state.copyWith(mediaFiles: media));
  }

  void addCameraPhotoOrVideoToMediaFiles(MediaStory media) {
    emit(state.copyWith(mediaFiles: [...state.mediaFiles ?? [], media]));
  }

  List<String> gradientToArray(GradientBackground gradient) {
    String formatColor(Color color) {
      // Mask out the alpha (top 8 bits) and convert to 6-character hex
      String hex = (color.value & 0x00FFFFFF).toRadixString(16).padLeft(6, '0');
      return '#$hex';
    }

    return [formatColor(gradient.startColor), formatColor(gradient.endColor)];
  }

  _mapFailureCreateStoryToState(emit, Failure f, StoryEditorState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            createStoryStatus: CreateStoryStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            createStoryStatus: CreateStoryStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
