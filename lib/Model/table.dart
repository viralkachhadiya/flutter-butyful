class Table {
  int tableid;
  int tableno;

  Table({this.tableid, this.tableno});

  factory Table.fromjson(Map<String, dynamic> json) {
    return Table(tableid: json["TblId"], tableno: json["TblNo"]);
  }
}
