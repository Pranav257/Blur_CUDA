/* Blur filter. Device code. */

#ifndef _BLUR_FILTER_KERNEL_H_
#define _BLUR_FILTER_KERNEL_H_

#include "blur_filter.h"

__global__ void blur_filter_kernel (const float *in, float *out, int size)
{
    int pix, i, j;
    int row, col;
    int curr_row, curr_col;
    float blur_value;
    int num_neighbors;

    int thread_id = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (pix = thread_id; pix < size * size; pix+= stride) { /* Iterate over pixels in image */
        row = pix/size;             /* Obtain row number of pixel */
        col = pix % size;           /* Obtain column number of pixel */

        /* Apply blur filter to current pixel */
        blur_value = 0.0;
        num_neighbors = 0;
        for (i = -BLUR_SIZE; i < (BLUR_SIZE + 1); i++) {
            for (j = -BLUR_SIZE; j < (BLUR_SIZE + 1); j++) {
                /* Accumulate values of neighbors while checking for 
                 * boundary conditions */
                curr_row = row + i;
                curr_col = col + j;
                if ((curr_row > -1) && (curr_row < size) &&\
                        (curr_col > -1) && (curr_col < size)) {
                    blur_value += in[curr_row * size + curr_col];
                    num_neighbors += 1;
                }
            }
        }

        /* Write averaged blurred value out */
        out[pix] = blur_value/num_neighbors;
    }


    return;
}

#endif /* _BLUR_FILTER_KERNEL_H_ */
