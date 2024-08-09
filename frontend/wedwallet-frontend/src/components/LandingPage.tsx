import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #f9f9f9;
`;

const Heading = styled.h1`
  font-size: 2.5rem;
  color: #333;
`;

const Description = styled.p`
  font-size: 1.2rem;
  color: #666;
  margin: 20px 0;
`;

const Button = styled.button`
  padding: 10px 20px;
  margin: 5px;
  background-color: #007BFF;
  color: #fff;
  border-radius: 5px;
  text-align: center;
  display: inline-block;
  font-size: 1rem;
  &:hover {
    background-color: #0056b3;
  }
`;

const isAuthenticated = () => {
  return !!localStorage.getItem('authToken');
};

const LandingPage: React.FC = () => {
  const navigate = useNavigate();

  useEffect(() => {
    if (isAuthenticated()) {
      navigate('/welcome');
    }
  }, [navigate]);

  return (
    <Container>
      <Heading>Welcome to WedWallet</Heading>
      <Description>Your all-in-one wedding planning solution.</Description>
      <Button onClick={() => navigate('/login')}>Log In</Button>
      <Button onClick={() => navigate('/signup')}>Sign Up</Button>
    </Container>
  );
};

export default LandingPage;
