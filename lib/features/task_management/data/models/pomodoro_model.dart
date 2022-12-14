import 'package:pomodore/features/task_management/domain/entities/pomodoro_entity.dart';

import '../../../../core/utils/utils.dart';

class PomodoroModel extends PomodoroEntity {
  const PomodoroModel(int id, int duration, String? taskUid, String datetime)
      : super(id: id, duration: duration, taskUid: taskUid, dateTime: datetime);

  static fromQueryToPomodoroModel(Map<String, dynamic> item) => PomodoroModel(
      item["_id"], item["duration"], item["taskUid"], item["datetime"]);

  static toDbQuery(PomodoroEntity item) => {
        "taskUid": item.taskUid,
        "duration": item.duration,
        "dateTime": item.dateTime,
      };

  static List<PomodoroEntity> parseRawList(List<Map<String, dynamic>> items) {
    late List<PomodoroEntity> list;
    list =
        items.map<PomodoroEntity>((e) => fromQueryToPomodoroModel(e)).toList();
    return list;
  }

  static List<PomodoroEntity> filterTodayPomodoroList(
      List<PomodoroEntity> items, DateTime date) {
    List<PomodoroEntity> list = [];
    for (var element in items) {
      if (Utils.checkDateIsToday(DateTime.parse(element.dateTime))) {
        list.add(element);
      }
    }
    return list;
  }
}
