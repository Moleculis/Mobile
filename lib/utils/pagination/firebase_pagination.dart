import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moleculis/utils/pagination/pagination.dart';
import 'package:moleculis/utils/pagination/pagination_common.dart';

class FirebasePagination<T> {
  final Pagination<T> _pagination;

  FirebasePagination({required int dataLimit})
      : _pagination = Pagination(dataLimit: dataLimit);

  int _docsAmount = 0;

  Stream<PaginationData<T>> loadData({
    required Query query,
    required bool isLoadMore,
    required List<T> Function(QuerySnapshot) mapSnapshot,
    List<T> Function(List<T> currentData, List<T> newData)? mapData,
    bool Function(T a, T b)? dataItemsEqual,
  }) {
    _docsAmount = !isLoadMore
        ? _pagination.dataLimit
        : _docsAmount + _pagination.dataLimit;
    query = query.limit(_docsAmount);

    return _pagination.loadData(
      stream: query.snapshots().map(mapSnapshot),
      dataItemsEqual: dataItemsEqual,
      mapData: mapData,
    );
  }
}
