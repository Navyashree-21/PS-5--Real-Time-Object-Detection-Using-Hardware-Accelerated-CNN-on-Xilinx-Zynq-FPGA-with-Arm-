import os
from feature_extraction import extract_feature
from knn_classifier import knn_predict

def evaluate(dataset_path, cnn, class_map):
    features, labels = [], []

    for cls, lbl in class_map.items():
        cls_dir = os.path.join(dataset_path, cls)
        for img in os.listdir(cls_dir)[:100]:
            feature = extract_feature(os.path.join(cls_dir, img))
            cnn.write(0x04, feature)
            cnn.write(0x08, 1)
            cnn.write(0x0C, -200)
            cnn.write(0x00, 1)
            score = cnn.read(0x10)

            features.append(score)
            labels.append(lbl)

    correct, total = 0, 0
    for cls, lbl in class_map.items():
        cls_dir = os.path.join(dataset_path, cls)
        for img in os.listdir(cls_dir)[:30]:
            feature = extract_feature(os.path.join(cls_dir, img))
            cnn.write(0x04, feature)
            cnn.write(0x08, 1)
            cnn.write(0x0C, -200)
            cnn.write(0x00, 1)
            score = cnn.read(0x10)

            pred = knn_predict(score, features, labels)
            if pred == lbl:
                correct += 1
            total += 1

    print("Accuracy:", (correct / total) * 100, "%")
