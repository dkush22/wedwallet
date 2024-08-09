import React from 'react';
import { useLocation } from 'react-router-dom';
import styled from 'styled-components';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
`;

const WelcomePage: React.FC = () => {
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const firstName = queryParams.get('firstName');
  const lastName = queryParams.get('lastName');

  return (
    <Container>
      <h1>Welcome {firstName} {lastName}</h1>
    </Container>
  );
};

export default WelcomePage;
