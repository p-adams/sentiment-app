import json
from bottle import route, run, template, request, HTTPResponse, post, get
from textblob import TextBlob
state = {"polarity": None, "subjectivity": None}

@get("/sentiment")
def index():
    return HTTPResponse(status = 200, body=json.dumps(state))


@post("/sentiment")
def index():
    text = request.body.read().decode('utf-8')
    if text:
        print(text)
        blob = TextBlob(text)
        state["polarity"] = blob.sentiment.polarity
        state["subjectivity"] = blob.sentiment.subjectivity
        return HTTPResponse(status = 201)

@route("/")
def index():
    return template("index")

run(host="localhost", port=8080)