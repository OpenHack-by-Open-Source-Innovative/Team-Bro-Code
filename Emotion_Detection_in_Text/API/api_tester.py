import requests

POST_URL = "http://localhost:83/get_text_analysis"


params = {'text': 'I am feeling happy', 'depression':"true", "emotion":"true", "suicide":"true"}

r = requests.post(POST_URL, params=params )
print(r.content)