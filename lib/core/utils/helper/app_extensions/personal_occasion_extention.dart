enum PersonalOccasionType {
  newJob,
  jobPromotion,
  graduation,
  startedStudies,
  relationshipStatus,
  movedCity,
  birthday,
  anniversary,
  achievement,
  travel,
  other,
}

extension PersonalOccasionExtention on PersonalOccasionType{
  String getValuesForApi(){
    switch(this){
      case PersonalOccasionType.birthday:
        return "birthday";
      case PersonalOccasionType.newJob:
        return "new_job";
      case PersonalOccasionType.jobPromotion:
        return "job_promotion";
      case PersonalOccasionType.graduation:
        return "graduation";
      case PersonalOccasionType.startedStudies:
        return "started_studies";
      case PersonalOccasionType.anniversary:
        return "anniversary";
      case PersonalOccasionType.movedCity:
        return "moved_city";
      case PersonalOccasionType.other:
        return "other";
      case PersonalOccasionType.relationshipStatus:
        return "relationship_status";
      case PersonalOccasionType.achievement:
        return "achievement";
      case PersonalOccasionType.travel:
        return "travel";
    }
  }
}
