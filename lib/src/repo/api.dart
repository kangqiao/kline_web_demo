// Copyright 2024 Andy.Zhao
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:dio/dio.dart';

import '../models/export.dart';
import 'http_client.dart';

/// 获取交易产品基础信息
Future<ApiResult<List<Instrument>>> getInstrumentList({
  String instType = 'SPOT',
  String? instId,
  CancelToken? cancelToken,
}) {
  return httpClient.getList(
    '/api/v5/public/instruments',
    Instrument.fromJson,
    queryParameters: {
      "instType": instType,
      "instId": instId,
    },
    cancelToken: cancelToken,
  );
}

/// GET / 获取所有产品行情信息
Future<ApiResult<List<MarketTicker>>> getMarketTickerList({
  String instType = 'SPOT',
  CancelToken? cancelToken,
}) {
  return httpClient.getList(
    '/api/v5/market/tickers',
    MarketTicker.fromJson,
    queryParameters: {"instType": instType},
    cancelToken: cancelToken,
  );
}

/// GET / 获取单个产品行情信息
Future<ApiResult<MarketTicker>> getMarketTicker(
  String instId, {
  CancelToken? cancelToken,
}) {
  return httpClient
      .getList(
        '/api/v5/market/ticker',
        MarketTicker.fromJson,
        queryParameters: {"instId": instId},
        cancelToken: cancelToken,
      )
      .then(
        (result) => ApiResult(
          code: result.code,
          msg: result.msg,
          data: result.data?.firstOrNull,
          success: result.success,
        ),
      );
}
