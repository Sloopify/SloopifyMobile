import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
enum CalculateTempStatus{init,loading,success,error,offline}
class CalculateTempState extends Equatable {
  final double tempC;
  final dynamic weatherCode;
  final bool isDay;
  final String weatherIcon;
  final CalculateTempStatus calculateTempStatus;
  final TemperatureElement? temperatureElement;

  const CalculateTempState({
    this.tempC = 0.0,
    this.weatherCode = '',
    this.isDay = true,
    this.weatherIcon = '',
    this.calculateTempStatus=CalculateTempStatus.init,
    this.temperatureElement
  });

  @override
  // TODO: implement props
  List<Object?> get props => [tempC, weatherIcon, weatherCode, isDay,calculateTempStatus,temperatureElement];

  CalculateTempState copyWith({
    double? tempC,
    String? weatherCode,
    bool? isDay,
    String? weatherIcon,
    CalculateTempStatus? status,
    TemperatureElement? element
  }) {
    return CalculateTempState(
      isDay: isDay ?? this.isDay,
      tempC: tempC ?? this.tempC,
      weatherCode: weatherCode ?? this.weatherCode,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      calculateTempStatus: status??calculateTempStatus,
      temperatureElement: element??temperatureElement
    );
  }
}
