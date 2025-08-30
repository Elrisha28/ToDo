import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<bool> {
  // true = dark, false = light
  static const boxName = 'settings';
  static const keyThemeDark = 'isDark';

  ThemeCubit(bool initial) : super(initial);

  static Future<ThemeCubit> load() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    final box = Hive.box(boxName);
    final isDark = box.get(keyThemeDark, defaultValue: false) as bool;
    return ThemeCubit(isDark);
  }

  void toggle() {
    final next = !state;
    Hive.box(boxName).put(keyThemeDark, next);
    emit(next);
  }
}