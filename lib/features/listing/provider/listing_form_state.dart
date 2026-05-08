import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing_form_state.freezed.dart';

enum ListingType { item, service }

@freezed
abstract class ListingFormState with _$ListingFormState {
  const factory ListingFormState({
    @Default(ListingType.item) ListingType type,
    required String title,
    required String category,
    required String condition,
    required String description,
    required List<String> images,
    required double price,
    required bool isWeeklyDiscount,
    required List<String> availability,
    required String minimumRentalDuration,
  }) = _ListingFormState;
}
