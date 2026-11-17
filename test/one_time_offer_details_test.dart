// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/src/messages.g.dart';
import 'package:in_app_purchase_android/src/pigeon_converters.dart';

void main() {
  group('OneTimePurchaseOfferDetailsWrapper', () {
    test('carries the offer token, discount, time window and quantity limit '
        'from the platform', () {
      final platform = PlatformOneTimePurchaseOfferDetails(
        priceAmountMicros: 1990000,
        formattedPrice: r'$1.99',
        priceCurrencyCode: 'USD',
        offerToken: 'discountOfferToken',
        offerId: 'launch',
        purchaseOptionId: 'buy',
        fullPriceMicros: 2990000,
        percentageDiscount: 33,
        offerTags: <String>['early'],
        startTimeMillis: 1798761600000,
        endTimeMillis: 1800835200000,
        maximumQuantity: 1000,
        remainingQuantity: 742,
      );

      final OneTimePurchaseOfferDetailsWrapper? wrapper =
          oneTimePurchaseOfferDetailsWrapperFromPlatform(platform);

      expect(
        wrapper,
        const OneTimePurchaseOfferDetailsWrapper(
          formattedPrice: r'$1.99',
          priceAmountMicros: 1990000,
          priceCurrencyCode: 'USD',
          offerToken: 'discountOfferToken',
          offerId: 'launch',
          purchaseOptionId: 'buy',
          fullPriceMicros: 2990000,
          percentageDiscount: 33,
          offerTags: <String>['early'],
          startTimeMillis: 1798761600000,
          endTimeMillis: 1800835200000,
          maximumQuantity: 1000,
          remainingQuantity: 742,
        ),
      );
    });

    test('an offer with no time window or limit has none', () {
      final OneTimePurchaseOfferDetailsWrapper? wrapper =
          oneTimePurchaseOfferDetailsWrapperFromPlatform(
            PlatformOneTimePurchaseOfferDetails(
              priceAmountMicros: 2990000,
              formattedPrice: r'$2.99',
              priceCurrencyCode: 'USD',
              offerTags: <String>[],
            ),
          );
      expect(wrapper!.startTimeMillis, isNull);
      expect(wrapper.endTimeMillis, isNull);
      expect(wrapper.maximumQuantity, isNull);
      expect(wrapper.remainingQuantity, isNull);
    });

    test('survives the platform channel encoding', () {
      final platform = PlatformOneTimePurchaseOfferDetails(
        priceAmountMicros: 2990000,
        formattedPrice: r'$2.99',
        priceCurrencyCode: 'USD',
        offerToken: 'baseOfferToken',
        purchaseOptionId: 'buy',
        offerTags: <String>[],
        endTimeMillis: 1800835200000,
        remainingQuantity: 5,
      );

      expect(PlatformOneTimePurchaseOfferDetails.decode(platform.encode()), platform);
    });

    test('offers that differ only by token are not equal', () {
      const a = OneTimePurchaseOfferDetailsWrapper(
        formattedPrice: r'$2.99',
        priceAmountMicros: 2990000,
        priceCurrencyCode: 'USD',
        offerToken: 'a',
      );
      const b = OneTimePurchaseOfferDetailsWrapper(
        formattedPrice: r'$2.99',
        priceAmountMicros: 2990000,
        priceCurrencyCode: 'USD',
        offerToken: 'b',
      );
      expect(a == b, isFalse);
    });
  });
}
