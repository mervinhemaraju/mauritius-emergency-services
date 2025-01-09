import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';

abstract class MesDataSource {
  // Gets a list of all MES services
  Future<List<Service>> getAllServices(String lang);

  // Gets the cyclone report from MES
  Future<CycloneReport> getCycloneReport(String lang);

  // Gets the cyclone names from MES
  Future<List<CycloneNames>> getCycloneNames(String lang);

  // Gets the cyclone guidelines from MES
  Future<List<CycloneGuidelines>> getCycloneGuidelines(String lang);

  // Gets the cyclone report from MES for testing purposes ONLY
  Future<CycloneReport> getCycloneReportTesting(String lang);
}

class MesRemoteDataSource implements MesDataSource {
  static final endpoint = "https://mes.mervinhemaraju.com/api";
  static final version = "v1";

  final Dio dio;

  MesRemoteDataSource(this.dio);

  @override
  Future<List<Service>> getAllServices(String lang) async {
    // Make API call
    final response = await dio.get("$endpoint/$version/$lang/services");

    // Check for errors
    if (!response.data["success"]) {
      if (response.data["message"].toString().isNotEmpty) {
        throw Exception(
          response.data["message"].toString(),
        );
      } else {
        throw Exception(
          'An error occured while retrieving the services. Please try again later.',
        );
      }
    }

    // Retrieve the services as List
    final services = response.data['services'] as List;

    // Convert the List to a List of Service objects
    return services.map((json) => Service.fromJson(json)).toList();
  }

  @override
  Future<List<CycloneGuidelines>> getCycloneGuidelines(String lang) async {
    // Make API call
    final response =
        await dio.get("$endpoint/$version/$lang/cyclone/guidelines");

    // Check for errors
    if (!response.data["success"]) {
      if (response.data["message"].toString().isNotEmpty) {
        throw Exception(
          response.data["message"].toString(),
        );
      } else {
        throw Exception(
          'An error occured while retrieving the cyclone guidelines. Please try again later.',
        );
      }
    }

    // Retrieve the guidelines as List
    final guidelines = response.data['guidelines'] as List;

    // Convert the List to a List of Service objects
    return guidelines.map((json) => CycloneGuidelines.fromJson(json)).toList();
  }

  @override
  Future<List<CycloneNames>> getCycloneNames(String lang) async {
    // Make API call
    final response = await dio.get("$endpoint/$version/$lang/cyclone/names");

    // Check for errors
    if (!response.data["success"]) {
      if (response.data["message"].toString().isNotEmpty) {
        throw Exception(
          response.data["message"].toString(),
        );
      } else {
        throw Exception(
          'An error occured while retrieving the cyclone names. Please try again later.',
        );
      }
    }

    // Retrieve the names as List
    final names = response.data['names'] as List;

    // Convert the List to a List of Service objects
    return names.map((json) => CycloneNames.fromJson(json)).toList();
  }

  @override
  Future<CycloneReport> getCycloneReport(String lang) async {
    // Make API call
    final response = await dio.get("$endpoint/$version/$lang/cyclone/report");

    // Check for errors
    if (!response.data["success"]) {
      if (response.data["message"].toString().isNotEmpty) {
        throw Exception(
          response.data["message"].toString(),
        );
      } else {
        throw Exception(
          'An error occured while retrieving the cyclone report. Please try again later.',
        );
      }
    }

    // Retrieve the report
    final report = response.data['report'];

    // Return the report
    return CycloneReport.fromJson(report);
  }

  @override
  Future<CycloneReport> getCycloneReportTesting(String lang) async {
    // Make API call
    final response =
        await dio.get("$endpoint/$version/$lang/cyclone/report/testing");

    // Check for errors
    if (!response.data["success"]) {
      if (response.data["message"].toString().isNotEmpty) {
        throw Exception(
          response.data["message"].toString(),
        );
      } else {
        throw Exception(
          'An error occured while retrieving the cyclone report. Please try again later.',
        );
      }
    }

    // Retrieve the report
    final report = response.data['report'];

    // Return the report
    return CycloneReport.fromJson(report);
  }
}
