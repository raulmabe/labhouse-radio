import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:labhouse_test/common/common.dart';
import 'package:labhouse_test/radio/models/station.dart';
import 'package:labhouse_test/radio/view/details.dart';
import 'package:labhouse_test/theme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StationCard extends StatelessWidget {
  const StationCard({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: () => context.pushNamed(
        DetailsPage.routeName,
        params: {'id': station.stationUuid},
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: FittedBox(
              child: station.favicon.isNotEmpty
                  ? Image.network(
                      station.favicon,
                      errorBuilder: (ctx, err, stacktrace) =>
                          const Icon(Icons.error),
                    )
                  : Icon(
                      PhosphorIcons.radioFill,
                      color: AppTheme.primaryLight,
                    ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            station.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Tap to see details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.5),
            ),
          ),
        ]
            .animate(
              interval: 200.ms,
            )
            .slide(
              curve: Curves.easeOutCubic,
              duration: 1.seconds,
              end: Offset.zero,
              begin: const Offset(0, .2),
            )
            .fadeIn(
              duration: 2.seconds,
              curve: Curves.easeOutCubic,
            ),
      ),
    );
  }
}
