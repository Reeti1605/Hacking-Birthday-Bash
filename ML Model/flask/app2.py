import numpy as np
from flask import flask, request, jsonify, render_template
import pickle
moodsings= flask(__name__)

#load pickle

model = pickle.load(open("model.pkl", "rb"))


@moodsings.route("/")
def Home():
    return render_template("index.html")


@moodsings.route("/predict", method=["POST"])


def predict():
    float_features = [float(x) for x in request.form.values()]
    features = [np.array(float_features)]
    prediction = moodsings.predict(features)

    return render_template("Index.html", prediction_text = "The mood is ".format(prediction))

if __name__== "__main__":
    moodsings.run(debug=True)