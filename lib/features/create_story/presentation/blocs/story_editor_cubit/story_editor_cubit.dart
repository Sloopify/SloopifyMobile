import 'dart:convert';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/utils/location_service.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/media_story.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

import '../../../../../core/utils/helper/postioned_element_story_theme.dart';
import '../../../../create_posts/domain/entities/media_entity.dart';
import '../../../domain/entities/all_positioned_element.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/story_entity.dart';
import '../../../domain/entities/text_properties_story.dart';


class StoryEditorCubit extends Cubit<StoryEditorState> {
  StoryEditorCubit() : super(const StoryEditorState());
  final Uuid _uuid = const Uuid();



  void toggleSelection(AssetEntity asset) {
    final updated = List<AssetEntity>.from(state.selectedMedia);
    if (updated.contains(asset)) {
      updated.remove(asset);
    } else {
      updated.add(asset);
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
    emit(state.copyWith(mediaFiles: [...state.mediaFiles??[],mediaStory]));
    emit(state.copyWith(selectedMedia: [...state.selectedMedia, asset]));
  }

  void updateSingleMedia(MediaStory updatedMedia) {
    final List<MediaStory> current = List.from(state.mediaFiles ?? []);
    final index = current.indexWhere((e) => e.id == updatedMedia.id);
    if (index != -1) {
      current[index] = updatedMedia;
      emit(state.copyWith(mediaFiles: current));
    }
  }

  void onUpdateAttributeOneMedia(double scale, Offset offset, double rotation,){
    final currentOne= state.mediaFiles!.first;
    final updatedMedia = currentOne.copyWith(
      scale: scale,
      rotateAngle: rotation,
      offset: offset,
    );
    emit(state.copyWith(selectedEditedMedia: updatedMedia));
    List<MediaStory>elements= List.from(state.mediaFiles??[]);
    elements.add(updatedMedia);
  }



  void clearSelection() => emit(state.copyWith(selectedMedia: []));

  void updateContent(String content) {
    emit(state.copyWith(content: content));
  }

  void setStoryAudience(StoryAudience privacy) {
    emit(state.copyWith(privacy: privacy));
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

  addTextElement({
    required String text,
    Color? color,
    String? fontType,
    bool? bold,
    bool? italic,
    bool? underline,
    String? alignment,
    required int id,
    Offset? offset,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final currentTextProperties =
        state.textProperties ?? TextPropertiesForStory.empty();
    final newElement = PositionedTextElement(
      scale: scale,
      text: text,
      id: Uuid().v4(),
      offset: offset,
      size: size,
      rotation: rotation,
      positionedElementStoryTheme: null,
      textPropertiesForStory: currentTextProperties.copyWith(
        color: color,
        alignment: alignment,
        bold: bold,
        fontType: fontType,
        italic: italic,
        underline: underline,
      ),
    );
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }

  void updateBackgroundColors(List<String> colors) {
    emit(state.copyWith(backgroundColors: colors));
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
      id: _uuid.v4(),
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

  void addMentionElement({required int friendId, required String friendName}) {
    final newElement = PositionedMentionElement(
      id: Uuid().v4(),
      friendId: friendId,
      friendName: friendName,
    );
    List<PositionedElement> newList = List.from(state.positionedElements);
    newList.add(newElement);
    emit(state.copyWith(positionedElements: newList));
  }

  void addClockElement({
    required Offset offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = ClockElement(
      scale: scale,
      dateTime: DateTime.now(),
      clockTheme: "",
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
    emit(
      state.copyWith(
        positionedElements: List.from(state.positionedElements)
          ..add(newElement),
      ),
    );
  }

  void addAudioElement({
    required int audioId,
    Offset? offset,
    required String audioName,
    required String audioImage,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = AudioElement(
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

  void addPollElement({
    required String question,
    required List<String> options,
    required Offset offset,
    PositionedElementStoryTheme? theme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    final newElement = PollElement(
      scale: scale,
      id: Uuid().v4(),
      question: question,
      options: options,
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

  void addDrawingElement(List<Offset> points, Color color, double strokeWidth) {
    final newElement = DrawingElement(
      points: points,
      color: color,
      strokeWidth: strokeWidth,
    );
    emit(
      state.copyWith(
        drawingElements: List.from(state.drawingElements)..add(newElement),
      ),
    );
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

  void updateSelectedPositioned(String id) {
    List<PositionedElement> elements = List.from(state.positionedElements);
    final PositionedElement currentOne =
        elements.where((e) => e.id == id).first;
    emit(state.copyWith(currentOne: currentOne));
  }

  void togglePositionedTheme(PositionedElementStoryTheme theme) {
    final newElement = state.currentElement?.copyWith(
      positionedElementStoryTheme: theme,
    );
    emit(state.copyWith(currentOne: newElement));
  }

  clearAll(){
    emit(StoryEditorState());

  }

  // void updatePositionedElement(
  //   String id,
  //   Offset? newOffset,
  //   Size? newSize,
  //   double? newRotation,
  //   double? scale,
  // ) {
  //   final updatedElements =
  //       state.positionedElements.map((element) {
  //         if (element.id == id) {
  //           if (element is PositionedElementWithLocationId) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is PositionedMentionElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is ClockElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is FeelingElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is TemperatureElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is AudioElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is PollElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           } else if (element is StickerElement) {
  //             return element.copyWith(
  //               offset: newOffset,
  //               size: newSize,
  //               rotation: newRotation,
  //             );
  //           }
  //         }
  //         return element;
  //       }).toList();
  //   emit(state.copyWith(positionedElements: updatedElements));
  // }

  void removePositionedElement(String id) {
    final updatedElements =
        state.positionedElements.where((element) => element.id != id).toList();
    emit(state.copyWith(positionedElements: updatedElements));
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
    String? gifUrl;
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
        gifUrl = element.gifUrl; // Assuming only one sticker/gif for now based
      }
    }
    return StoryEntity(
      content: state.content,
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
}
