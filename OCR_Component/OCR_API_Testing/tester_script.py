import requests

POST_URL = "http://localhost:81/extract_text_from_img"


with open('text_msg.jpeg', 'rb') as f:
    r = requests.post(POST_URL, files={"file": f} )
    print(r.text)
