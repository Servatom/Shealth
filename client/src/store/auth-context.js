import React, { useState } from 'react';

const AuthContext = React.createContext({
    token: '',
    email: '',
    isLoggedIn: false,
    login: (token)=>{},
    setEmail:(email)=>{},
    logout: ()=>{}
});

export const AuthContextProvider = (props)=>
{
    const [token, setToken] = useState(null);
    const [email, setEmail] = useState(null);

    const userIsLoggedIn = !!token;
    const loginHandler=(token)=>
    {
        setToken(token);
    }
    const emailHandler=(email)=>
    {
        setEmail(email);
    }

    const logoutHandler=()=>
    {
        setToken(null);
        setEmail(null);
    }

    const contextValue={
        token: token,
        email: email,
        isLoggedIn: userIsLoggedIn,
        login: loginHandler,
        setEmail: emailHandler,
        logout: logoutHandler
    }
    
    return <AuthContext.Provider value={contextValue}>
        {props.children}
        </AuthContext.Provider>
}

export default AuthContext;