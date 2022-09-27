part of 'radio_list_cubit.dart';

@immutable
abstract class RadioListState extends Equatable {
  @override
  List<Object> get props => [];
}

class RadioListInitial extends RadioListState {}

class RadioListLoading extends RadioListState {}

class RadioListSuccess extends RadioListState {
  RadioListSuccess({
    required this.stations,
  });
  final List<Station> stations;
  @override
  List<Object> get props => [stations];
}

class RadioListFailure extends RadioListState {}
