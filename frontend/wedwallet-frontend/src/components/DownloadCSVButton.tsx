import React from 'react';

const DownloadCSVButton: React.FC = () => {
  const handleDownload = async () => {
    const authToken = localStorage.getItem('authToken');
    const response = await fetch('http://localhost:3001/gifts/download_csv', {
      headers: {
        'Authorization': `Bearer ${authToken}`,
        'Content-Type': 'application/json',
      },
    });

    if (response.ok) {
      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'gifts.csv';
      document.body.appendChild(a);
      a.click();
      a.remove();
    } else {
      console.error('Failed to download CSV');
    }
  };

  return (
    <button onClick={handleDownload}>
      Download Gifts CSV
    </button>
  );
};

export default DownloadCSVButton;
