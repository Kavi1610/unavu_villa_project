import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

class FoodItemsProvider extends BaseProvider {
  Future updateItemStatus(int itemid, int status, int statusTime) async {
    try {
      var token;
      await fetchToken().then((val) {
        token = val;
      });
      final response = await post(
          "${ApiEndpoints.updateItem}?itemid=$itemid&status=$status&statustime=$statusTime",
          {},
          headers: {"Authorization": "Bearer $token"});
      if (response.hasError) {
        return Future.error("Error");
      } else {
        return Future.value(true);
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
