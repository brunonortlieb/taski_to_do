import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  const Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}

class HiveFailure extends Failure {
  const HiveFailure({
    super.message = 'Error accessing hive database',
    String super.statusCode = '500',
  });
}
