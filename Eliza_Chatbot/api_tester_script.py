import requests

POST_URL = "http://localhost:80/response"

params = {'msg': 'hello'}

r = requests.post(POST_URL, params=params )
print(r.text)
