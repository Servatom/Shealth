import "../assets/css/Card.css";

const DocCard=(props)=>
{
    return(
        <div className="card">
            <h3 className="cardTitle">{`Dr. ${props.doc.name}`}</h3>
            <h3 className="cardTitle">{props.doc.speciality}</h3>
            <h3 className="cardTitle">{props.doc.email}</h3>
            <h3 className="cardTitle">{props.doc.phone}</h3>
        </div>
    )
}

export default DocCard;