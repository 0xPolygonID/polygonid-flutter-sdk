import 'package:equatable/equatable.dart';

class InteractionDTO extends Equatable {
  final int id;
  final Map<String, dynamic> data;

  InteractionDTO({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}
