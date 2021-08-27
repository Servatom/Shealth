
const Register=()=>{
    return(
        <div className="form-wrapper">
            <form>
                    <label>Email ID</label>
                    <input type="email" required />
                    <label>Full Name</label>
                    <input type="text" required/>
                    <label>Password</label>
                    <input type="password" required/>
                    <label>Confirm Password</label>
                    <input type="password" required/>
                    <button type="submit" className="registerBtn" >Register</button>
                </form>

        </div>
    )
}
export default Register;