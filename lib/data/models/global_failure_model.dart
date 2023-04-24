import 'package:equatable/equatable.dart';

class GlobalFailureModel extends Equatable{
  GlobalFailureModel({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
