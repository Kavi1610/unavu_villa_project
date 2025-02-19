class ApiEndpoints {
  static const createUser = "users/create_user";
  static const login = "users/user_login/";
  static const getallMenu = "menumaster/get_all_menumaster/?page=1&size=50";
  static const getcatagoryMenu = "menumaster/get_menu_category/";
  static const allOrders = "order/get_all_order/?page=1&size=50";
  static const createOrder = "order/create_order/";

  // Method to get the URL for getting menu categories with parameters
  static String getCategoryMenuFiter(String categoryId, String categoryName) {
    return "menumaster/get_items_by_filter/?category=$categoryName&type=$categoryId"; // Example of adding a parameter
  }

  static String getCategoryMenueSearch(String categoryName) {
    return "menumaster/search_menumaster/?search=$categoryName&page=1&size=50"; // Example of adding a parameter
  }
}
