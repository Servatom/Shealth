import { useContext, useEffect, useState } from "react";
import "../assets/css/Dashboard.css";
import Addfile from "../components/Addfile";
import Record from "../components/Record";
import RecordList from "../components/RecordList";
import SideNav from "../components/SideNav";
import AuthContext from "../store/auth-context";

const Dashboard=()=>
{
    
    const [profile, setProfile]= useState({});
    const [addFile, setAddFile] = useState(false);

    const authCtx = useContext(AuthContext);




   useEffect(()=>{
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Token "+authCtx.token);
        myHeaders.append("Content-Type", "application/json");
        
        
        var raw = JSON.stringify({
        "email": authCtx.email
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

    
    const [records, setRecords] = useState(()=>[]);
    
    const getRecords=()=>{

        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Token "+authCtx.token);
        myHeaders.append("Content-Type", "application/json");

        var raw = JSON.stringify({
        "email": authCtx.email
        });

        var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
        };

        fetch("https://shealthapi.servatom.com/patient/records/", requestOptions)
        .then(response => response.json())
        .then(result => {
            console.log(result);
            setRecords(result);
        })
        .catch(error => console.log('error', error));

    }

    useEffect(()=>{
        getRecords();
    },[])

    return(
        
        <div className="dashboard">
            <div className="nav">
                <SideNav onAdd={setAddFile}/>
            </div>
            <div className="dashright">
                <h1 className="welcome">Welcome, {profile.name}!</h1>
                <div className="records">
                    <RecordList records={records}/>
                </div>
            </div>
            {
                addFile?
                <Addfile onClose={setAddFile} token={authCtx.token} fetchRecords={getRecords}/>
                :null
            }
        </div>
    )
}

export default Dashboard;