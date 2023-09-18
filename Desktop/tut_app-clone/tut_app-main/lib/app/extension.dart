import 'constants.dart';

// function to check if string is null and put default value "" if it is null
extension NonNullableString on String? {
  String? orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
} // function to check if int is null and put default value zero  if it is null
extension NonNullableInt on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}
