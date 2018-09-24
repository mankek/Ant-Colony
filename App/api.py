#!/usr/bin/python
from flask import Flask
import random

app = Flask(__name__)


@app.route('/')
@app.route('index')
def index():
    return "Nothing yet!"






