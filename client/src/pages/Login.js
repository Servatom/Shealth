import loginimg from "../assets/images/security.svg";

const Login =()=>
{
    return(
        <div className="login">
                <div className="form-wrapper">
                    <form>
                        <h1>Login</h1>
                            {/* <label>Country</label>
                            <input type="text" required />
                            <label>State</label>
                            <input type="text" required />
                            <label>City</label>
                            <input type="text" required /> */}
                            <label>Email</label>
                            <input type="email" required/>
                            <label>Password</label>
                            <input type="password" required/>
                            <button type="submit" className="registerBtn" >Login</button>
                    </form>
                </div>
                <img className="form-img" src={loginimg}/>
            </div>
    )
}
export default Login;