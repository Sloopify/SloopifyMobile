abstract class OccasionDetails{
  Map<String,dynamic> toJson();
}


class NewJobDetails extends OccasionDetails{
  final String position;
  final String company;

  NewJobDetails({required this.company,required this.position});

  @override
  Map<String, dynamic> toJson() =>{
   "position":position,
    "company":company
};


}
class JobPromotion extends OccasionDetails{
  final String newPosition;
  final String department;

  JobPromotion({required this.newPosition,required this.department});

  @override
  Map<String, dynamic> toJson() =>{
    "new_position":newPosition,
    "department":department
  };


}
class Graduation extends OccasionDetails{
  final String university;
  final String degree;

  Graduation({required this.university,required this.degree});

  @override
  Map<String, dynamic> toJson() =>{
    "university":university,
    "degree":degree
  };


}
class StartedStudies extends OccasionDetails{
  final String university;
  final String program;

  StartedStudies({required this.university,required this.program});

  @override
  Map<String, dynamic> toJson() =>{
    "university":university,
    "program":program
  };


}
class MovedCity extends OccasionDetails{
  final String city;
  final String reason;

  MovedCity({required this.city,required this.reason});

  @override
  Map<String, dynamic> toJson() =>{
    "city":city,
    "reason":reason
  };


}