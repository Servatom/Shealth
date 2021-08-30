import './App.css';
import LandingPage from './pages/LandingPage';
import {BrowserRouter as Router, Route, Switch, Redirect} from 'react-router-dom';
import Register from './pages/Register';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import { useContext, useState } from 'react';
import AuthContext from './store/auth-context';


function App() {
  
  const authCtx = useContext(AuthContext);
  const [email, setEmail] = useState("");
  
  return (
    <Router>
      <Switch>
        
        <Route exact path="/">
          { authCtx.isLoggedIn?
          <Redirect to="/dashboard"/>
          :<LandingPage/>}
        </Route>
        <Route path="/register" exact>
          <Register/>
        </Route>
        {!authCtx.isLoggedIn && (
        <Route path="/login" exact>
          <Login />
        </Route>)}
        {authCtx.isLoggedIn && (
        <Route path="/dashboard" exact>
          <Dashboard />
        </Route>)}
        <Route path="*">
          {
            authCtx.isLoggedIn?<Redirect to="/dashboard"/>:<Redirect to="/login"/>
          }
        </Route>
      </Switch>
    </Router>
  );
}

export default App;
