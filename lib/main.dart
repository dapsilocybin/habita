import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/routing.dart';
import 'package:habita/theme/theme_helpers.dart';

void main() {
  runApp(const MyApp());
}

class myBloc extends Cubit<int> {
  myBloc() : super(0);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<HabitBloc>(
        //     create: (context) => HabitBloc(context.read<HabitRepository>())
        //     // ..add(LoadHabits()),
        //     ),
        BlocProvider<myBloc>(
          create: (context) => myBloc(),
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: router,
        theme: buildThemeData(Color(0xFF2EC4B6), Brightness.light),
        darkTheme: buildThemeData(Color(0xFF2EC4B6), Brightness.dark),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
