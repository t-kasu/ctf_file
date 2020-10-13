#!/usr/bin/python3.7

import os
import sqlite3
import getuser
import requests

from flask import Flask
from flask import redirect
from flask import request

app = Flask(__name__)

app.secret_key = 'ctf-sql-injection'

DATABASE_PATH = os.path.join(os.path.dirname(__file__), 'database.db')

def init():
    users = [
        ('user1', '123456', 'CTFlaguser1'),
        ('user2', '123456', 'CTFlaguser2')
    ]
    conn = sqlite3.connect(DATABASE_PATH)
    cur = conn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS user(username VARCHAR(32), password VARCHAR(32), flag VARCHAR(32) )")
    cur.executemany('INSERT INTO user VALUES(?,?,?)', users)
    conn.commit()
    conn.close()


def login_page():
    return '''
<form method="POST" style="margin:0 auto; width:140px;">
    <p>ID<input name="username" type="text" /></p>
    <p>Pass<input name="password" type="password" /></p>
    <p><input value="Login" type="submit" /></p>
</form>
<p>

<br>

<div style="text-align:center">Please push the button if you modified a program.</div>
<form action="/check" method="GET" style="margin: 0 auto; width:140px;">
    <p><input value="Check Injection" type="submit" /></p>
</form>
    '''

@app.route('/')
def index():
    init()
    return redirect('/login')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return login_page()
    elif request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user_flag = getuser.get_flag(username, password)
	
        return user_flag

@app.route('/check', methods=['GET'])
def check():

        url = "http://localhost:5000/login"
        s = requests.session()
        param1 = { "username":"user1", "password":"123456" }
        param2 = { "username":"user1", "password":"123457' or '1' = '1';--" }

        r1 = s.post(url, data = param1)
        r2 = s.post(url, data = param2)

        if r1.text=="CTFlaguser1" and r2.text=="Error":
           check_result= "Flag is bear"
        else:
           check_result= "Not correct"
        return check_result

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
