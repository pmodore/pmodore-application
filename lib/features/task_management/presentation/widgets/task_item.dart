import 'package:flutter/material.dart';
import 'package:pomodore/core/constant/constant.dart';
import 'package:pomodore/core/extensions/datetime_extensions.dart';
import 'package:pomodore/features/task_management/domain/entities/task_entity.dart';

import '../../../../core/utils/size_config.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Text(task.deadLineTime.taskTimeFormat()),
          SizedBox(width: SizeConfig.widthMultiplier * 2),
          Expanded(
            child: Container(
              height: SizeConfig.heightMultiplier * 11,
              decoration: BoxDecoration(
                color: AppConstant.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  Text(
                    task.deadLineTime.taskDateFormat(),
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
