import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labhouse_test/radio/data/audio_player_repository.dart';
import 'package:labhouse_test/radio/models/station.dart';

part 'radio_player_state.dart';

class RadioPlayerCubit extends Cubit<RadioPlayerState> {
  RadioPlayerCubit({required this.repository})
      : super(const RadioPlayerState.empty()) {
    repository.onStateChanged.listen(onPlayerStateChanged);
  }

  final AudioPlayerRepository repository;

  void onPlayerStateChanged(PlayerState playerState) {
    emit(
      state.copyWith(
        isPlaying: playerState == PlayerState.playing,
      ),
    );
  }

  Future<void> playStation(Station station) async {
    emit(
      state.copyWith(
        isLoading: true,
        selectedStation: station,
      ),
    );

    await repository.play(station.url);

    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }

  void toggle() {
    if (!state.isPlaying && state.selectedStation != null) {
      playStation(state.selectedStation!);
    } else if (state.isPlaying) {
      stop();
    }
  }

  Future<void> stop() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    await repository.stop();
    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }
}
