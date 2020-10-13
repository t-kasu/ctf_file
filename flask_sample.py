#!/usr/bin/python3.7

from flask import Flask
app = Flask(__name__)
 
@app.route('/')
def hello():
    hello = "Hello!!"
    return hello
 
if __name__ == "__main__":
    app.run(host='0.0.0.0',port='5000')
