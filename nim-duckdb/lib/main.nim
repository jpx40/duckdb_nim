import "../src/duckdb"
import std/assertions

# Open database and connection.
# Connection and database closed automatically with destructors

proc main() =
  var dbConn = connect("mydb.db")
  dbConn.exec("CREATE TABLE integers(i INTEGER, j INTEGER);")
  dbConn.exec("INSERT INTO integers VALUES (3, 4), (5, 6), (7, NULL);")
  dbConn.fastInsert(
    "integers",
    @[
      @["11", "NULL"]
    ],
  )
  var items: seq[seq[string]]
  for item in dbConn.rows(
    """SELECT i, j, i + j
    FROM integers"""
    ): items.add(item)
  for  v in items:
    echo "["
    for x in v:
    stdout.write "]"
  
  doAssert items == @[@["3", "4", "7"], @["5", "6", "11"], @["7", "NULL", "NULL"], @["11", "NULL", "NULL"]]
  
main()