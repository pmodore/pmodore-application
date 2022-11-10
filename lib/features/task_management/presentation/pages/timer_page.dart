import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pomodore/core/constant/constant.dart';
import 'package:pomodore/core/shared_widgets/base_app_bar.dart';
import 'package:pomodore/core/shared_widgets/my_button.dart';
import 'package:pomodore/core/utils/datetime_converter.dart';
import 'package:pomodore/features/task_management/presentation/pages/analyze_page.dart';

import '../../../../exports.dart';
import '../widgets/timer_task.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? _timer;
  int _sec = 60 * 30;
  final int _max = 60 * 30;

  stopAndDelete() {
    _sec = 0;
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  reset() {
    _sec = _max;
    _timer?.cancel();
    _timer = null;
    start();
  }

  start() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec > 0) {
        setState(() {
          _sec--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: BaseAppBar(
        title: localization.timerTitle,
        action: const Icon(
          Icons.bar_chart,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AnalyzePage.routeName);
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TimerTask(
              count: 2,
              targetCount: 5,
              title: "Deutsch lernen",
              totalTime: 29,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              height: MediaQuery.of(context).size.width * .6,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      height: MediaQuery.of(context).size.width * .6,
                      child: CircularProgressIndicator(
                        value: _sec / _max,
                        color: AppConstant.primaryColor,
                        backgroundColor:
                            AppConstant.primaryColor.withOpacity(.2),
                        strokeWidth: 7,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _sec == 0
                          ? localization.smile
                          : DateTimeConverter.formatSecToMinSec(
                              timeInSecond: _sec),
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppConstant.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(localization.stayFocus.replaceAll(
                "#",
                DateTimeConverter.formatSecToMinSec(
                    timeInSecond: (30 * 60) - _sec))),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  width: 55,
                  height: 55,
                  backgroundColor: AppConstant.primaryColor,
                  onPressed: () => reset(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Ionicons.repeat,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                MyButton(
                  width: 80,
                  height: 80,
                  backgroundColor: AppConstant.secondaryColor,
                  onPressed: () => start(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Ionicons.play,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                MyButton(
                  width: 55,
                  height: 55,
                  backgroundColor: AppConstant.primaryColor,
                  onPressed: () => stopAndDelete(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Ionicons.square,
                    size: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}