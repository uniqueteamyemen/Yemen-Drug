# Engineering Backlog
## Yemen Pharmaceutical Market Intelligence Platform

This document translates the architectural documentation and PRD into an actionable Engineering Backlog. It is structured into Epics, Features, User Stories, and Tasks, prioritized for the MVP release.

### Epic 1: Identity & Access Management
**Objective**: Securely manage entity registration, verification, and authentication.
- **Feature 1.1: Entity Registration**
  - **Story 1.1.1**: As an administrator, I want to manually verify new entities so that only legitimate organizations can participate.
    - **Task 1.1.1.1**: Implement `POST /api/v1/entities/register` endpoint.
    - **Task 1.1.1.2**: Create database schema for `entities` table (including soft deletes and audit fields).
    - **Task 1.1.1.3**: Implement manual verification workflow (admin UI/backend logic to update status).
- **Feature 1.2: Authentication & Authorization**
  - **Story 1.2.1**: As a user, I want to log in and receive a JWT token so that I can securely access the platform.
    - **Task 1.2.1.1**: Implement `POST /api/v1/auth/login` endpoint.
    - **Task 1.2.1.2**: Implement JWT generation and refresh logic.
    - **Task 1.2.1.3**: Implement middleware for protecting private routes based on Entity status (Verified vs Pending).

### Epic 2: Product Catalog & Geography
**Objective**: Provide a standardized list of drugs and geographic locations, while allowing for free-text entries.
- **Feature 2.1: Geographic Hierarchies**
  - **Story 2.1.1**: As a user, I want to select my Region, Governorate, and City from predefined lists.
    - **Task 2.1.1.1**: Seed database with Yemen's geographic data (`regions`, `governorates`, `cities`).
    - **Task 2.1.1.2**: Create read-only endpoints to fetch geographic data.
- **Feature 2.2: Official Drug Catalog**
  - **Story 2.2.1**: As a user, I want to select a drug from the official list when creating an Offer or Request.
    - **Task 2.2.1.1**: Seed database with the official drug list.
    - **Task 2.2.1.2**: Implement search endpoint for the official drug catalog (`GET /api/v1/drugs`).
- **Feature 2.3: Free-Text Entries**
  - **Story 2.3.1**: As a user, I want to enter a drug name not found in the official list as free text.
    - **Task 2.3.1.1**: Update Offer and Request database schemas to include `is_free_text` (boolean) and `free_text_name` (string).
    - **Task 2.3.1.2**: Update API validation to accept either a valid `drug_id` OR a non-empty `free_text_name`.

### Epic 3: Marketplace Operations (Core MVP)
**Objective**: Enable users to publish supply (Offers) and demand (Requests), and manage their lifecycle.
- **Feature 3.1: Offer Management**
  - **Story 3.1.1**: As a distributor, I want to publish an Offer so that the market knows I have surplus stock.
    - **Task 3.1.1.1**: Implement `POST /api/v1/offers` endpoint.
    - **Task 3.1.1.2**: Implement background job to automatically expire offers after 30 days.
  - **Story 3.1.2**: As a distributor, I want to close an Offer manually when it is sold or allocated.
    - **Task 3.1.2.1**: Implement `PATCH /api/v1/offers/{id}` endpoint to update status to 'Closed'.
- **Feature 3.2: Request Management**
  - **Story 3.2.1**: As a pharmacy, I want to publish a Request so that suppliers know I need a specific drug.
    - **Task 3.2.1.1**: Implement `POST /api/v1/requests` endpoint.
  - **Story 3.2.2**: As a pharmacy, I want to close a Request manually when I have procured the drug.
    - **Task 3.2.2.1**: Implement `PATCH /api/v1/requests/{id}` endpoint to update status to 'Closed'.

### Epic 4: Matching, Messaging & Contact Revelation
**Objective**: Connect supply and demand, facilitate negotiation, and reveal contact info only upon mutual agreement.
- **Feature 4.1: Basic Matching Engine**
  - **Story 4.1.1**: As the system, I want to automatically match new Offers with existing Requests based on location and drug name (including free-text).
    - **Task 4.1.1.1**: Implement background job listener for `OfferCreatedEvent` and `RequestCreatedEvent`.
    - **Task 4.1.1.2**: Develop matching algorithm logic (scoring based on official ID, free-text similarity, and location).
    - **Task 4.1.1.3**: Store match results in the `matches` database table.
- **Feature 4.2: Messaging & Connection**
  - **Story 4.2.1**: As a matched user, I want to send messages to the other party to negotiate the deal.
    - **Task 4.2.1.1**: Implement WebSocket server for real-time messaging.
    - **Task 4.2.1.2**: Create `conversations` and `messages` database tables.
    - **Task 4.2.1.3**: Implement REST API fallback for message history.
- **Feature 4.3: Contact Revelation**
  - **Story 4.3.1**: As a matched user, I want to request the contact information of the other party, which is only revealed upon their acceptance.
    - **Task 4.3.1.1**: Implement `POST /api/v1/conversations/{id}/reveal-contact` endpoint.
    - **Task 4.3.1.2**: Add logic to update `contact_revealed` boolean in the `conversations` table only when both parties agree.

### Epic 5: Market Intelligence & Dashboard (Phase 1)
**Objective**: Provide basic macro-level insights based on the aggregated Offer and Request data.
- **Feature 5.1: Basic Dashboard Metrics**
  - **Story 5.1.1**: As an analyst, I want to view the total number of active Offers and Requests by Region.
    - **Task 5.1.1.1**: Implement aggregation endpoints (`GET /api/v1/reports/market-trends`).
  - **Story 5.1.2**: As an analyst, I want to view a simple dashboard showing regional shortages.
    - **Task 5.1.2.1**: Implement logic to calculate the Shortage Index (Requests > Offers in a region).
    - **Task 5.1.2.2**: Build frontend visualization for the dashboard.
