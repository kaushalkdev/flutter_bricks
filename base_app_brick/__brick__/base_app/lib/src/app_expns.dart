import 'package:equatable/equatable.dart';

abstract class AppExpns extends Equatable {
  final String message;
  final int? code;

  const AppExpns({required this.message, this.code});
}

class NotificationExpn extends AppExpns {
  const NotificationExpn({required super.message});

  @override
  List<Object?> get props => [message];
}
