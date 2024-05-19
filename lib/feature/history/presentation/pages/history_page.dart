import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/loading/base_linear_progress_indicator.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/bloc/history_bloc.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/widgets/base_list_history_widget.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    sl<HistoryBloc>().add(const HistoryInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBarWidget(title: 'История подключений', needClose: true),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        buildWhen: (prev, next) => prev.users.hashCode != next.users.hashCode || prev.status != next.status,
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    BaseListHistory(
                      users: state.users,
                      onRefresh: () {
                        sl<HistoryBloc>().add(const GetHistoryEvent());
                        return Future(() => true);
                      },
                    ),
                  ],
                ),
              ),
              if (state.status == StateStatus.loading)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BaseLinearProgressIndicator(),
                )
            ],
          );
        },
      ),
    );
  }
}
