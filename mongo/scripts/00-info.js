function info() {
  var result = {
    host: db.hostInfo(),
    database: db.stats(),
    collections: {}
  };
  var colNames = db.getCollectionNames();
  for (var i = 0; i < colNames.length; i++) {
    result.collections[colNames[i]] = db[colNames[i]].stats();
  }
  return result;
}
