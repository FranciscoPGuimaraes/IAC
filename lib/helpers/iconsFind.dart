import '../constants/names.dart';

findConstant(String process) {
  if (NAMED_ICONS.containsKey(process)) {
    return NAMED_ICONS[process];
  } else {
    return NAMED_ICONS["default"];
  }
}