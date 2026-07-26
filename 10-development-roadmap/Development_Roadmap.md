# Development Roadmap
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the development phases (Sprints) required to deliver the platform, detailing objectives, deliverables, dependencies, and acceptance criteria for each stage. The roadmap is updated to reflect the simplified MVP scope, focusing on connection, matching, and intelligence rather than transaction processing.

### Sprint 1: Foundation and Identity
**Objectives**: Establish the core infrastructure, database, and user authentication system.
**Deliverables**:
- Initialized backend repository and database schema.
- User registration and login endpoints (JWT authentication).
- Basic Entity management (CRUD operations).
**Dependencies**: None.
**Acceptance Criteria**: Users can register, log in, and update their basic organization profiles.

### Sprint 2: Core Marketplace (Offers & Requests)
**Objectives**: Implement the creation and management of supply and demand listings.
**Deliverables**:
- Offer creation, listing, and closing endpoints (supporting both official drugs and free-text entries).
- Request creation, listing, and closing endpoints (supporting both official drugs and free-text entries).
- Basic Drug Catalog (CRUD operations).
**Dependencies**: Sprint 1 (Entity authentication).
**Acceptance Criteria**: Users can create, search, and close offers and requests for drugs in the catalog, including unlisted free-text items.

### Sprint 3: Matching Engine and Notifications
**Objectives**: Connect supply and demand, and alert users of potential matches.
**Deliverables**:
- Basic matching algorithm (based on drug name, free-text similarity, and location).
- In-app notification system.
- Alternative drug suggestions.
**Dependencies**: Sprint 2 (Offers and Requests).
**Acceptance Criteria**: When a new offer is created, matching requests are identified, and the requesting user receives a notification.

### Sprint 4: Communication, Contact Revelation, and Dashboard
**Objectives**: Facilitate user interaction, secure contact exchange, and provide market insights.
**Deliverables**:
- Real-time messaging system (WebSockets).
- Secure contact revelation mechanism between matched entities.
- Basic market dashboard (supply/demand trends).
- Reporting endpoints.
**Dependencies**: Sprint 3 (Matching and Notifications).
**Acceptance Criteria**: Matched users can exchange messages, reveal contact information upon agreement, and analysts can view basic market trend charts.

### Sprint 5: Advanced Features and MVP Release
**Objectives**: Polish the system, implement advanced search, and prepare for deployment.
**Deliverables**:
- Full-text search integration (Elasticsearch) to handle both official catalog and free-text entries.
- Advanced filtering and sorting.
- Soft deletes and audit logging implementation.
- Production deployment scripts and CI/CD pipeline.
**Dependencies**: Sprint 4 (Communication and Dashboard).
**Acceptance Criteria**: The platform is deployed to a production environment, passing all load and security tests.
