import "../assets/css/Sidenav.css";
import logo from "../assets/images/logo2.png";
import {GrDocumentText, GrUserManager, GrSettingsOption, GrAdd} from 'react-icons/gr';
import {IoMdStats} from 'react-icons/io';
import {AiFillDelete} from 'react-icons/ai';
import { useState } from "react";
import swal from 'sweetalert';


const SideNav =(props)=>
{   

    
    const allDeleteHandler=()=>
    {
        swal({
            title: "Delete all notes?",
            text: "This action cannot be reverted!!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) 
            {
              swal("Poof! Your notes have been deleted!", {
                icon: "success",
              });
            } 
            else 
            {
              swal("Your notes are safe!");
            }
          });
    }


 

    return(
        <div className="sidenav">
            <div className="navhead">
                <img src={logo} className="navlogo"/>
                <h2 className="heading">Shealth</h2>
            </div>
            
            <a onClick={props.onAdd}><h4 className="add"><GrAdd className="icon"/> Add </h4></a>
            <a><h4 className="active" ><GrDocumentText className="icon"/>Prescriptions</h4></a>
            <a><h4 className="" ><IoMdStats className="icon"/>Reports</h4></a>
            <a><h4 className="" ><GrUserManager className="icon"/>Doctors</h4></a>
            <a><h4 className="" ><GrSettingsOption className="icon"/>Settings</h4></a>
            <div className="sidenavIcons">
                {/* <AiFillDelete className="delete-all" onClick={allDeleteHandler}/> */}
            </div>
            
        </div>

    );
}

export default SideNav;