from flask import (Flask, make_response, request, g, current_app)
import json
import sys
import logging

app = Flask(__name__)

@app.route("/", methods=['GET'])
def root():
    resp = make_response("Sum app, use /sum?a=2&b=3")
    resp.headers['Content-Type'] = 'text/plain'
    return resp

@app.route("/sum", methods=['GET'])
def sum():
    a = request.args['a'] if 'a' in request.args else 0
    b = request.args['b'] if 'b' in request.args else 0
    res = str(int(a) + int(b))
    resp = make_response(res)
    resp.headers['Content-Type'] = 'text/plain'
    return resp

def main():
    app.debug = True
    app.run(host='0.0.0.0', port=int(sys.argv[1]))

if __name__ == "__main__":
    main()
