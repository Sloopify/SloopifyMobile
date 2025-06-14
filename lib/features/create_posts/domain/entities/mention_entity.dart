import 'package:equatable/equatable.dart';

class MentionEntity extends Equatable {
  final List<int>? friends;
  final int? placeId;
  final String? activity;
  final String? feeling;

  const MentionEntity({
    this.friends,
    this.activity,
    this.feeling,
    this.placeId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [friends, placeId, activity, feeling];

  MentionEntity copyWith({
    List<int>? friends,
    int? placeId,
    String? activity,
    String? feeling,
  }) {
    return MentionEntity(
      friends: friends ?? this.friends,
      activity: activity ?? this.activity,
      feeling: feeling ?? this.feeling,
      placeId: placeId ?? this.placeId,
    );
  }

  Map<String, dynamic> toJson() => {
    if (friends != null) "friends": friends,
    if (placeId != null) "placeId": placeId,
    if (activity != null) "activity": activity,
    if (feeling != null) "feeling": feeling,
  };
}
