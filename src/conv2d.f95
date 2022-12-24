
!!! Program to convolve 2d-image with different kernels.
!!! Used with Python scripts "img_to_matrix.py" and "mat_to_image.py".
!!! First one converts chosen image to matrix and saves it as .txt-file
!!! and after that one runs this program. After calculations one converts
!!! the convolved matrix back to image.

program conv2d
    use kernels
    implicit none

    ! Variables
    character (len = 50) :: operation, image_name
    integer :: dim1, dim2, kernel_size
    integer, dimension(2) :: target_size1
    double precision, dimension(:,:), allocatable :: kernel_matrix
    double precision, dimension(:,:), allocatable :: image, conv_image

    intrinsic transpose, sum, matmul

    !Choosing the kernel for the convolution. All kernels are size of 3x3.
    write(*, '(A)') 'Available operations are: "identity" = 1, "edge detection" = 2, "sharpen" = 3, "box blur" = 4, & 
                    & "Gaussian blur" = 5, "Gaussian blur 5x5" = 6, "Sobel x" = 7, "Sobel y" = 8'
    write(*, *) ' '
    write(*, '(A)') 'Choose an operation: '
    read(*,*) operation
    print *, ''

    ! Calling function from the module "kernels".
    call kernel_matrices(operation, kernel_size, kernel_matrix)

    ! Writing the kernel to show its values by calling subroutine from the
    ! module "matrix_module".
    write(*, '(A)') 'The chosen kernel matrix is = '
    call print_matrix(kernel_matrix)
    print *, ''

    !!! Choosing the image as a .txt-file from the folder. Text-file must
    !!! have to be such that first line contains dimension of the image
    !!! and lines below are the values of the image-matrix.
    write(*, '(A)') 'Choose the image from the folder: '
    read(*,*) image_name

    ! Reading the first line to get dimension of the image.
    open(10, file = image_name)
    read(10, *) dim1, dim2

    allocate(image(dim1, dim2))

    ! Reading the rest of lines to get the image as a matrix.
    open(10, file = image_name)
    read(10, *) image
    close(10)

    target_size1 = target_size(dim1, dim2, kernel_size)
    
    allocate(conv_image(target_size1(2), target_size1(1)))

    ! Convolving happens here.
    conv_image = real_conv(kernel_matrix, kernel_size, image, dim1, dim2, target_size1)

    ! Save the matrix as .txt-file.
    open(12, file = 'convolved_image.txt', status = 'replace', action = 'write')
    write(12, *) target_size1(1), ':',  target_size1(2)
    write(12, *) transpose(conv_image)
    close(12)

    contains

        function real_conv(kernel_matrix, kernel_size, image, dim1, dim2, target_size) result(conv_image)
            implicit none

            ! Variables
            integer :: i, j
            integer, intent(in) :: kernel_size, dim1, dim2
            integer, dimension(2), intent(in) :: target_size
            double precision, dimension(dim1, dim2), intent(in) :: image
            double precision, dimension(kernel_size, kernel_size), intent(in) :: kernel_matrix
            double precision, dimension(kernel_size, kernel_size) :: to_conv
            double precision, dimension(target_size(1), target_size(2)) :: conv_image

            ! Convolution routine.
            do i = 1, target_size(1)
                do j = 1, target_size(2)
                    to_conv = image(i:i + kernel_size, j:j + kernel_size)
                    to_conv = transpose(to_conv)
                    conv_image(i, j) = sum(to_conv * kernel_matrix)
                end do
            end do

        end function real_conv

        !!! Subroutine to print a given matrix.
        subroutine print_matrix(matrix)
            implicit none

            double precision, dimension(:,:) :: matrix
            integer :: dim1, dim2, i ,j
            intrinsic size

            dim1 = size(matrix, dim = 1)
            dim2 = size(matrix, dim = 2)

            do i = 1, dim1
                do j = 1, dim2
                    write(*, '(f10.5)', advance = 'no') matrix(i,j)
                end do
                write(*,*)
            end do

        end subroutine print_matrix

end program conv2d

!!! TO COMPILE, RUN
! gfortran -c kernels.f95 conv2d.f95
! gfortran kernels.o conv2d.o
! ./a.out
