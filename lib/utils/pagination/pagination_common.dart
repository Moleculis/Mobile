import 'package:flutter/foundation.dart';

class PaginationData<T> {
  final List<T> data;
  final bool? loadedAll;

  PaginationData({
    required this.data,
    this.loadedAll = false,
  });
}

abstract class PaginationCommon<T> {
  final int dataLimit;

  PaginationCommon({required this.dataLimit}) : assert(dataLimit > 0);

  @protected
  PaginationData<T>? lastData;
}
