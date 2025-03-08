import 'dart:convert';
import 'package:flutter_countries_states/core/error/exception.dart';
import 'package:flutter_countries_states/data/api_constants.dart';
import 'package:flutter_countries_states/data/model/location_model.dart';
import 'package:http/http.dart' as http;

abstract class LocationBackupDataSource {
  /// Gets a list of countries from the backup API
  ///
  /// Throws [ServerException] on API errors
  Future<List<LocationModel>> getCountries();

  /// Gets a list of states for a country from the backup API
  ///
  /// Throws [ServerException] on API errors
  Future<List<LocationModel>> getStates(String countryName);

  /// Map a country name to its ISO code
  ///
  /// Returns null if the country name is not found
  Future<String?> getCountryCodeByName(String countryName);
}

class LocationBackupDataSourceImpl implements LocationBackupDataSource {
  final http.Client client;

  // Cache of country names to country codes
  Map<String, String> _countryNameToCodeMap = {};

  LocationBackupDataSourceImpl({required this.client});

  @override
  Future<List<LocationModel>> getCountries() async {
    try {
      final response = await client.get(
        Uri.parse('${BackupApiConstants.baseUrl}${BackupApiConstants.allCountriesEndpoint}'),
        headers: BackupApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> countriesData = json.decode(response.body);

        // Clear and rebuild the country name to code mapping
        _countryNameToCodeMap.clear();

        // Map to our location model format
        int id = 1;
        final countries = countriesData.map((country) {
          final countryName = country['name'] as String;
          final countryCode = country['isoCode'] as String;

          // Add to mapping cache
          _countryNameToCodeMap[countryName.toLowerCase()] = countryCode;

          return LocationModel(
            id: id++,
            value: countryName,
          );
        }).toList();

        return countries;
      } else {
        throw ServerException(
          message: 'Failed to fetch countries from Rapid API: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(
        message: 'Rapid API error: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<LocationModel>> getStates(String countryName) async {
    try {
      // Get the country code for the given country name
      final countryCode = await getCountryCodeByName(countryName);

      if (countryCode == null) {
        throw ServerException(
          message: 'Could not find country code for "$countryName"',
        );
      }

      final Uri uri = Uri.parse(
          '${BackupApiConstants.baseUrl}${BackupApiConstants.statesByCountryCodeEndpoint}?countrycode=${countryCode.toLowerCase()}');

      final response = await client.get(
        uri,
        headers: BackupApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> statesData = json.decode(response.body);

        // Map to our location model format
        int id = 1;
        return statesData.map((state) {
          return LocationModel(
            id: id++,
            value: state['name'] as String,
          );
        }).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch states from Rapid API: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(
        message: 'Rapid API error: ${e.toString()}',
      );
    }
  }

  @override
  Future<String?> getCountryCodeByName(String countryName) async {
    // If we have a cache of country codes, use it
    if (_countryNameToCodeMap.isNotEmpty) {
      return _countryNameToCodeMap[countryName.toLowerCase()];
    }

    // Otherwise, fetch countries first and then try again
    await getCountries();
    return _countryNameToCodeMap[countryName.toLowerCase()];
  }
}
