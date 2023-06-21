import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_entity_wrapper.g.dart';

part 'paginated_entity_wrapper.freezed.dart';

@Freezed(genericArgumentFactories: true)
class PaginatedWrapperEntity<T> with _$PaginatedWrapperEntity<T> {
  const factory PaginatedWrapperEntity({
    required final int totalItems,
    required final int itemsPerPage,
    required final int countOfPages,
    @Default([]) final List<T> data,
  }) = _PaginatedWrapperEntity;

  factory PaginatedWrapperEntity.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PaginatedWrapperEntityFromJson(json, fromJsonT);
}
