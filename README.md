# Blur_CUDA
The program expects a command-line argument (size) to be passed when executed. This size represents the height of the square image to be processed. The program assumes that the image is size x size.

The program uses the following data structures to store the input and output images:

image_t: A structure containing the image size (height) and a pointer to a float array storing the pixel values.
The main function allocates memory for the input and output images, populates the input image with random values between [-0.5, 0.5], and then calculates the blur on the CPU using the compute_gold function. The resulting blurred image is stored in out_gold.

The compute_gold function is provided separately and computes the blur on the CPU using a sequential implementation.

The compute_on_device function is not yet implemented (marked with FIXME). This function is responsible for calculating the blur on the GPU using CUDA parallel processing.

To perform the GPU computation, the function first allocates memory on the GPU for the input and output images (in_on_device and out_on_device) using cudaMalloc. Then, it copies the input image data from the host to the GPU using cudaMemcpy. The function launches a CUDA kernel (blur_filter_kernel) to perform the blur computation on the GPU.

The blur_filter_kernel function, defined in the separate file blur_filter_kernel.cu, is responsible for the actual blur computation on the GPU. The function is not shown here, but it should be available in the blur_filter_kernel.cu file.

After GPU computation is complete, the results are copied back from the GPU to the host using cudaMemcpy.

The program then checks the correctness of the GPU results by comparing them with the CPU results using the check_results function. The function checks whether the relative difference between each corresponding pixel value is within a predefined threshold (eps). If the difference exceeds the threshold for any pixel, the test is considered failed.

The program prints the image contents before and after the blur using the print_image function (enabled by the DEBUG flag, which is currently commented out).

Finally, the allocated memory for the input and output images on the host is freed using free.

To use the program, you need to compile it with the provided Makefile by running make. After compilation, execute the program as follows: ./blur_filter size, where size is the height of the square image.
