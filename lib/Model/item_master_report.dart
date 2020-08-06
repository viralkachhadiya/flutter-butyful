class ItemMasterReport {
  int itemid;
  String itemcode;
  String description;
  String unit;
  int inventory;
  int actualcost;
  int totalvalue;
  String subcategory;

  ItemMasterReport(
      {this.itemid,
      this.itemcode,
      this.description,
      this.unit,
      this.inventory,
      this.actualcost,
      this.totalvalue,
      this.subcategory});

  factory ItemMasterReport.fromJson(Map<String, dynamic> json) {
    return ItemMasterReport(
      itemid: json["ItemId"],
      itemcode: json["ItemCode"],
      description: json["Description"],
      unit: json["Unit"],
      inventory: json["Inventory"],
      actualcost: json["ActualCost"],
      totalvalue: json["TotalValue"],
      subcategory: json["CategoryName"],
    );
  }
}
