
import {GrDocumentPdf} from 'react-icons/gr';
import "../assets/css/Records.css";

const Record=(props)=>
{
    let filepath = props.record.file;
    
    let filename = filepath.substring(filepath.lastIndexOf("/") + 1, filepath.length);
    
    return(
        <div className="record">
            <GrDocumentPdf className="docicon" />
            <h4 className="filename">{filename}</h4>
        </div>
    )
}

export default Record;