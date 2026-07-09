import 'package:equatable/equatable.dart';

enum TrekkingDifficulty { easy, moderate, hard }

class TrekkingLocation extends Equatable {
  final String id;
  final String name;
  final String distance;
  final TrekkingDifficulty difficulty;
  final String icon;
  final double latitude;
  final double longitude;

  const TrekkingLocation({
    required this.id,
    required this.name,
    required this.distance,
    required this.difficulty,
    required this.icon,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, name, distance, difficulty, icon, latitude, longitude];
}
