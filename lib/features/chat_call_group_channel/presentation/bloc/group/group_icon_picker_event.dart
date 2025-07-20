abstract class GroupIconEvent {}

class PickFromGallery extends GroupIconEvent {}

class CaptureFromCamera extends GroupIconEvent {}

class CropImage extends GroupIconEvent {
  final String imagePath;
  CropImage(this.imagePath);
}
