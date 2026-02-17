import cv2
import numpy as np

def extract_feature(img_path):
    img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
    img = cv2.resize(img, (32, 32))

    mean = int(np.mean(img))
    var  = int(np.var(img))
    mx   = int(np.max(img))

    feature = mean + (var >> 4) + mx
    return feature
