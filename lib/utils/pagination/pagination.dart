import 'dart:async';

import 'package:moleculis/utils/pagination/pagination_common.dart';

class Pagination<T> extends PaginationCommon<T> {
  Pagination({required int dataLimit}) : super(dataLimit: dataLimit);

  Stream<PaginationData<T>> loadData({
    required Stream<List<T>> stream,
    List<T> Function(List<T> currentData, List<T> newData)? mapData,
    bool Function(T a, T b)? dataItemsEqual,
  }) {
    bool? isUpdate;
    return stream.map(
          (List<T> newData) {
        final List<T> currentData = lastData?.data ?? [];
        if (isUpdate == null) {
          isUpdate = false;
        } else {
          if (isUpdate!) {
            if (newData.length == currentData.length) {
              bool sameData = true;
              for (int i = 0; i < newData.length; ++i) {
                final bool equal = dataItemsEqual != null
                    ? dataItemsEqual(newData[i], currentData[i])
                    : newData[i] == currentData[i];
                if (!equal) {
                  sameData = false;
                  break;
                }
              }
              if (sameData) {
                return lastData ??
                    PaginationData(
                      data: [],
                      loadedAll: true,
                    );
              }
            }
          } else {
            isUpdate = true;
          }
        }

        if (mapData != null) {
          newData = mapData(currentData, newData);
        }

        final int dataLengthDelta = newData.length - currentData.length;

        bool lastLoadedAll = false;

        if (isUpdate!) {
          if (dataLengthDelta < 0) {
            lastLoadedAll = true;
          } else if (dataLengthDelta == 0 && newData.length % dataLimit == 0) {
            lastLoadedAll = dataItemsEqual != null
                ? dataItemsEqual(currentData.last, newData.last)
                : currentData.last == newData.last;
          } else {
            lastLoadedAll = true;
          }
        } else if (dataLengthDelta < dataLimit) {
          lastLoadedAll = true;
        }

        lastData = PaginationData(
          data: newData,
          loadedAll: lastLoadedAll,
        );

        return lastData!;
      },
    );
  }
}
