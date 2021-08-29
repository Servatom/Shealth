import { useState } from "react";
import { Redirect } from "react-router-dom";
import "../assets/css/Form.css";
import choiceimg from "../assets/images/choice.svg";
import RegisterForm from "../components/RegisterForm";
const Register=()=>{
    
    const [choose, setChoose] = useState(false);
    const [isPatient, setIsPatient] = useState(null);

    const selectDoctor=()=>
        {
            setChoose(true);
            setIsPatient(false);
        }
    const selectPatient=()=>
        {
            setChoose(true);
            setIsPatient(true);
        }
    
    const [created, setCreated] = useState(false);
    
    return(

        <>
        {
            !choose?
            <div className="choice">
                <h1>Register as:</h1>
                <div className="buttons">
                    <button onClick={selectDoctor}>Doctor</button>
                    <button onClick={selectPatient}>Patient</button>
                </div>
                <img className="choiceimg" src={choiceimg}/>
            </div>
            :
            created?<Redirect to="/login"/>:<RegisterForm isPatient={isPatient} onRegister={setCreated}/>
        }
        
        
        </>
    )
}
export default Register;