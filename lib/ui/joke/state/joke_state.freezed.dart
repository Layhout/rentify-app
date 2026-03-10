// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'joke_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JokeState {

 Joke get joke;
/// Create a copy of JokeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JokeStateCopyWith<JokeState> get copyWith => _$JokeStateCopyWithImpl<JokeState>(this as JokeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JokeState&&(identical(other.joke, joke) || other.joke == joke));
}


@override
int get hashCode => Object.hash(runtimeType,joke);

@override
String toString() {
  return 'JokeState(joke: $joke)';
}


}

/// @nodoc
abstract mixin class $JokeStateCopyWith<$Res>  {
  factory $JokeStateCopyWith(JokeState value, $Res Function(JokeState) _then) = _$JokeStateCopyWithImpl;
@useResult
$Res call({
 Joke joke
});




}
/// @nodoc
class _$JokeStateCopyWithImpl<$Res>
    implements $JokeStateCopyWith<$Res> {
  _$JokeStateCopyWithImpl(this._self, this._then);

  final JokeState _self;
  final $Res Function(JokeState) _then;

/// Create a copy of JokeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? joke = null,}) {
  return _then(_self.copyWith(
joke: null == joke ? _self.joke : joke // ignore: cast_nullable_to_non_nullable
as Joke,
  ));
}

}


/// Adds pattern-matching-related methods to [JokeState].
extension JokeStatePatterns on JokeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JokeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JokeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JokeState value)  $default,){
final _that = this;
switch (_that) {
case _JokeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JokeState value)?  $default,){
final _that = this;
switch (_that) {
case _JokeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Joke joke)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JokeState() when $default != null:
return $default(_that.joke);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Joke joke)  $default,) {final _that = this;
switch (_that) {
case _JokeState():
return $default(_that.joke);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Joke joke)?  $default,) {final _that = this;
switch (_that) {
case _JokeState() when $default != null:
return $default(_that.joke);case _:
  return null;

}
}

}

/// @nodoc


class _JokeState implements JokeState {
  const _JokeState({required this.joke});
  

@override final  Joke joke;

/// Create a copy of JokeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JokeStateCopyWith<_JokeState> get copyWith => __$JokeStateCopyWithImpl<_JokeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JokeState&&(identical(other.joke, joke) || other.joke == joke));
}


@override
int get hashCode => Object.hash(runtimeType,joke);

@override
String toString() {
  return 'JokeState(joke: $joke)';
}


}

/// @nodoc
abstract mixin class _$JokeStateCopyWith<$Res> implements $JokeStateCopyWith<$Res> {
  factory _$JokeStateCopyWith(_JokeState value, $Res Function(_JokeState) _then) = __$JokeStateCopyWithImpl;
@override @useResult
$Res call({
 Joke joke
});




}
/// @nodoc
class __$JokeStateCopyWithImpl<$Res>
    implements _$JokeStateCopyWith<$Res> {
  __$JokeStateCopyWithImpl(this._self, this._then);

  final _JokeState _self;
  final $Res Function(_JokeState) _then;

/// Create a copy of JokeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? joke = null,}) {
  return _then(_JokeState(
joke: null == joke ? _self.joke : joke // ignore: cast_nullable_to_non_nullable
as Joke,
  ));
}


}

// dart format on
