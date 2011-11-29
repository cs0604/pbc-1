#include "pbc.h"
#include "array.h"
#include "alloc.h"

#include <stdlib.h>
#include <string.h>

struct array {
	int number;
	union _pbc_var * a;
};

#define INNER_FIELD ((PBC_ARRAY_CAP - sizeof(struct array)) / sizeof(pbc_var))

void 
_pbcA_open(pbc_array _array) {
	struct array * a = (struct array *)_array;
	a->number = 0;
	a->a = (union _pbc_var *)(a+1);
}

void 
_pbcA_close(pbc_array _array) {
	struct array * a = (struct array *)_array;
	if (a->a != NULL && (union _pbc_var *)(a+1) != a->a) {
		free(a->a);
		a->a = NULL;
	}
}

void 
_pbcA_push(pbc_array _array, pbc_var var) {
	struct array * a = (struct array *)_array;
	if (a->number >= INNER_FIELD) {
		if (a->number == INNER_FIELD) {
			int cap = 1;
			while (cap <= a->number + 1) 
				cap *= 2;
			union _pbc_var * outer = malloc(cap * sizeof(union _pbc_var));
			memcpy(outer , a->a , INNER_FIELD * sizeof(pbc_var));
			a->a = outer;
		} else {
			int size=a->number;
			if (((size + 1) ^ size) > size) {
			   a->a=realloc(a->a,sizeof(union _pbc_var) * (size+1) * 2);
			}
		}
	}
	a->a[a->number] = *var;
	++ a->number;
}

void 
_pbcA_index(pbc_array _array, int idx, pbc_var var)
{
	struct array * a = (struct array *)_array;
	var[0] = a->a[idx];
}

void *
_pbcA_index_p(pbc_array _array, int idx)
{
	struct array * a = (struct array *)_array;
	return &(a->a[idx]);
}

int 
pbc_array_size(pbc_array _array) {
	struct array * a = (struct array *)_array;
	return a->number;
}

uint32_t 
pbc_array_integer(pbc_array array, int index, uint32_t *hi) {
	pbc_var var;
	_pbcA_index(array , index , var);
	if (hi) {
		*hi = var->integer.hi;
	}
	return var->integer.low;
}

double 
pbc_array_real(pbc_array array, int index) {
	pbc_var var;
	_pbcA_index(array , index , var);
	return var->real;
}

struct pbc_slice *
pbc_array_bytes(pbc_array _array, int index) {
	struct array * a = (struct array *)_array;
	if (index <0 || index > a->number) {
		return NULL;
	}
	return (struct pbc_slice *) &(a->a[index]);
}