#include <stddef.h>
#include <stdlib.h>

#ifndef RUST_GRAPH_WITNESS_H
#define RUST_GRAPH_WITNESS_H

typedef enum {
  OK = 0,
  ERROR = 1
} GW_ERROR_CODE;

typedef struct {
  GW_ERROR_CODE code;
  char *error_msg;
} gw_status_t;

int
gw_calc_witness(const char *inputs,
				const void *graph_data, const size_t graph_data_len,
			    void **wtns_data, size_t *wtns_len,
				const gw_status_t *status);

void
gw_free_status(gw_status_t *status) {
  if (status->error_msg != NULL) {
	free(status->error_msg);
  }
}

#endif // RUST_GRAPH_WITNESS_H
