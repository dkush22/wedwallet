import React from 'react';
import { Route, Navigate } from 'react-router-dom';

interface PrivateRouteProps {
  element: React.ComponentType;
  [key: string]: any;
}

const isAuthenticated = () => {
  return !!localStorage.getItem('authToken');
};

const PrivateRoute: React.FC<PrivateRouteProps> = ({ element: Element, ...rest }) => {
  return isAuthenticated() ? <Element {...rest} /> : <Navigate to="/" />;
};

export default PrivateRoute;
