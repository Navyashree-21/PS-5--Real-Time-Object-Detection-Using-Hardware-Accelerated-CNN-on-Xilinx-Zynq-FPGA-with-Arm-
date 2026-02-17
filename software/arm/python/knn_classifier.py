def knn_predict(test_feature, features, labels, k=5):
    distances = [(abs(test_feature - f), lbl) for f, lbl in zip(features, labels)]
    distances.sort(key=lambda x: x[0])
    topk = distances[:k]

    votes = {}
    for _, lbl in topk:
        votes[lbl] = votes.get(lbl, 0) + 1

    return max(votes, key=votes.get)
