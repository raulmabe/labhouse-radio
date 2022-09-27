part of 'radio_player_cubit.dart';

class RadioPlayerState extends Equatable {
  const RadioPlayerState({
    this.isPlaying = false,
    this.isLoading = false,
    this.selectedStation,
  });

  const RadioPlayerState.empty()
      : isPlaying = false,
        isLoading = false,
        selectedStation = null;

  final bool isPlaying;
  final bool isLoading;
  final Station? selectedStation;

  @override
  List<Object> get props =>
      [isPlaying, isLoading, if (selectedStation != null) selectedStation!];

  RadioPlayerState copyWith({
    bool? isPlaying,
    bool? isLoading,
    Station? selectedStation,
  }) {
    return RadioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      selectedStation: selectedStation ?? this.selectedStation,
    );
  }
}
