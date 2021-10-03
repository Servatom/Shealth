import { useContext, useEffect, useState } from "react";
import "../assets/css/Dashboard.css";
import Addfile from "../components/Addfile";
import Record from "../components/Record";
import RecordList from "../components/RecordList";
import SideNav from "../components/SideNav";
import AuthContext from "../store/auth-context";
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import AddDoc from "../components/AddDoc";


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
                <div className="records">
                <Switch>
                    <Route exact path='/dashboard'>
                            <RecordList records={records}/>
                    </Route>

                    <Route exact path='/dashboard/reports'>
                            <h1>Reports</h1>
                    </Route>

                    <Route exact path='/dashboard/add_Doc'>
                        <AddDoc/>
                    </Route>

                    <Route exact path='/dashboard/settings'>
                            <h1>Settings</h1>    
                    </Route>
                </Switch>
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