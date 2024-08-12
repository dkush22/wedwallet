import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import LandingPage from './pages/LandingPage';
import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';
import WelcomePage from './pages/WelcomePage';
import MyWeddingPage from './pages/MyWeddingPage';
import PrivateRoute from './components/PrivateRoute';


const App: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/welcome" element={<PrivateRoute element={WelcomePage} />} />
        <Route path="/my_wedding" element={<MyWeddingPage />} />
      </Routes>
    </Router>
  );
};

export default App;
