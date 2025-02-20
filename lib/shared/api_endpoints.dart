class ApiEndpoints {
  static const createUser = "users/create_user";
  static const login = "users/user_login/";
  static const getallMenu = "menumaster/get_all_menumaster/?page=1&size=50";
  static const getcatagoryMenu = "menumaster/get_menu_category/";
  static const allOrders = "order/get_all_order/";
  static const createOrder = "order/create_order/";
  static const floorMaster = "floormaster/get_all_floormaster/?page=1&size=50";
  static const tableMaster = "tablemaster/get_all_tablemaster/?page=1&size=50";
  static const getReport = "order/get_reports/";
  static const updateItem = "order/item_status_change/";

  // Method to get the URL for getting menu categories with parameters
  static String getCategoryMenuFiter(String categoryId, String categoryName) {
    return "menumaster/get_items_by_filter/?category=$categoryName&type=$categoryId"; // Example of adding a parameter
  }

  static String getCategoryMenueSearch(String categoryName) {
    return "menumaster/search_menumaster/?search=$categoryName&page=1&size=50"; // Example of adding a parameter
  }
}
