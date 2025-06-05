import 'package:equatable/equatable.dart';

class PaginationData extends Equatable {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;
  final bool hasMorePages;
  final String requestedPage;

  PaginationData({
    required this.from,
    required this.currentPage,
    required this.hasMorePages,
    required this.lastPage,
    required this.perPage,
    required this.requestedPage,
    required this.to,
    required this.total,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [total,to,requestedPage,perPage,hasMorePages,currentPage,lastPage,from];
}
