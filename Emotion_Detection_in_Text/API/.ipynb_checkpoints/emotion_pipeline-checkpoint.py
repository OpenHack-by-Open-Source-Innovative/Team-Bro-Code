import numpy as np 
import pandas as pd

from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences

import nltk
from nltk.corpus import stopwords
import string
import pickle
import re

tokenizer = pickle.load(open("./emotion_tokenizer.obj", "rb"))

model = load_model("./emotion_pred_model.h5")

#============== Sub Functions =======================#
# Tweets cleaning

def remove_hashtags_mentions(sent):
    removed_mentions = re.sub("@[A-Za-z0-9_]+", "", sent)
    removed_hashtags = re.sub("#[A-Za-z0-9_]+","", removed_mentions)
    return removed_hashtags


# lowercase
def lower_case(sent):
    return sent.lower()


# Removing Punctuation
def remove_punctuation(sent):
    return " ".join([char for char in sent.split() if char not in string.punctuation])

def clean_pipeline(sentence):
    
    sent = remove_hashtags_mentions(sentence)
    sent = lower_case(sent)
    sent = remove_punctuation(sent)

    if sent is float:
        return None
    
    return sent

embedding_dim = 300
max_length = 350
trunc_type='post'
padding_type='post'
oov_tok = "<OOV>"

#===================================================#

emotion_dict = ['anger', 'happiness', 'neutral', 'sadness', 'surprise']

def emotion_pipeline(text):
    if type(text) is str:
        p_text = clean_pipeline(text)
        sequences = tokenizer.texts_to_sequences([p_text])
    else:
        p_text = [clean_pipeline(x) for x in text]
        sequences = tokenizer.texts_to_sequences(p_text)
        
    padded = pad_sequences(sequences, maxlen=max_length, padding=padding_type, truncating=trunc_type)
    padded = np.array(padded)
    
    pred_l = model.predict(padded)
    
    pred = [np.argmax(x) for x in pred_l]
    emotion = [emotion_dict[x] for x in pred]
    
    percentage = [x * 100 for x in pred_l]
    percentage = [list(map(str, l)) for l in percentage]
    
    return list(zip(emotion, percentage))
