import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_test/radio/cubit/radio_player_cubit.dart';
import 'package:labhouse_test/radio/models/station.dart';
import 'package:labhouse_test/radio/widgets/animated_disc.dart';
import 'package:labhouse_test/radio/widgets/station_details.dart';
import 'package:labhouse_test/theme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.station});
  static const String routeName = 'details';

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const BackButton(
                  color: Colors.white,
                ),
                const Spacer(),
                if (station.homepage.isNotEmpty)
                  IconButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse(station.homepage));
                    },
                    icon: const Icon(
                      PhosphorIcons.globe,
                      color: Colors.white,
                    ),
                  )
              ],
            ),
            const Expanded(
              child: AnimatedDisc(
                size: 140,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: StationDetails(station: station),
              ),
            ),
            Expanded(
              child: Center(
                child: Builder(
                  builder: (context) {
                    final isThisStationSelected =
                        context.select<RadioPlayerCubit, bool>(
                      (cubit) =>
                          cubit.state.selectedStation?.stationUuid ==
                          station.stationUuid,
                    );
                    final isLoading = context.select<RadioPlayerCubit, bool>(
                      (cubit) => cubit.state.isLoading && isThisStationSelected,
                    );
                    final isPlaying = context.select<RadioPlayerCubit, bool>(
                      (cubit) => cubit.state.isPlaying && isThisStationSelected,
                    );

                    return AnimatedOpacity(
                      opacity: isLoading ? .2 : 1,
                      duration: 400.ms,
                      child: FloatingActionButton(
                        backgroundColor: AppTheme.primary,
                        disabledElevation: 0,
                        onPressed: isLoading
                            ? null
                            : () {
                                if (isPlaying) {
                                  context.read<RadioPlayerCubit>().stop();
                                } else {
                                  context
                                      .read<RadioPlayerCubit>()
                                      .playStation(station);
                                }
                              },
                        child: Icon(
                          isPlaying
                              ? PhosphorIcons.pauseFill
                              : PhosphorIcons.playFill,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
