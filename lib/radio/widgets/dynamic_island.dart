import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:labhouse_test/common/common.dart';
import 'package:labhouse_test/radio/cubit/radio_player_cubit.dart';
import 'package:labhouse_test/radio/view/details.dart';
import 'package:labhouse_test/radio/widgets/animated_disc.dart';
import 'package:labhouse_test/theme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DynamicIslandPlayer extends StatelessWidget {
  const DynamicIslandPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final playerState = context.watch<RadioPlayerCubit>().state;

    return ScaleOnTap(
      onTap: playerState.selectedStation != null
          ? () {
              context.pushNamed(
                DetailsPage.routeName,
                params: {
                  'id': playerState.selectedStation!.stationUuid,
                },
              );
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const AnimatedDisc(),
            const Gap(12),
            Expanded(
              child: Text(
                playerState.selectedStation != null
                    ? playerState.selectedStation!.name
                    : 'Not playing',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            if (playerState.selectedStation != null)
              IconButton(
                onPressed: () => context.read<RadioPlayerCubit>().toggle(),
                icon: Icon(
                  playerState.isPlaying
                      ? PhosphorIcons.pauseFill
                      : PhosphorIcons.playFill,
                  color: Colors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}
