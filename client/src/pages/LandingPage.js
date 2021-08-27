import '../assets/css/Landing.css';
import illustration from "../assets/images/medical2.svg";

const LandingPage =()=>{
    return(
        <div className="landingcontainer">
            <div className="left">
            <h1 className="title">Shealth</h1>
            <p className="tagline">Organise your medical history with ease</p>
            <div className="buttons">
                <button>Login</button>
                <button>Sign Up</button>
            </div>
            </div>
            <div className="right">
                <img src={illustration}></img>
            </div>
        </div>
    )
}

export default LandingPage;