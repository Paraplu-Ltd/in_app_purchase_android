// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

/// Dart wrapper around [`com.android.billingclient.api.ProductDetails.OneTimePurchaseOfferDetails`](https://developer.android.com/reference/com/android/billingclient/api/ProductDetails.OneTimePurchaseOfferDetails).
///
/// Represents the offer details to buy a one-time purchase product.
@immutable
class OneTimePurchaseOfferDetailsWrapper {
  /// Creates a [OneTimePurchaseOfferDetailsWrapper].
  const OneTimePurchaseOfferDetailsWrapper({
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
    this.offerToken,
    this.offerId,
    this.purchaseOptionId,
    this.fullPriceMicros,
    this.percentageDiscount,
    this.offerTags = const <String>[],
  });

  /// Formatted price for the payment, including its currency sign.
  ///
  /// For tax exclusive countries, the price doesn't include tax.
  final String formattedPrice;

  /// The price for the payment in micro-units, where 1,000,000 micro-units
  /// equal one unit of the currency.
  ///
  /// For example, if price is "€7.99", price_amount_micros is "7990000". This
  /// value represents the localized, rounded price for a particular currency.
  final int priceAmountMicros;

  /// The ISO 4217 currency code for price.
  ///
  /// For example, if price is specified in British pounds sterling, currency
  /// code is "GBP".
  final String priceCurrencyCode;

  /// The token that selects this offer when it is bought: pass it as
  /// `GooglePlayPurchaseParam.offerToken` to buy at this offer's price.
  ///
  /// A one-time product can carry several offers (its purchase options and
  /// any discount offers on them), each with its own token. Null only when
  /// the wrapper was built by hand.
  final String? offerToken;

  /// The offer's ID, or null for a purchase option's base offer.
  final String? offerId;

  /// The ID of the purchase option this offer belongs to.
  final String? purchaseOptionId;

  /// The price before any discount, in micro-units, when this offer is a
  /// discount; null otherwise.
  final int? fullPriceMicros;

  /// The discount as a percentage, when Play gives one for display.
  final int? percentageDiscount;

  /// The offer's tags, as set in Play Console.
  final List<String> offerTags;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is OneTimePurchaseOfferDetailsWrapper &&
        other.formattedPrice == formattedPrice &&
        other.priceAmountMicros == priceAmountMicros &&
        other.priceCurrencyCode == priceCurrencyCode &&
        other.offerToken == offerToken &&
        other.offerId == offerId &&
        other.purchaseOptionId == purchaseOptionId &&
        other.fullPriceMicros == fullPriceMicros &&
        other.percentageDiscount == percentageDiscount &&
        listEquals(other.offerTags, offerTags);
  }

  @override
  int get hashCode {
    return Object.hash(
      formattedPrice.hashCode,
      priceAmountMicros.hashCode,
      priceCurrencyCode.hashCode,
      offerToken,
      offerId,
      purchaseOptionId,
      fullPriceMicros,
      percentageDiscount,
      Object.hashAll(offerTags),
    );
  }
}
