import 'package:author/models/Work.dart';

abstract class WorkState {}

class WorkInitial extends WorkState {}

class WorkLoading extends WorkState {}

class WorkLoaded extends WorkState {
  final List<Work> works;

  WorkLoaded(this.works);

  WorkLoaded copyWith({List<Work>? works}) {
    return WorkLoaded(works ?? this.works);
  }
}
