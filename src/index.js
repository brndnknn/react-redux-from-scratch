import './style.css';
import React from 'react';
import ReactDOM from 'react-dom/client';


function ReactButton(props){
    function handleClick(){
        console.log("you clicked the react button")
    }
    return(
        <button onClick={handleClick}>{props.text}</button>
    )
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<ReactButton text='React'/>);
