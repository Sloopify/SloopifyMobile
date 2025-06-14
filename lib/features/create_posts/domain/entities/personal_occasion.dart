import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/personal_occasion_extention.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/occasion_details.dart';

class PersonalOccasion extends Equatable {
  final PersonalOccasionType personalOccasionType;
  final String title;
  final String description;
  final DateTime date;
  final OccasionDetails? details;

  const PersonalOccasion({
    required this.personalOccasionType,
    required this.description,
    required this.title,
    required this.date,
    this.details,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [personalOccasionType, title, description, date,details];

  Map<String, dynamic> toJson() {
    return {
      "type": personalOccasionType.getValuesForApi(),
      "title": title,
      "description": description,
      "date": "${date.year}-${date.month}-${date.day}",
      "details": details,
    };
  }
}
