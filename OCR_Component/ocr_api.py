import traceback
import numpy as np
import pytesseract
import cv2
from flask import Flask, request
import json
from skimage import io

# Uncomment below line or put the tesseract ocr folder path in the environment variables
pytesseract.pytesseract.tesseract_cmd = "./Tesseract-OCR/tesseract.exe"

# Iniatlize a Flask app
app = Flask('app')

def get_string(img):
	# Read image using opencv
	# img = cv2.imread(file)
	
	# Rescale the image, if needed.
	img = cv2.resize(img, None, fx=1.5, fy=1.5, interpolation=cv2.INTER_CUBIC)

	# Convert to gray
	img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

	# Apply dilation and erosion to remove some noise
	kernel = np.ones((1, 1), np.uint8)
	img = cv2.dilate(img, kernel, iterations=1)
	img = cv2.erode(img, kernel, iterations=1)
	# Apply blur to smooth out the edges
	img = cv2.GaussianBlur(img, (5, 5), 0)

	# Apply threshold to get image with only b&w (binarization)
	img = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]

	# Recognize text with tesseract for python
	result = pytesseract.image_to_string(img, lang="eng")
	return result[:-2]


@app.route('/extract_text_from_img', methods=['GET', 'POST'])
def extract_text_from_img():
	if request.method == 'GET':
		return "<h1>Extract Text Path Works</h1>"
	elif request.method == 'POST':
		try:
			file = request.files["file"]
			npimg = np.fromfile(file, np.uint8)
			file = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
			extracted_string = get_string(file)
			return json.dumps({"code":200, "extracted": extracted_string})
		except Exception as e:
			print(traceback.format_exc())
			return json.dumps({"code":500, "extracted": "", "error":str(e)})
	else:
		return "Unknown Return Type"


@app.route('/extract_text_from_url', methods=['GET', 'POST'])
def extract_text_from_url():
	if request.method == 'GET':
		return "<h1>Extract Text Path from URL Works</h1>"
	elif request.method == 'POST':
		try:
			URL = request.args.get("url")
			file = io.imread( URL )
			print(type(file))
			extracted_string = get_string(file)
			return json.dumps({"code":200, "extracted": extracted_string})
		except Exception as e:
			print(traceback.format_exc())
			return json.dumps({"code":500, "extracted": "", "error":str(e)})
	else:
		return "Unknown Return Type"


if __name__ == '__main__':
    app.run(host='localhost', port=81, debug=False)