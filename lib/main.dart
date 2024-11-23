import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/routing.dart';
import 'package:habita/theme/theme_helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyBloc extends Cubit<int> {
  MyBloc() : super(0);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyBloc>(
          create: (context) => MyBloc(),
        ),
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
