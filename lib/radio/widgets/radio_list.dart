import 'package:flutter/material.dart';
import 'package:labhouse_test/common/common.dart';
import 'package:labhouse_test/radio/models/station.dart';
import 'package:labhouse_test/radio/widgets/rotate_wheel_list_view.dart';
import 'package:labhouse_test/radio/widgets/station_card.dart';

class RadioList extends StatefulWidget {
  const RadioList({
    super.key,
    required this.stations,
  });

  final List<Station> stations;

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  late final ScrollController scrollController;
  double offset = 300;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController(initialScrollOffset: offset);

    scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (offset != scrollController.position.pixels) {
      setState(() => offset = scrollController.position.pixels);
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemExtent = context.screen.width * .1;
    final totalCount = widget.stations.length;
    final dimension = totalCount * itemExtent;
    final percent = (offset / dimension).clamp(0, 1.0);
    final selectedIndex =
        (percent * totalCount).round().clamp(0, totalCount - 1);
    final station = widget.stations[selectedIndex];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Container(
            height: 300,
            // color: Colors.green,
            alignment: Alignment.center,
            child: StationCard(
              key: ValueKey(station.stationUuid),
              station: station,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          // color: Colors.blue,
          child: HorizontalListWheelScrollView(
            controller: scrollController,
            childCount: totalCount,
            itemExtent: itemExtent,
            builder: (ctx, index) {
              final isSelected = selectedIndex == index;
              return Center(
                child: AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 450),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 450),
                    height: isSelected ? 50 : 20,
                    width: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // const Spacer(),
      ],
    );
  }
}
