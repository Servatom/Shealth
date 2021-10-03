import { useContext, useEffect, useState } from "react";
import swal from "sweetalert";
import "../assets/css/Form.css"
import AuthContext from "../store/auth-context";
import DocCard from "./DocCard";

const AddDoc=()=>
{

    const authCtx = useContext(AuthContext)
    
    const [docList, setDocList] = useState([]);
    const [inputID, setInputID] = useState('');
    const inputChangeHandler =(e)=>
    {
        setInputID(e.target.value)
    }
    
    const addDoctorHandler=(e)=>
    {
        e.preventDefault();
        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");

        var raw = JSON.stringify({
        "doc_id": inputID
        });

        var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
        };

        fetch("https://shealthapi.servatom.com/doctor/details/", requestOptions)
        .then(response => response.json() )
        .then(result => {
            if(result.doctor_name)
            {
                swal({
                    title: "Add Doctor?",
                    text: `Are you sure you want to give Dr. ${result.doctor_name} (${result.doctor_speciality}) to view your documents?`,
                    icon: "warning",
                    buttonColor: '#b793da',                  
                    buttons: true,
                    dangerMode: false,
                  })
                  .then((giveAccess) => {
                    if (giveAccess) {

                        setInputID('');
                        swal("Permission granted!", {
                            icon: "success",
                        });

                        var myHeaders = new Headers();
                        myHeaders.append("Authorization", "Token "+authCtx.token);
                        myHeaders.append("Content-Type", "application/json");

                        var raw = JSON.stringify({
                        "doc_id": inputID
                        });

                        var requestOptions = {
                        method: 'POST',
                        headers: myHeaders,
                        body: raw,
                        redirect: 'follow'
                        };

                        fetch("https://shealthapi.servatom.com/patient/access/doc_id/", requestOptions)
                        .then(response => {
                            getDocList()
                            return response.text()
                        })
                        .then(result => console.log(result))
                        .catch(error => console.log('error', error));

                    } 
                  });
            }
            else
            {
                swal({
                    title: "No Doctor Found!",
                    text: "Please Enter a valid Doctor ID",
                    icon: "error",
                    showConfirmButton: true,
                    confirmButtonColor: "#b793da",
                    confirmButtonText: 'OK',
                    cancelButtonColor: "#b793da"
                })
            }
        })
        .catch(error => {
            console.log('error', error)
            swal({
                title: "No Doctor Found!",
                text: "Please Enter a valid Doctor ID",
                icon: "error",
                showConfirmButton: true,
                confirmButtonColor: "#b793da",
                confirmButtonText: 'OK',
                cancelButtonColor: "#b793da"
            })
        });
    }
    
    
    const getDocList=()=>
    {
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Token "+authCtx.token);

        var requestOptions = {
        method: 'GET',
        headers: myHeaders,
        redirect: 'follow'
        };

        fetch("https://shealthapi.servatom.com/patient/dlist/", requestOptions)
        .then(response => response.json())
        .then(result => setDocList(result))
        .catch(error => console.log('error', error));
    }

    useEffect(()=>{
        getDocList();
    },[])

    return(
        <>
            <div className="form-wrapper searchdoc">
                <form>
                    <input type="text" placeholder="Enter Doctor ID" value={inputID} onChange={inputChangeHandler}/>
                    <button type="submit" className="registerBtn" onClick={addDoctorHandler}>Add Doctor</button>
                </form>
            </div>
            <div>
                {
                    docList.length?
                    <div className="card">
                        <h2 className="cardTitle">Doctor Name</h2>
                        <h2 className="cardTitle">Speciality</h2>
                        <h2 className="cardTitle">Email</h2>
                        <h2 className="cardTitle">Phone</h2>
                    </div>:null
                }
                {
                    docList.length?
                    docList.map((doc)=>{
                        console.log(doc);
                        return (<DocCard doc={doc}/>)
                    })
                    :<p>No doctors added yet</p>
                }
            </div>
        </>
    )
}

export default AddDoc;