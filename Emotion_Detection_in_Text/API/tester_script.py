import requests


params ={
    "text": "lmao\nI am sad and wanna die\nI ma happy\nI wanna take my life",
    "depression": "true",
    "emotion": "true",
    "suicide": "true",
    "sentiment": "true"
}

try:
    r = requests.post("http://127.0.0.1:5000/get_text_analysis", params=params, timeout=5000)
    print(r.content)
except Exception as e:
    print(e)

    