import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labhouse_test/radio/data/radio_browser_repository.dart';
import 'package:labhouse_test/radio/models/station.dart';
import 'package:meta/meta.dart';

part 'radio_list_state.dart';

class RadioListCubit extends Cubit<RadioListState> {
  RadioListCubit({
    required this.repository,
  }) : super(RadioListInitial());

  final RadioBrowserRepository repository;

  Future<void> fetch() async {
    try {
      emit(RadioListLoading());
      final list = await repository.fetchAll();
      emit(
        RadioListSuccess(
          stations: list,
        ),
      );
    } catch (e) {
      emit(RadioListFailure());
    }
  }
}
