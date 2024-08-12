import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
`;

const Form = styled.form`
  display: flex;
  flex-direction: column;
  width: 300px;
`;

const Input = styled.input`
  margin: 10px 0;
  padding: 10px;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 5px;
`;

const Button = styled.button`
  padding: 10px;
  font-size: 1rem;
  background-color: #007BFF;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  &:hover {
    background-color: #0056b3;
  }
`;

const isAuthenticated = () => {
  return !!localStorage.getItem('authToken');
};

const LoginPage: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    if (isAuthenticated()) {
      navigate('/welcome');
    }
  }, [navigate]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
  
    try {
      const response = await fetch('http://localhost:3001/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: email,
          password: password,
        }),
      });
  
      if (response.ok) {
        const data = await response.json();
        localStorage.setItem('authToken', data.authToken); // Store JWT in localStorage
        navigate('/welcome');
      } else {
        const errorData = await response.json();
        alert(errorData.errors.join(", "));
      }
    } catch (error) {
      console.error('Error:', error);
      alert('An error occurred. Please try again.');
    }
  };  

  return (
    <Container>
      <h1>Login</h1>
      <Form onSubmit={handleSubmit}>
        <Input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <Input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <Button type="submit">Log In</Button>
      </Form>
    </Container>
  );
};

export default LoginPage;
