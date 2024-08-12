// User-related types
export interface User {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
}

// Wedding-related types
export interface Wedding {
  id: number;
  title: string;
  date: string; // or use Date if you're parsing dates
  location: string;
  hostId: number;
  secondHostId?: number;
}

// Guest-related types
export interface Guest {
  id: number;
  first_name: string;
  last_name: string;
  userId: number;
  weddingId: number;
  name: string; // Optional: Derived from the User model
  rsvp_status: 'pending' | 'yes' | 'no';
}

// Gift-related types
export interface Gift {
  id: number;
  senderId: number;
  recipientId: number;
  weddingId: number;
  sender_name: string; // Optional: Derived from the User model
  amount: number;
  message?: string;
}

// Card-related types (for Wedding and Thank You Cards)
export interface Card {
  id: number;
  senderId: number;
  recipientId: number;
  weddingId: number;
  message: string;
  cardType: 'wedding' | 'thank_you';
  photo?: string; // URL or file path to photo
  video?: string; // URL or file path to video
}

// RSVP Status Enum (Optional)
export type RSVPStatus = 'pending' | 'yes' | 'no';

// Couples-related types
export interface Couple {
  partner1Id: number;
  partner2Id: number;
}

// Wedding Fund-related types (For future features)
export interface WeddingFund {
  id: number;
  weddingId: number;
  contributorId: number;
  amount: number;
  message?: string;
}

// CSV Export types (For future features like exporting data)
export interface CSVExport {
  fileName: string;
  data: any[]; // Can be any type of data you're exporting
}

// Generic Response type (Optional for API calls)
export interface APIResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}

// Auth Token type (Optional for authentication)
export interface AuthToken {
  token: string;
  expiresAt: string;
}
