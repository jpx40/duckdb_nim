#include "../libduckdb/duckdb.h"
#include <stdio.h>

int main(void) {
    duckdb_database db;
    duckdb_connection con;
	duckdb_result result;
    if (duckdb_open("../test.db", &db) == DuckDBError) {
        // handle error
        printf("error on open");
    }
    if (duckdb_connect(db, &con) == DuckDBError) {
        // handle error
        printf("error on open");

    }

    // run queries...
    if (duckdb_query(con, "CREATE TABLE integers(i INTEGER, j INTEGER) if not exists;", NULL) == DuckDBError) {
		// fprintf(stderr, "Failed to query database\n");
		// goto cleanup;
	}
	if (duckdb_query(con, "INSERT INTO integers VALUES (3, 4), (5, 6);", NULL) == DuckDBError) {
		fprintf(stderr, "Failed to query database\n");
		//goto cleanup;
	}
	if (duckdb_query(con, "SELECT * FROM integers", &result) == DuckDBError) {
		fprintf(stderr, "Failed to query database\n");
		//goto cleanup;
	}
	// print the names of the result
	idx_t row_count = duckdb_row_count(&result);
	idx_t column_count = duckdb_column_count(&result);
	for (size_t i = 0; i < column_count; i++) {
		printf("%s ", duckdb_column_name(&result, i));
	}
	printf("\n");
	// print the data of the result
	for (size_t row_idx = 0; row_idx < row_count; row_idx++) {
		for (size_t col_idx = 0; col_idx < column_count; col_idx++) {
			char *val = duckdb_value_varchar(&result, col_idx, row_idx);
			printf("%s ", val);
			//duckdb_free(val);
		}
		printf("\n");
	}
	// duckdb_print_result(result);
    cleanup:
	//duckdb_destroy_result(&result);
	duckdb_disconnect(&con);
	duckdb_close(&db);
  
    return 0;
}
