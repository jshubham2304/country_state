import 'package:flutter_countries_states/domain/entity/location_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required int id,
    required String value,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  /// Maps the model to an entity
  const LocationModel._();

  LocationEntity toEntity() => LocationEntity(
        id: id,
        value: value,
      );
}

extension LocationModelListX on List<LocationModel> {
  List<LocationEntity> toEntityList() => map((model) => model.toEntity()).toList();
}
