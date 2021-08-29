import './App.css';
import LandingPage from './pages/LandingPage';
import {BrowserRouter as Router, Route, Switch, Redirect} from 'react-router-dom';
import Register from './pages/Register';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import { useState } from 'react';


function App() {
  
  const [isLoggedin, setIsLoggedIn] = useState(false);
  const [email, setEmail] = useState("");
  
  return (
    <Router>
      <Switch>
        
        <Route exact path="/">
          <LandingPage/>
        </Route>
        <Route path="/register" exact>
          <Register/>
        </Route>
        <Route path="/login" exact>
          <Login setEmail={setEmail}/>
        </Route>
        <Route path="/dashboard" exact>
          <Dashboard email={email}/>
        </Route>
      </Switch>
    </Router>
  );
}

export default App;
