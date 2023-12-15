import 'package:dynamic/dynamic.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'text.g.dart';

@JsonSerializable()
class XText extends XView {
  XText(this.text) : super(key: 'unkonw', type: 'text');

  String text;

  // region json serialization.
  /// toJson is not required
//  factory XText.fromJson(Map<String, dynamic> json) => _$XTextFromJson(json);
  // endregion
}
