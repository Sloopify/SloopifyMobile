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

  toJson(bool withMedia) {
    final Map<String, dynamic> data = {};
    if (placeId != null) {
      data["place"] = placeId;
    }
    if (activity != null && activity!.isNotEmpty) {
      data["activity"] = activity;
    }
    if (feeling != null && feeling!.isNotEmpty) {
      data["feeling"] = feeling;
    }
    if (friends != null && friends!.isNotEmpty) {
      if (!withMedia) {
        data['friends'] = friends!;
      } else {
        List<int> friendsList = friends!;
        for (int i = 0; i < friendsList.length; i++) {
          data["friends[$i]"] = friendsList[i];
        }
      }
    }
    return data;
  }
}
