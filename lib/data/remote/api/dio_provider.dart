import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/data/remote/api/dio_provider.g.dart';

/// A single [Dio] instance shared across all remote data sources.
/// Dispose is handled automatically by Riverpod when the provider is released.
@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  ref.onDispose(dio.close);
  return dio;
}
