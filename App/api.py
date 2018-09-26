#!/usr/bin/python
from flask import Flask, render_template, request, jsonify, redirect
from App import methods

app = Flask(__name__)


@app.route('/', methods=['GET'])
@app.route('/index', methods=['GET'])
def index():
    return render_template('index.html', history="None")


@app.route('/result', methods=['POST'])
def results():
    if request.form['action'] == 'submit':
        number_blue = int(request.form['blue'])
        number_green = int(request.form['green'])
        num_cycles = int(request.form['cycles'])
        area = int(request.form['range'])
        ants = methods.get_ants(number_blue, number_green)
        Blue, Green, changes, hist = methods.cycle_ants(num_cycles, area, ants)
        return render_template('index.html', Blue=Blue, Green=Green, changes=changes, history=hist)
    elif request.form['action'] == 'refresh':
        return redirect("index")







