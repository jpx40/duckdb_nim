
# Generated @ 2024-10-11T12:17:32+02:00
# Command line:
#   /Users/jonas/.nimble/pkgs2/nimterop-0.6.13-a93246b2ad5531db11e51de7b2d188c42d95576a/nimterop/toast --preprocess -m:c --recurse --pnim --dynlib=/Users/jonas/.cache/nim/nimterop/duckdb/libduckdb.dylib --nim:/Users/jonas/.choosenim/toolchains/nim-2.2.0/bin/nim --pluginSourcePath=/Users/jonas/.cache/nim/nimterop/cPlugins/nimterop_6104020274626711960.nim /Users/jonas/.cache/nim/nimterop/duckdb/duckdb.h -o /Users/jonas/.cache/nim/nimterop/toastCache/nimterop_455658140385898303.nim

# const 'DUCKDB_EXTENSION_API' has unsupported value '__attribute__((visibility("default")))'
# const 'DUCKDB_API_LATEST' has unsupported value 'DUCKDB_API_0_3_2'
# const 'DUCKDB_API_VERSION' has unsupported value 'DUCKDB_API_LATEST'
{.push hint[ConvFromXtoItselfNotNeeded]: off.}
import macros

macro defineEnum(typ: untyped): untyped =
  result = newNimNode(nnkStmtList)

  # Enum mapped to distinct cint
  result.add quote do:
    type `typ`* = distinct cint

  for i in ["+", "-", "*", "div", "mod", "shl", "shr", "or", "and", "xor", "<", "<=", "==", ">", ">="]:
    let
      ni = newIdentNode(i)
      typout = if i[0] in "<=>": newIdentNode("bool") else: typ # comparisons return bool
    if i[0] == '>': # cannot borrow `>` and `>=` from templates
      let
        nopp = if i.len == 2: newIdentNode("<=") else: newIdentNode("<")
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` = `nopp`(y, x)
        proc `ni`*(x: cint, y: `typ`): `typout` = `nopp`(y, x)
        proc `ni`*(x, y: `typ`): `typout` = `nopp`(y, x)
    else:
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` {.borrow.}
        proc `ni`*(x: cint, y: `typ`): `typout` {.borrow.}
        proc `ni`*(x, y: `typ`): `typout` {.borrow.}
    result.add quote do:
      proc `ni`*(x: `typ`, y: int): `typout` = `ni`(x, y.cint)
      proc `ni`*(x: int, y: `typ`): `typout` = `ni`(x.cint, y)

  let
    divop = newIdentNode("/")   # `/`()
    dlrop = newIdentNode("$")   # `$`()
    notop = newIdentNode("not") # `not`()
  result.add quote do:
    proc `divop`*(x, y: `typ`): `typ` = `typ`((x.float / y.float).cint)
    proc `divop`*(x: `typ`, y: cint): `typ` = `divop`(x, `typ`(y))
    proc `divop`*(x: cint, y: `typ`): `typ` = `divop`(`typ`(x), y)
    proc `divop`*(x: `typ`, y: int): `typ` = `divop`(x, y.cint)
    proc `divop`*(x: int, y: `typ`): `typ` = `divop`(x.cint, y)

    proc `dlrop`*(x: `typ`): string {.borrow.}
    proc `notop`*(x: `typ`): `typ` {.borrow.}


{.pragma: impduckdbHdr,
  header: "/Users/jonas/.cache/nim/nimterop/duckdb/duckdb.h".}
{.pragma: impduckdbDyn,
  dynlib: "/Users/jonas/.cache/nim/nimterop/duckdb/libduckdb.dylib".}
{.experimental: "codeReordering".}
defineEnum(DUCKDB_TYPE) ## ```
                        ##   ===--------------------------------------------------------------------===
                        ##      Enums
                        ##     ===--------------------------------------------------------------------===
                        ##     ! An enum over DuckDB's internal types.
                        ## ```
defineEnum(duckdb_state) ## ```
                         ##   ! An enum over the returned state of different functions.
                         ## ```
defineEnum(duckdb_pending_state) ## ```
                                 ##   ! An enum over the pending state of a pending query result.
                                 ## ```
defineEnum(duckdb_result_type) ## ```
                               ##   ! An enum over DuckDB's different result types.
                               ## ```
defineEnum(duckdb_statement_type) ## ```
                                  ##   ! An enum over DuckDB's different statement types.
                                  ## ```
const
  DUCKDB_API_0_3_1* = 1
  DUCKDB_API_0_3_2* = 2
  DUCKDB_TYPE_INVALID* = (0).DUCKDB_TYPE ## ```
                                         ##   bool
                                         ## ```
  DUCKDB_TYPE_BOOLEAN* = (DUCKDB_TYPE_INVALID + 1).DUCKDB_TYPE ## ```
                                                               ##   bool
                                                               ## ```
  DUCKDB_TYPE_TINYINT* = (DUCKDB_TYPE_BOOLEAN + 1).DUCKDB_TYPE ## ```
                                                               ##   int8_t
                                                               ## ```
  DUCKDB_TYPE_SMALLINT* = (DUCKDB_TYPE_TINYINT + 1).DUCKDB_TYPE ## ```
                                                                ##   int16_t
                                                                ## ```
  DUCKDB_TYPE_INTEGER* = (DUCKDB_TYPE_SMALLINT + 1).DUCKDB_TYPE ## ```
                                                                ##   int32_t
                                                                ## ```
  DUCKDB_TYPE_BIGINT* = (DUCKDB_TYPE_INTEGER + 1).DUCKDB_TYPE ## ```
                                                              ##   int64_t
                                                              ## ```
  DUCKDB_TYPE_UTINYINT* = (DUCKDB_TYPE_BIGINT + 1).DUCKDB_TYPE ## ```
                                                               ##   uint8_t
                                                               ## ```
  DUCKDB_TYPE_USMALLINT* = (DUCKDB_TYPE_UTINYINT + 1).DUCKDB_TYPE ## ```
                                                                  ##   uint16_t
                                                                  ## ```
  DUCKDB_TYPE_UINTEGER* = (DUCKDB_TYPE_USMALLINT + 1).DUCKDB_TYPE ## ```
                                                                  ##   uint32_t
                                                                  ## ```
  DUCKDB_TYPE_UBIGINT* = (DUCKDB_TYPE_UINTEGER + 1).DUCKDB_TYPE ## ```
                                                                ##   uint64_t
                                                                ## ```
  DUCKDB_TYPE_FLOAT* = (DUCKDB_TYPE_UBIGINT + 1).DUCKDB_TYPE ## ```
                                                             ##   float
                                                             ## ```
  DUCKDB_TYPE_DOUBLE* = (DUCKDB_TYPE_FLOAT + 1).DUCKDB_TYPE ## ```
                                                            ##   double
                                                            ## ```
  DUCKDB_TYPE_TIMESTAMP* = (DUCKDB_TYPE_DOUBLE + 1).DUCKDB_TYPE ## ```
                                                                ##   duckdb_timestamp, in microseconds
                                                                ## ```
  DUCKDB_TYPE_DATE* = (DUCKDB_TYPE_TIMESTAMP + 1).DUCKDB_TYPE ## ```
                                                              ##   duckdb_date
                                                              ## ```
  DUCKDB_TYPE_TIME* = (DUCKDB_TYPE_DATE + 1).DUCKDB_TYPE ## ```
                                                         ##   duckdb_time
                                                         ## ```
  DUCKDB_TYPE_INTERVAL* = (DUCKDB_TYPE_TIME + 1).DUCKDB_TYPE ## ```
                                                             ##   duckdb_interval
                                                             ## ```
  DUCKDB_TYPE_HUGEINT* = (DUCKDB_TYPE_INTERVAL + 1).DUCKDB_TYPE ## ```
                                                                ##   duckdb_hugeint
                                                                ## ```
  DUCKDB_TYPE_UHUGEINT* = (DUCKDB_TYPE_HUGEINT + 1).DUCKDB_TYPE ## ```
                                                                ##   duckdb_uhugeint
                                                                ## ```
  DUCKDB_TYPE_VARCHAR* = (DUCKDB_TYPE_UHUGEINT + 1).DUCKDB_TYPE ## ```
                                                                ##   const char*
                                                                ## ```
  DUCKDB_TYPE_BLOB* = (DUCKDB_TYPE_VARCHAR + 1).DUCKDB_TYPE ## ```
                                                            ##   duckdb_blob
                                                            ## ```
  DUCKDB_TYPE_DECIMAL* = (DUCKDB_TYPE_BLOB + 1).DUCKDB_TYPE ## ```
                                                            ##   decimal
                                                            ## ```
  DUCKDB_TYPE_TIMESTAMP_S* = (DUCKDB_TYPE_DECIMAL + 1).DUCKDB_TYPE ## ```
                                                                   ##   duckdb_timestamp, in seconds
                                                                   ## ```
  DUCKDB_TYPE_TIMESTAMP_MS* = (DUCKDB_TYPE_TIMESTAMP_S + 1).DUCKDB_TYPE ## ```
                                                                        ##   duckdb_timestamp, in milliseconds
                                                                        ## ```
  DUCKDB_TYPE_TIMESTAMP_NS* = (DUCKDB_TYPE_TIMESTAMP_MS + 1).DUCKDB_TYPE ## ```
                                                                         ##   duckdb_timestamp, in nanoseconds
                                                                         ## ```
  DUCKDB_TYPE_ENUM* = (DUCKDB_TYPE_TIMESTAMP_NS + 1).DUCKDB_TYPE ## ```
                                                                 ##   enum type, only useful as logical type
                                                                 ## ```
  DUCKDB_TYPE_LIST* = (DUCKDB_TYPE_ENUM + 1).DUCKDB_TYPE ## ```
                                                         ##   list type, only useful as logical type
                                                         ## ```
  DUCKDB_TYPE_STRUCT* = (DUCKDB_TYPE_LIST + 1).DUCKDB_TYPE ## ```
                                                           ##   struct type, only useful as logical type
                                                           ## ```
  DUCKDB_TYPE_MAP* = (DUCKDB_TYPE_STRUCT + 1).DUCKDB_TYPE ## ```
                                                          ##   map type, only useful as logical type
                                                          ## ```
  DUCKDB_TYPE_UUID* = (DUCKDB_TYPE_MAP + 1).DUCKDB_TYPE ## ```
                                                        ##   duckdb_hugeint
                                                        ## ```
  DUCKDB_TYPE_UNION* = (DUCKDB_TYPE_UUID + 1).DUCKDB_TYPE ## ```
                                                          ##   union type, only useful as logical type
                                                          ## ```
  DUCKDB_TYPE_BIT* = (DUCKDB_TYPE_UNION + 1).DUCKDB_TYPE ## ```
                                                         ##   duckdb_bit
                                                         ## ```
  DUCKDB_TYPE_TIME_TZ* = (DUCKDB_TYPE_BIT + 1).DUCKDB_TYPE ## ```
                                                           ##   duckdb_time_tz
                                                           ## ```
  DUCKDB_TYPE_TIMESTAMP_TZ* = (DUCKDB_TYPE_TIME_TZ + 1).DUCKDB_TYPE ## ```
                                                                    ##   duckdb_timestamp
                                                                    ## ```
  DuckDBSuccess* = (0).duckdb_state
  DuckDBError* = (1).duckdb_state
  DUCKDB_PENDING_RESULT_READY* = (0).duckdb_pending_state
  DUCKDB_PENDING_RESULT_NOT_READY* = (1).duckdb_pending_state
  DUCKDB_PENDING_ERROR* = (2).duckdb_pending_state
  DUCKDB_PENDING_NO_TASKS_AVAILABLE* = (3).duckdb_pending_state
  DUCKDB_RESULT_TYPE_INVALID* = (0).duckdb_result_type
  DUCKDB_RESULT_TYPE_CHANGED_ROWS* = (DUCKDB_RESULT_TYPE_INVALID + 1).duckdb_result_type
  DUCKDB_RESULT_TYPE_NOTHING* = (DUCKDB_RESULT_TYPE_CHANGED_ROWS + 1).duckdb_result_type
  DUCKDB_RESULT_TYPE_QUERY_RESULT* = (DUCKDB_RESULT_TYPE_NOTHING + 1).duckdb_result_type
  DUCKDB_STATEMENT_TYPE_INVALID* = (0).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_SELECT* = (DUCKDB_STATEMENT_TYPE_INVALID + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_INSERT* = (DUCKDB_STATEMENT_TYPE_SELECT + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_UPDATE* = (DUCKDB_STATEMENT_TYPE_INSERT + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_EXPLAIN* = (DUCKDB_STATEMENT_TYPE_UPDATE + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_DELETE* = (DUCKDB_STATEMENT_TYPE_EXPLAIN + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_PREPARE* = (DUCKDB_STATEMENT_TYPE_DELETE + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_CREATE* = (DUCKDB_STATEMENT_TYPE_PREPARE + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_EXECUTE* = (DUCKDB_STATEMENT_TYPE_CREATE + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_ALTER* = (DUCKDB_STATEMENT_TYPE_EXECUTE + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_TRANSACTION* = (DUCKDB_STATEMENT_TYPE_ALTER + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_COPY* = (DUCKDB_STATEMENT_TYPE_TRANSACTION + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_ANALYZE* = (DUCKDB_STATEMENT_TYPE_COPY + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_VARIABLE_SET* = (DUCKDB_STATEMENT_TYPE_ANALYZE + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_CREATE_FUNC* = (DUCKDB_STATEMENT_TYPE_VARIABLE_SET + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_DROP* = (DUCKDB_STATEMENT_TYPE_CREATE_FUNC + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_EXPORT* = (DUCKDB_STATEMENT_TYPE_DROP + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_PRAGMA* = (DUCKDB_STATEMENT_TYPE_EXPORT + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_VACUUM* = (DUCKDB_STATEMENT_TYPE_PRAGMA + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_CALL* = (DUCKDB_STATEMENT_TYPE_VACUUM + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_SET* = (DUCKDB_STATEMENT_TYPE_CALL + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_LOAD* = (DUCKDB_STATEMENT_TYPE_SET + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_RELATION* = (DUCKDB_STATEMENT_TYPE_LOAD + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_EXTENSION* = (DUCKDB_STATEMENT_TYPE_RELATION + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_LOGICAL_PLAN* = (DUCKDB_STATEMENT_TYPE_EXTENSION + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_ATTACH* = (DUCKDB_STATEMENT_TYPE_LOGICAL_PLAN + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_DETACH* = (DUCKDB_STATEMENT_TYPE_ATTACH + 1).duckdb_statement_type
  DUCKDB_STATEMENT_TYPE_MULTI* = (DUCKDB_STATEMENT_TYPE_DETACH + 1).duckdb_statement_type
type
  duckdb_type* {.importc, impduckdbHdr.} = DUCKDB_TYPE ## ```
                                                       ##   ===--------------------------------------------------------------------===
                                                       ##      Enums
                                                       ##     ===--------------------------------------------------------------------===
                                                       ##     ! An enum over DuckDB's internal types.
                                                       ## ```
  idx_t* {.importc, impduckdbHdr.} = uint64 ## ```
                                            ##   ===--------------------------------------------------------------------===
                                            ##      General type definitions
                                            ##     ===--------------------------------------------------------------------===
                                            ##     ! DuckDB's index type.
                                            ## ```
  duckdb_delete_callback_t* {.importc, impduckdbHdr.} = proc (data: pointer) {.
      cdecl.}
  duckdb_task_state* {.importc, impduckdbHdr.} = pointer ## ```
                                                         ##   ! Used for threading, contains a task state. Must be destroyed with duckdb_destroy_state.
                                                         ## ```
  duckdb_date* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                           ##   ===--------------------------------------------------------------------===
                                                           ##      Types (no explicit freeing)
                                                           ##     ===--------------------------------------------------------------------===
                                                           ##     ! Days are stored as days since 1970-01-01
                                                           ##     ! Use the duckdb_from_date/duckdb_to_date function to extract individual information
                                                           ## ```
    days*: int32
  duckdb_date_struct* {.bycopy, importc, impduckdbHdr.} = object
    year*: int32
    month*: int8
    day*: int8
  duckdb_time* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                           ##   ! Time is stored as microseconds since 00:00:00
                                                           ##     ! Use the duckdb_from_time/duckdb_to_time function to extract individual information
                                                           ## ```
    micros*: int64
  duckdb_time_struct* {.bycopy, importc, impduckdbHdr.} = object
    hour*: int8
    min*: int8
    sec*: int8
    micros*: int32
  duckdb_time_tz* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                              ##   ! TIME_TZ is stored as 40 bits for int64_t micros, and 24 bits for int32_t offset
                                                              ## ```
    bits*: uint64
  duckdb_time_tz_struct* {.bycopy, importc, impduckdbHdr.} = object
    time*: duckdb_time
    offset*: int32
  duckdb_timestamp* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                                ##   ! Timestamps are stored as microseconds since 1970-01-01
                                                                ##     ! Use the duckdb_from_timestamp/duckdb_to_timestamp function to extract individual information
                                                                ## ```
    micros*: int64
  duckdb_timestamp_struct* {.bycopy, importc, impduckdbHdr.} = object
    date*: duckdb_date_struct
    time*: duckdb_time_struct
  duckdb_interval* {.bycopy, importc, impduckdbHdr.} = object
    months*: int32
    days*: int32
    micros*: int64
  duckdb_hugeint* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                              ##   ! Hugeints are composed of a (lower, upper) component
                                                              ##     ! The value of the hugeint is upper 2^64 + lower
                                                              ##     ! For easy usage, the functions duckdb_hugeint_to_double/duckdb_double_to_hugeint are recommended
                                                              ## ```
    lower*: uint64
    upper*: int64
  duckdb_uhugeint* {.bycopy, importc, impduckdbHdr.} = object
    lower*: uint64
    upper*: uint64
  duckdb_decimal* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                              ##   ! Decimals are composed of a width and a scale, and are stored in a hugeint
                                                              ## ```
    width*: uint8
    scale*: uint8
    value*: duckdb_hugeint
  duckdb_query_progress_type* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                                          ##   ! A type holding information about the query execution progress
                                                                          ## ```
    percentage*: cdouble
    rows_processed*: uint64
    total_rows_to_process*: uint64
  Type_duckdbh1* {.bycopy, impduckdbHdr, importc: "struct Type_duckdbh1".} = object
    length*: uint32
    prefix*: array[4, cchar]
    `ptr`*: cstring
  Type_duckdbh2* {.bycopy, impduckdbHdr, importc: "struct Type_duckdbh2".} = object
    length*: uint32
    inlined*: array[12, cchar]
  Union_duckdbh1* {.union, bycopy, impduckdbHdr, importc: "union Union_duckdbh1".} = object
    pointer*: Type_duckdbh1
    inlined*: Type_duckdbh2
  duckdb_string_t* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                               ##   ! The internal representation of a VARCHAR (string_t). If the VARCHAR does not
                                                               ##     ! exceed 12 characters, then we inline it. Otherwise, we inline a prefix for faster
                                                               ##     ! string comparisons and store a pointer to the remaining characters. This is a non-
                                                               ##     ! owning structure, i.e., it does not have to be freed.
                                                               ## ```
    value*: Union_duckdbh1
  duckdb_list_entry* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                                 ##   ! The internal representation of a list metadata entry contains the list's offset in
                                                                 ##     ! the child vector, and its length. The parent vector holds these metadata entries,
                                                                 ##     ! whereas the child vector holds the data
                                                                 ## ```
    offset*: uint64
    length*: uint64
  duckdb_column* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                             ##   ! A column consists of a pointer to its internal data. Don't operate on this type directly.
                                                             ##     ! Instead, use functions such as duckdb_column_data, duckdb_nullmask_data,
                                                             ##     ! duckdb_column_type, and duckdb_column_name, which take the result and the column index
                                                             ##     ! as their parameters
                                                             ## ```
    deprecated_data*: pointer ## ```
                              ##   deprecated, use duckdb_column_data
                              ## ```
    deprecated_nullmask*: ptr bool ## ```
                                   ##   deprecated, use duckdb_nullmask_data
                                   ## ```
    deprecated_type*: duckdb_type ## ```
                                  ##   deprecated, use duckdb_column_type
                                  ## ```
    deprecated_name*: cstring ## ```
                              ##   deprecated, use duckdb_column_name
                              ## ```
    internal_data*: pointer
  duckdb_vector* {.bycopy, impduckdbHdr, importc: "struct _duckdb_vector".} = object ## ```
                                                                                      ##   ! A vector to a specified column in a data chunk. Lives as long as the
                                                                                      ##     ! data chunk lives, i.e., must not be destroyed.
                                                                                      ## ```
    vctr*: pointer
  duckdb_string* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                             ##   ===--------------------------------------------------------------------===
                                                             ##      Types (explicit freeing/destroying)
                                                             ##     ===--------------------------------------------------------------------===
                                                             ##     ! Strings are composed of a char pointer and a size. You must free string.data
                                                             ##     ! with duckdb_free.
                                                             ## ```
    data*: cstring
    size*: idx_t
  duckdb_blob* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                           ##   ! BLOBs are composed of a byte pointer and a size. You must free blob.data
                                                           ##     ! with duckdb_free.
                                                           ## ```
    data*: pointer
    size*: idx_t
  duckdb_result* {.bycopy, importc, impduckdbHdr.} = object ## ```
                                                             ##   ! A query result consists of a pointer to its internal data.
                                                             ##     ! Must be freed with 'duckdb_destroy_result'.
                                                             ## ```
    deprecated_column_count*: idx_t ## ```
                                    ##   deprecated, use duckdb_column_count
                                    ## ```
    deprecated_row_count*: idx_t ## ```
                                 ##   deprecated, use duckdb_row_count
                                 ## ```
    deprecated_rows_changed*: idx_t ## ```
                                    ##   deprecated, use duckdb_rows_changed
                                    ## ```
    deprecated_columns*: ptr duckdb_column ## ```
                                           ##   deprecated, use duckdb_column_*-family of functions
                                           ## ```
    deprecated_error_message*: cstring ## ```
                                       ##   deprecated, use duckdb_result_error
                                       ## ```
    internal_data*: pointer
  duckdb_database* {.bycopy, impduckdbHdr, importc: "struct _duckdb_database".} = object ## ```
                                                                                          ##   ! A database object. Should be closed with duckdb_close.
                                                                                          ## ```
    db*: pointer
  duckdb_connection* {.bycopy, impduckdbHdr,
                       importc: "struct _duckdb_connection".} = object ## ```
                                                                        ##   ! A connection to a duckdb database. Must be closed with duckdb_disconnect.
                                                                        ## ```
    conn*: pointer
  duckdb_prepared_statement* {.bycopy, impduckdbHdr,
                               importc: "struct _duckdb_prepared_statement".} = object ## ```
                                                                                        ##   ! A prepared statement is a parameterized query that allows you to bind parameters to it.
                                                                                        ##     ! Must be destroyed with duckdb_destroy_prepare.
                                                                                        ## ```
    prep*: pointer
  duckdb_extracted_statements* {.bycopy, impduckdbHdr,
                                 importc: "struct _duckdb_extracted_statements".} = object ## ```
                                                                                            ##   ! Extracted statements. Must be destroyed with duckdb_destroy_extracted.
                                                                                            ## ```
    extrac*: pointer
  duckdb_pending_result* {.bycopy, impduckdbHdr,
                           importc: "struct _duckdb_pending_result".} = object ## ```
                                                                                ##   ! The pending result represents an intermediate structure for a query that is not yet fully executed.
                                                                                ##     ! Must be destroyed with duckdb_destroy_pending.
                                                                                ## ```
    pend*: pointer
  duckdb_appender* {.bycopy, impduckdbHdr, importc: "struct _duckdb_appender".} = object ## ```
                                                                                          ##   ! The appender enables fast data loading into DuckDB.
                                                                                          ##     ! Must be destroyed with duckdb_appender_destroy.
                                                                                          ## ```
    appn*: pointer
  duckdb_config* {.bycopy, impduckdbHdr, importc: "struct _duckdb_config".} = object ## ```
                                                                                      ##   ! Can be used to provide start-up options for the DuckDB instance.
                                                                                      ##     ! Must be destroyed with duckdb_destroy_config.
                                                                                      ## ```
    cnfg*: pointer
  duckdb_logical_type* {.bycopy, impduckdbHdr,
                         importc: "struct _duckdb_logical_type".} = object ## ```
                                                                            ##   ! Holds an internal logical type.
                                                                            ##     ! Must be destroyed with duckdb_destroy_logical_type.
                                                                            ## ```
    lglt*: pointer
  duckdb_data_chunk* {.bycopy, impduckdbHdr,
                       importc: "struct _duckdb_data_chunk".} = object ## ```
                                                                        ##   ! Contains a data chunk from a duckdb_result.
                                                                        ##     ! Must be destroyed with duckdb_destroy_data_chunk.
                                                                        ## ```
    dtck*: pointer
  duckdb_value* {.bycopy, impduckdbHdr, importc: "struct _duckdb_value".} = object ## ```
                                                                                    ##   ! Holds a DuckDB value, which wraps a type.
                                                                                    ##     ! Must be destroyed with duckdb_destroy_value.
                                                                                    ## ```
    val*: pointer
  duckdb_table_function* {.importc, impduckdbHdr.} = pointer ## ```
                                                             ##   ===--------------------------------------------------------------------===
                                                             ##      Table function types
                                                             ##     ===--------------------------------------------------------------------===
                                                             ##     ! A table function. Must be destroyed with duckdb_destroy_table_function.
                                                             ## ```
  duckdb_bind_info* {.importc, impduckdbHdr.} = pointer ## ```
                                                        ##   ! The bind info of the function. When setting this info, it is necessary to pass a destroy-callback function.
                                                        ## ```
  duckdb_init_info* {.importc, impduckdbHdr.} = pointer ## ```
                                                        ##   ! Additional function init info. When setting this info, it is necessary to pass a destroy-callback function.
                                                        ## ```
  duckdb_function_info* {.importc, impduckdbHdr.} = pointer ## ```
                                                            ##   ! Additional function info. When setting this info, it is necessary to pass a destroy-callback function.
                                                            ## ```
  duckdb_table_function_bind_t* {.importc, impduckdbHdr.} = proc (
      info: duckdb_bind_info) {.cdecl.}
  duckdb_table_function_init_t* {.importc, impduckdbHdr.} = proc (
      info: duckdb_init_info) {.cdecl.}
  duckdb_table_function_t* {.importc, impduckdbHdr.} = proc (
      info: duckdb_function_info; output: duckdb_data_chunk) {.cdecl.}
  duckdb_replacement_scan_info* {.importc, impduckdbHdr.} = pointer ## ```
                                                                    ##   ===--------------------------------------------------------------------===
                                                                    ##      Replacement scan types
                                                                    ##     ===--------------------------------------------------------------------===
                                                                    ##     ! Additional replacement scan info. When setting this info, it is necessary to pass a destroy-callback function.
                                                                    ## ```
  duckdb_replacement_callback_t* {.importc, impduckdbHdr.} = proc (
      info: duckdb_replacement_scan_info; table_name: cstring; data: pointer) {.
      cdecl.}
  duckdb_arrow* {.bycopy, impduckdbHdr, importc: "struct _duckdb_arrow".} = object ## ```
                                                                                    ##   ===--------------------------------------------------------------------===
                                                                                    ##      Arrow-related types
                                                                                    ##     ===--------------------------------------------------------------------===
                                                                                    ##     ! Holds an arrow query result. Must be destroyed with duckdb_destroy_arrow.
                                                                                    ## ```
    arrw*: pointer
  duckdb_arrow_stream* {.bycopy, impduckdbHdr,
                         importc: "struct _duckdb_arrow_stream".} = object ## ```
                                                                            ##   ! Holds an arrow array stream. Must be destroyed with duckdb_destroy_arrow_stream.
                                                                            ## ```
    arrwstr*: pointer
  duckdb_arrow_schema* {.bycopy, impduckdbHdr,
                         importc: "struct _duckdb_arrow_schema".} = object ## ```
                                                                            ##   ! Holds an arrow schema. Remember to release the respective ArrowSchema object.
                                                                            ## ```
    arrs*: pointer
  duckdb_arrow_array* {.bycopy, impduckdbHdr,
                        importc: "struct _duckdb_arrow_array".} = object ## ```
                                                                          ##   ! Holds an arrow array. Remember to release the respective ArrowArray object.
                                                                          ## ```
    arra*: pointer
proc duckdb_open*(path: cstring; out_database: ptr duckdb_database): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Functions
                                  ##     ===--------------------------------------------------------------------===
                                  ##     ===--------------------------------------------------------------------===
                                  ##      Open/Connect
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Creates a new database or opens an existing database file stored at the given path.
                                  ##   If no path is given a new in-memory database is created instead.
                                  ##   The instantiated database should be closed with 'duckdb_close'.
                                  ##   
                                  ##   path: Path to the database file on disk, or nullptr or :memory: to open an in-memory database.
                                  ##   out_database: The result database object.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_open_ext*(path: cstring; out_database: ptr duckdb_database;
                      config: duckdb_config; out_error: ptr cstring): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Extended version of duckdb_open. Creates a new database or opens an existing database file stored at the given path.
                                  ##   The instantiated database should be closed with 'duckdb_close'.
                                  ##   
                                  ##   path: Path to the database file on disk, or nullptr or :memory: to open an in-memory database.
                                  ##   out_database: The result database object.
                                  ##   config: (Optional) configuration used to start up the database system.
                                  ##   out_error: If set and the function returns DuckDBError, this will contain the reason why the start-up failed.
                                  ##   Note that the error must be freed using duckdb_free.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_close*(database: ptr duckdb_database) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                                  ##   !
                                                                                  ##   Closes the specified database and de-allocates all memory allocated for that database.
                                                                                  ##   This should be called after you are done with any database allocated through duckdb_open or duckdb_open_ext.
                                                                                  ##   Note that failing to call duckdb_close (in case of e.g. a program crash) will not cause data corruption.
                                                                                  ##   Still, it is recommended to always correctly close a database object after you are done with it.
                                                                                  ##   
                                                                                  ##   database: The database object to shut down.
                                                                                  ## ```
proc duckdb_connect*(database: duckdb_database;
                     out_connection: ptr duckdb_connection): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Opens a connection to a database. Connections are required to query the database, and store transactional state
                                  ##   associated with the connection.
                                  ##   The instantiated connection should be closed using 'duckdb_disconnect'.
                                  ##   
                                  ##   database: The database file to connect to.
                                  ##   out_connection: The result connection object.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_interrupt*(connection: duckdb_connection) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Interrupt running query
                  ##   
                  ##   connection: The connection to interrupt
                  ## ```
proc duckdb_query_progress*(connection: duckdb_connection): duckdb_query_progress_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Get progress of the running query
                                  ##   
                                  ##   connection: The working connection
                                  ##   returns: -1 if no progress or a percentage of the progress
                                  ## ```
proc duckdb_disconnect*(connection: ptr duckdb_connection) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Closes the specified connection and de-allocates all memory allocated for that connection.
                  ##   
                  ##   connection: The connection to close.
                  ## ```
proc duckdb_library_version*(): cstring {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                        ##   !
                                                                        ##   Returns the version of the linked DuckDB, with a version postfix for dev versions
                                                                        ##   
                                                                        ##   Usually used for developing C extensions that must return this for a compatibility check.
                                                                        ## ```
proc duckdb_create_config*(out_config: ptr duckdb_config): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Configuration
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Initializes an empty configuration object that can be used to provide start-up options for the DuckDB instance
                                  ##   through duckdb_open_ext.
                                  ##   The duckdb_config must be destroyed using 'duckdb_destroy_config'
                                  ##   
                                  ##   This will always succeed unless there is a malloc failure.
                                  ##   
                                  ##   out_config: The result configuration object.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_config_count*(): uint {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                  ##   !
                                                                  ##   This returns the total amount of configuration options available for usage with duckdb_get_config_flag.
                                                                  ##   
                                                                  ##   This should not be called in a loop as it internally loops over all the options.
                                                                  ##   
                                                                  ##   returns: The amount of config options available.
                                                                  ## ```
proc duckdb_get_config_flag*(index: uint; out_name: ptr cstring;
                             out_description: ptr cstring): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Obtains a human-readable name and description of a specific configuration option. This can be used to e.g.
                                  ##   display configuration options. This will succeed unless index is out of range (i.e. >= duckdb_config_count).
                                  ##   
                                  ##   The result name or description MUST NOT be freed.
                                  ##   
                                  ##   index: The index of the configuration option (between 0 and duckdb_config_count)
                                  ##   out_name: A name of the configuration flag.
                                  ##   out_description: A description of the configuration flag.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_set_config*(config: duckdb_config; name: cstring; option: cstring): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the specified option for the specified configuration. The configuration option is indicated by name.
                                  ##   To obtain a list of config options, see duckdb_get_config_flag.
                                  ##   
                                  ##   In the source code, configuration options are defined in config.cpp.
                                  ##   
                                  ##   This can fail if either the name is invalid, or if the value provided for the option is invalid.
                                  ##   
                                  ##   duckdb_config: The configuration object to set the option on.
                                  ##   name: The name of the configuration flag to set.
                                  ##   option: The value to set the configuration flag to.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_destroy_config*(config: ptr duckdb_config) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Destroys the specified configuration object and de-allocates all memory allocated for the object.
                  ##   
                  ##   config: The configuration object to destroy.
                  ## ```
proc duckdb_query*(connection: duckdb_connection; query: cstring;
                   out_result: ptr duckdb_result): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   ===--------------------------------------------------------------------===
                         ##      Query Execution
                         ##     ===--------------------------------------------------------------------===
                         ##     !
                         ##   Executes a SQL query within a connection and stores the full (materialized) result in the out_result pointer.
                         ##   If the query fails to execute, DuckDBError is returned and the error message can be retrieved by calling
                         ##   duckdb_result_error.
                         ##   
                         ##   Note that after running duckdb_query, duckdb_destroy_result must be called on the result object even if the
                         ##   query fails, otherwise the error stored within the result will not be freed correctly.
                         ##   
                         ##   connection: The connection to perform the query in.
                         ##   query: The SQL query to run.
                         ##   out_result: The query result.
                         ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                         ## ```
proc duckdb_destroy_result*(result: ptr duckdb_result) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Closes the result and de-allocates all memory allocated for that connection.
                  ##   
                  ##   result: The result to destroy.
                  ## ```
proc duckdb_column_name*(result: ptr duckdb_result; col: idx_t): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the column name of the specified column. The result should not need to be freed; the column names will
                                  ##   automatically be destroyed when the result is destroyed.
                                  ##   
                                  ##   Returns NULL if the column is out of range.
                                  ##   
                                  ##   result: The result object to fetch the column name from.
                                  ##   col: The column index.
                                  ##   returns: The column name of the specified column.
                                  ## ```
proc duckdb_column_type*(result: ptr duckdb_result; col: idx_t): duckdb_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the column type of the specified column.
                                  ##   
                                  ##   Returns DUCKDB_TYPE_INVALID if the column is out of range.
                                  ##   
                                  ##   result: The result object to fetch the column type from.
                                  ##   col: The column index.
                                  ##   returns: The column type of the specified column.
                                  ## ```
proc duckdb_result_statement_type*(result: duckdb_result): duckdb_statement_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the statement type of the statement that was executed
                                  ##   
                                  ##   result: The result object to fetch the statement type from.
                                  ##    returns: duckdb_statement_type value or DUCKDB_STATEMENT_TYPE_INVALID
                                  ## ```
proc duckdb_column_logical_type*(result: ptr duckdb_result; col: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the logical column type of the specified column.
                                  ##   
                                  ##   The return type of this call should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   Returns NULL if the column is out of range.
                                  ##   
                                  ##   result: The result object to fetch the column type from.
                                  ##   col: The column index.
                                  ##   returns: The logical column type of the specified column.
                                  ## ```
proc duckdb_column_count*(result: ptr duckdb_result): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of columns present in a the result object.
                  ##   
                  ##   result: The result object.
                  ##   returns: The number of columns present in the result object.
                  ## ```
proc duckdb_row_count*(result: ptr duckdb_result): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of rows present in the result object.
                  ##   
                  ##   result: The result object.
                  ##   returns: The number of rows present in the result object.
                  ## ```
proc duckdb_rows_changed*(result: ptr duckdb_result): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of rows changed by the query stored in the result. This is relevant only for INSERT/UPDATE/DELETE
                  ##   queries. For other queries the rows_changed will be 0.
                  ##   
                  ##   result: The result object.
                  ##   returns: The number of rows changed.
                  ## ```
proc duckdb_column_data*(result: ptr duckdb_result; col: idx_t): pointer {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##  *DEPRECATED**: Prefer using duckdb_result_get_chunk instead.
                                  ##   
                                  ##   Returns the data of a specific column of a result in columnar format.
                                  ##   
                                  ##   The function returns a dense array which contains the result data. The exact type stored in the array depends on the
                                  ##   corresponding duckdb_type (as provided by duckdb_column_type). For the exact type by which the data should be
                                  ##   accessed, see the comments in [the types section](types) or the DUCKDB_TYPE enum.
                                  ##   
                                  ##   For example, for a column of type DUCKDB_TYPE_INTEGER, rows can be accessed in the following manner:
                                  ##   c
                                  ##   int32_tdata = (int32_t) duckdb_column_data(&result, 0);
                                  ##   printf("Data for row %d: %d\n", row, data[row]);
                                  ##   
                                  ##   
                                  ##   result: The result object to fetch the column data from.
                                  ##   col: The column index.
                                  ##   returns: The column data of the specified column.
                                  ## ```
proc duckdb_nullmask_data*(result: ptr duckdb_result; col: idx_t): ptr bool {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##  *DEPRECATED**: Prefer using duckdb_result_get_chunk instead.
                                  ##   
                                  ##   Returns the nullmask of a specific column of a result in columnar format. The nullmask indicates for every row
                                  ##   whether or not the corresponding row is NULL. If a row is NULL, the values present in the array provided
                                  ##   by duckdb_column_data are undefined.
                                  ##   
                                  ##   c
                                  ##   int32_tdata = (int32_t) duckdb_column_data(&result, 0);
                                  ##   boolnullmask = duckdb_nullmask_data(&result, 0);
                                  ##   if (nullmask[row]) {
                                  ##       printf("Data for row %d: NULL\n", row);
                                  ##   } else {
                                  ##       printf("Data for row %d: %d\n", row, data[row]);
                                  ##   }
                                  ##   
                                  ##   
                                  ##   result: The result object to fetch the nullmask from.
                                  ##   col: The column index.
                                  ##   returns: The nullmask of the specified column.
                                  ## ```
proc duckdb_result_error*(result: ptr duckdb_result): cstring {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the error message contained within the result. The error is only set if duckdb_query returns DuckDBError.
                  ##   
                  ##   The result of this function must not be freed. It will be cleaned up when duckdb_destroy_result is called.
                  ##   
                  ##   result: The result object to fetch the error from.
                  ##   returns: The error of the result.
                  ## ```
proc duckdb_result_get_chunk*(result: duckdb_result; chunk_index: idx_t): duckdb_data_chunk {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Result Functions
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Fetches a data chunk from the duckdb_result. This function should be called repeatedly until the result is exhausted.
                                  ##   
                                  ##   The result must be destroyed with duckdb_destroy_data_chunk.
                                  ##   
                                  ##   This function supersedes all duckdb_value functions, as well as the duckdb_column_data and duckdb_nullmask_data
                                  ##   functions. It results in significantly better performance, and should be preferred in newer code-bases.
                                  ##   
                                  ##   If this function is used, none of the other result functions can be used and vice versa (i.e. this function cannot be
                                  ##   mixed with the legacy result functions).
                                  ##   
                                  ##   Use duckdb_result_chunk_count to figure out how many chunks there are in the result.
                                  ##   
                                  ##   result: The result object to fetch the data chunk from.
                                  ##   chunk_index: The chunk index to fetch from.
                                  ##   returns: The resulting data chunk. Returns NULL if the chunk index is out of bounds.
                                  ## ```
proc duckdb_result_is_streaming*(result: duckdb_result): bool {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Checks if the type of the internal result is StreamQueryResult.
                  ##   
                  ##   result: The result object to check.
                  ##   returns: Whether or not the result object is of the type StreamQueryResult
                  ## ```
proc duckdb_result_chunk_count*(result: duckdb_result): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of data chunks present in the result.
                  ##   
                  ##   result: The result object
                  ##   returns: Number of data chunks present in the result.
                  ## ```
proc duckdb_result_return_type*(result: duckdb_result): duckdb_result_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the return_type of the given result, or DUCKDB_RETURN_TYPE_INVALID on error
                                  ##   
                                  ##   result: The result object
                                  ##   returns: The return_type
                                  ## ```
proc duckdb_value_boolean*(result: ptr duckdb_result; col: idx_t; row: idx_t): bool {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Safe fetch functions
                                  ##     ===--------------------------------------------------------------------===
                                  ##      These functions will perform conversions if necessary.
                                  ##      On failure (e.g. if conversion cannot be performed or if the value is NULL) a default value is returned.
                                  ##      Note that these functions are slow since they perform bounds checking and conversion
                                  ##      For fast access of values prefer using duckdb_result_get_chunk
                                  ##     !
                                  ##    returns: The boolean value at the specified location, or false if the value cannot be converted.
                                  ## ```
proc duckdb_value_int8*(result: ptr duckdb_result; col: idx_t; row: idx_t): int8 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The int8_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_int16*(result: ptr duckdb_result; col: idx_t; row: idx_t): int16 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The int16_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_int32*(result: ptr duckdb_result; col: idx_t; row: idx_t): int32 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The int32_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_int64*(result: ptr duckdb_result; col: idx_t; row: idx_t): int64 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The int64_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_hugeint*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_hugeint {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_hugeint value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_uhugeint*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_uhugeint {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_uhugeint value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_decimal*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_decimal {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_decimal value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_uint8*(result: ptr duckdb_result; col: idx_t; row: idx_t): uint8 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The uint8_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_uint16*(result: ptr duckdb_result; col: idx_t; row: idx_t): uint16 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The uint16_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_uint32*(result: ptr duckdb_result; col: idx_t; row: idx_t): uint32 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The uint32_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_uint64*(result: ptr duckdb_result; col: idx_t; row: idx_t): uint64 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The uint64_t value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_float*(result: ptr duckdb_result; col: idx_t; row: idx_t): cfloat {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The float value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_double*(result: ptr duckdb_result; col: idx_t; row: idx_t): cdouble {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The double value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_date*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_date {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_date value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_time*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_time {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_time value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_timestamp*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_timestamp {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_timestamp value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_interval*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_interval {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The duckdb_interval value at the specified location, or 0 if the value cannot be converted.
                                  ## ```
proc duckdb_value_varchar*(result: ptr duckdb_result; col: idx_t; row: idx_t): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   DEPRECATED: use duckdb_value_string instead. This function does not work correctly if the string contains null bytes.
                                  ##   returns: The text value at the specified location as a null-terminated string, or nullptr if the value cannot be
                                  ##   converted. The result must be freed with duckdb_free.
                                  ## ```
proc duckdb_value_string*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_string {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: The string value at the specified location.
                                  ##    The resulting field "string.data" must be freed with duckdb_free.
                                  ## ```
proc duckdb_value_varchar_internal*(result: ptr duckdb_result; col: idx_t;
                                    row: idx_t): cstring {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   DEPRECATED: use duckdb_value_string_internal instead. This function does not work correctly if the string contains
                  ##   null bytes.
                  ##   returns: The char* value at the specified location. ONLY works on VARCHAR columns and does not auto-cast.
                  ##   If the column is NOT a VARCHAR column this function will return NULL.
                  ##   
                  ##   The result must NOT be freed.
                  ## ```
proc duckdb_value_string_internal*(result: ptr duckdb_result; col: idx_t;
                                   row: idx_t): duckdb_string {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   DEPRECATED: use duckdb_value_string_internal instead. This function does not work correctly if the string contains
                  ##   null bytes.
                  ##   returns: The char* value at the specified location. ONLY works on VARCHAR columns and does not auto-cast.
                  ##   If the column is NOT a VARCHAR column this function will return NULL.
                  ##   
                  ##   The result must NOT be freed.
                  ## ```
proc duckdb_value_blob*(result: ptr duckdb_result; col: idx_t; row: idx_t): duckdb_blob {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   returns: The duckdb_blob value at the specified location. Returns a blob with blob.data set to nullptr if the
                                  ##   value cannot be converted. The resulting field "blob.data" must be freed with duckdb_free.
                                  ## ```
proc duckdb_value_is_null*(result: ptr duckdb_result; col: idx_t; row: idx_t): bool {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##    returns: Returns true if the value at the specified index is NULL, and false otherwise.
                                  ## ```
proc duckdb_malloc*(size: uint): pointer {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                         ##   ===--------------------------------------------------------------------===
                                                                         ##      Helpers
                                                                         ##     ===--------------------------------------------------------------------===
                                                                         ##     !
                                                                         ##   Allocate size bytes of memory using the duckdb internal malloc function. Any memory allocated in this manner
                                                                         ##   should be freed using duckdb_free.
                                                                         ##   
                                                                         ##   size: The number of bytes to allocate.
                                                                         ##   returns: A pointer to the allocated memory region.
                                                                         ## ```
proc duckdb_free*(`ptr`: pointer) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                  ##   !
                                                                  ##   Free a value returned from duckdb_malloc, duckdb_value_varchar, duckdb_value_blob, or
                                                                  ##   duckdb_value_string.
                                                                  ##   
                                                                  ##   ptr: The memory region to de-allocate.
                                                                  ## ```
proc duckdb_vector_size*(): idx_t {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                  ##   !
                                                                  ##   The internal vector size used by DuckDB.
                                                                  ##   This is the amount of tuples that will fit into a data chunk created by duckdb_create_data_chunk.
                                                                  ##   
                                                                  ##   returns: The vector size.
                                                                  ## ```
proc duckdb_string_is_inlined*(string: duckdb_string_t): bool {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Whether or not the duckdb_string_t value is inlined.
                  ##   This means that the data of the string does not have a separate allocation.
                  ## ```
proc duckdb_from_date*(date: duckdb_date): duckdb_date_struct {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   ===--------------------------------------------------------------------===
                  ##      Date/Time/Timestamp Helpers
                  ##     ===--------------------------------------------------------------------===
                  ##     !
                  ##   Decompose a duckdb_date object into year, month and date (stored as duckdb_date_struct).
                  ##   
                  ##   date: The date object, as obtained from a DUCKDB_TYPE_DATE column.
                  ##   returns: The duckdb_date_struct with the decomposed elements.
                  ## ```
proc duckdb_to_date*(date: duckdb_date_struct): duckdb_date {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Re-compose a duckdb_date from year, month and date (duckdb_date_struct).
                  ##   
                  ##   date: The year, month and date stored in a duckdb_date_struct.
                  ##   returns: The duckdb_date element.
                  ## ```
proc duckdb_is_finite_date*(date: duckdb_date): bool {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Test a duckdb_date to see if it is a finite value.
                  ##   
                  ##   date: The date object, as obtained from a DUCKDB_TYPE_DATE column.
                  ##   returns: True if the date is finite, false if it is ±infinity.
                  ## ```
proc duckdb_from_time*(time: duckdb_time): duckdb_time_struct {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Decompose a duckdb_time object into hour, minute, second and microsecond (stored as duckdb_time_struct).
                  ##   
                  ##   time: The time object, as obtained from a DUCKDB_TYPE_TIME column.
                  ##   returns: The duckdb_time_struct with the decomposed elements.
                  ## ```
proc duckdb_create_time_tz*(micros: int64; offset: int32): duckdb_time_tz {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Create a duckdb_time_tz object from micros and a timezone offset.
                                  ##   
                                  ##   micros: The microsecond component of the time.
                                  ##   offset: The timezone offset component of the time.
                                  ##   returns: The duckdb_time_tz element.
                                  ## ```
proc duckdb_from_time_tz*(micros: duckdb_time_tz): duckdb_time_tz_struct {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Decompose a TIME_TZ objects into micros and a timezone offset.
                                  ##   
                                  ##   Use duckdb_from_time to further decompose the micros into hour, minute, second and microsecond.
                                  ##   
                                  ##   micros: The time object, as obtained from a DUCKDB_TYPE_TIME_TZ column.
                                  ##   out_micros: The microsecond component of the time.
                                  ##   out_offset: The timezone offset component of the time.
                                  ## ```
proc duckdb_to_time*(time: duckdb_time_struct): duckdb_time {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Re-compose a duckdb_time from hour, minute, second and microsecond (duckdb_time_struct).
                  ##   
                  ##   time: The hour, minute, second and microsecond in a duckdb_time_struct.
                  ##   returns: The duckdb_time element.
                  ## ```
proc duckdb_from_timestamp*(ts: duckdb_timestamp): duckdb_timestamp_struct {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Decompose a duckdb_timestamp object into a duckdb_timestamp_struct.
                                  ##   
                                  ##   ts: The ts object, as obtained from a DUCKDB_TYPE_TIMESTAMP column.
                                  ##   returns: The duckdb_timestamp_struct with the decomposed elements.
                                  ## ```
proc duckdb_to_timestamp*(ts: duckdb_timestamp_struct): duckdb_timestamp {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Re-compose a duckdb_timestamp from a duckdb_timestamp_struct.
                                  ##   
                                  ##   ts: The de-composed elements in a duckdb_timestamp_struct.
                                  ##   returns: The duckdb_timestamp element.
                                  ## ```
proc duckdb_is_finite_timestamp*(ts: duckdb_timestamp): bool {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Test a duckdb_timestamp to see if it is a finite value.
                  ##   
                  ##   ts: The timestamp object, as obtained from a DUCKDB_TYPE_TIMESTAMP column.
                  ##   returns: True if the timestamp is finite, false if it is ±infinity.
                  ## ```
proc duckdb_hugeint_to_double*(val: duckdb_hugeint): cdouble {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   ===--------------------------------------------------------------------===
                  ##      Hugeint Helpers
                  ##     ===--------------------------------------------------------------------===
                  ##     !
                  ##   Converts a duckdb_hugeint object (as obtained from a DUCKDB_TYPE_HUGEINT column) into a double.
                  ##   
                  ##   val: The hugeint value.
                  ##   returns: The converted double element.
                  ## ```
proc duckdb_double_to_hugeint*(val: cdouble): duckdb_hugeint {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Converts a double value to a duckdb_hugeint object.
                  ##   
                  ##   If the conversion fails because the double value is too big the result will be 0.
                  ##   
                  ##   val: The double value.
                  ##   returns: The converted duckdb_hugeint element.
                  ## ```
proc duckdb_uhugeint_to_double*(val: duckdb_uhugeint): cdouble {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   ===--------------------------------------------------------------------===
                  ##      Unsigned Hugeint Helpers
                  ##     ===--------------------------------------------------------------------===
                  ##     !
                  ##   Converts a duckdb_uhugeint object (as obtained from a DUCKDB_TYPE_UHUGEINT column) into a double.
                  ##   
                  ##   val: The uhugeint value.
                  ##   returns: The converted double element.
                  ## ```
proc duckdb_double_to_uhugeint*(val: cdouble): duckdb_uhugeint {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Converts a double value to a duckdb_uhugeint object.
                  ##   
                  ##   If the conversion fails because the double value is too big the result will be 0.
                  ##   
                  ##   val: The double value.
                  ##   returns: The converted duckdb_uhugeint element.
                  ## ```
proc duckdb_double_to_decimal*(val: cdouble; width: uint8; scale: uint8): duckdb_decimal {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Decimal Helpers
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Converts a double value to a duckdb_decimal object.
                                  ##   
                                  ##   If the conversion fails because the double value is too big, or the width/scale are invalid the result will be 0.
                                  ##   
                                  ##   val: The double value.
                                  ##   returns: The converted duckdb_decimal element.
                                  ## ```
proc duckdb_decimal_to_double*(val: duckdb_decimal): cdouble {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Converts a duckdb_decimal object (as obtained from a DUCKDB_TYPE_DECIMAL column) into a double.
                  ##   
                  ##   val: The decimal value.
                  ##   returns: The converted double element.
                  ## ```
proc duckdb_prepare*(connection: duckdb_connection; query: cstring;
                     out_prepared_statement: ptr duckdb_prepared_statement): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Prepared Statements
                                  ##     ===--------------------------------------------------------------------===
                                  ##      A prepared statement is a parameterized query that allows you to bind parameters to it.
                                  ##      This is useful to easily supply parameters to functions and avoid SQL injection attacks.
                                  ##      This is useful to speed up queries that you will execute several times with different parameters.
                                  ##      Because the query will only be parsed, bound, optimized and planned once during the prepare stage,
                                  ##      rather than once per execution.
                                  ##      For example:
                                  ##        SELECT FROM tbl WHERE id=?
                                  ##      Or a query with multiple parameters:
                                  ##        SELECT FROM tbl WHERE id=$1 OR name=$2
                                  ##     !
                                  ##   Create a prepared statement object from a query.
                                  ##   
                                  ##   Note that after calling duckdb_prepare, the prepared statement should always be destroyed using
                                  ##   duckdb_destroy_prepare, even if the prepare fails.
                                  ##   
                                  ##   If the prepare fails, duckdb_prepare_error can be called to obtain the reason why the prepare failed.
                                  ##   
                                  ##   connection: The connection object
                                  ##   query: The SQL query to prepare
                                  ##   out_prepared_statement: The resulting prepared statement object
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_destroy_prepare*(prepared_statement: ptr duckdb_prepared_statement) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Closes the prepared statement and de-allocates all memory allocated for the statement.
                                  ##   
                                  ##   prepared_statement: The prepared statement to destroy.
                                  ## ```
proc duckdb_prepare_error*(prepared_statement: duckdb_prepared_statement): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the error message associated with the given prepared statement.
                                  ##   If the prepared statement has no error message, this returns nullptr instead.
                                  ##   
                                  ##   The error message should not be freed. It will be de-allocated when duckdb_destroy_prepare is called.
                                  ##   
                                  ##   prepared_statement: The prepared statement to obtain the error from.
                                  ##   returns: The error message, or nullptr if there is none.
                                  ## ```
proc duckdb_nparams*(prepared_statement: duckdb_prepared_statement): idx_t {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the number of parameters that can be provided to the given prepared statement.
                                  ##   
                                  ##   Returns 0 if the query was not successfully prepared.
                                  ##   
                                  ##   prepared_statement: The prepared statement to obtain the number of parameters for.
                                  ## ```
proc duckdb_parameter_name*(prepared_statement: duckdb_prepared_statement;
                            index: idx_t): cstring {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the name used to identify the parameter
                  ##   The returned string should be freed using duckdb_free.
                  ##   
                  ##   Returns NULL if the index is out of range for the provided prepared statement.
                  ##   
                  ##   prepared_statement: The prepared statement for which to get the parameter name from.
                  ## ```
proc duckdb_param_type*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t): duckdb_type {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the parameter type for the parameter at the given index.
                  ##   
                  ##   Returns DUCKDB_TYPE_INVALID if the parameter index is out of range or the statement was not successfully prepared.
                  ##   
                  ##   prepared_statement: The prepared statement.
                  ##   param_idx: The parameter index.
                  ##   returns: The parameter type
                  ## ```
proc duckdb_clear_bindings*(prepared_statement: duckdb_prepared_statement): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Clear the params bind to the prepared statement.
                                  ## ```
proc duckdb_prepared_statement_type*(statement: duckdb_prepared_statement): duckdb_statement_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the statement type of the statement to be executed
                                  ##   
                                  ##    statement: The prepared statement.
                                  ##    returns: duckdb_statement_type value or DUCKDB_STATEMENT_TYPE_INVALID
                                  ## ```
proc duckdb_bind_value*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t; val: duckdb_value): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Bind Values to Prepared Statements
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Binds a value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_parameter_index*(prepared_statement: duckdb_prepared_statement;
                                  param_idx_out: ptr idx_t; name: cstring): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieve the index of the parameter for the prepared statement, identified by name
                                  ## ```
proc duckdb_bind_boolean*(prepared_statement: duckdb_prepared_statement;
                          param_idx: idx_t; val: bool): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds a bool value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_int8*(prepared_statement: duckdb_prepared_statement;
                       param_idx: idx_t; val: int8): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an int8_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_int16*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t; val: int16): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an int16_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_int32*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t; val: int32): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an int32_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_int64*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t; val: int64): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an int64_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_hugeint*(prepared_statement: duckdb_prepared_statement;
                          param_idx: idx_t; val: duckdb_hugeint): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a duckdb_hugeint value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_uhugeint*(prepared_statement: duckdb_prepared_statement;
                           param_idx: idx_t; val: duckdb_uhugeint): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds an duckdb_uhugeint value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_decimal*(prepared_statement: duckdb_prepared_statement;
                          param_idx: idx_t; val: duckdb_decimal): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a duckdb_decimal value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_uint8*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t; val: uint8): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an uint8_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_uint16*(prepared_statement: duckdb_prepared_statement;
                         param_idx: idx_t; val: uint16): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an uint16_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_uint32*(prepared_statement: duckdb_prepared_statement;
                         param_idx: idx_t; val: uint32): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an uint32_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_uint64*(prepared_statement: duckdb_prepared_statement;
                         param_idx: idx_t; val: uint64): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds an uint64_t value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_float*(prepared_statement: duckdb_prepared_statement;
                        param_idx: idx_t; val: cfloat): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Binds a float value to the prepared statement at the specified index.
                         ## ```
proc duckdb_bind_double*(prepared_statement: duckdb_prepared_statement;
                         param_idx: idx_t; val: cdouble): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a double value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_date*(prepared_statement: duckdb_prepared_statement;
                       param_idx: idx_t; val: duckdb_date): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a duckdb_date value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_time*(prepared_statement: duckdb_prepared_statement;
                       param_idx: idx_t; val: duckdb_time): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a duckdb_time value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_timestamp*(prepared_statement: duckdb_prepared_statement;
                            param_idx: idx_t; val: duckdb_timestamp): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a duckdb_timestamp value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_interval*(prepared_statement: duckdb_prepared_statement;
                           param_idx: idx_t; val: duckdb_interval): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a duckdb_interval value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_varchar*(prepared_statement: duckdb_prepared_statement;
                          param_idx: idx_t; val: cstring): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a null-terminated varchar value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_varchar_length*(prepared_statement: duckdb_prepared_statement;
                                 param_idx: idx_t; val: cstring; length: idx_t): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a varchar value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_blob*(prepared_statement: duckdb_prepared_statement;
                       param_idx: idx_t; data: pointer; length: idx_t): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Binds a blob value to the prepared statement at the specified index.
                                  ## ```
proc duckdb_bind_null*(prepared_statement: duckdb_prepared_statement;
                       param_idx: idx_t): duckdb_state {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Binds a NULL value to the prepared statement at the specified index.
                  ## ```
proc duckdb_execute_prepared*(prepared_statement: duckdb_prepared_statement;
                              out_result: ptr duckdb_result): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Execute Prepared Statements
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Executes the prepared statement with the given bound parameters, and returns a materialized query result.
                                  ##   
                                  ##   This method can be called multiple times for each prepared statement, and the parameters can be modified
                                  ##   between calls to this function.
                                  ##   
                                  ##   Note that the result must be freed with duckdb_destroy_result.
                                  ##   
                                  ##   prepared_statement: The prepared statement to execute.
                                  ##   out_result: The query result.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_execute_prepared_streaming*(prepared_statement: duckdb_prepared_statement;
                                        out_result: ptr duckdb_result): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Executes the prepared statement with the given bound parameters, and returns an optionally-streaming query result.
                                  ##   To determine if the resulting query was in fact streamed, use duckdb_result_is_streaming
                                  ##   
                                  ##   This method can be called multiple times for each prepared statement, and the parameters can be modified
                                  ##   between calls to this function.
                                  ##   
                                  ##   Note that the result must be freed with duckdb_destroy_result.
                                  ##   
                                  ##   prepared_statement: The prepared statement to execute.
                                  ##   out_result: The query result.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_extract_statements*(connection: duckdb_connection; query: cstring;
    out_extracted_statements: ptr duckdb_extracted_statements): idx_t {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   ===--------------------------------------------------------------------===
                         ##      Extract Statements
                         ##     ===--------------------------------------------------------------------===
                         ##      A query string can be extracted into multiple SQL statements. Each statement can be prepared and executed separately.
                         ##     !
                         ##   Extract all statements from a query.
                         ##   Note that after calling duckdb_extract_statements, the extracted statements should always be destroyed using
                         ##   duckdb_destroy_extracted, even if no statements were extracted.
                         ##   
                         ##   If the extract fails, duckdb_extract_statements_error can be called to obtain the reason why the extract failed.
                         ##   
                         ##   connection: The connection object
                         ##   query: The SQL query to extract
                         ##   out_extracted_statements: The resulting extracted statements object
                         ##   returns: The number of extracted statements or 0 on failure.
                         ## ```
proc duckdb_prepare_extracted_statement*(connection: duckdb_connection;
    extracted_statements: duckdb_extracted_statements; index: idx_t;
    out_prepared_statement: ptr duckdb_prepared_statement): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Prepare an extracted statement.
                                  ##   Note that after calling duckdb_prepare_extracted_statement, the prepared statement should always be destroyed using
                                  ##   duckdb_destroy_prepare, even if the prepare fails.
                                  ##   
                                  ##   If the prepare fails, duckdb_prepare_error can be called to obtain the reason why the prepare failed.
                                  ##   
                                  ##   connection: The connection object
                                  ##   extracted_statements: The extracted statements object
                                  ##   index: The index of the extracted statement to prepare
                                  ##   out_prepared_statement: The resulting prepared statement object
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_extract_statements_error*(extracted_statements: duckdb_extracted_statements): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the error message contained within the extracted statements.
                                  ##   The result of this function must not be freed. It will be cleaned up when duckdb_destroy_extracted is called.
                                  ##   
                                  ##   result: The extracted statements to fetch the error from.
                                  ##   returns: The error of the extracted statements.
                                  ## ```
proc duckdb_destroy_extracted*(extracted_statements: ptr duckdb_extracted_statements) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   De-allocates all memory allocated for the extracted statements.
                                  ##   extracted_statements: The extracted statements to destroy.
                                  ## ```
proc duckdb_pending_prepared*(prepared_statement: duckdb_prepared_statement;
                              out_result: ptr duckdb_pending_result): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Pending Result Interface
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Executes the prepared statement with the given bound parameters, and returns a pending result.
                                  ##   The pending result represents an intermediate structure for a query that is not yet fully executed.
                                  ##   The pending result can be used to incrementally execute a query, returning control to the client between tasks.
                                  ##   
                                  ##   Note that after calling duckdb_pending_prepared, the pending result should always be destroyed using
                                  ##   duckdb_destroy_pending, even if this function returns DuckDBError.
                                  ##   
                                  ##   prepared_statement: The prepared statement to execute.
                                  ##   out_result: The pending query result.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_pending_prepared_streaming*(prepared_statement: duckdb_prepared_statement;
                                        out_result: ptr duckdb_pending_result): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Executes the prepared statement with the given bound parameters, and returns a pending result.
                                  ##   This pending result will create a streaming duckdb_result when executed.
                                  ##   The pending result represents an intermediate structure for a query that is not yet fully executed.
                                  ##   
                                  ##   Note that after calling duckdb_pending_prepared_streaming, the pending result should always be destroyed using
                                  ##   duckdb_destroy_pending, even if this function returns DuckDBError.
                                  ##   
                                  ##   prepared_statement: The prepared statement to execute.
                                  ##   out_result: The pending query result.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_destroy_pending*(pending_result: ptr duckdb_pending_result) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Closes the pending result and de-allocates all memory allocated for the result.
                                  ##   
                                  ##   pending_result: The pending result to destroy.
                                  ## ```
proc duckdb_pending_error*(pending_result: duckdb_pending_result): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the error message contained within the pending result.
                                  ##   
                                  ##   The result of this function must not be freed. It will be cleaned up when duckdb_destroy_pending is called.
                                  ##   
                                  ##   result: The pending result to fetch the error from.
                                  ##   returns: The error of the pending result.
                                  ## ```
proc duckdb_pending_execute_task*(pending_result: duckdb_pending_result): duckdb_pending_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Executes a single task within the query, returning whether or not the query is ready.
                                  ##   
                                  ##   If this returns DUCKDB_PENDING_RESULT_READY, the duckdb_execute_pending function can be called to obtain the result.
                                  ##   If this returns DUCKDB_PENDING_RESULT_NOT_READY, the duckdb_pending_execute_task function should be called again.
                                  ##   If this returns DUCKDB_PENDING_ERROR, an error occurred during execution.
                                  ##   
                                  ##   The error message can be obtained by calling duckdb_pending_error on the pending_result.
                                  ##   
                                  ##   pending_result: The pending result to execute a task within.
                                  ##   returns: The state of the pending result after the execution.
                                  ## ```
proc duckdb_pending_execute_check_state*(pending_result: duckdb_pending_result): duckdb_pending_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   If this returns DUCKDB_PENDING_RESULT_READY, the duckdb_execute_pending function can be called to obtain the result.
                                  ##   If this returns DUCKDB_PENDING_RESULT_NOT_READY, the duckdb_pending_execute_check_state function should be called again.
                                  ##   If this returns DUCKDB_PENDING_ERROR, an error occurred during execution.
                                  ##   
                                  ##   The error message can be obtained by calling duckdb_pending_error on the pending_result.
                                  ##   
                                  ##   pending_result: The pending result.
                                  ##   returns: The state of the pending result.
                                  ## ```
proc duckdb_execute_pending*(pending_result: duckdb_pending_result;
                             out_result: ptr duckdb_result): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Fully execute a pending query result, returning the final query result.
                                  ##   
                                  ##   If duckdb_pending_execute_task has been called until DUCKDB_PENDING_RESULT_READY was returned, this will return fast.
                                  ##   Otherwise, all remaining tasks must be executed first.
                                  ##   
                                  ##   Note that the result must be freed with duckdb_destroy_result.
                                  ##   
                                  ##   pending_result: The pending result to execute.
                                  ##   out_result: The result object.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_pending_execution_is_finished*(pending_state: duckdb_pending_state): bool {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns whether a duckdb_pending_state is finished executing. For example if pending_state is
                                  ##   DUCKDB_PENDING_RESULT_READY, this function will return true.
                                  ##   
                                  ##   pending_state: The pending state on which to decide whether to finish execution.
                                  ##   returns: Boolean indicating pending execution should be considered finished.
                                  ## ```
proc duckdb_destroy_value*(value: ptr duckdb_value) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   ===--------------------------------------------------------------------===
                  ##      Value Interface
                  ##     ===--------------------------------------------------------------------===
                  ##     !
                  ##   Destroys the value and de-allocates all memory allocated for that type.
                  ##   
                  ##   value: The value to destroy.
                  ## ```
proc duckdb_create_varchar*(text: cstring): duckdb_value {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Creates a value from a null-terminated string
                  ##   
                  ##   value: The null-terminated string
                  ##   returns: The value. This must be destroyed with duckdb_destroy_value.
                  ## ```
proc duckdb_create_varchar_length*(text: cstring; length: idx_t): duckdb_value {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a value from a string
                                  ##   
                                  ##   value: The text
                                  ##   length: The length of the text
                                  ##   returns: The value. This must be destroyed with duckdb_destroy_value.
                                  ## ```
proc duckdb_create_int64*(val: int64): duckdb_value {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Creates a value from an int64
                  ##   
                  ##   value: The bigint value
                  ##   returns: The value. This must be destroyed with duckdb_destroy_value.
                  ## ```
proc duckdb_create_struct_value*(`type`: duckdb_logical_type;
                                 values: ptr duckdb_value): duckdb_value {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a struct value from a type and an array of values
                                  ##   
                                  ##   type: The type of the struct
                                  ##   values: The values for the struct fields
                                  ##   returns: The value. This must be destroyed with duckdb_destroy_value.
                                  ## ```
proc duckdb_create_list_value*(`type`: duckdb_logical_type;
                               values: ptr duckdb_value; value_count: idx_t): duckdb_value {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a list value from a type and an array of values of length value_count
                                  ##   
                                  ##   type: The type of the list
                                  ##   values: The values for the list
                                  ##   value_count: The number of values in the list
                                  ##   returns: The value. This must be destroyed with duckdb_destroy_value.
                                  ## ```
proc duckdb_get_varchar*(value: duckdb_value): cstring {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Obtains a string representation of the given value.
                  ##   The result must be destroyed with duckdb_free.
                  ##   
                  ##   value: The value
                  ##   returns: The string value. This must be destroyed with duckdb_free.
                  ## ```
proc duckdb_get_int64*(value: duckdb_value): int64 {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Obtains an int64 of the given value.
                  ##   
                  ##   value: The value
                  ##   returns: The int64 value, or 0 if no conversion is possible
                  ## ```
proc duckdb_create_logical_type*(`type`: duckdb_type): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Logical Type Interface
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Creates a duckdb_logical_type from a standard primitive type.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   This should not be used with DUCKDB_TYPE_DECIMAL.
                                  ##   
                                  ##   type: The primitive type to create.
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_logical_type_get_alias*(`type`: duckdb_logical_type): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the alias of a duckdb_logical_type, if one is set, else NULL.
                                  ##   The result must be destroyed with duckdb_free.
                                  ##   
                                  ##   type: The logical type to return the alias of
                                  ##   returns: The alias or NULL
                                  ## ```
proc duckdb_create_list_type*(`type`: duckdb_logical_type): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a list type from its child type.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The child type of list type to create.
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_create_map_type*(key_type: duckdb_logical_type;
                             value_type: duckdb_logical_type): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a map type from its key type and value type.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The key type and value type of map type to create.
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_create_union_type*(member_types: ptr duckdb_logical_type;
                               member_names: ptr cstring; member_count: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a UNION type from the passed types array.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   types: The array of types that the union should consist of.
                                  ##   type_amount: The size of the types array.
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_create_struct_type*(member_types: ptr duckdb_logical_type;
                                member_names: ptr cstring; member_count: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a STRUCT type from the passed member name and type arrays.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   member_types: The array of types that the struct should consist of.
                                  ##   member_names: The array of names that the struct should consist of.
                                  ##   member_count: The number of members that were specified for both arrays.
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_create_enum_type*(member_names: ptr cstring; member_count: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates an ENUM type from the passed member name array.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   enum_name: The name of the enum.
                                  ##   member_names: The array of names that the enum should consist of.
                                  ##   member_count: The number of elements that were specified in the array.
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_create_decimal_type*(width: uint8; scale: uint8): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a duckdb_logical_type of type decimal with the specified width and scale.
                                  ##   The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   width: The width of the decimal type
                                  ##   scale: The scale of the decimal type
                                  ##   returns: The logical type.
                                  ## ```
proc duckdb_get_type_id*(`type`: duckdb_logical_type): duckdb_type {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Retrieves the enum type class of a duckdb_logical_type.
                         ##   
                         ##   type: The logical type object
                         ##   returns: The type id
                         ## ```
proc duckdb_decimal_width*(`type`: duckdb_logical_type): uint8 {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Retrieves the width of a decimal type.
                  ##   
                  ##   type: The logical type object
                  ##   returns: The width of the decimal type
                  ## ```
proc duckdb_decimal_scale*(`type`: duckdb_logical_type): uint8 {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Retrieves the scale of a decimal type.
                  ##   
                  ##   type: The logical type object
                  ##   returns: The scale of the decimal type
                  ## ```
proc duckdb_decimal_internal_type*(`type`: duckdb_logical_type): duckdb_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the internal storage type of a decimal type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The internal type of the decimal type
                                  ## ```
proc duckdb_enum_internal_type*(`type`: duckdb_logical_type): duckdb_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the internal storage type of an enum type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The internal type of the enum type
                                  ## ```
proc duckdb_enum_dictionary_size*(`type`: duckdb_logical_type): uint32 {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the dictionary size of the enum type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The dictionary size of the enum type
                                  ## ```
proc duckdb_enum_dictionary_value*(`type`: duckdb_logical_type; index: idx_t): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the dictionary value at the specified position from the enum.
                                  ##   
                                  ##   The result must be freed with duckdb_free.
                                  ##   
                                  ##   type: The logical type object
                                  ##   index: The index in the dictionary
                                  ##   returns: The string value of the enum type. Must be freed with duckdb_free.
                                  ## ```
proc duckdb_list_type_child_type*(`type`: duckdb_logical_type): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the child type of the given list type.
                                  ##   
                                  ##   The result must be freed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The child type of the list type. Must be destroyed with duckdb_destroy_logical_type.
                                  ## ```
proc duckdb_map_type_key_type*(`type`: duckdb_logical_type): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the key type of the given map type.
                                  ##   
                                  ##   The result must be freed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The key type of the map type. Must be destroyed with duckdb_destroy_logical_type.
                                  ## ```
proc duckdb_map_type_value_type*(`type`: duckdb_logical_type): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the value type of the given map type.
                                  ##   
                                  ##   The result must be freed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The value type of the map type. Must be destroyed with duckdb_destroy_logical_type.
                                  ## ```
proc duckdb_struct_type_child_count*(`type`: duckdb_logical_type): idx_t {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the number of children of a struct type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   returns: The number of children of a struct type.
                                  ## ```
proc duckdb_struct_type_child_name*(`type`: duckdb_logical_type; index: idx_t): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the name of the struct child.
                                  ##   
                                  ##   The result must be freed with duckdb_free.
                                  ##   
                                  ##   type: The logical type object
                                  ##   index: The child index
                                  ##   returns: The name of the struct type. Must be freed with duckdb_free.
                                  ## ```
proc duckdb_struct_type_child_type*(`type`: duckdb_logical_type; index: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the child type of the given struct type at the specified index.
                                  ##   
                                  ##   The result must be freed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   index: The child index
                                  ##   returns: The child type of the struct type. Must be destroyed with duckdb_destroy_logical_type.
                                  ## ```
proc duckdb_union_type_member_count*(`type`: duckdb_logical_type): idx_t {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the number of members that the union type has.
                                  ##   
                                  ##   type: The logical type (union) object
                                  ##   returns: The number of members of a union type.
                                  ## ```
proc duckdb_union_type_member_name*(`type`: duckdb_logical_type; index: idx_t): cstring {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the name of the union member.
                                  ##   
                                  ##   The result must be freed with duckdb_free.
                                  ##   
                                  ##   type: The logical type object
                                  ##   index: The child index
                                  ##   returns: The name of the union member. Must be freed with duckdb_free.
                                  ## ```
proc duckdb_union_type_member_type*(`type`: duckdb_logical_type; index: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the child type of the given union member at the specified index.
                                  ##   
                                  ##   The result must be freed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   type: The logical type object
                                  ##   index: The child index
                                  ##   returns: The child type of the union member. Must be destroyed with duckdb_destroy_logical_type.
                                  ## ```
proc duckdb_destroy_logical_type*(`type`: ptr duckdb_logical_type) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Destroys the logical type and de-allocates all memory allocated for that type.
                         ##   
                         ##   type: The logical type to destroy.
                         ## ```
proc duckdb_create_data_chunk*(types: ptr duckdb_logical_type;
                               column_count: idx_t): duckdb_data_chunk {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Data Chunk Interface
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Creates an empty DataChunk with the specified set of types.
                                  ##   
                                  ##   Note that the result must be destroyed with duckdb_destroy_data_chunk.
                                  ##   
                                  ##   types: An array of types of the data chunk.
                                  ##   column_count: The number of columns.
                                  ##   returns: The data chunk.
                                  ## ```
proc duckdb_destroy_data_chunk*(chunk: ptr duckdb_data_chunk) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Destroys the data chunk and de-allocates all memory allocated for that chunk.
                  ##   
                  ##   chunk: The data chunk to destroy.
                  ## ```
proc duckdb_data_chunk_reset*(chunk: duckdb_data_chunk) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Resets a data chunk, clearing the validity masks and setting the cardinality of the data chunk to 0.
                  ##   
                  ##   chunk: The data chunk to reset.
                  ## ```
proc duckdb_data_chunk_get_column_count*(chunk: duckdb_data_chunk): idx_t {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the number of columns in a data chunk.
                                  ##   
                                  ##   chunk: The data chunk to get the data from
                                  ##   returns: The number of columns in the data chunk
                                  ## ```
proc duckdb_data_chunk_get_vector*(chunk: duckdb_data_chunk; col_idx: idx_t): duckdb_vector {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the vector at the specified column index in the data chunk.
                                  ##   
                                  ##   The pointer to the vector is valid for as long as the chunk is alive.
                                  ##   It does NOT need to be destroyed.
                                  ##   
                                  ##   chunk: The data chunk to get the data from
                                  ##   returns: The vector
                                  ## ```
proc duckdb_data_chunk_get_size*(chunk: duckdb_data_chunk): idx_t {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Retrieves the current number of tuples in a data chunk.
                         ##   
                         ##   chunk: The data chunk to get the data from
                         ##   returns: The number of tuples in the data chunk
                         ## ```
proc duckdb_data_chunk_set_size*(chunk: duckdb_data_chunk; size: idx_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the current number of tuples in a data chunk.
                                  ##   
                                  ##   chunk: The data chunk to set the size in
                                  ##   size: The number of tuples in the data chunk
                                  ## ```
proc duckdb_vector_get_column_type*(vector: duckdb_vector): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Vector Interface
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Retrieves the column type of the specified vector.
                                  ##   
                                  ##   The result must be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   vector: The vector get the data from
                                  ##   returns: The type of the vector
                                  ## ```
proc duckdb_vector_get_data*(vector: duckdb_vector): pointer {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Retrieves the data pointer of the vector.
                  ##   
                  ##   The data pointer can be used to read or write values from the vector.
                  ##   How to read or write values depends on the type of the vector.
                  ##   
                  ##   vector: The vector to get the data from
                  ##   returns: The data pointer
                  ## ```
proc duckdb_vector_get_validity*(vector: duckdb_vector): ptr uint64 {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Retrieves the validity mask pointer of the specified vector.
                         ##   
                         ##   If all values are valid, this function MIGHT return NULL!
                         ##   
                         ##   The validity mask is a bitset that signifies null-ness within the data chunk.
                         ##   It is a series of uint64_t values, where each uint64_t value contains validity for 64 tuples.
                         ##   The bit is set to 1 if the value is valid (i.e. not NULL) or 0 if the value is invalid (i.e. NULL).
                         ##   
                         ##   Validity of a specific value can be obtained like this:
                         ##   
                         ##   idx_t entry_idx = row_idx / 64;
                         ##   idx_t idx_in_entry = row_idx % 64;
                         ##   bool is_valid = validity_mask[entry_idx] & (1 << idx_in_entry);
                         ##   
                         ##   Alternatively, the (slower) duckdb_validity_row_is_valid function can be used.
                         ##   
                         ##   vector: The vector to get the data from
                         ##   returns: The pointer to the validity mask, or NULL if no validity mask is present
                         ## ```
proc duckdb_vector_ensure_validity_writable*(vector: duckdb_vector) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Ensures the validity mask is writable by allocating it.
                         ##   
                         ##   After this function is called, duckdb_vector_get_validity will ALWAYS return non-NULL.
                         ##   This allows null values to be written to the vector, regardless of whether a validity mask was present before.
                         ##   
                         ##   vector: The vector to alter
                         ## ```
proc duckdb_vector_assign_string_element*(vector: duckdb_vector; index: idx_t;
    str: cstring) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                  ##   !
                                                  ##   Assigns a string element in the vector at the specified location.
                                                  ##   
                                                  ##   vector: The vector to alter
                                                  ##   index: The row position in the vector to assign the string to
                                                  ##   str: The null-terminated string
                                                  ## ```
proc duckdb_vector_assign_string_element_len*(vector: duckdb_vector;
    index: idx_t; str: cstring; str_len: idx_t) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                                ##   !
                                                                                ##   Assigns a string element in the vector at the specified location.
                                                                                ##   
                                                                                ##   vector: The vector to alter
                                                                                ##   index: The row position in the vector to assign the string to
                                                                                ##   str: The string
                                                                                ##   str_len: The length of the string (in bytes)
                                                                                ## ```
proc duckdb_list_vector_get_child*(vector: duckdb_vector): duckdb_vector {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the child vector of a list vector.
                                  ##   
                                  ##   The resulting vector is valid as long as the parent vector is valid.
                                  ##   
                                  ##   vector: The vector
                                  ##   returns: The child vector
                                  ## ```
proc duckdb_list_vector_get_size*(vector: duckdb_vector): idx_t {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Returns the size of the child vector of the list.
                         ##   
                         ##   vector: The vector
                         ##   returns: The size of the child list
                         ## ```
proc duckdb_list_vector_set_size*(vector: duckdb_vector; size: idx_t): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the total size of the underlying child-vector of a list vector.
                                  ##   
                                  ##   vector: The list vector.
                                  ##   size: The size of the child list.
                                  ##   returns: The duckdb state. Returns DuckDBError if the vector is nullptr.
                                  ## ```
proc duckdb_list_vector_reserve*(vector: duckdb_vector; required_capacity: idx_t): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the total capacity of the underlying child-vector of a list.
                                  ##   
                                  ##   vector: The list vector.
                                  ##   required_capacity: the total capacity to reserve.
                                  ##   return: The duckdb state. Returns DuckDBError if the vector is nullptr.
                                  ## ```
proc duckdb_struct_vector_get_child*(vector: duckdb_vector; index: idx_t): duckdb_vector {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the child vector of a struct vector.
                                  ##   
                                  ##   The resulting vector is valid as long as the parent vector is valid.
                                  ##   
                                  ##   vector: The vector
                                  ##   index: The child index
                                  ##   returns: The child vector
                                  ## ```
proc duckdb_validity_row_is_valid*(validity: ptr uint64; row: idx_t): bool {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Validity Mask Functions
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Returns whether or not a row is valid (i.e. not NULL) in the given validity mask.
                                  ##   
                                  ##   validity: The validity mask, as obtained through duckdb_vector_get_validity
                                  ##   row: The row index
                                  ##   returns: true if the row is valid, false otherwise
                                  ## ```
proc duckdb_validity_set_row_validity*(validity: ptr uint64; row: idx_t;
                                       valid: bool) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   In a validity mask, sets a specific row to either valid or invalid.
                  ##   
                  ##   Note that duckdb_vector_ensure_validity_writable should be called before calling duckdb_vector_get_validity,
                  ##   to ensure that there is a validity mask to write to.
                  ##   
                  ##   validity: The validity mask, as obtained through duckdb_vector_get_validity.
                  ##   row: The row index
                  ##   valid: Whether or not to set the row to valid, or invalid
                  ## ```
proc duckdb_validity_set_row_invalid*(validity: ptr uint64; row: idx_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   In a validity mask, sets a specific row to invalid.
                                  ##   
                                  ##   Equivalent to duckdb_validity_set_row_validity with valid set to false.
                                  ##   
                                  ##   validity: The validity mask
                                  ##   row: The row index
                                  ## ```
proc duckdb_validity_set_row_valid*(validity: ptr uint64; row: idx_t) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   In a validity mask, sets a specific row to valid.
                         ##   
                         ##   Equivalent to duckdb_validity_set_row_validity with valid set to true.
                         ##   
                         ##   validity: The validity mask
                         ##   row: The row index
                         ## ```
proc duckdb_create_table_function*(): duckdb_table_function {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   ===--------------------------------------------------------------------===
                  ##      Table Functions
                  ##     ===--------------------------------------------------------------------===
                  ##     !
                  ##   Creates a new empty table function.
                  ##   
                  ##   The return value should be destroyed with duckdb_destroy_table_function.
                  ##   
                  ##   returns: The table function object.
                  ## ```
proc duckdb_destroy_table_function*(table_function: ptr duckdb_table_function) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Destroys the given table function object.
                                  ##   
                                  ##   table_function: The table function to destroy
                                  ## ```
proc duckdb_table_function_set_name*(table_function: duckdb_table_function;
                                     name: cstring) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Sets the name of the given table function.
                  ##   
                  ##   table_function: The table function
                  ##   name: The name of the table function
                  ## ```
proc duckdb_table_function_add_parameter*(table_function: duckdb_table_function;
    `type`: duckdb_logical_type) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                 ##   !
                                                                 ##   Adds a parameter to the table function.
                                                                 ##   
                                                                 ##   table_function: The table function
                                                                 ##   type: The type of the parameter to add.
                                                                 ## ```
proc duckdb_table_function_add_named_parameter*(
    table_function: duckdb_table_function; name: cstring;
    `type`: duckdb_logical_type) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                 ##   !
                                                                 ##   Adds a named parameter to the table function.
                                                                 ##   
                                                                 ##   table_function: The table function
                                                                 ##   name: The name of the parameter
                                                                 ##   type: The type of the parameter to add.
                                                                 ## ```
proc duckdb_table_function_set_extra_info*(
    table_function: duckdb_table_function; extra_info: pointer;
    destroy: duckdb_delete_callback_t) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                       ##   !
                                                                       ##   Assigns extra information to the table function that can be fetched during binding, etc.
                                                                       ##   
                                                                       ##   table_function: The table function
                                                                       ##   extra_info: The extra information
                                                                       ##   destroy: The callback that will be called to destroy the bind data (if any)
                                                                       ## ```
proc duckdb_table_function_set_bind*(table_function: duckdb_table_function;
                                     `bind`: duckdb_table_function_bind_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the bind function of the table function.
                                  ##   
                                  ##   table_function: The table function
                                  ##   bind: The bind function
                                  ## ```
proc duckdb_table_function_set_init*(table_function: duckdb_table_function;
                                     init: duckdb_table_function_init_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the init function of the table function.
                                  ##   
                                  ##   table_function: The table function
                                  ##   init: The init function
                                  ## ```
proc duckdb_table_function_set_local_init*(
    table_function: duckdb_table_function; init: duckdb_table_function_init_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets the thread-local init function of the table function.
                                  ##   
                                  ##   table_function: The table function
                                  ##   init: The init function
                                  ## ```
proc duckdb_table_function_set_function*(table_function: duckdb_table_function;
    function: duckdb_table_function_t) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                       ##   !
                                                                       ##   Sets the main function of the table function.
                                                                       ##   
                                                                       ##   table_function: The table function
                                                                       ##   function: The function
                                                                       ## ```
proc duckdb_table_function_supports_projection_pushdown*(
    table_function: duckdb_table_function; pushdown: bool) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Sets whether or not the given table function supports projection pushdown.
                  ##   
                  ##   If this is set to true, the system will provide a list of all required columns in the init stage through
                  ##   the duckdb_init_get_column_count and duckdb_init_get_column_index functions.
                  ##   If this is set to false (the default), the system will expect all columns to be projected.
                  ##   
                  ##   table_function: The table function
                  ##   pushdown: True if the table function supports projection pushdown, false otherwise.
                  ## ```
proc duckdb_register_table_function*(con: duckdb_connection;
                                     function: duckdb_table_function): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Register the table function object within the given connection.
                                  ##   
                                  ##   The function requires at least a name, a bind function, an init function and a main function.
                                  ##   
                                  ##   If the function is incomplete or a function with this name already exists DuckDBError is returned.
                                  ##   
                                  ##   con: The connection to register it in.
                                  ##   function: The function pointer
                                  ##   returns: Whether or not the registration was successful.
                                  ## ```
proc duckdb_bind_get_extra_info*(info: duckdb_bind_info): pointer {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   ===--------------------------------------------------------------------===
                         ##      Table Function Bind
                         ##     ===--------------------------------------------------------------------===
                         ##     !
                         ##   Retrieves the extra info of the function as set in duckdb_table_function_set_extra_info.
                         ##   
                         ##   info: The info object
                         ##   returns: The extra info
                         ## ```
proc duckdb_bind_add_result_column*(info: duckdb_bind_info; name: cstring;
                                    `type`: duckdb_logical_type) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Adds a result column to the output of the table function.
                         ##   
                         ##   info: The info object
                         ##   name: The name of the column
                         ##   type: The logical type of the column
                         ## ```
proc duckdb_bind_get_parameter_count*(info: duckdb_bind_info): idx_t {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Retrieves the number of regular (non-named) parameters to the function.
                         ##   
                         ##   info: The info object
                         ##   returns: The number of parameters
                         ## ```
proc duckdb_bind_get_parameter*(info: duckdb_bind_info; index: idx_t): duckdb_value {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves the parameter at the given index.
                                  ##   
                                  ##   The result must be destroyed with duckdb_destroy_value.
                                  ##   
                                  ##   info: The info object
                                  ##   index: The index of the parameter to get
                                  ##   returns: The value of the parameter. Must be destroyed with duckdb_destroy_value.
                                  ## ```
proc duckdb_bind_get_named_parameter*(info: duckdb_bind_info; name: cstring): duckdb_value {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Retrieves a named parameter with the given name.
                                  ##   
                                  ##   The result must be destroyed with duckdb_destroy_value.
                                  ##   
                                  ##   info: The info object
                                  ##   name: The name of the parameter
                                  ##   returns: The value of the parameter. Must be destroyed with duckdb_destroy_value.
                                  ## ```
proc duckdb_bind_set_bind_data*(info: duckdb_bind_info; bind_data: pointer;
                                destroy: duckdb_delete_callback_t) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Sets the user-provided bind data in the bind object. This object can be retrieved again during execution.
                         ##   
                         ##   info: The info object
                         ##   extra_data: The bind data object.
                         ##   destroy: The callback that will be called to destroy the bind data (if any)
                         ## ```
proc duckdb_bind_set_cardinality*(info: duckdb_bind_info; cardinality: idx_t;
                                  is_exact: bool) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                                                  ##   !
                                                                                  ##   Sets the cardinality estimate for the table function, used for optimization.
                                                                                  ##   
                                                                                  ##   info: The bind data object.
                                                                                  ##   is_exact: Whether or not the cardinality estimate is exact, or an approximation
                                                                                  ## ```
proc duckdb_bind_set_error*(info: duckdb_bind_info; error: cstring) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Report that an error has occurred while calling bind.
                         ##   
                         ##   info: The info object
                         ##   error: The error message
                         ## ```
proc duckdb_init_get_extra_info*(info: duckdb_init_info): pointer {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   ===--------------------------------------------------------------------===
                         ##      Table Function Init
                         ##     ===--------------------------------------------------------------------===
                         ##     !
                         ##   Retrieves the extra info of the function as set in duckdb_table_function_set_extra_info.
                         ##   
                         ##   info: The info object
                         ##   returns: The extra info
                         ## ```
proc duckdb_init_get_bind_data*(info: duckdb_init_info): pointer {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Gets the bind data set by duckdb_bind_set_bind_data during the bind.
                         ##   
                         ##   Note that the bind data should be considered as read-only.
                         ##   For tracking state, use the init data instead.
                         ##   
                         ##   info: The info object
                         ##   returns: The bind data object
                         ## ```
proc duckdb_init_set_init_data*(info: duckdb_init_info; init_data: pointer;
                                destroy: duckdb_delete_callback_t) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Sets the user-provided init data in the init object. This object can be retrieved again during execution.
                         ##   
                         ##   info: The info object
                         ##   extra_data: The init data object.
                         ##   destroy: The callback that will be called to destroy the init data (if any)
                         ## ```
proc duckdb_init_get_column_count*(info: duckdb_init_info): idx_t {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Returns the number of projected columns.
                         ##   
                         ##   This function must be used if projection pushdown is enabled to figure out which columns to emit.
                         ##   
                         ##   info: The info object
                         ##   returns: The number of projected columns.
                         ## ```
proc duckdb_init_get_column_index*(info: duckdb_init_info; column_index: idx_t): idx_t {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the column index of the projected column at the specified position.
                                  ##   
                                  ##   This function must be used if projection pushdown is enabled to figure out which columns to emit.
                                  ##   
                                  ##   info: The info object
                                  ##   column_index: The index at which to get the projected column index, from 0..duckdb_init_get_column_count(info)
                                  ##   returns: The column index of the projected column.
                                  ## ```
proc duckdb_init_set_max_threads*(info: duckdb_init_info; max_threads: idx_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Sets how many threads can process this table function in parallel (default: 1)
                                  ##   
                                  ##   info: The info object
                                  ##   max_threads: The maximum amount of threads that can process this table function
                                  ## ```
proc duckdb_init_set_error*(info: duckdb_init_info; error: cstring) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Report that an error has occurred while calling init.
                         ##   
                         ##   info: The info object
                         ##   error: The error message
                         ## ```
proc duckdb_function_get_extra_info*(info: duckdb_function_info): pointer {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Table Function
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Retrieves the extra info of the function as set in duckdb_table_function_set_extra_info.
                                  ##   
                                  ##   info: The info object
                                  ##   returns: The extra info
                                  ## ```
proc duckdb_function_get_bind_data*(info: duckdb_function_info): pointer {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Gets the bind data set by duckdb_bind_set_bind_data during the bind.
                                  ##   
                                  ##   Note that the bind data should be considered as read-only.
                                  ##   For tracking state, use the init data instead.
                                  ##   
                                  ##   info: The info object
                                  ##   returns: The bind data object
                                  ## ```
proc duckdb_function_get_init_data*(info: duckdb_function_info): pointer {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Gets the init data set by duckdb_init_set_init_data during the init.
                                  ##   
                                  ##   info: The info object
                                  ##   returns: The init data object
                                  ## ```
proc duckdb_function_get_local_init_data*(info: duckdb_function_info): pointer {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Gets the thread-local init data set by duckdb_init_set_init_data during the local_init.
                                  ##   
                                  ##   info: The info object
                                  ##   returns: The init data object
                                  ## ```
proc duckdb_function_set_error*(info: duckdb_function_info; error: cstring) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Report that an error has occurred while executing the function.
                                  ##   
                                  ##   info: The info object
                                  ##   error: The error message
                                  ## ```
proc duckdb_add_replacement_scan*(db: duckdb_database;
                                  replacement: duckdb_replacement_callback_t;
                                  extra_data: pointer;
                                  delete_callback: duckdb_delete_callback_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Replacement Scans
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Add a replacement scan definition to the specified database.
                                  ##   
                                  ##   db: The database object to add the replacement scan to
                                  ##   replacement: The replacement scan callback
                                  ##   extra_data: Extra data that is passed back into the specified callback
                                  ##   delete_callback: The delete callback to call on the extra data, if any
                                  ## ```
proc duckdb_replacement_scan_set_function_name*(
    info: duckdb_replacement_scan_info; function_name: cstring) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Sets the replacement function name. If this function is called in the replacement callback,
                         ##   the replacement scan is performed. If it is not called, the replacement callback is not performed.
                         ##   
                         ##   info: The info object
                         ##   function_name: The function name to substitute.
                         ## ```
proc duckdb_replacement_scan_add_parameter*(info: duckdb_replacement_scan_info;
    parameter: duckdb_value) {.importc, cdecl, impduckdbDyn.}
  ## ```
                                                             ##   !
                                                             ##   Adds a parameter to the replacement scan function.
                                                             ##   
                                                             ##   info: The info object
                                                             ##   parameter: The parameter to add.
                                                             ## ```
proc duckdb_replacement_scan_set_error*(info: duckdb_replacement_scan_info;
                                        error: cstring) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Report that an error has occurred while executing the replacement scan.
                  ##   
                  ##   info: The info object
                  ##   error: The error message
                  ## ```
proc duckdb_appender_create*(connection: duckdb_connection; schema: cstring;
                             table: cstring; out_appender: ptr duckdb_appender): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Appender
                                  ##     ===--------------------------------------------------------------------===
                                  ##      Appenders are the most efficient way of loading data into DuckDB from within the C interface, and are recommended for
                                  ##      fast data loading. The appender is much faster than using prepared statements or individual INSERT INTO statements.
                                  ##      Appends are made in row-wise format. For every column, a duckdb_append_[type] call should be made, after which
                                  ##      the row should be finished by calling duckdb_appender_end_row. After all rows have been appended,
                                  ##      duckdb_appender_destroy should be used to finalize the appender and clean up the resulting memory.
                                  ##      Instead of appending rows with duckdb_appender_end_row, it is also possible to fill and append
                                  ##      chunks-at-a-time.
                                  ##      Note that duckdb_appender_destroy should always be called on the resulting appender, even if the function returns
                                  ##      DuckDBError.
                                  ##     !
                                  ##   Creates an appender object.
                                  ##   
                                  ##   Note that the object must be destroyed with duckdb_appender_destroy.
                                  ##   
                                  ##   connection: The connection context to create the appender in.
                                  ##   schema: The schema of the table to append to, or nullptr for the default schema.
                                  ##   table: The table name to append to.
                                  ##   out_appender: The resulting appender object.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_appender_column_count*(appender: duckdb_appender): idx_t {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Returns the number of columns in the table that belongs to the appender.
                         ##   
                         ##   appender The appender to get the column count from.
                         ##   returns: The number of columns in the table.
                         ## ```
proc duckdb_appender_column_type*(appender: duckdb_appender; col_idx: idx_t): duckdb_logical_type {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Returns the type of the column at the specified index.
                                  ##   
                                  ##   Note: The resulting type should be destroyed with duckdb_destroy_logical_type.
                                  ##   
                                  ##   appender The appender to get the column type from.
                                  ##   col_idx The index of the column to get the type of.
                                  ##   returns: The duckdb_logical_type of the column.
                                  ## ```
proc duckdb_appender_error*(appender: duckdb_appender): cstring {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Returns the error message associated with the given appender.
                         ##   If the appender has no error message, this returns nullptr instead.
                         ##   
                         ##   The error message should not be freed. It will be de-allocated when duckdb_appender_destroy is called.
                         ##   
                         ##   appender: The appender to get the error from.
                         ##   returns: The error message, or nullptr if there is none.
                         ## ```
proc duckdb_appender_flush*(appender: duckdb_appender): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Flush the appender to the table, forcing the cache of the appender to be cleared and the data to be appended to the
                         ##   base table.
                         ##   
                         ##   This should generally not be used unless you know what you are doing. Instead, call duckdb_appender_destroy when you
                         ##   are done with the appender.
                         ##   
                         ##   appender: The appender to flush.
                         ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                         ## ```
proc duckdb_appender_close*(appender: duckdb_appender): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Close the appender, flushing all intermediate state in the appender to the table and closing it for further appends.
                         ##   
                         ##   This is generally not necessary. Call duckdb_appender_destroy instead.
                         ##   
                         ##   appender: The appender to flush and close.
                         ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                         ## ```
proc duckdb_appender_destroy*(appender: ptr duckdb_appender): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Close the appender and destroy it. Flushing all intermediate state in the appender to the table, and de-allocating
                                  ##   all memory associated with the appender.
                                  ##   
                                  ##   appender: The appender to flush, close and destroy.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_appender_begin_row*(appender: duckdb_appender): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   A nop function, provided for backwards compatibility reasons. Does nothing. Only duckdb_appender_end_row is required.
                                  ## ```
proc duckdb_appender_end_row*(appender: duckdb_appender): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Finish the current row of appends. After end_row is called, the next row can be appended.
                                  ##   
                                  ##   appender: The appender.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_append_bool*(appender: duckdb_appender; value: bool): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a bool value to the appender.
                                  ## ```
proc duckdb_append_int8*(appender: duckdb_appender; value: int8): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append an int8_t value to the appender.
                                  ## ```
proc duckdb_append_int16*(appender: duckdb_appender; value: int16): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append an int16_t value to the appender.
                                  ## ```
proc duckdb_append_int32*(appender: duckdb_appender; value: int32): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append an int32_t value to the appender.
                                  ## ```
proc duckdb_append_int64*(appender: duckdb_appender; value: int64): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append an int64_t value to the appender.
                                  ## ```
proc duckdb_append_hugeint*(appender: duckdb_appender; value: duckdb_hugeint): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a duckdb_hugeint value to the appender.
                                  ## ```
proc duckdb_append_uint8*(appender: duckdb_appender; value: uint8): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a uint8_t value to the appender.
                                  ## ```
proc duckdb_append_uint16*(appender: duckdb_appender; value: uint16): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a uint16_t value to the appender.
                                  ## ```
proc duckdb_append_uint32*(appender: duckdb_appender; value: uint32): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a uint32_t value to the appender.
                                  ## ```
proc duckdb_append_uint64*(appender: duckdb_appender; value: uint64): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a uint64_t value to the appender.
                                  ## ```
proc duckdb_append_uhugeint*(appender: duckdb_appender; value: duckdb_uhugeint): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a duckdb_uhugeint value to the appender.
                                  ## ```
proc duckdb_append_float*(appender: duckdb_appender; value: cfloat): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a float value to the appender.
                                  ## ```
proc duckdb_append_double*(appender: duckdb_appender; value: cdouble): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a double value to the appender.
                                  ## ```
proc duckdb_append_date*(appender: duckdb_appender; value: duckdb_date): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a duckdb_date value to the appender.
                                  ## ```
proc duckdb_append_time*(appender: duckdb_appender; value: duckdb_time): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a duckdb_time value to the appender.
                                  ## ```
proc duckdb_append_timestamp*(appender: duckdb_appender; value: duckdb_timestamp): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a duckdb_timestamp value to the appender.
                                  ## ```
proc duckdb_append_interval*(appender: duckdb_appender; value: duckdb_interval): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a duckdb_interval value to the appender.
                                  ## ```
proc duckdb_append_varchar*(appender: duckdb_appender; val: cstring): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a varchar value to the appender.
                                  ## ```
proc duckdb_append_varchar_length*(appender: duckdb_appender; val: cstring;
                                   length: idx_t): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Append a varchar value to the appender.
                         ## ```
proc duckdb_append_blob*(appender: duckdb_appender; data: pointer; length: idx_t): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Append a blob value to the appender.
                                  ## ```
proc duckdb_append_null*(appender: duckdb_appender): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Append a NULL value to the appender (of any type).
                         ## ```
proc duckdb_append_data_chunk*(appender: duckdb_appender;
                               chunk: duckdb_data_chunk): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Appends a pre-filled data chunk to the specified appender.
                                  ##   
                                  ##   The types of the data chunk must exactly match the types of the table, no casting is performed.
                                  ##   If the types do not match or the appender is in an invalid state, DuckDBError is returned.
                                  ##   If the append is successful, DuckDBSuccess is returned.
                                  ##   
                                  ##   appender: The appender to append to.
                                  ##   chunk: The data chunk to append.
                                  ##   returns: The return state.
                                  ## ```
proc duckdb_query_arrow*(connection: duckdb_connection; query: cstring;
                         out_result: ptr duckdb_arrow): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   ===--------------------------------------------------------------------===
                         ##      Arrow Interface
                         ##     ===--------------------------------------------------------------------===
                         ##     !
                         ##   Executes a SQL query within a connection and stores the full (materialized) result in an arrow structure.
                         ##   If the query fails to execute, DuckDBError is returned and the error message can be retrieved by calling
                         ##   duckdb_query_arrow_error.
                         ##   
                         ##   Note that after running duckdb_query_arrow, duckdb_destroy_arrow must be called on the result object even if the
                         ##   query fails, otherwise the error stored within the result will not be freed correctly.
                         ##   
                         ##   connection: The connection to perform the query in.
                         ##   query: The SQL query to run.
                         ##   out_result: The query result.
                         ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                         ## ```
proc duckdb_query_arrow_schema*(result: duckdb_arrow;
                                out_schema: ptr duckdb_arrow_schema): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Fetch the internal arrow schema from the arrow result. Remember to call release on the respective
                                  ##   ArrowSchema object.
                                  ##   
                                  ##   result: The result to fetch the schema from.
                                  ##   out_schema: The output schema.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_prepared_arrow_schema*(prepared: duckdb_prepared_statement;
                                   out_schema: ptr duckdb_arrow_schema): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Fetch the internal arrow schema from the prepared statement. Remember to call release on the respective
                                  ##   ArrowSchema object.
                                  ##   
                                  ##   result: The prepared statement to fetch the schema from.
                                  ##   out_schema: The output schema.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_result_arrow_array*(result: duckdb_result; chunk: duckdb_data_chunk;
                                out_array: ptr duckdb_arrow_array) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Convert a data chunk into an arrow struct array. Remember to call release on the respective
                         ##   ArrowArray object.
                         ##   
                         ##   result: The result object the data chunk have been fetched from.
                         ##   chunk: The data chunk to convert.
                         ##   out_array: The output array.
                         ## ```
proc duckdb_query_arrow_array*(result: duckdb_arrow;
                               out_array: ptr duckdb_arrow_array): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Fetch an internal arrow struct array from the arrow result. Remember to call release on the respective
                                  ##   ArrowArray object.
                                  ##   
                                  ##   This function can be called multiple time to get next chunks, which will free the previous out_array.
                                  ##   So consume the out_array before calling this function again.
                                  ##   
                                  ##   result: The result to fetch the array from.
                                  ##   out_array: The output array.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_arrow_column_count*(result: duckdb_arrow): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of columns present in the arrow result object.
                  ##   
                  ##   result: The result object.
                  ##   returns: The number of columns present in the result object.
                  ## ```
proc duckdb_arrow_row_count*(result: duckdb_arrow): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of rows present in the arrow result object.
                  ##   
                  ##   result: The result object.
                  ##   returns: The number of rows present in the result object.
                  ## ```
proc duckdb_arrow_rows_changed*(result: duckdb_arrow): idx_t {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the number of rows changed by the query stored in the arrow result. This is relevant only for
                  ##   INSERT/UPDATE/DELETE queries. For other queries the rows_changed will be 0.
                  ##   
                  ##   result: The result object.
                  ##   returns: The number of rows changed.
                  ## ```
proc duckdb_query_arrow_error*(result: duckdb_arrow): cstring {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Returns the error message contained within the result. The error is only set if duckdb_query_arrow returns
                  ##   DuckDBError.
                  ##   
                  ##   The error message should not be freed. It will be de-allocated when duckdb_destroy_arrow is called.
                  ##   
                  ##   result: The result object to fetch the error from.
                  ##   returns: The error of the result.
                  ## ```
proc duckdb_destroy_arrow*(result: ptr duckdb_arrow) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Closes the result and de-allocates all memory allocated for the arrow result.
                  ##   
                  ##   result: The result to destroy.
                  ## ```
proc duckdb_destroy_arrow_stream*(stream_p: ptr duckdb_arrow_stream) {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Releases the arrow array stream and de-allocates its memory.
                         ##   
                         ##   stream: The arrow array stream to destroy.
                         ## ```
proc duckdb_execute_prepared_arrow*(prepared_statement: duckdb_prepared_statement;
                                    out_result: ptr duckdb_arrow): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Executes the prepared statement with the given bound parameters, and returns an arrow query result.
                                  ##   Note that after running duckdb_execute_prepared_arrow, duckdb_destroy_arrow must be called on the result object.
                                  ##   
                                  ##   prepared_statement: The prepared statement to execute.
                                  ##   out_result: The query result.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_arrow_scan*(connection: duckdb_connection; table_name: cstring;
                        arrow: duckdb_arrow_stream): duckdb_state {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Scans the Arrow stream and creates a view with the given name.
                         ##   
                         ##   connection: The connection on which to execute the scan.
                         ##   table_name: Name of the temporary view to create.
                         ##   arrow: Arrow stream wrapper.
                         ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                         ## ```
proc duckdb_arrow_array_scan*(connection: duckdb_connection;
                              table_name: cstring;
                              arrow_schema: duckdb_arrow_schema;
                              arrow_array: duckdb_arrow_array;
                              out_stream: ptr duckdb_arrow_stream): duckdb_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Scans the Arrow array and creates a view with the given name.
                                  ##   Note that after running duckdb_arrow_array_scan, duckdb_destroy_arrow_stream must be called on the out stream.
                                  ##   
                                  ##   connection: The connection on which to execute the scan.
                                  ##   table_name: Name of the temporary view to create.
                                  ##   arrow_schema: Arrow schema wrapper.
                                  ##   arrow_array: Arrow array wrapper.
                                  ##   out_stream: Output array stream that wraps around the passed schema, for releasing/deleting once done.
                                  ##   returns: DuckDBSuccess on success or DuckDBError on failure.
                                  ## ```
proc duckdb_execute_tasks*(database: duckdb_database; max_tasks: idx_t) {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Threading Information
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Execute DuckDB tasks on this thread.
                                  ##   
                                  ##   Will return after max_tasks have been executed, or if there are no more tasks present.
                                  ##   
                                  ##   database: The database object to execute tasks for
                                  ##   max_tasks: The maximum amount of tasks to execute
                                  ## ```
proc duckdb_create_task_state*(database: duckdb_database): duckdb_task_state {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Creates a task state that can be used with duckdb_execute_tasks_state to execute tasks until
                                  ##   duckdb_finish_execution is called on the state.
                                  ##   
                                  ##   duckdb_destroy_state must be called on the result.
                                  ##   
                                  ##   database: The database object to create the task state for
                                  ##   returns: The task state that can be used with duckdb_execute_tasks_state.
                                  ## ```
proc duckdb_execute_tasks_state*(state: duckdb_task_state) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Execute DuckDB tasks on this thread.
                  ##   
                  ##   The thread will keep on executing tasks forever, until duckdb_finish_execution is called on the state.
                  ##   Multiple threads can share the same duckdb_task_state.
                  ##   
                  ##   state: The task state of the executor
                  ## ```
proc duckdb_execute_n_tasks_state*(state: duckdb_task_state; max_tasks: idx_t): idx_t {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   !
                                  ##   Execute DuckDB tasks on this thread.
                                  ##   
                                  ##   The thread will keep on executing tasks until either duckdb_finish_execution is called on the state,
                                  ##   max_tasks tasks have been executed or there are no more tasks to be executed.
                                  ##   
                                  ##   Multiple threads can share the same duckdb_task_state.
                                  ##   
                                  ##   state: The task state of the executor
                                  ##   max_tasks: The maximum amount of tasks to execute
                                  ##   returns: The amount of tasks that have actually been executed
                                  ## ```
proc duckdb_finish_execution*(state: duckdb_task_state) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Finish execution on a specific task.
                  ##   
                  ##   state: The task state to finish execution
                  ## ```
proc duckdb_task_state_is_finished*(state: duckdb_task_state): bool {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Check if the provided duckdb_task_state has finished execution
                         ##   
                         ##   state: The task state to inspect
                         ##   returns: Whether or not duckdb_finish_execution has been called on the task state
                         ## ```
proc duckdb_destroy_task_state*(state: duckdb_task_state) {.importc, cdecl,
    impduckdbDyn.}
  ## ```
                  ##   !
                  ##   Destroys the task state returned from duckdb_create_task_state.
                  ##   
                  ##   Note that this should not be called while there is an active duckdb_execute_tasks_state running
                  ##   on the task state.
                  ##   
                  ##   state: The task state to clean up
                  ## ```
proc duckdb_execution_is_finished*(con: duckdb_connection): bool {.importc,
    cdecl, impduckdbDyn.}
  ## ```
                         ##   !
                         ##   Returns true if the execution of the current query is finished.
                         ##   
                         ##   con: The connection on which to check
                         ## ```
proc duckdb_stream_fetch_chunk*(result: duckdb_result): duckdb_data_chunk {.
    importc, cdecl, impduckdbDyn.}
  ## ```
                                  ##   ===--------------------------------------------------------------------===
                                  ##      Streaming Result Interface
                                  ##     ===--------------------------------------------------------------------===
                                  ##     !
                                  ##   Fetches a data chunk from the (streaming) duckdb_result. This function should be called repeatedly until the result is
                                  ##   exhausted.
                                  ##   
                                  ##   The result must be destroyed with duckdb_destroy_data_chunk.
                                  ##   
                                  ##   This function can only be used on duckdb_results created with 'duckdb_pending_prepared_streaming'
                                  ##   
                                  ##   If this function is used, none of the other result functions can be used and vice versa (i.e. this function cannot be
                                  ##   mixed with the legacy result functions or the materialized result functions).
                                  ##   
                                  ##   It is not known beforehand how many chunks will be returned by this result.
                                  ##   
                                  ##   result: The result object to fetch the data chunk from.
                                  ##   returns: The resulting data chunk. Returns NULL if the result has an error.
                                  ## ```
{.pop.}