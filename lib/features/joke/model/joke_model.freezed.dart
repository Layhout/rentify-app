// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'joke_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JokeModel {

 int? get id; String? get type; String? get setup; String? get punchline;
/// Create a copy of JokeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JokeModelCopyWith<JokeModel> get copyWith => _$JokeModelCopyWithImpl<JokeModel>(this as JokeModel, _$identity);

  /// Serializes this JokeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.setup, setup) || other.setup == setup)&&(identical(other.punchline, punchline) || other.punchline == punchline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,setup,punchline);

@override
String toString() {
  return 'JokeModel(id: $id, type: $type, setup: $setup, punchline: $punchline)';
}


}

/// @nodoc
abstract mixin class $JokeModelCopyWith<$Res>  {
  factory $JokeModelCopyWith(JokeModel value, $Res Function(JokeModel) _then) = _$JokeModelCopyWithImpl;
@useResult
$Res call({
 int? id, String? type, String? setup, String? punchline
});




}
/// @nodoc
class _$JokeModelCopyWithImpl<$Res>
    implements $JokeModelCopyWith<$Res> {
  _$JokeModelCopyWithImpl(this._self, this._then);

  final JokeModel _self;
  final $Res Function(JokeModel) _then;

/// Create a copy of JokeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = freezed,Object? setup = freezed,Object? punchline = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,punchline: freezed == punchline ? _self.punchline : punchline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JokeModel].
extension JokeModelPatterns on JokeModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JokeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JokeModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JokeModel value)  $default,){
final _that = this;
switch (_that) {
case _JokeModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JokeModel value)?  $default,){
final _that = this;
switch (_that) {
case _JokeModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? type,  String? setup,  String? punchline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JokeModel() when $default != null:
return $default(_that.id,_that.type,_that.setup,_that.punchline);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? type,  String? setup,  String? punchline)  $default,) {final _that = this;
switch (_that) {
case _JokeModel():
return $default(_that.id,_that.type,_that.setup,_that.punchline);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? type,  String? setup,  String? punchline)?  $default,) {final _that = this;
switch (_that) {
case _JokeModel() when $default != null:
return $default(_that.id,_that.type,_that.setup,_that.punchline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JokeModel extends JokeModel {
  const _JokeModel({required this.id, required this.type, required this.setup, required this.punchline}): super._();
  factory _JokeModel.fromJson(Map<String, dynamic> json) => _$JokeModelFromJson(json);

@override final  int? id;
@override final  String? type;
@override final  String? setup;
@override final  String? punchline;

/// Create a copy of JokeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JokeModelCopyWith<_JokeModel> get copyWith => __$JokeModelCopyWithImpl<_JokeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JokeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.setup, setup) || other.setup == setup)&&(identical(other.punchline, punchline) || other.punchline == punchline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,setup,punchline);

@override
String toString() {
  return 'JokeModel(id: $id, type: $type, setup: $setup, punchline: $punchline)';
}


}

/// @nodoc
abstract mixin class _$JokeModelCopyWith<$Res> implements $JokeModelCopyWith<$Res> {
  factory _$JokeModelCopyWith(_JokeModel value, $Res Function(_JokeModel) _then) = __$JokeModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? type, String? setup, String? punchline
});




}
/// @nodoc
class __$JokeModelCopyWithImpl<$Res>
    implements _$JokeModelCopyWith<$Res> {
  __$JokeModelCopyWithImpl(this._self, this._then);

  final _JokeModel _self;
  final $Res Function(_JokeModel) _then;

/// Create a copy of JokeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = freezed,Object? setup = freezed,Object? punchline = freezed,}) {
  return _then(_JokeModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,punchline: freezed == punchline ? _self.punchline : punchline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
