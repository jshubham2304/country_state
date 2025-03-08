import 'dart:convert';
import 'package:flutter_countries_states/core/error/exception.dart';
import 'package:flutter_countries_states/data/api_constants.dart';
import 'package:flutter_countries_states/data/model/location_model.dart';
import 'package:http/http.dart' as http;

abstract class LocationRemoteDataSource {
  /// Gets a list of countries from the API
  ///
  /// Throws [ServerException] on API errors
  Future<List<LocationModel>> getCountries();

  /// Gets a list of states for a country from the API
  ///
  /// Throws [ServerException] on API errors
  Future<List<LocationModel>> getStates(int countryId);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final http.Client client;

  LocationRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LocationModel>> getCountries() async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.countriesEndpoint}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => LocationModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch countries: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<LocationModel>> getStates(int countryId) async {
    try {
      final String endpoint = ApiConstants.statesEndpoint.replaceAll('{countryId}', countryId.toString());

      final response = await client.get(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => LocationModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch states: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}
