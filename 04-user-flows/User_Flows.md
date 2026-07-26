# User Flows
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the core user flows for the platform, focusing on the logical movement and state transitions rather than UI design. The flows are simplified to align with the MVP scope, focusing on connection, matching, and contact revelation without complex transaction management.

### 1. Entity Registration and Verification
1. **User Action**: Navigates to the registration page and submits Entity details (name, type, location, license number).
2. **System Action**: Validates the input and creates a new Entity record with a "Pending Verification" status.
3. **System Action**: Sends a notification to Platform Admins for manual verification.
4. **User Action**: Waits for approval.
5. **System Action**: Admin approves the Entity. Status changes to "Verified".
6. **System Action**: Sends a verification notification to the User.
7. **User Action**: Logs in and gains access to create Offers and Requests.

### 2. Creating an Offer (Supply)
1. **User Action**: Navigates to "My Offers" and clicks "Create New Offer".
2. **User Action**: Selects a Drug from the official database or enters a free-text name for an unlisted drug.
3. **User Action**: Enters Offer details: Quantity, Region, City, Expiry Date, Price (optional), and Notes.
4. **System Action**: Validates the data (e.g., ensures quantity is > 0). If it's an unlisted drug, it tags the offer as "Free Text".
5. **System Action**: Saves the Offer with an "Active" status.
6. **System Action**: Triggers the **Matching Engine** to check for open Requests that match this Drug and Location.
7. **System Action**: If a match is found, sends a Notification to the requesting Entity.

### 3. Creating a Request (Demand)
1. **User Action**: Navigates to "My Requests" and clicks "Create New Request".
2. **User Action**: Selects a Drug from the official database or enters a free-text name for an unlisted drug.
3. **User Action**: Enters Request details: Quantity, Region, City, Urgency (Low, Medium, High, Critical), Maximum Price (optional), and Notes.
4. **System Action**: Validates the data.
5. **System Action**: Saves the Request with an "Open" status.
6. **System Action**: Triggers the **Matching Engine** to check for active Offers that match this Drug and Location.
7. **System Action**: If a match is found, sends a Notification to the offering Entity.

### 4. Search and Matching
1. **User Action**: Uses the global search bar to search for a Drug by name or active ingredient.
2. **System Action**: Queries the Drug, Offer, and Request databases.
3. **System Action**: Returns a list of matching active Offers and Requests, filtered by the user's Region if applicable.
4. **User Action**: Reviews the list.
5. **User Action**: Clicks on a relevant Offer or Request.
6. **System Action**: Displays the details of the selected item.
7. **User Action**: Clicks "Initiate Conversation" or "Match Request".
8. **System Action**: Creates a Conversation thread between the two Entities.

### 5. Notifications and Alerts
1. **System Event**: A new Offer is created that matches an existing Request.
2. **System Action**: Generates a Notification record.
3. **System Action**: Delivers the notification via in-app alerts, email, or SMS based on user preferences.
4. **User Action**: Receives and clicks the notification.
5. **System Action**: Redirects the user to the matching Offer/Request or the Conversation thread.

### 6. Conversation and Contact Revelation
1. **System Event**: A match is established (either by the user searching or by the matching engine).
2. **System Action**: Opens a secure messaging channel between Entity A and Entity B.
3. **User Action**: Sends messages to negotiate price, quantity, or logistics.
4. **System Action**: Logs all messages with timestamps.
5. **User Action**: Clicks "Reveal Contact Information" and sends a request to the other party.
6. **User Action**: The other party clicks "Accept Contact Reveal".
7. **System Action**: Displays the contact details (phone, email) of both parties within the chat window, completing the connection outside the platform.

### 7. Closing a Request
1. **User Action**: Navigates to "My Requests" and selects an "Open" request.
2. **User Action**: Clicks "Mark as Closed".
3. **System Action**: Prompts for a reason (e.g., "Procured", "No longer needed", "Expired").
4. **System Action**: Updates the Request status to "Closed".
5. **System Action**: Removes the Request from the active matching queue.
6. **System Action**: Sends a notification to any matched Offers that the request is closed.

### 8. Closing an Offer
1. **User Action**: Navigates to "My Offers" and selects an "Active" offer.
2. **User Action**: Clicks "Mark as Closed".
3. **System Action**: Prompts for a reason (e.g., "Sold", "Allocated internally", "Expired").
4. **System Action**: Updates the Offer status to "Closed".
5. **System Action**: Removes the Offer from the active matching queue.
6. **System Action**: Sends a notification to any matched Requests that the offer is closed.

### 9. Market Intelligence and Reporting
1. **User Action**: Navigates to the "Market Dashboard".
2. **System Action**: Aggregates data from active Offers, Requests, and closed transactions.
3. **System Action**: Calculates regional supply/demand ratios.
4. **User Action**: Applies filters (e.g., specific Drug category, Governorate, time frame).
5. **System Action**: Updates the visual dashboard with charts and maps showing Surpluses, Shortages, and Trends.
6. **User Action**: Clicks "Export Report".
7. **System Action**: Generates a PDF or CSV file and initiates a download.
