// src/components/HamburgerMenu.tsx

import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBars } from '@fortawesome/free-solid-svg-icons';

const MenuIcon = styled.div`
  position: absolute;
  top: 20px;
  right: 20px;
  cursor: pointer;
`;

const Menu = styled.ul<{ open: boolean }>`
  list-style: none;
  background: #333;
  padding: 10px;
  border-radius: 5px;
  position: absolute;
  top: 60px;
  right: 20px;
  display: ${({ open }) => (open ? 'block' : 'none')};
`;

const MenuItem = styled.li`
  padding: 10px 20px;
  color: white;
  cursor: pointer;
  &:hover {
    background: #444;
  }
`;

const HamburgerMenu: React.FC = () => {
  const [menuOpen, setMenuOpen] = useState(false);
  const navigate = useNavigate();

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  const handleLogout = () => {
    localStorage.removeItem('authToken');
    navigate('/');
  };

  return (
    <>
      <MenuIcon onClick={toggleMenu}>
        <FontAwesomeIcon icon={faBars} size="2x" />
      </MenuIcon>
      <Menu open={menuOpen}>
        <MenuItem onClick={() => navigate('/my_wedding')}>My Wedding</MenuItem>
        <MenuItem onClick={() => navigate('/future_weddings')}>Future Weddings</MenuItem>
        <MenuItem onClick={() => navigate('/past_weddings')}>Past Weddings</MenuItem>
        <MenuItem onClick={handleLogout}>Logout</MenuItem>
      </Menu>
    </>
  );
};

export default HamburgerMenu;
