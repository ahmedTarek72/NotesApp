import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_class.freezed.dart';
@freezed
class LoginObject with _$LoginObject {
  const factory LoginObject(
     String name,
     String password,
  ) = _LoginObject;
}
