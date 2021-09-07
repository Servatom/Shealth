import loginimg from "../assets/images/security.svg";
import { useContext, useState } from "react";
import "../assets/css/loader.css";
import AuthContext from "../store/auth-context";
import { Link, Redirect, useHistory } from "react-router-dom";

const Login =()=>
{
    
    
    const authCtx = useContext(AuthContext);
    const history = useHistory();
    
    const [email, setEmail] = useState("");
    const emailChangeHandler=(event)=>
    {
        setEmail(event.target.value);
        authCtx.setEmail(event.target.value);
    }

    const [pass, setPass] = useState("");
    const passChangeHandler=(event)=>
    {
        setPass(event.target.value);
    }

    const [loading, setLoading] = useState(false);
    const [error, setError] = useState({
        status: false,
        body: ""
    });

    const loginHandler=(e)=>
    {
        e.preventDefault();
        setLoading(true);

        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");
        myHeaders.append("Cookie", "cf_ob_info=520:6862f273df140f00:BOM; cf_use_ob=443");

        var raw = JSON.stringify({
        "email": email,
        "password": pass
        });

        var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
        };

        fetch("https://shealthapi.servatom.com/auth/login/", requestOptions)
        .then(response => {
 
            const data= response.json();
            setLoading(false)

            return data;
         })
         .then(result => {
             
             
             console.log(result.key, email);
             authCtx.login(result.key);

             if(result.key)
             history.replace("/dashboard");
            let firstkey = Object.keys(result)[0];

             setError(
                 {
                     status: true,
                     body: result[firstkey]
                 }
             )

             if(result.key)
             setError(
                {
                    status: true,
                    body: "Loggin successful"
                }
            )
             
         })
         .catch(error => 
        {console.log('error', error);
         setLoading(false);
         
        });
    }
    
    return(
        <div className="login">
                <div className="form-wrapper">
                    <form>
                        <h1>Login</h1>
                        <p>New User? <Link to="/register">Register Here</Link></p>
                            {/* <label>Country</label>
                            <input type="text" required />
                            <label>State</label>
                            <input type="text" required />
                            <label>City</label>
                            <input type="text" required /> */}
                            <label>Email</label>
                            <input type="email" required onChange={emailChangeHandler} value={email}/>
                            <label>Password</label>
                            <input type="password" required onChange={passChangeHandler} value={pass}/>
                            {
                                error.status?<span className="reqmsg">{error.body}</span>:null
                            }
                            <button type="submit" className="registerBtn" onClick={loginHandler} >Login</button>
                            {
                                loading?
                                <div className="lds-ring"><div></div><div></div><div></div><div></div></div>
                                :null
                            }
                    </form>
                </div>
                <img className="form-img" src={loginimg}/>
            </div>
    )
}
export default Login;