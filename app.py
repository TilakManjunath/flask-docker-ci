from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from GitHub Actions!"

if __name__ == "__main__":
    # listen on 0.0.0.0 so Docker can expose it; port 5000 as requested
    app.run(host="0.0.0.0", port=5000)
