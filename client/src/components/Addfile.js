import "../assets/css/Addfile.css"
import {GrClose} from 'react-icons/gr';
import {AiOutlineFileAdd} from 'react-icons/ai';
import { useState } from "react";
import AuthContext from "../store/auth-context";
const Addfile=(props)=>
{
    const closeModal=()=>
    {
        props.onClose(false);
    }

    
    const [token, setToken] = useState(props.token);

    const [isUploaded, setIsUploaded] = useState(false);
    const [file, setFile] = useState(null);

    const [filename, setFilename] = useState("");

    const filenameChangeHandler=(e)=>{
        setFilename(e.target.value);
    }
    
    const fileChangeHandler=(e)=>{
        setFile(e.target.files[0]);
        console.log(e.target.files[0]);
        setIsUploaded(true)
        setFilename(e.target.files[0].name);
    }

    const [loading, setLoading] = useState(false);
    const [error, setError] = useState({
        status: false,
        body: ""
    });
    
    const fileUploadHandler=(e)=>
    {
        setLoading(true);
        e.preventDefault();
        if(!filename.length)
        {
            setError(
                {
                    status: true,
                    body: "File name can't be empty"
                }
            );
            return
        }

        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Token "+token);
        myHeaders.append("Content-Disposition", "multipart/form-data; filename="+filename);
        // myHeaders.append("Content-Type", "application/pdf");


        var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: file,
        redirect: 'follow'
        };

        fetch("https://shealthapi.servatom.com/patient/upload/", requestOptions)
        .then(response => {
 
            const data= response.json();
            setLoading(false)
            
            props.fetchRecords();
            return data;
         })
         .then(result => {
             
             
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
    
    return(
        <div className="expanded">
            <GrClose className="close-icon" onClick={closeModal}/>
            <div className="contents">
                
                <div className="form-wrapper">
                    <form>
                        <h2>Upload your file here</h2>
                        <input type="file" onChange={fileChangeHandler}></input>
                        {
                            isUploaded?
                            <>
                                <label>Filename:</label>
                                <input type="text" required onChange={filenameChangeHandler} value={filename} id="filename"/>
                                <button type="submit" className="registerBtn addfile" onClick={fileUploadHandler} >Upload</button>
                            </>
                            :null
                        }
                        {
                            loading?
                            <div className="lds-ring"><div></div><div></div><div></div><div></div></div>
                            :null
                        }
                    </form>
                </div>
                {
                    error.status?<span className="reqmsg">{error.body}</span>:null
                }
            </div>
        </div>
    )
}

export default Addfile;