from flask import Flask, request, jsonify
import eliza


app = Flask('app')
eliza = eliza.Eliza()
eliza.load('doctor.txt')

@app.route('/response', methods=['GET', 'POST'])
def response():
    if request.method == 'POST':
        try:
            said = request.args.get("msg")
        except Exception as e:
            print("msg not specified")
            
        try:
            response = eliza.respond(said)
        except Exception as e:
            print("response error")
            return jsonify({
                "text": "",
                "error": True
            })
        
        return jsonify({
            "text": response,
            "error": False
        })
        
    else:
        return "Response GET route is working"

if __name__ == '__main__':
    app.run(host='localhost', port=80)