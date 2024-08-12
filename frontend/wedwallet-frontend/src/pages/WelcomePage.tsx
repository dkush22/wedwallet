import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';
import { Wedding } from '../types';
import HamburgerMenu from '../components/HamburgerMenu';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
  position: relative;
`;



const isAuthenticated = () => {
  return !!localStorage.getItem('authToken');
};

const WelcomePage: React.FC = () => {
  const [user, setUser] = useState({ firstName: '', lastName: '' });
  const [myWedding, setMyWedding] = useState<Wedding | null>(null);
  const [upcomingWeddings, setUpcomingWeddings] = useState<Wedding[]>([]);
  const [pastWeddings, setPastWeddings] = useState<Wedding[]>([]);

  const navigate = useNavigate();

  useEffect(() => {
    if (!isAuthenticated()) {
      navigate('/');
    } else {
      const fetchData = async () => {
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
          setMyWedding(data.my_wedding);
          setUpcomingWeddings(data.upcoming_weddings);
          setPastWeddings(data.past_weddings);
          console.log(data);
        } else {
          console.error('Failed to fetch user data');
          handleLogout(); // Optionally log out if fetching user data fails
        }
      };


      fetchData();
    }
  }, [navigate]);


  const handleLogout = () => {
    localStorage.removeItem('authToken');
    navigate('/');
  };

  return (
    <Container>
      <HamburgerMenu />
      <h1>Welcome {user.firstName} {user.lastName}</h1>
    </Container>
  );
};

export default WelcomePage;
