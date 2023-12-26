import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../app/logic/app_settings.dart';
import '../../../../injection.dart';
import '../../data/models/price_model.dart';

class ProductsEntity extends Equatable {
  final List<ProductEntity>? products;
  final int? pageNumber;
  final int? totalPages;

  ProductsEntity(
      {required this.products,
      required this.pageNumber,
      required this.totalPages});

  @override
  List<Object?> get props => [
        products,
        pageNumber,
      ];
}

class ProductEntity extends Equatable {
  final int? id;
  late String? name;
  late String? description;
  late String? shippingDetails;
  final String? image;
  final bool? inStock;
  late String priceLabel;
  late String highestPrice;
  late List<Color> colors;
  late List<String> sizes;
  late List<PriceModel>? pricesList;

  ProductEntity({
    this.id,
    required String enName,
    required String arName,
    required String krName,

    required String enDescription,
    required String arDescription,
    required String krDiscription,

    required String enShippingDetails,
    required String arShippingDetails,
    required String krShippingDetails,

    this.image,

    this.inStock,
    required String stringColors,
    required String stringSizes,
    required List<PriceModel> prices,
  }) {

    final selectedLang = serviceLocator<AppSettings>().selectedLanguage;
    if(selectedLang.id == 1){
      name = krName;
      shippingDetails = krShippingDetails;
      description = krDiscription;
    }else if(selectedLang.id == 2){
      name = arName;
      shippingDetails = arShippingDetails;
      description = arDescription;
    }else{
      name = enName;
      shippingDetails = enShippingDetails;
      description = enDescription;
    }

    pricesList = prices;
    if (prices.isEmpty) {
      priceLabel = "";
      highestPrice = "";
    } else if (prices.length == 1) {
      priceLabel = "${prices[0].price} IQD";
      highestPrice = "${prices[0].price} IQD";
    } else {
      priceLabel =
          "${prices[prices.length - 1].price} IQD - ${prices[0].price} IQD";
      highestPrice = "${prices[0].price} IQD";
    }

    if (stringColors.isNotEmpty) {
      String colorString = "$stringColors"; // Your color string
      List<Color> colorList = [];
      colorString = colorString.replaceAll('[', '').replaceAll(']', '').trim();

      List<String> colorStrings = colorString.split(',');

      for (String colorStr in colorStrings) {
        colorStr = colorStr.trim();
        colorStr.replaceAll('"', '').trim();
        if (true) {
          colorStr = colorStr.substring(
              2, colorStr.length - 1); // Remove the '#' symbol if present
        }

        if (colorStr.isNotEmpty) {
          int colorValue = int.parse(colorStr, radix: 16);
          colorList.add(Color(0xff000000 | colorValue));
          // Parse the color string and add it to the list.
        }
      }

      print("colorList ${colorList}");
      colors = colorList;
    } else {
      colors = [];
    }
    if (stringSizes.isNotEmpty) {
      List<String> stringList =
          json.decode(stringSizes).whereType<String>().toList();
      sizes = stringList;
    } else {
      sizes = [];
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
