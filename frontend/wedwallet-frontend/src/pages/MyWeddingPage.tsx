import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import HamburgerMenu from '../components/HamburgerMenu';
import DownloadCSVButton from '../components/DownloadCSVButton';
import { Wedding, Guest, Gift } from '../types';

const Container = styled.div`
  padding: 20px;
`;

const TabContainer = styled.div`
  display: flex;
  justify-content: space-around;
  margin-bottom: 20px;
`;

const Tab = styled.button<{ active: boolean }>`
  padding: 10px 20px;
  background-color: ${({ active }) => (active ? '#007BFF' : '#f1f1f1')};
  color: ${({ active }) => (active ? '#fff' : '#333')};
  border: none;
  border-radius: 5px;
  cursor: pointer;
  &:hover {
    background-color: ${({ active }) => (active ? '#0056b3' : '#ddd')};
  }
`;

const Content = styled.div`
  background-color: #f9f9f9;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
`;

const MyWeddingPage: React.FC = () => {
  const [activeTab, setActiveTab] = useState('details');
  const [wedding, setWedding] = useState<Wedding | null>(null);
  const [guests, setGuests] = useState<Guest[]>([]);
  const [gifts, setGifts] = useState<Gift[]>([]);

  useEffect(() => {
    // Fetch wedding details
    const fetchWeddingData = async () => {
      const authToken = localStorage.getItem('authToken');
      const response = await fetch('http://localhost:3001/my_wedding', {
        headers: {
          'Authorization': `Bearer ${authToken}`,
        },
      });
      const data = await response.json();
      {console.log(data)};
      setWedding(data.wedding);
      setGuests(data.guests);
      setGifts(data.gifts);
    };

    fetchWeddingData();
  }, []);

  const renderContent = () => {
    switch (activeTab) {
      case 'details':
        return (
          <div>
            <h3>{wedding?.title}</h3>
            <p>Date: {wedding?.date}</p>
            <p>Location: {wedding?.location}</p>
          </div>
        );
      case 'guests':
        return (
          <div>
            <h3>Guest List</h3>
            <ul>
            {guests.map((guest, index) => (
              <div key={index}>
              <p>{guest.first_name} {guest.last_name} - RSVP: {guest.rsvp_status}</p>
            </div>
))}
            </ul>
          </div>
        );
      case 'gifts':
        return (
          <div>
            <h3>Gifts</h3>
            <DownloadCSVButton/>
            <ul>
              {gifts.map((gift, index) => (
                <li key={index}>
                  {gift.sender_name} gave ${gift.amount}
                </li>
              ))}
            </ul>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <Container>
      <HamburgerMenu />
      <h1>My Wedding</h1>
      <TabContainer>
        <Tab active={activeTab === 'details'} onClick={() => setActiveTab('details')}>
          Wedding Details
        </Tab>
        <Tab active={activeTab === 'guests'} onClick={() => setActiveTab('guests')}>
          Guest List
        </Tab>
        <Tab active={activeTab === 'gifts'} onClick={() => setActiveTab('gifts')}>
          Gifts
        </Tab>
      </TabContainer>
      <Content>{renderContent()}</Content>
    </Container>
  );
};

export default MyWeddingPage;
