# Database Design
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the relational database schema designed to support the platform's domain model. It incorporates requirements for normalization, scalability, audit readiness, soft deletes, versioning, indexing, and history tracking. The schema is updated to support the official drug list alongside free-text entries, and to include the Conversation and Contact Revelation features.

### Core Principles
- **Normalization**: Data is normalized to the 3rd Normal Form (3NF) to reduce redundancy and ensure data integrity.
- **Scalability**: UUIDs are used for primary keys to facilitate distributed systems and horizontal scaling.
- **Audit Ready**: Every table includes `created_at`, `updated_at`, `created_by`, and `updated_by` fields.
- **Soft Delete**: A `is_deleted` boolean flag is used instead of physical deletion to retain historical data.
- **Versioning**: Changes to critical entities are tracked in dedicated history tables.
- **Indexes**: Strategic indexes are applied to frequently queried columns (e.g., status, foreign keys, search fields).

### Schema Design

#### 1. Identity Domain
**Table: `entities`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `name` | VARCHAR(100) | NOT NULL | Organization name |
| `type` | VARCHAR(20) | NOT NULL | pharmacy, hospital, etc. |
| `status` | VARCHAR(20) | NOT NULL | pending, verified, suspended |
| `license_number` | VARCHAR(50) | NOT NULL, UNIQUE | Official registration number |
| `contact_person` | VARCHAR(100) | NOT NULL | Primary contact name |
| `email` | VARCHAR(100) | NOT NULL | Contact email |
| `phone` | VARCHAR(20) | NOT NULL | Contact phone |
| `region_id` | UUID | FK -> regions.id | Geographic region |
| `governorate_id` | UUID | FK -> governorates.id | Administrative division |
| `city_id` | UUID | FK -> cities.id | Specific city |
| `address` | VARCHAR(255) | NULL | Physical address |
| `verification_level` | VARCHAR(20) | NOT NULL | basic, advanced |
| `is_deleted` | BOOLEAN | DEFAULT FALSE | Soft delete flag |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

#### 2. Product Domain
**Table: `drugs`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `brand_name` | VARCHAR(100) | NOT NULL | Commercial name |
| `generic_name` | VARCHAR(100) | NOT NULL | Active ingredient name |
| `manufacturer` | VARCHAR(100) | NOT NULL | Producing company |
| `dosage_form` | VARCHAR(50) | NOT NULL | Form of medication |
| `strength` | VARCHAR(50) | NOT NULL | Dosage strength |
| `category` | VARCHAR(50) | NOT NULL | Therapeutic category |
| `is_official` | BOOLEAN | DEFAULT TRUE | Indicates if part of the official list |
| `is_active` | BOOLEAN | DEFAULT TRUE | Availability flag |
| `is_deleted` | BOOLEAN | DEFAULT FALSE | Soft delete flag |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

**Table: `drug_alternatives`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `source_drug_id` | UUID | FK -> drugs.id | The original drug |
| `alternative_drug_id` | UUID | FK -> drugs.id | The substitute drug |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |

#### 3. Marketplace Domain
**Table: `offers`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `entity_id` | UUID | FK -> entities.id | Offering organization |
| `drug_id` | UUID | FK -> drugs.id | Product being offered (official list) |
| `is_free_text` | BOOLEAN | DEFAULT FALSE | Flag for unlisted drugs |
| `free_text_name` | VARCHAR(200) | NULL | Exact text entered for unlisted drugs |
| `quantity` | INTEGER | NOT NULL | Available amount |
| `unit` | VARCHAR(20) | NOT NULL | Unit of measure |
| `expiry_date` | DATE | NOT NULL | Product expiration |
| `price` | DECIMAL(10,2) | NULL | Asking price |
| `currency` | VARCHAR(3) | NOT NULL | Currency code |
| `source` | VARCHAR(20) | NOT NULL | manual, api, system |
| `data_quality` | DECIMAL(5,2) | NULL | Quality score (0-100) |
| `status` | VARCHAR(20) | NOT NULL | active, closed, expired |
| `is_deleted` | BOOLEAN | DEFAULT FALSE | Soft delete flag |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

**Table: `requests`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `entity_id` | UUID | FK -> entities.id | Requesting organization |
| `drug_id` | UUID | FK -> drugs.id | Product needed (official list) |
| `is_free_text` | BOOLEAN | DEFAULT FALSE | Flag for unlisted drugs |
| `free_text_name` | VARCHAR(200) | NULL | Exact text entered for unlisted drugs |
| `quantity` | INTEGER | NOT NULL | Required amount |
| `unit` | VARCHAR(20) | NOT NULL | Unit of measure |
| `urgency` | VARCHAR(20) | NOT NULL | low, medium, high, critical |
| `max_price` | DECIMAL(10,2) | NULL | Maximum acceptable price |
| `currency` | VARCHAR(3) | NOT NULL | Currency code |
| `source` | VARCHAR(20) | NOT NULL | manual, api, system |
| `data_quality` | DECIMAL(5,2) | NULL | Quality score (0-100) |
| `status` | VARCHAR(20) | NOT NULL | open, closed, expired |
| `is_deleted` | BOOLEAN | DEFAULT FALSE | Soft delete flag |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

**Table: `matches`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `offer_id` | UUID | FK -> offers.id | Matched offer |
| `request_id` | UUID | FK -> requests.id | Matched request |
| `match_score` | DECIMAL(5,2) | NULL | Algorithm confidence |
| `status` | VARCHAR(20) | NOT NULL | suggested, accepted, rejected |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |

**Table: `conversations`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `match_id` | UUID | FK -> matches.id | The match that initiated the conversation |
| `offer_entity_id` | UUID | FK -> entities.id | The entity making the offer |
| `request_entity_id` | UUID | FK -> entities.id | The entity making the request |
| `contact_revealed` | BOOLEAN | DEFAULT FALSE | Flag indicating if contact info was shared |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update timestamp |

**Table: `messages`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `conversation_id` | UUID | FK -> conversations.id | The conversation thread |
| `sender_entity_id` | UUID | FK -> entities.id | The entity sending the message |
| `message_text` | TEXT | NOT NULL | The content of the message |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |

#### 4. Geography Domain
**Table: `regions`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `name` | VARCHAR(100) | NOT NULL | Geographic name |

**Table: `governorates`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `region_id` | UUID | FK -> regions.id | Parent region |
| `name` | VARCHAR(100) | NOT NULL | Geographic name |

**Table: `cities`**
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK | Primary Key |
| `governorate_id` | UUID | FK -> governorates.id | Parent governorate |
| `name` | VARCHAR(100) | NOT NULL | Geographic name |
| `latitude` | DECIMAL(10,8) | NULL | GPS coordinate |
| `longitude` | DECIMAL(11,8) | NULL | GPS coordinate |

### History and Auditing
To support versioning and history tracking, every core entity (`entities`, `drugs`, `offers`, `requests`) has a corresponding history table (e.g., `offers_history`).
When an update occurs on the main table, a trigger or application logic inserts a snapshot of the previous state into the `_history` table, recording the `updated_at` timestamp and the `updated_by` user ID. This ensures a complete audit trail of all changes.
