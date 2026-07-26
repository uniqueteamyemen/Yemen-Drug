# Domain Driven Design (DDD) Architecture
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the software architecture based on Domain-Driven Design principles. It decomposes the system into strategic and tactical building blocks without relying on database assumptions. The architecture is updated to reflect the simplified MVP scope, focusing on connection and intelligence rather than transaction processing.

### 1. Domains
The platform is divided into three primary Bounded Contexts (Domains). The **Marketplace Domain** handles the core business logic of supply (Offers) and demand (Requests). It manages the lifecycle of these entities, the matching process, and the revelation of contact information. The **Identity & Access Domain** manages the registration, verification, and authentication of Entities such as pharmacies and hospitals. The **Market Intelligence Domain** aggregates data from the Marketplace Domain to generate Signals, identify Surpluses and Shortages, and provide reporting.

### 2. Sub-Domains
The core sub-domain for the marketplace is where Offers, Requests, Matching, and Conversations occur. The core sub-domain for identity is responsible for Entity management and verification. Additionally, there is an Intelligence Support sub-domain that consumes data to provide insights and alerts.

### 3. Aggregates and Entities
An Aggregate is a cluster of domain objects that can be treated as a single unit.

| Aggregate | Root Entity | Value Objects | Behavior |
|-----------|-------------|---------------|----------|
| **Offer Aggregate** | `Offer` | `Quantity`, `Price`, `ExpiryDate`, `DrugIdentifier` (can be an official ID or free text) | Can be closed, expired, or matched. |
| **Request Aggregate** | `Request` | `Quantity`, `MaxPrice`, `Urgency`, `DrugIdentifier` (can be an official ID or free text) | Can be closed, expired, or matched. |
| **Entity Aggregate** | `Entity` | `ContactInfo`, `Location` | Can be verified or suspended. |
| **Drug Catalog Aggregate** | `Drug` | `Dosage`, `Manufacturer` | Can be categorized or linked to Alternatives. |
| **Conversation Aggregate** | `Conversation` | `MessageText`, `Timestamp` | Can be initiated, messages added, and contact info revealed upon agreement. |

### 4. Value Objects
Value Objects are immutable objects defined by their attributes, not their identity. Examples include `Location` (Region, Governorate, City), `Quantity` (Amount, Unit), `Price` (Amount, Currency), `ContactInfo` (Email, Phone), `DateRange` (Start, End), and `DrugIdentifier` (Official ID or Free Text String).

### 5. Repositories
Repositories provide an interface for retrieving and storing aggregates. Key repositories include `IOfferRepository`, `IRequestRepository`, `IEntityRepository`, `IDrugRepository`, `IMatchRepository`, and `IConversationRepository`.

### 6. Services
Domain Services handle logic that doesn't naturally fit into a single Entity or Aggregate. The `MatchingService` evaluates Requests against Offers based on rules and algorithms. The `NotificationService` manages the dispatching of alerts and communications. The `MarketAnalysisService` calculates Surpluses and Shortages based on aggregate data. The `ContactRevealService` manages the secure exchange of contact information between matched entities.

### 7. Events
Domain Events capture significant state changes. Examples include `OfferCreatedEvent`, `OfferClosedEvent`, `RequestCreatedEvent`, `RequestClosedEvent`, `EntityVerifiedEvent`, `MatchFoundEvent`, and `ContactRevealedEvent`.

### 8. Commands
Commands represent an intention to change state. Examples include `CreateOfferCommand`, `CloseOfferCommand`, `CreateRequestCommand`, `CloseRequestCommand`, `RegisterEntityCommand`, and `RevealContactCommand`.

### 9. Queries
Queries represent a request for data without modifying state. Examples include `GetOfferByIdQuery`, `SearchDrugsQuery`, `GetMarketTrendsQuery`, `ListOffersByDrugQuery`, and `GetConversationMessagesQuery`.

### 10. Use Cases
Use Cases orchestrate the execution of Commands and Queries, bridging the domain layer with the application layer. The `PublishSurplusUseCase` handles the `CreateOfferCommand`. The `ProcureDrugUseCase` handles the `CreateRequestCommand`. The `ViewMarketDashboardUseCase` handles the `GetMarketTrendsQuery`. The `MatchInventoryUseCase` orchestrates the `MatchingService` when an Offer or Request is created. Finally, the `EstablishConnectionUseCase` handles the `RevealContactCommand` after both parties agree.
