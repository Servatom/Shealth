import "../assets/css/Sidenav.css";
import logo from "../assets/images/logo2.png";
import {GrDocumentText, GrUserManager, GrSettingsOption, GrAdd, GrLogout} from 'react-icons/gr';
import {IoMdStats} from 'react-icons/io';
import {AiFillDelete} from 'react-icons/ai';
import { useContext, useState } from "react";
import swal from 'sweetalert';
import AuthContext from "../store/auth-context";
import { useHistory } from "react-router-dom";


const SideNav =(props)=>
{   

  const authCtx = useContext(AuthContext);
  const history = useHistory();
    
  const logoutHandler=()=>
  {
    swal(
      {
        text:"Are you sure you want to log out?",
        icon:"warning",
        dangerMode:true,
        buttons: true,
      }
    )
    .then((willlogout)=>{
      if(willlogout)
      {
        authCtx.logout();
        history.replace("/");
        
      }
    })
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
            <a onClick={logoutHandler}><h4 className="" ><GrLogout className="icon"/>Logout</h4></a>
            <div className="sidenavIcons">
                {/* <AiFillDelete className="delete-all" onClick={allDeleteHandler}/> */}
            </div>
            
        </div>

    );
}

export default SideNav;