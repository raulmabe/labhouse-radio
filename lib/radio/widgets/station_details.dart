import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:labhouse_test/common/common.dart';
import 'package:labhouse_test/radio/models/station.dart';
import 'package:labhouse_test/theme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StationDetails extends StatelessWidget {
  const StationDetails({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.compact();
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white,
            ),
            children: [
              if (station.favicon.isNotEmpty)
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.network(
                      station.favicon,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              TextSpan(
                text: station.name,
              )
            ],
          ),
        ),
        if (station.country.isNotEmpty)
          Text(
            '${station.country}, ${station.countryCode}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(.5),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconText(
              icon: Icon(
                PhosphorIcons.heartFill,
                color: AppTheme.primary,
              ),
              text: Text(
                formatter.format(station.votes),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            IconText(
              icon: Icon(
                station.clicktrend.isNegative
                    ? PhosphorIcons.arrowFatDownFill
                    : PhosphorIcons.arrowFatUpFill,
                color: AppTheme.primary,
              ),
              text: Text(
                formatter.format(station.clicktrend),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ]
          .animate(
            interval: 200.ms,
          )
          .fadeIn()
          .separateBy(const Gap(20))
          .toList(),
    );
  }
}
