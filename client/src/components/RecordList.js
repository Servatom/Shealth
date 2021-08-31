import { useContext, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "../assets/css/Records.css";
import AuthContext from "../store/auth-context";
import Record from "./Record";

const RecordList=(props)=>
{
    
    const authCtx = useContext(AuthContext);

    return(
        
            <div className="recordlist">
                {
                    props.records.map((record)=>{
                        return(
                            <a href={"https://shealthapi.servatom.com"+record.file} target="_blank">
                                <Record record={record}/>
                            </a>
                        )
                    })
                }
            </div>
        
    );
}

export default RecordList;