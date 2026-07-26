# Data Catalog
## Yemen Pharmaceutical Market Intelligence Platform

This document serves as the definitive reference for the data entities within the platform. It outlines the fields, types, validations, and indexing requirements for each core entity, including the new Market Intelligence and Signal models. The catalog is updated to reflect the requirement for an official drug list alongside free-text entries.

### 1. Entity (Organization/User)
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `a1b2c3d4-e5f6...` |
| `name` | Organization name | String | Yes | Max 100 chars | Yes | Yes | `Al-Amal Pharmacy` |
| `type` | Type of entity | Enum | Yes | `['pharmacy', 'hospital', 'distributor', 'clinic']` | Yes | Yes | `pharmacy` |
| `status` | Account status | Enum | Yes | `['pending', 'verified', 'suspended']` | Yes | Yes | `verified` |
| `license_number` | Official registration number | String | Yes | Alphanumeric | Yes | Yes | `MOH-12345` |
| `contact_person` | Primary contact name | String | Yes | Max 100 chars | Yes | No | `Dr. Ahmed Ali` |
| `email` | Contact email | String | Yes | Valid email format | Yes | Yes | `contact@alamal.ye` |
| `phone` | Contact phone | String | Yes | E.164 format | Yes | Yes | `+967700000000` |
| `region_id` | Geographic region | UUID | Yes | Must exist in Region table | No | Yes | `region-uuid` |
| `governorate_id` | Administrative division | UUID | Yes | Must exist in Governorate table | No | Yes | `gov-uuid` |
| `city_id` | Specific city | UUID | Yes | Must exist in City table | No | Yes | `city-uuid` |
| `address` | Physical address | String | No | Max 255 chars | Yes | No | `Main St, Sana'a` |
| `verification_level` | Level of verification (e.g., Basic, Advanced) | Enum | Yes | `['basic', 'advanced']` | No | Yes | `advanced` |
| `created_at` | Registration date | DateTime | Yes | Auto-generated | No | Yes | `2023-10-01T10:00:00Z` |
| `updated_at` | Last modification date | DateTime | Yes | Auto-updated | No | Yes | `2023-10-05T14:30:00Z` |

### 2. Drug (Product)
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `d1e2f3g4-h5i6...` |
| `brand_name` | Commercial name | String | Yes | Max 100 chars | Yes | Yes | `Panadol` |
| `generic_name` | Active ingredient name | String | Yes | Max 100 chars | Yes | Yes | `Paracetamol` |
| `manufacturer` | Producing company | String | Yes | Max 100 chars | Yes | Yes | `GSK` |
| `dosage_form` | Form of medication | String | Yes | Max 50 chars | Yes | Yes | `Tablet` |
| `strength` | Dosage strength | String | Yes | Max 50 chars | Yes | Yes | `500mg` |
| `category` | Therapeutic category | Enum | Yes | `['antibiotics', 'analgesics', 'cardio', ...]` | Yes | Yes | `analgesics` |
| `is_official` | Indicates if the drug is part of the official list | Boolean | Yes | Default `true` | No | Yes | `true` |
| `is_active` | Availability flag | Boolean | Yes | Default `true` | No | Yes | `true` |

### 3. Offer (Supply Listing)
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `o1a2b3c4...` |
| `entity_id` | Offering organization | UUID | Yes | Must be verified Entity | No | Yes | `entity-uuid` |
| `drug_id` | Product being offered | UUID | Yes | Must be active Drug | No | Yes | `drug-uuid` |
| `is_free_text` | Flag indicating if the drug was entered as free text | Boolean | Yes | Default `false` | No | Yes | `false` |
| `free_text_name` | The exact free text entered if `is_free_text` is true | String | No | Max 200 chars | Yes | Yes | `Unknown Brand X` |
| `quantity` | Available amount | Integer | Yes | Must be > 0 | No | No | `500` |
| `unit` | Unit of measure | String | Yes | Max 20 chars | No | No | `Box` |
| `expiry_date` | Product expiration | Date | Yes | Must be in future | No | Yes | `2025-12-31` |
| `price` | Asking price (optional) | Decimal | No | Must be > 0 | No | No | `15.50` |
| `currency` | Currency code | String | Yes | `['USD', 'YER', 'SAR']` | No | Yes | `USD` |
| `source` | Source of the offer (Manual, API, etc.) | Enum | Yes | `['manual', 'api', 'system']` | No | No | `manual` |
| `data_quality` | Quality score of the data | Decimal | No | 0.0 to 100.0 | No | Yes | `95.0` |
| `status` | Current state | Enum | Yes | `['active', 'closed', 'expired']` | Yes | Yes | `active` |
| `created_at` | Listing date | DateTime | Yes | Auto-generated | No | Yes | `2023-10-01T10:00:00Z` |

### 4. Request (Demand Listing)
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `r1x2y3z4...` |
| `entity_id` | Requesting organization | UUID | Yes | Must be verified Entity | No | Yes | `entity-uuid` |
| `drug_id` | Product needed | UUID | Yes | Must be active Drug | No | Yes | `drug-uuid` |
| `is_free_text` | Flag indicating if the drug was entered as free text | Boolean | Yes | Default `false` | No | Yes | `false` |
| `free_text_name` | The exact free text entered if `is_free_text` is true | String | No | Max 200 chars | Yes | Yes | `Unknown Brand X` |
| `quantity` | Required amount | Integer | Yes | Must be > 0 | No | No | `1000` |
| `unit` | Unit of measure | String | Yes | Max 20 chars | No | No | `Box` |
| `urgency` | Priority level | Enum | Yes | `['low', 'medium', 'high', 'critical']` | Yes | Yes | `critical` |
| `max_price` | Maximum acceptable price | Decimal | No | Must be > 0 | No | No | `18.00` |
| `currency` | Currency code | String | Yes | `['USD', 'YER', 'SAR']` | No | Yes | `USD` |
| `source` | Source of the request | Enum | Yes | `['manual', 'api', 'system']` | No | No | `manual` |
| `data_quality` | Quality score of the data | Decimal | No | 0.0 to 100.0 | No | Yes | `95.0` |
| `status` | Current state | Enum | Yes | `['open', 'closed', 'expired']` | Yes | Yes | `open` |
| `created_at` | Request date | DateTime | Yes | Auto-generated | No | Yes | `2023-10-01T10:00:00Z` |

### 5. Geographic Entities
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `geo-uuid` |
| `name` | Geographic name | String | Yes | Max 100 chars | Yes | Yes | `Sana'a` |
| `type` | Hierarchy level | Enum | Yes | `['region', 'governorate', 'city']` | No | Yes | `city` |
| `parent_id` | Parent entity ID | UUID | No | Must match parent type | No | Yes | `parent-uuid` |
| `latitude` | GPS coordinate | Decimal | No | -90 to 90 | No | Yes | `15.3694` |
| `longitude` | GPS coordinate | Decimal | No | -180 to 180 | No | Yes | `44.1910` |

### 6. Market Signals (Intelligence Engine)
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `s1a2b3c4...` |
| `signal_type` | Type of signal | Enum | Yes | `['shortage', 'surplus', 'invisible_inventory', 'price_anomaly', 'trend_shift']` | Yes | Yes | `shortage` |
| `drug_id` | Associated drug | UUID | No | Must be active Drug | No | Yes | `drug-uuid` |
| `region_id` | Geographic region | UUID | Yes | Must exist in Region table | No | Yes | `region-uuid` |
| `severity` | Criticality level | Enum | Yes | `['low', 'medium', 'high', 'critical']` | Yes | Yes | `critical` |
| `confidence` | Reliability score | Integer | Yes | 0 to 100 | No | Yes | `95` |
| `generated_from` | Source data description | String | Yes | Max 500 chars | Yes | No | `Based on 5 active requests and 0 offers in Aden` |
| `status` | Current state | Enum | Yes | `['new', 'acknowledged', 'dismissed', 'resolved']` | Yes | Yes | `new` |
| `created_at` | Generation date | DateTime | Yes | Auto-generated | No | Yes | `2023-10-01T10:00:00Z` |

### 7. Match (Connection Record)
| Field Name | Description | Type | Required | Validation | Searchable | Indexed | Example |
|------------|-------------|------|----------|------------|------------|---------|---------|
| `id` | Unique identifier | UUID | Yes | Must be unique | No | Yes | `m1a2b3c4...` |
| `offer_id` | Matched offer | UUID | Yes | Must be active Offer | No | Yes | `offer-uuid` |
| `request_id` | Matched request | UUID | Yes | Must be open Request | No | Yes | `request-uuid` |
| `match_score` | Algorithm confidence | Decimal | No | 0.0 to 100.0 | No | No | `95.5` |
| `status` | Match state | Enum | Yes | `['suggested', 'accepted', 'rejected']` | Yes | Yes | `suggested` |
| `created_at` | Match date | DateTime | Yes | Auto-generated | No | Yes | `2023-10-01T10:00:00Z` |
