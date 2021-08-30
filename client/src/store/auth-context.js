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
        localStorage.setItem('token',JSON.stringify(token));
        localStorage.setItem('userEmail',JSON.stringify(email));
        localStorage.setItem('isLoggedIn',JSON.stringify(userIsLoggedIn));
    }
    const emailHandler=(email)=>
    {
        setEmail(email);

    }

    const logoutHandler=()=>
    {
        setToken(null);
        setEmail(null);
        localStorage.setItem('token',null);
        localStorage.setItem('userEmail',null);
        localStorage.setItem('isLoggedIn',false);
        
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