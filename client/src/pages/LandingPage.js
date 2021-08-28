import '../assets/css/Landing.css';
import illustration from "../assets/images/medical2.svg";
import {Redirect, Link} from 'react-router-dom';
import logo from "../assets/images/logo2.png";

const LandingPage =()=>{
    

    return(
        <div className="landingcontainer">
            <div className="left">
                <div className="header">
                <img src={logo}/>
                <h1 className="title">Shealth</h1>
                </div>
            
            <p className="tagline">Organise your medical history with ease</p>
            <div className="buttons">
                <Link to="/login"><button>Login</button></Link>
                <Link to='/register' ><button>Register</button></Link>
            </div>
            </div>
            <div className="right">
                <img src={illustration}></img>
            </div>
        </div>
    )
}

export default LandingPage;