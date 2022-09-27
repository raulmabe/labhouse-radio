import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_test/radio/cubit/radio_list_cubit.dart';
import 'package:labhouse_test/radio/widgets/dynamic_island.dart';
import 'package:labhouse_test/radio/widgets/radio_list.dart';
import 'package:labhouse_test/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DynamicIslandPlayer(),
            Expanded(
              child: BlocBuilder<RadioListCubit, RadioListState>(
                builder: (context, state) {
                  if (state is RadioListSuccess) {
                    return RadioList(
                      stations: state.stations,
                    );
                  }
                  if (state is RadioListFailure) {
                    return const Center(child: Text('Failure'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
