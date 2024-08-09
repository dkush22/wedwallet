import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';
import { Wedding } from '../types';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
`;

const Row = styled.div`
  display: flex;
  justify-content: space-between;
  width: 100%;
`;

const Column = styled.div`
  flex: 1;
  margin: 10px;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
`;

const Heading = styled.h2`
  text-align: center;
  margin-bottom: 20px;
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
      <h1>Welcome {user.firstName} {user.lastName}</h1>
      <Row>
        <Column>
          <Heading>My Wedding</Heading>
          {myWedding ? (
            <div>
              <h3>{myWedding.title}</h3>
              <p>{myWedding.date}</p>
              <p>{myWedding.location}</p>
            </div>
          ) : (
            <p>You haven't created a wedding yet.</p>
          )}
        </Column>
        <Column>
          <Heading>Upcoming Weddings</Heading>
          {upcomingWeddings.length > 0 ? (
            upcomingWeddings.map((wedding, index) => (
              <div key={index}>
                <h3>{wedding.title}</h3>
                <p>{wedding.date}</p>
                <p>{wedding.location}</p>
              </div>
            ))
          ) : (
            <p>No upcoming weddings.</p>
          )}
        </Column>
        <Column>
          <Heading>Past Weddings</Heading>
          {pastWeddings.length > 0 ? (
            pastWeddings.map((wedding, index) => (
              <div key={index}>
                <h3>{wedding.title}</h3>
                <p>{wedding.date}</p>
                <p>{wedding.location}</p>
              </div>
            ))
          ) : (
            <p>No past weddings.</p>
          )}
        </Column>
      </Row>
      <Button onClick={handleLogout}>Logout</Button>
    </Container>
  );
};

export default WelcomePage;
