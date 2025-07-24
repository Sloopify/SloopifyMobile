abstract class CreateChannelEvent {}

class PickImage extends CreateChannelEvent {
  final bool fromCamera;
  PickImage({required this.fromCamera});
}

class SubmitChannel extends CreateChannelEvent {
  final String name;
  final String description;
  SubmitChannel(this.name, this.description);
}
