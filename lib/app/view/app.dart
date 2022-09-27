// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:labhouse_test/l10n/l10n.dart';
import 'package:labhouse_test/radio/cubit/radio_list_cubit.dart';
import 'package:labhouse_test/radio/cubit/radio_player_cubit.dart';
import 'package:labhouse_test/radio/data/audio_player_repository.dart';
import 'package:labhouse_test/radio/data/radio_browser_repository.dart';
import 'package:labhouse_test/radio/models/station.dart';
import 'package:labhouse_test/radio/radio.dart';
import 'package:labhouse_test/radio/view/details.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RadioPlayerCubit(
            repository: AudioPlayerRepository(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              RadioListCubit(repository: RadioBrowserRepository())..fetch(),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: DetailsPage.routeName,
        path: '/details/:id',
        builder: (context, state) {
          final id = state.params['id'];
          final radioListState = context.read<RadioListCubit>().state;
          if (radioListState is! RadioListSuccess) throw ArgumentError();

          final station = radioListState.stations.cast<Station?>().firstWhere(
                (element) => element?.stationUuid == id,
                orElse: () => null,
              );
          if (station == null) throw ArgumentError();
          return DetailsPage(
            station: station,
          );
        },
      ),
    ],
  );
}
