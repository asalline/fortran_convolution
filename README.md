# 2D convolution implemented in Fortran 95

The convolution is mathematical background in image processing and image filters. 
It uses elementwise-multiplication and addition to change picture with given filter.

There is alot of articles and videos about convolution so I am not going to give any explanation here on how it works.

My convolution scripts are made with Fortran and Python.
Python scripts are to download images, transfer them into grayscale pixel-valued matrices and then read them back and show them.
Fortran is used to crunch the numbers.

To use my scripts do the following:
1. Be sure that you have some kind of working Fortran compiler (I used gfortran) and that you have Python3 installed.
2. Download the "src"-folder and name it what you want.
3. Take any picture and add it into the folder where the scripts are. (I have some pictures I used in "pics"-folder)
4. Run the scripts in terminal with command given below
5. Follow the orders in the terminal.

### Command to compile and run the scripts
`python3 img_to_matrix.py && **your Fortran compiler here** -c kernels.f95 conv2d.f95 && **your Fortran compiler here** kernels.o conv2d.o && ./a.out && python3 mat_to_image.py`

**Author:** asalline

**year:** 2022

