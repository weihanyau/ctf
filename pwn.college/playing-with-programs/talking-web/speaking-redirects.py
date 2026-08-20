import os

import flask

app = flask.Flask(__name__)


@app.route("/", methods=["GET"])
def challenge():

    return flask.redirect("http://challenge.localhost:80/complete")


app.secret_key = os.urandom(8)
app.run("localhost", 1337)
