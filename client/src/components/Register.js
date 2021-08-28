import "../assets/css/Form.css";
const Register=()=>{
    return(
        <div className="form-wrapper">
            <form>
                    <label>Name</label>
                    <input type="text" required />
                    <label>Email</label>
                    <input type="email" required/>
                    <label>Phone</label>
                    <input type="number" required/>
                    <label>Country</label>
                    <input type="text" required />
                    <label>State</label>
                    <input type="text" required />
                    <label>City</label>
                    <input type="text" required />
                    <label>Password</label>
                    <input type="password" required/>
                    <button type="submit" className="registerBtn" >Register</button>
                </form>

        </div>
    )
}
export default Register;