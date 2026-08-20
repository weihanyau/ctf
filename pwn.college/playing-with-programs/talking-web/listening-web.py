import os

import flask

app = flask.Flask(__name__)


@app.route("/", methods=["GET"])
def challenge():

    return """
        <html>
          <head><title>Talking Web</title></head>
        <body>
          <h1>Great job!</h1>
        </body>
        </html>
    """


app.secret_key = os.urandom(8)
app.run("localhost", 1337)
