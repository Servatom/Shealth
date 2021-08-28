import { useState } from "react";
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
            <RegisterForm isPatient={isPatient}/>
        }
        
        
        </>
    )
}
export default Register;