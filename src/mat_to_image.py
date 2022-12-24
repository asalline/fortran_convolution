from PIL import Image
import numpy as np

### Function to set all under-zero values to exactly zero.
def negative_to_zero(image: np.array) -> np.array:
    image = image.copy()
    image[image < 0] = 0
    return image

### Function to set all over-255 values to exactly 255.
def over_to_max(image: np.array) -> np.array:
    image = image.copy()
    image[image > 255] = 255
    return image

### Reading the first line of .txt-file to extract dimensions of convolved picture.
sizeof = []
with open('convolved_image.txt') as f:
    sizeof1, sizeof2 = f.readline().strip('\n').split(':')
sizeof1 = int(sizeof1.strip())
sizeof2 = int(sizeof2.strip())

### Reading the matrix elements.
file = np.loadtxt(open('convolved_image.txt', 'rb'), delimiter = None, skiprows = 1)

### Using Numpy.
x = list(file)
image = np.array(x).astype('float')
image1 = np.array(image).reshape(sizeof1, sizeof2)

### Running the functions defined above.
image1 = negative_to_zero(image1)
image1 = over_to_max(image1)

image1 = np.transpose(image1)

### Showing the convolved picture.
img = Image.fromarray(image1)
img.show()
