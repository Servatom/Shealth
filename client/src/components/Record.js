
import {GrDocumentPdf} from 'react-icons/gr';
import "../assets/css/Records.css";

const Record=()=>
{
    return(
        <div className="record">
            <GrDocumentPdf className="docicon" />
            <h4 className="filename">covid_Certificate.pdf</h4>
        </div>
    )
}

export default Record;