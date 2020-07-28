// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  // ignore: always_specify_types
  static const Map<String, dynamic> en = <String, dynamic>{
    "cyclesPage": "Cycles",
    "todaysPage": "Today",
    "rewardsPage": "Rewards",
    "pickColor": "Pick A Color",
    "pickIcon": "Pick An Icon",
    "currentPoints": "Current Reward Points",
    "markSkip": "Mark As Skipped",
    "markDone": "Mark as done",
    "markFail": "Mark as failed",
    "skip": "Skip",
    "done": "Done",
    "fail": "Fail",
    "failure": {"one": "Failure", "many": "Failures"},
    "habit": {"one": "Habit", "many": "Habits"},
    "reward": {"one": "Reward", "many": "Rewards"},
    "failures": "Failures",
    "delete": "Delete",
    "icon": "Icon",
    "color": "Color",
    "notEnoughPoints": "You don't have enough reward points",
    "take": "Take",
    "createHabitTitle": "Create A Habit",
    "validInteger": "Please Enter Valid Number",
    "positiveInteger": "Please Enter Positive Number",
    "validName": "Please Enter Valid Name",
    "habitName": "Habit Name",
    "rewardPoints": "Reward Points",
    "submit": "Done",
    "createRewardTitle": "Create A Reward",
    "rewardName": "Reward Name"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": en};
}
