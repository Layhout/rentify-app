import 'package:rentify_app/features/joke/model/joke.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'joke_model.freezed.dart';
part 'joke_model.g.dart';

@freezed
abstract class JokeModel extends Joke with _$JokeModel {
  const JokeModel._();

  const factory JokeModel({
    required int? id,
    required String? type,
    required String? setup,
    required String? punchline,
  }) = _JokeModel;

  factory JokeModel.fromJson(Map<String, dynamic> json) => _$JokeModelFromJson(json);
}
