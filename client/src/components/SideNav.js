import "../assets/css/Sidenav.css";
import logo from "../assets/images/logo2.png";
import {GrDocumentText, GrUserManager, GrSettingsOption, GrAdd, GrLogout} from 'react-icons/gr';
import {IoMdStats} from 'react-icons/io';
import { useContext, useState } from "react";
import swal from 'sweetalert';
import AuthContext from "../store/auth-context";
import { Link, useHistory } from "react-router-dom";


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

            <Link to={'/dashboard'}>
            <h4 onClick={() => {
                props.setCurrentTab(1);
                history.push('/dashboard');
                }}
                className={props.currentTab === 1 ? 'active' : ''} >
                <GrDocumentText className="icon"/>Prescriptions
            </h4>  
            </Link>
            
            <Link to={'/dashboard/reports'}>
            <h4 onClick={() => {
                props.setCurrentTab(2);
                history.push('/dashboard/reports');
                }}
                className={props.currentTab === 2 ? 'active' : ''} >
                <IoMdStats className="icon"/>Reports
            </h4>
            </Link>

            <Link to={'/dashboard/add_Doc'}>
            <h4 onClick={() => {
                props.setCurrentTab(3);
                history.push('/dashboard/add_Doc');
                }}
                className={props.currentTab === 3 ? 'active' : ''} >
                <GrUserManager className="icon"/>Doctors
            </h4> 
            </Link>

            <Link to={'/dashboard/settings'}>
            <h4 onClick={() => {
                props.setCurrentTab(4);
                history.push('/dashboard/settings');
                }}
                className={props.currentTab === 4 ? 'active' : ''} >
                <GrSettingsOption className="icon"/>Settings
            </h4> 
            </Link>
            <a onClick={logoutHandler}><h4 className="" ><GrLogout className="icon"/>Logout</h4></a>
            <div className="sidenavIcons">
                {/* <AiFillDelete className="delete-all" onClick={allDeleteHandler}/> */}
            </div>
            
        </div>

    );
}

export default SideNav;