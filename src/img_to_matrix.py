from PIL import Image, ImageOps
import matplotlib.pyplot as plt
import numpy as np
import os

### Function to load the picture by a name from folder where this script is.
### Also, if user wants to resize picture, it happens here.
def converter(filename, resize):
    path = os.path.dirname(os.path.abspath(__file__))
    final_path = os.path.join(path, filename)
    img = Image.open(final_path)
    img = ImageOps.grayscale(img)
    if resize == 'Y':
        size1 = int(input("How wide do you want the picture to be?: "))
        size2 = int(input("How high do you want the picture to be?: "))
        img = img.resize(size = (size1, size2))

    return img

### Function to plot image in grayscale.
def plot_image(image):
    plt.figure(figsize = (10, 10))
    plt.imshow(image, cmap = 'gray')
    plt.show()

### Couple of inputs.
filename = input("Type the name and the type of the image to convert it: ")
savename = str(input("Type the name you want to save picture: "))
savename = savename + '.txt'
resize = input("Do you want to resize the picture? Y / N: ")

### Running the functions.
img = converter(filename, resize)
plot_image(img)

### Couple of needed parameters.
img_as_np = np.asarray(img)
img_size = np.size(img)
img_size1 = str(img_size[0])
img_size2 = str(img_size[1])
img_size = ','.join([img_size1, img_size2])

### Saving the .txt-file.
np.savetxt(savename, img_as_np, fmt = '%7.3f', header = img_size, comments = '')
