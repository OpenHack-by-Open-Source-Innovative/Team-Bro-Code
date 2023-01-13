import numpy as np 
import pandas as pd

from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences

import nltk
from nltk.corpus import stopwords
import string
import pickle
import re

tokenizer = pickle.load(open("./suicide_tokenizer.obj", "rb"))
wordnet_lemmatizer = nltk.WordNetLemmatizer()
stop_words = stopwords.words('english')

model = load_model("./suicide_pred_model.h5")

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

# Tokenize
def tokenize_sent(sent):
    return nltk.word_tokenize(sent)

def filter_stopwords(tokens):
    return [word for word in tokens if word not in stop_words]

def lemmatizer(tokens):
    return [wordnet_lemmatizer.lemmatize(word) for word in tokens]

def clean_pipeline(sentence):
    sent = remove_hashtags_mentions(sentence)
    sent = lower_case(sent)
    sent = remove_punctuation(sent)
    
    sent_tokens = tokenize_sent(sent)
    sent_tokens = filter_stopwords(sent_tokens)
    
    preprocessed_tokens = lemmatizer(sent_tokens)
    
    return preprocessed_tokens

embed_size = 150 # how big is each word vector
max_feature = 5000 # how many unique words to use
max_len = 2000 # max number of words to use

def suicide_pipeline(text):
    if type(text) is str:
        p_text = clean_pipeline(text)
        sequences = tokenizer.texts_to_sequences([p_text])
    else:
        p_text = [clean_pipeline(x) for x in text]
        sequences = tokenizer.texts_to_sequences(p_text)
        
    padded = pad_sequences(sequences, maxlen=max_len)
    padded = np.array(padded)
    
    pred = model.predict(padded)
    emotion = ["Suicidal" if x > 0.5 else "Not Suicidal"  for x in pred]
    percentage = [x[0] * 100 for x in pred]

    return list(zip(emotion, percentage))
