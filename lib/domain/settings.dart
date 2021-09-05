import 'package:mow/mow.dart';
import 'package:shared_preferences/shared_preferences.dart';
// What to do with finished tasks
enum DoneOptions { nothing, greyOut, delete }
// Class that behaves like a map of DoneOptions and saves to shared prefs
// If all options are turned off, `nothing` will be turned on (the default value)
// Whenever the object chnages, it sends an Update signal
class Settings with Updatable {
  Map<DoneOptions, bool> _doneOptions = {
    DoneOptions.nothing: true,
    DoneOptions.greyOut: false,
    DoneOptions.delete: false
  };
  static const String kOptionNothing = 'Nothing (Default)';
  static const String kOptionGreyOut = 'Gray out';
  static const String kOptionDelete = 'Delete';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Settings._create(); // Don't create a Settings object directly.
  static Future<Settings> getInstance() async {
    final settings = Settings._create();
    await settings._load();
    return settings;
  }
  bool operator [](DoneOptions option) {
    return _doneOptions[option]!;
  }
  void operator []=(DoneOptions option, bool value) {
    if (_doneOptions[option] != value) {
      if (value == true) {
        // turn all off before continuing
        _doneOptions = {
          DoneOptions.nothing: true,
          DoneOptions.greyOut: false,
          DoneOptions.delete: false
        };
      }
      // Apply change
      _doneOptions[option] = value;
      // if all are turned off, turn on default
      if (_doneOptions[DoneOptions.nothing] == false &&
          _doneOptions[DoneOptions.greyOut] == false &&
          _doneOptions[DoneOptions.delete] == false) {
        _doneOptions[DoneOptions.nothing] = true;
      }
      // commit to preferences
      _commit().then((value) {
        // Notify the change
        changeState(() {});
      });
    }
  }
  // SharedPreferences
  Future<void> _commit() async {
    final prefs = await _prefs;
    await prefs.setBool(kOptionNothing, _doneOptions[DoneOptions.nothing]!);
    await prefs.setBool(kOptionGreyOut, _doneOptions[DoneOptions.greyOut]!);
    await prefs.setBool(kOptionDelete, _doneOptions[DoneOptions.delete]!);
  }
  Future<void> _load() async {
    final prefs = await _prefs;
    _doneOptions[DoneOptions.nothing] = prefs.getBool(kOptionNothing) ?? true;
    _doneOptions[DoneOptions.greyOut] = prefs.getBool(kOptionGreyOut) ?? false;
    _doneOptions[DoneOptions.delete] = prefs.getBool(kOptionDelete) ?? false;
  }
}