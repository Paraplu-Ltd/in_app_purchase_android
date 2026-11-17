// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/src/messages.g.dart';
import 'package:in_app_purchase_android/src/pigeon_converters.dart';

void main() {
  group('OneTimePurchaseOfferDetailsWrapper', () {
    test('carries the offer token and discount fields from the platform', () {
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
        ),
      );
    });

    test('survives the platform channel encoding', () {
      final platform = PlatformOneTimePurchaseOfferDetails(
        priceAmountMicros: 2990000,
        formattedPrice: r'$2.99',
        priceCurrencyCode: 'USD',
        offerToken: 'baseOfferToken',
        purchaseOptionId: 'buy',
        offerTags: <String>[],
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
