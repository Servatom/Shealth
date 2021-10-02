import { useContext, useEffect, useState } from "react";
import "../assets/css/Dashboard.css";
import Addfile from "../components/Addfile";
import Record from "../components/Record";
import RecordList from "../components/RecordList";
import SideNav from "../components/SideNav";
import AuthContext from "../store/auth-context";
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';


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

    const [currentTab, setCurrentTab] = useState(1);

    return(
        
        <div className="dashboard">
            <div className="nav">
                <SideNav onAdd={setAddFile}
                setCurrentTab={setCurrentTab}
                currentTab={currentTab}/>
            </div>
            <div className="dashright">
                <h1 className="welcome">Welcome, {profile.name}!</h1>
                <Switch>
                    <Route exact path='/dashboard'>
                        <div className="records">
                            <RecordList records={records}/>
                        </div>
                    </Route>
                    <Route path='/dashboard/reports'>
                        <div className="records">
                            <h1>Reports Screen</h1>
                        </div>
                    </Route>
                    <Route path='/dashboard/add_Doc'>
                        <div className="records">
                            <h1>Add Doc</h1>
                        </div>
                    </Route>
                    <Route path='/dashboard/settings'>
                        <div className="records">
                            <h1>Add Doc</h1>
                        </div>
                    </Route>
                </Switch>
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