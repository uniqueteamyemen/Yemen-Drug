# API Design
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the REST API design for the platform, including authentication, core entity management, and marketplace operations. The API is simplified to reflect the MVP scope, focusing on connection, matching, and contact revelation without transaction management.

### Authentication
The authentication endpoints manage user access. The `POST /api/v1/auth/login` endpoint handles user login, while `POST /api/v1/auth/register` is used for new user registration. Token refreshing is handled by `POST /api/v1/auth/refresh`. The system utilizes JSON Web Tokens (JWT) for stateless authentication to ensure security and scalability.

### Entities (Organizations)
The Entities API manages the organizations using the platform.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `GET /api/v1/entities` | List all verified entities. | Query: `type`, `region_id`, `governorate_id`, `city_id`, `status` | `EntityListResponse` |
| `GET /api/v1/entities/{id}` | Get entity details. | Path: `id` | `EntityResponse` |
| `PUT /api/v1/entities/{id}` | Update entity details. | Body: `UpdateEntityRequest` | `EntityResponse` |

### Offers (Supply)
The Offers API handles the creation and management of supply listings.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `POST /api/v1/offers` | Create a new offer. | Body: `CreateOfferRequest` (includes `drug_id` OR `free_text_name`, `quantity`, `unit`, `expiry_date`, `price`, `currency`) | `OfferResponse` |
| `GET /api/v1/offers` | Search and list offers. | Query: `drug_name`, `generic_name`, `region_id`, `status` | `OfferListResponse` |
| `GET /api/v1/offers/{id}` | Get offer details. | Path: `id` | `OfferResponse` |
| `PATCH /api/v1/offers/{id}` | Update offer status. | Body: `UpdateOfferStatusRequest` | `OfferResponse` |

### Requests (Demand)
The Requests API manages demand listings.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `POST /api/v1/requests` | Create a new request. | Body: `CreateRequestRequest` (includes `drug_id` OR `free_text_name`, `quantity`, `unit`, `urgency`, `max_price`, `currency`) | `RequestResponse` |
| `GET /api/v1/requests` | Search and list requests. | Query: `drug_name`, `generic_name`, `urgency`, `region_id`, `status` | `RequestListResponse` |
| `GET /api/v1/requests/{id}` | Get request details. | Path: `id` | `RequestResponse` |
| `PATCH /api/v1/requests/{id}` | Update request status. | Body: `UpdateRequestStatusRequest` | `RequestResponse` |

### Drugs (Product Catalog)
The Drugs API provides access to the standardized product catalog.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `GET /api/v1/drugs` | Search drug catalog. | Query: `q`, `category`, `manufacturer` | `DrugListResponse` |
| `GET /api/v1/drugs/{id}` | Get drug details and alternatives. | Path: `id` | `DrugResponse` |
| `GET /api/v1/drugs/{id}/alternatives` | Get alternatives for a specific drug. | Path: `id` | `AlternativeListResponse` |

### Notifications
The Notifications API manages alerts for the users.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `GET /api/v1/notifications` | List user notifications. | Path: N/A | `NotificationListResponse` |
| `PATCH /api/v1/notifications/{id}/read` | Mark notification as read. | Path: `id` | `NotificationResponse` |

### Search and Matching
The Matching API facilitates the connection between supply and demand.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `GET /api/v1/match` | Find matches for a specific request or offer. | Query: `request_id` or `offer_id` | `MatchListResponse` |
| `POST /api/v1/match/accept` | Accept a suggested match and initiate a conversation. | Body: `AcceptMatchRequest` | `ConversationResponse` |

### Conversations and Contact Revelation
The Conversations API handles communication between matched entities and the secure revelation of contact information.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `GET /api/v1/conversations` | List all conversations for the authenticated user. | Path: N/A | `ConversationListResponse` |
| `GET /api/v1/conversations/{id}/messages` | Get messages in a specific conversation. | Path: `id` | `MessageListResponse` |
| `POST /api/v1/conversations/{id}/messages` | Send a new message. | Body: `SendMessageRequest` | `MessageResponse` |
| `POST /api/v1/conversations/{id}/reveal-contact` | Request to reveal contact information to the other party. | Body: N/A | `ContactRevealResponse` |

### Reports and Market Intelligence
The Reports API provides macro-level data for analysts.
| Endpoint | Description | Request/Query | Response |
|----------|-------------|---------------|----------|
| `GET /api/v1/reports/market-trends` | Get macro-level market trends. | Query: `region_id`, `timeframe`, `drug_category` | `MarketTrendsResponse` |
| `GET /api/v1/reports/shortages` | Get current regional shortages. | Path: N/A | `ShortageReportResponse` |
| `GET /api/v1/reports/surpluses` | Get current regional surpluses. | Path: N/A | `SurplusReportResponse` |
