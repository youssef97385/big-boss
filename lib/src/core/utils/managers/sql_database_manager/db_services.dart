import 'db.dart';

class DBService {
  // Future<List<OrdersResponseModel>> getOrders() async {
  //   try {
  //     await DB.init();
  //     List<Map<String, dynamic>> orders = await DB.getAllOrders();
  //     print("tssst $orders");
  //     List<OrdersResponseModel> orderDemo =
  //         orders.map((item) => OrdersResponseModel.fromJson(item)).toList();
  //
  //
  //     return orderDemo;
  //   } catch (e) {
  //     print("db services $e");
  //     throw Exception();
  //   }
  // }
  //
  // Future<bool> insertOrders(
  //     List<OrdersResponseModel> list,
  // ) async {
  //   await DB.init();
  //
  //   bool isSaved = false;
  //
  //   int inserted = 0;
  //   for(OrdersResponseModel model in list){
  //      inserted = await DB.insertOrder(order: model);
  //   }
  //
  //   isSaved = inserted == 1;
  //
  //   return isSaved;
  // }
}
