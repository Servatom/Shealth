import "../assets/css/Addfile.css"
import {GrClose} from 'react-icons/gr';
import {AiOutlineFileAdd} from 'react-icons/ai';
import { useState } from "react";
const Addfile=(props)=>
{
    const closeModal=()=>
    {
        props.onClose(false);
    }

    const [isUploaded, setIsUploaded] = useState(false);
    
    return(
        <div className="expanded">
            <GrClose className="close-icon" onClick={closeModal}/>
            <div className="contents">
                <form>
                    <input type="file"></input>
                </form>
                <AiOutlineFileAdd className="addicon"/>
                <h2>Upload your PDF here</h2>
            </div>
        </div>
    )
}

export default Addfile;