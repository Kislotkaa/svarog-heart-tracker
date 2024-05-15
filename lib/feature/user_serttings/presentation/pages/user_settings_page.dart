import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/feature/user_serttings/presentation/bloc/user_settings_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  void initState() {
    sl<UserSettingsBloc>().add(const UserSettingsInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBarWidget(title: 'User Settings'),
      body: Center(
        child: Text('Настройки пользователя!'),
      ),
    );
  }
}
