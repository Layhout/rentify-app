// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListingFormState {

 ListingType get type; String get title; String get category; String get condition; String get description; List<String> get images; double get price; bool get isWeeklyDiscount; List<String> get availability; String get minimumRentalDuration;
/// Create a copy of ListingFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingFormStateCopyWith<ListingFormState> get copyWith => _$ListingFormStateCopyWithImpl<ListingFormState>(this as ListingFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingFormState&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.price, price) || other.price == price)&&(identical(other.isWeeklyDiscount, isWeeklyDiscount) || other.isWeeklyDiscount == isWeeklyDiscount)&&const DeepCollectionEquality().equals(other.availability, availability)&&(identical(other.minimumRentalDuration, minimumRentalDuration) || other.minimumRentalDuration == minimumRentalDuration));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,category,condition,description,const DeepCollectionEquality().hash(images),price,isWeeklyDiscount,const DeepCollectionEquality().hash(availability),minimumRentalDuration);

@override
String toString() {
  return 'ListingFormState(type: $type, title: $title, category: $category, condition: $condition, description: $description, images: $images, price: $price, isWeeklyDiscount: $isWeeklyDiscount, availability: $availability, minimumRentalDuration: $minimumRentalDuration)';
}


}

/// @nodoc
abstract mixin class $ListingFormStateCopyWith<$Res>  {
  factory $ListingFormStateCopyWith(ListingFormState value, $Res Function(ListingFormState) _then) = _$ListingFormStateCopyWithImpl;
@useResult
$Res call({
 ListingType type, String title, String category, String condition, String description, List<String> images, double price, bool isWeeklyDiscount, List<String> availability, String minimumRentalDuration
});




}
/// @nodoc
class _$ListingFormStateCopyWithImpl<$Res>
    implements $ListingFormStateCopyWith<$Res> {
  _$ListingFormStateCopyWithImpl(this._self, this._then);

  final ListingFormState _self;
  final $Res Function(ListingFormState) _then;

/// Create a copy of ListingFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? category = null,Object? condition = null,Object? description = null,Object? images = null,Object? price = null,Object? isWeeklyDiscount = null,Object? availability = null,Object? minimumRentalDuration = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ListingType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isWeeklyDiscount: null == isWeeklyDiscount ? _self.isWeeklyDiscount : isWeeklyDiscount // ignore: cast_nullable_to_non_nullable
as bool,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as List<String>,minimumRentalDuration: null == minimumRentalDuration ? _self.minimumRentalDuration : minimumRentalDuration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingFormState].
extension ListingFormStatePatterns on ListingFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingFormState value)  $default,){
final _that = this;
switch (_that) {
case _ListingFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingFormState value)?  $default,){
final _that = this;
switch (_that) {
case _ListingFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ListingType type,  String title,  String category,  String condition,  String description,  List<String> images,  double price,  bool isWeeklyDiscount,  List<String> availability,  String minimumRentalDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingFormState() when $default != null:
return $default(_that.type,_that.title,_that.category,_that.condition,_that.description,_that.images,_that.price,_that.isWeeklyDiscount,_that.availability,_that.minimumRentalDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ListingType type,  String title,  String category,  String condition,  String description,  List<String> images,  double price,  bool isWeeklyDiscount,  List<String> availability,  String minimumRentalDuration)  $default,) {final _that = this;
switch (_that) {
case _ListingFormState():
return $default(_that.type,_that.title,_that.category,_that.condition,_that.description,_that.images,_that.price,_that.isWeeklyDiscount,_that.availability,_that.minimumRentalDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ListingType type,  String title,  String category,  String condition,  String description,  List<String> images,  double price,  bool isWeeklyDiscount,  List<String> availability,  String minimumRentalDuration)?  $default,) {final _that = this;
switch (_that) {
case _ListingFormState() when $default != null:
return $default(_that.type,_that.title,_that.category,_that.condition,_that.description,_that.images,_that.price,_that.isWeeklyDiscount,_that.availability,_that.minimumRentalDuration);case _:
  return null;

}
}

}

/// @nodoc


class _ListingFormState implements ListingFormState {
  const _ListingFormState({this.type = ListingType.item, required this.title, required this.category, required this.condition, required this.description, required final  List<String> images, required this.price, required this.isWeeklyDiscount, required final  List<String> availability, required this.minimumRentalDuration}): _images = images,_availability = availability;
  

@override@JsonKey() final  ListingType type;
@override final  String title;
@override final  String category;
@override final  String condition;
@override final  String description;
 final  List<String> _images;
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  double price;
@override final  bool isWeeklyDiscount;
 final  List<String> _availability;
@override List<String> get availability {
  if (_availability is EqualUnmodifiableListView) return _availability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availability);
}

@override final  String minimumRentalDuration;

/// Create a copy of ListingFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingFormStateCopyWith<_ListingFormState> get copyWith => __$ListingFormStateCopyWithImpl<_ListingFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingFormState&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.price, price) || other.price == price)&&(identical(other.isWeeklyDiscount, isWeeklyDiscount) || other.isWeeklyDiscount == isWeeklyDiscount)&&const DeepCollectionEquality().equals(other._availability, _availability)&&(identical(other.minimumRentalDuration, minimumRentalDuration) || other.minimumRentalDuration == minimumRentalDuration));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,category,condition,description,const DeepCollectionEquality().hash(_images),price,isWeeklyDiscount,const DeepCollectionEquality().hash(_availability),minimumRentalDuration);

@override
String toString() {
  return 'ListingFormState(type: $type, title: $title, category: $category, condition: $condition, description: $description, images: $images, price: $price, isWeeklyDiscount: $isWeeklyDiscount, availability: $availability, minimumRentalDuration: $minimumRentalDuration)';
}


}

/// @nodoc
abstract mixin class _$ListingFormStateCopyWith<$Res> implements $ListingFormStateCopyWith<$Res> {
  factory _$ListingFormStateCopyWith(_ListingFormState value, $Res Function(_ListingFormState) _then) = __$ListingFormStateCopyWithImpl;
@override @useResult
$Res call({
 ListingType type, String title, String category, String condition, String description, List<String> images, double price, bool isWeeklyDiscount, List<String> availability, String minimumRentalDuration
});




}
/// @nodoc
class __$ListingFormStateCopyWithImpl<$Res>
    implements _$ListingFormStateCopyWith<$Res> {
  __$ListingFormStateCopyWithImpl(this._self, this._then);

  final _ListingFormState _self;
  final $Res Function(_ListingFormState) _then;

/// Create a copy of ListingFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? category = null,Object? condition = null,Object? description = null,Object? images = null,Object? price = null,Object? isWeeklyDiscount = null,Object? availability = null,Object? minimumRentalDuration = null,}) {
  return _then(_ListingFormState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ListingType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isWeeklyDiscount: null == isWeeklyDiscount ? _self.isWeeklyDiscount : isWeeklyDiscount // ignore: cast_nullable_to_non_nullable
as bool,availability: null == availability ? _self._availability : availability // ignore: cast_nullable_to_non_nullable
as List<String>,minimumRentalDuration: null == minimumRentalDuration ? _self.minimumRentalDuration : minimumRentalDuration // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
