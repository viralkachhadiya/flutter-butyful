class ItemProduction {
  String productiondate;
  String tblid;
  String productiontime;
  String masterbox;
  String itemid;

  ItemProduction(
      {this.productiondate,
      this.tblid,
      this.productiontime,
      this.masterbox,
      this.itemid});

  Map toJson() {
    return {
      "ProductionDate": this.productiondate,
      "TblId": this.tblid,
      "ProductionTime": this.productiontime,
      "MasterBox": this.masterbox,
      "ItemId": this.itemid
    };
  }
}
