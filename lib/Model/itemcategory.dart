class ItemCategory {
  int categoryid;
  String categoryname;

  ItemCategory({this.categoryid, this.categoryname});

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
        categoryid: json["CategoryId"], categoryname: json["CategoryName"]);
  }
}
