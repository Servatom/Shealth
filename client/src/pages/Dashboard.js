import "../assets/css/Dashboard.css";
import SideNav from "../components/SideNav";

const Dashboard=()=>
{
    return(

        <div className="dashboard">
            <div className="nav">
                <SideNav/>
            </div>
            <div className="dashright">
                <h1 className="welcome">Welcome, Yashvardhan!</h1>
            </div>
        </div>
    )
}

export default Dashboard;