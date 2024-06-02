import React from "react";
import ReactDOM from "react-dom";
import { PublicClientApplication } from "@azure/msal-browser";

const msalConfig = {
    auth: {
        clientId: "your-client-id",
        authority: "https://login.microsoftonline.com/your-tenant-id",
        redirectUri: "http://localhost:3000",
    },
};

const msalInstance = new PublicClientApplication(msalConfig);

const loginRequest = {
    scopes: ["openid", "profile", "User.Read"],
};

function App() {
    const handleLogin = () => {
        msalInstance.loginPopup(loginRequest)
            .then(response => {
                console.log("ID Token: ", response.idToken);
            })
            .catch(error => {
                console.error("Login error: ", error);
            });
    };

    return (
        <div>
            <h1>Welcome to the React App</h1>
            <button onClick={handleLogin}>Login with Azure AD</button>
        </div>
    );
}

ReactDOM.render(<App />, document.getElementById("root"));
