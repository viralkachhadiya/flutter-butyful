class Item {
  String itemcode;
  String description;
  String unit;
  int inventory;
  int actualcost;
  int totalvalue;
  int categoryid;

  Item(
      {this.itemcode,
      this.description,
      this.unit,
      this.inventory,
      this.actualcost,
      this.totalvalue,
      this.categoryid});

  Map toJson() {
    return {
      "ItemCode": this.itemcode,
      "Description": this.description,
      "Unit": this.unit,
      "Inventory": this.inventory,
      "ActualCost": this.actualcost,
      "TotalValue": this.totalvalue,
      "CategoryId": this.categoryid,
    };
  }
}
