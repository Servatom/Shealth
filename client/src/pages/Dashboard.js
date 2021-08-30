import { useContext, useEffect, useState } from "react";
import "../assets/css/Dashboard.css";
import Addfile from "../components/Addfile";
import Record from "../components/Record";
import RecordList from "../components/RecordList";
import SideNav from "../components/SideNav";
import AuthContext from "../store/auth-context";

const Dashboard=(props)=>
{
    
    const [profile, setProfile]= useState({});
    const [addFile, setAddFile] = useState(false);

    const authCtx = useContext(AuthContext);
    const [token, setToken] = useState(authCtx.token);
    const [email, setEmail] = useState(authCtx.email);


    console.log("Token "+token);
    console.log(email);

   useEffect(()=>{
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Token "+token);
        myHeaders.append("Content-Type", "application/json");
        
        
        var raw = JSON.stringify({
        "email": email
        });

        var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
        };

        fetch("https://shealthapi.servatom.com/detail/", requestOptions)
        .then(response => response.json())
        .then(result => {
            console.log(result)
            setProfile(result);
        })
        .catch(error => console.log('error', error));
    },[])

    

    return(
        
        <div className="dashboard">
            <div className="nav">
                <SideNav onAdd={setAddFile}/>
            </div>
            <div className="dashright">
                <h1 className="welcome">Welcome, {profile.name}!</h1>
                <RecordList/>
            </div>
            {
                addFile?
                <Addfile onClose={setAddFile} token={token}/>
                :null
            }
        </div>
    )
}

export default Dashboard;