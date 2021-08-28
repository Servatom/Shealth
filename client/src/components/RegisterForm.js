import { useState } from "react";
import "../assets/css/Form.css";
import yoga from "../assets/images/yoga.svg";
import "../assets/css/loader.css";

const RegisterForm=(props)=>
{
    const [name, setName] = useState("");
    const nameChangeHandler=(event)=>
    {
        setName(event.target.value);
    }

    const [speciality, setSpeciality] = useState("");
    const specialityChangeHandler=(event)=>
    {
        setSpeciality(event.target.value);
    }

    const [age, setAge] = useState("");
    const ageChangeHandler=(event)=>
    {
        setAge(event.target.value);
    }

    const [gender, setGender] = useState("");
    const genderChangeHandler=(event)=>
    {
        setGender(event.target.value);
    }

    const [phone, setPhone] = useState("");
    const phoneChangeHandler=(event)=>
    {
        setPhone(event.target.value);
    }

    const [email, setEmail] = useState("");
    const emailChangeHandler=(event)=>
    {
        setEmail(event.target.value);
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



    const registerHandler=(e)=>{

        e.preventDefault();
        setLoading(true);

        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");

        if(!props.isPatient)
        {

            var raw = JSON.stringify({
            "name": name,
            "email": email,
            "phone": phone,
            "speciality": speciality,
            "password": pass
            });

            var requestOptions = {
            method: 'POST',
            headers: myHeaders,
            body: raw,
            redirect: 'follow'
            };

            fetch("https://shealthapi.servatom.com/register/d/", requestOptions)
            .then(response => {
                const data= response.json();
                setLoading(false)
                //  if(response.status==201)
                //  setCreated(true)
 
                return data;
             })
             .then(result => {
                 console.log(result)
                 
                 let firstkey = Object.keys(result)[0];
                 
                 setError(
                     {
                         status: true,
                         body: result[firstkey]
                     }
                 )
                 
             })
             .catch(error => 
            {console.log('error', error);
             setLoading(false);
            });
        }
        else
        {

            var raw = JSON.stringify({
            "name": name,
            "email": email,
            "phone": phone,
            "age": age,
            "sex": gender,
            "password": pass
            });

            var requestOptions = {
            method: 'POST',
            headers: myHeaders,
            body: raw,
            redirect: 'follow'
            };

            fetch("https://shealthapi.servatom.com/register/p/", requestOptions)
            .then(response => {
                const data= response.json();
                setLoading(false)
                //  if(response.status==201)
                //  setCreated(true)
 
                return data;
             })
            .then(result => {
                 console.log(result)
                 
                 let firstkey = Object.keys(result)[0];
                 
                 setError(
                     {
                         status: true,
                         body: result[firstkey]
                     }
                 )
                 
             })
            .catch(error => {console.log('error', error);
            setLoading(false);
            });
        }
    }

    return(
        <div className="register">
                <div className="form-wrapper">
                    <form>
                        <h1>Register</h1>
                            <label>Name</label>
                            <input type="text" required onChange={nameChangeHandler} value={name}/>
                            {
                                props.isPatient?
                                <>
                                    <label>Age</label>
                                    <input type="number" required onChange={ageChangeHandler} value={age}/>
                                    <label>Gender</label>
                                    <select name="gender" id="gender" onChange={genderChangeHandler} value={gender}>
                                        <option selected value="None">None</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Others">Others</option>
                                    </select>
                                </>
                                :<>
                                    <label>Speciality</label>
                                    <input type="text" required onChange={specialityChangeHandler} value={speciality}/>
                                </>
                            }
                            
                            <label>Phone</label>
                            <input type="number" required onChange={phoneChangeHandler} value={phone}/>
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
                                error.status?<span className="warning error">{error.body}</span>:null
                            }
                            <button type="submit" className="registerBtn" onClick={registerHandler} >Register</button>
                            {
                                loading?
                                <div className="lds-ring"><div></div><div></div><div></div><div></div></div>
                                :null
                            }
                    </form>

                </div>
                <img className="form-img" src={yoga}/>
            </div>
    )
}
export default RegisterForm;