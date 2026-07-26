# Business Rules
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the core business rules governing the behavior of the platform, its users, and the data within it. These rules ensure data integrity, fair matching, and accurate market intelligence, while strictly adhering to the platform's role as a connection facilitator rather than an e-commerce or ERP system.

### Entity Management Rules

| Rule ID | Rule Description | Rationale |
|---------|------------------|-----------|
| BR-001 | An Entity must be verified before it can create Offers or Requests. | To prevent fraud and ensure market data comes from legitimate sources. |
| BR-002 | An Entity can have multiple active Offers and Requests simultaneously. | To allow comprehensive inventory management and procurement. |
| BR-003 | An Entity cannot communicate with another Entity unless they have a matched Offer/Request. | To maintain focus on market intelligence and prevent spam. |

### Offer and Request Rules

| Rule ID | Rule Description | Rationale |
|---------|------------------|-----------|
| BR-010 | An Offer or Request automatically transitions to an "Expired" status after 30 days if not manually closed. | To ensure market data remains current and relevant. |
| BR-011 | An Entity can manually close an Offer or Request at any time. | To provide flexibility when items are sold or procured elsewhere. |
| BR-012 | An Offer cannot be matched if its remaining quantity is zero. | To prevent false matching and user frustration. |
| BR-013 | A Request can specify a maximum price, but this does not affect the matching algorithm's core logic (which is based on availability and location). | To keep matching objective while allowing users to filter later. |
| BR-014 | Urgent Requests are prioritized in the matching queue over standard Requests. | To ensure critical shortages are addressed quickly. |

### Matching and Communication Rules

| Rule ID | Rule Description | Rationale |
|---------|------------------|-----------|
| BR-020 | Matching occurs based on Drug Name, Active Ingredient, Region/Governorate, and Urgency. | To ensure relevant and actionable matches. |
| BR-021 | If an exact Drug match is unavailable, the system suggests matches based on approved Alternatives. | To maximize the utilization of available market supply. |
| BR-022 | A Conversation is initiated only when a Request matches an Offer, or when a user explicitly searches for an Offer. | To prevent unsolicited communication. |
| BR-023 | Contact information is only revealed when both parties agree via the platform's messaging system. | To maintain control over the negotiation process while allowing the transaction to happen outside the platform. |

### Market Intelligence and Data Rules

| Rule ID | Rule Description | Rationale |
|---------|------------------|-----------|
| BR-030 | The platform does not process or store any financial transaction data. | To strictly adhere to the "Market Intelligence" scope, not e-commerce. |
| BR-031 | "Invisible Inventory" is identified when an Entity is registered but has no active Offers, yet operates in a high-demand region. | To highlight potential hidden supply for market analysts. |
| BR-032 | A "Shortage" signal is generated when Requests for a specific Drug in a Region exceed Offers by a defined threshold (e.g., 50%). | To provide actionable alerts to decision-makers. |
| BR-033 | A "Surplus" signal is generated when Offers for a specific Drug in a Region exceed Requests by a defined threshold. | To help distributors manage waste and over-supply. |
| BR-034 | The official drug list serves as the base, but unlisted drugs can be entered as free text without being automatically added to the official list. | To maintain the integrity of the official catalog while accommodating user needs. |
