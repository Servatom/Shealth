import './App.css';
import LandingPage from './pages/LandingPage';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom';
import Register from './pages/Register';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';


function App() {
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
          <Login/>
        </Route>
        <Route path="/dashboard" exact>
          <Dashboard/>
        </Route>
      </Switch>
    </Router>
  );
}

export default App;
