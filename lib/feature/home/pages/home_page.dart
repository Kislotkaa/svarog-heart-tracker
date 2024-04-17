import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: [
          IconButton(
            onPressed: () => sl<ThemeCubit>().switchTheme(),
            icon: const Icon(Icons.light),
          ),
          IconButton(
            onPressed: () => sl<ThemeCubit>().switchTheme(),
            icon: const Icon(Icons.light),
          ),
        ],
      ),
      body: const Center(
        child: Text('Главная страница'),
      ),
    );
  }
}
