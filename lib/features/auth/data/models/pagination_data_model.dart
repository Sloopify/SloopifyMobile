import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';

class PaginationDataModel extends PaginationData {
  PaginationDataModel({
    required super.from,
    required super.currentPage,
    required super.hasMorePages,
    required super.lastPage,
    required super.perPage,
    required super.requestedPage,
    required super.to,
    required super.total,
  });

  factory PaginationDataModel.fromJson(Map<String, dynamic> json) {
    return PaginationDataModel(
      from: json["from"] ?? 0,
      currentPage: json["current_page"] ?? 0,
      hasMorePages: json["has_more_pages"] ?? false,
      lastPage: json["last_page"] ?? 0,
      perPage: json["per_page"] ?? 0,
      requestedPage: json["requested_page"] ?? "0",
      to: json["to"] ?? 0,
      total: json["total"] ?? 0,
    );
  }
}
