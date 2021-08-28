import './App.css';
import LandingPage from './pages/LandingPage';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom';
import Register from './components/Register';


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
      </Switch>
    </Router>
  );
}

export default App;
