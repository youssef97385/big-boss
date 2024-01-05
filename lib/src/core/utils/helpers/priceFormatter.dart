import 'package:easy_localization/easy_localization.dart';

String getFormattedPrice(double price){
  NumberFormat formatter = NumberFormat('#,###', 'en_US');
  final String formattedPrice = formatter.format(price);
 return "${formattedPrice} IQD";

}