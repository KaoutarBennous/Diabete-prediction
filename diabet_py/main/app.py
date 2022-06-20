# Importing essential libraries
from flask import Flask, render_template, request
import pickle
import os
import numpy as np


# Load the Random Forest CLassifier model
filename = 'diabetes-prediction-rfc-model.pkl'
classifier = pickle.load(open(filename, 'rb'))

script_dir = os.path.dirname(os.path.abspath(__file__))
app = Flask(__name__, template_folder=f"{script_dir}/../templates", static_folder=f"{script_dir}/../static")
app.secret_key = 'many random bytes'

@app.route('/')

@app.route('/home')
def home_page():
    return render_template('index.html')

@app.route('/prediction')
def predict_page():
    return render_template('predict.html')

@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        preg = request.form['pregnancies']
        glucose = request.form['glucose']
        bp = request.form['bloodpressure']
        st = request.form['skinthickness']
        insulin = request.form['insulin']
        bmi = request.form['bmi']
        dpf = request.form['dpf']
        age = request.form['age']


        data = np.array([[preg, glucose, bp, st, insulin, bmi, dpf, age]])
        my_prediction = classifier.predict(data)

        return render_template("result.html", prediction=my_prediction)

@app.route('/diagrammes')
def diagrammes_page():
    return render_template('tableaubord.html')

if __name__ == '__main__':
    app.run(debug=True)