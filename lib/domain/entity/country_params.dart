import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_params.freezed.dart';

@freezed
class CountryParams with _$CountryParams {
  const factory CountryParams({
    required int countryId,
  }) = _CountryParams;
}

class NoParams {}
