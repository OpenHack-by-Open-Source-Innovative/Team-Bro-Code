import traceback
import numpy as np
import cv2
from flask import Flask, request, send_file
import json

from depression_pipeline import depression_pipeline
from emotion_pipeline import emotion_pipeline
from suicide_pipeline import suicide_pipeline
from sentiment_analyzer import sentiment_pipeline

# Iniatlize a Flask app
app = Flask('app')

emotion_dict = ['anger', 'happiness', 'neutral', 'sadness', 'surprise']
sentiment_dict = ["Negative", "Neutral", "Positive"]

@app.route('/get_text_analysis', methods=['GET', 'POST'])
def get_text_analysis():
    return_dict = {}
    if request.method == 'POST':
        try:
            return_dict = {"emotion_dict": emotion_dict}
            return_dict["sentiment_dict"] = sentiment_dict
            if request.args.get("text"):
                text = request.args.get("text")
            else:
                raise Exception("No Text arg provided")

            if request.args.get("depression"):
                dep_pred = depression_pipeline(text.split("\n"))
                return_dict["depression"] = dep_pred

            if request.args.get("emotion"):
                emotion_pred = emotion_pipeline(text.split("\n"))
                return_dict["emotion"] = emotion_pred

            if request.args.get("suicide"):
                suicide_pred = suicide_pipeline(text.split("\n"))
                return_dict["suicide"] = suicide_pred
            
            if request.args.get("sentiment"):
                sentiment_pred = sentiment_pipeline(text.split("\n"))
                return_dict["sentiment"] = sentiment_pred
            

            return json.dumps(return_dict)
        except Exception as e:
            print(e)
            return json.dumps({"Status": 500})
    else:
        return "Infer route"


if __name__ == '__main__':
    app.run(host='localhost', port=83)
