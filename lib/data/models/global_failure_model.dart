import 'package:equatable/equatable.dart';

class GlobalFailureModel extends Equatable {
  const GlobalFailureModel({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
