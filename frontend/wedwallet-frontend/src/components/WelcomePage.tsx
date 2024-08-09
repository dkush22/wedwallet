import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
`;

const Button = styled.button`
  padding: 10px;
  font-size: 1rem;
  background-color: #dc3545;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  &:hover {
    background-color: #c82333;
  }
`;

const isAuthenticated = () => {
  return !!localStorage.getItem('authToken');
};

const WelcomePage: React.FC = () => {
  const [user, setUser] = useState({ firstName: '', lastName: '' });
  const navigate = useNavigate();

  useEffect(() => {
    if (!isAuthenticated()) {
      navigate('/');
    } else {
      const fetchUserData = async () => {
        try {
          const authToken = localStorage.getItem('authToken');
          const response = await fetch('http://localhost:3001/current_user', {
            method: 'GET',
            headers: {
              'Authorization': `Bearer ${authToken}`,
            },
          });

          if (response.ok) {
            const data = await response.json();
            setUser({ firstName: data.first_name, lastName: data.last_name });
          } else {
            console.error('Failed to fetch user data');
            handleLogout(); // Optionally log out if fetching user data fails
          }
        } catch (error) {
          console.error('Error fetching user data:', error);
          handleLogout(); // Optionally log out if an error occurs
        }
      };

      fetchUserData();
    }
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('authToken');
    navigate('/');
  };

  return (
    <Container>
      <h1>Welcome {user.firstName} {user.lastName}</h1>
      <Button onClick={handleLogout}>Logout</Button>
    </Container>
  );
};

export default WelcomePage;
