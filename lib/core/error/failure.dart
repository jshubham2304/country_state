import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server({required String message}) = ServerFailure;

  const factory Failure.network({@Default('No internet connection') String message}) = NetworkFailure;

  const factory Failure.unexpected({@Default('An unexpected error occurred') String message}) = UnexpectedFailure;
}
