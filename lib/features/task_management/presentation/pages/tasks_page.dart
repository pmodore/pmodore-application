import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pomodore/core/constant/constant.dart';
import 'package:pomodore/core/shared_widgets/base_app_bar.dart';
import 'package:pomodore/core/shared_widgets/global_indicator.dart';
import 'package:pomodore/core/utils/size_config.dart';
import 'package:pomodore/features/task_management/presentation/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:pomodore/features/task_management/presentation/pages/add_task_page.dart';

import '../../../../di.dart';
import '../../../../exports.dart';
import '../widgets/task_item.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) => getIt.get<TasksBloc>()
        ..add(SpecificDateTasksReceived(DateTime.now())),
      child: const TaskView(),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar(
            title: localization.tasksTitle,
            action: (state is SpecificDateTasksReceivedSuccess &&
                    state.list.isNotEmpty)
                ? const Icon(CupertinoIcons.add_circled_solid)
                : null,
            onPressed: (state is SpecificDateTasksReceivedSuccess &&
                    state.list.isNotEmpty)
                ? () => Navigator.pushNamed(context, AddTaskPage.routeName)
                : null,
          ),
          body: Column(
            children: [
              if (state is SpecificDateTasksReceivedSuccess &&
                  state.list.isEmpty)
                const DayWithoutTask(),
              if (state is SpecificDateTasksReceivedSuccess)
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: state.list.length,
                    itemBuilder: (context, index) =>
                        TaskItem(task: state.list[index]),
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == 2) {
                        return Column(
                          children: const [
                            Divider(
                              color: AppConstant.secondaryColor,
                              thickness: 8,
                              endIndent: 20,
                              indent: 20,
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              if (state is SpecificDateTasksReceivedFailure)
                // todo: create a error widget
                const Center(child: Text("error")),
              if (state is SpecificDateTasksReceivedLoading)
                const GlobalIndicator(),
              Container(),
            ],
          ),
        );
      },
    );
  }
}

class DayWithoutTask extends StatelessWidget {
  const DayWithoutTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(
          height: SizeConfig.heightMultiplier * 10,
        ),
        const Icon(
          Ionicons.document_text,
          size: 150,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 5,
        ),
        Text(
          localization.emptyTaskListTitle,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.cyanAccent),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 2,
        ),
        Text(localization.emptyTaskListHint),
        SizedBox(
          height: SizeConfig.heightMultiplier * 2,
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AddTaskPage.routeName),
          icon: const Icon(CupertinoIcons.add_circled_solid),
        ),
      ],
    );
  }
}
