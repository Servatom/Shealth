import "../assets/css/Records.css";
import Record from "./Record";

const RecordList=()=>
{
    return(
        <div className="recordlist">
            <Record/>
            <Record/>
            <Record/>
        </div>
    );
}

export default RecordList;