import os

from flask import Flask, redirect, request, session, url_for
from msal import ConfidentialClientApplication

app = Flask(__name__)
app.secret_key = os.getenv("FLASK_SECRET_KEY", "your-secret-key")

CLIENT_ID = os.getenv("CLIENT_ID", "your-client-id")
CLIENT_SECRET = os.getenv("CLIENT_SECRET", "your-client-secret")
AUTHORITY = f"https://login.microsoftonline.com/{os.getenv('TENANT_ID', 'your-tenant-id')}"
REDIRECT_URI = os.getenv(
    "REDIRECT_URI", "http://localhost:5000/getAToken"
)
SCOPE = ["User.Read"]

msal_app = ConfidentialClientApplication(
    CLIENT_ID, authority=AUTHORITY, client_credential=CLIENT_SECRET
)


@app.route("/")
def index():
    if "user" in session:
        return f'Hello, {session["user"]["name"]}!'
    return (
        'Hello, you are not logged in. <a href="/login">Login</a>'
    )


@app.route("/login")
def login():
    auth_url = msal_app.get_authorization_request_url(
        SCOPE, redirect_uri=REDIRECT_URI
    )
    return redirect(auth_url)


@app.route("/getAToken")
def authorized():
    if "code" not in request.args:
        return redirect(url_for("index"))

    code = request.args["code"]
    result = msal_app.acquire_token_by_authorization_code(
        code, scopes=SCOPE, redirect_uri=REDIRECT_URI
    )

    if "access_token" in result:
        session["user"] = result.get("id_token_claims")
        return redirect(url_for("index"))
    return "Could not authenticate."


@app.route("/logout")
def logout():
    session.clear()
    return redirect(
        f"https://login.microsoftonline.com/common/oauth2/v2.0/logout?post_logout_redirect_uri={url_for('index', _external=True)}"
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
