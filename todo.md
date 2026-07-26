# Project TODO

## Backend & Database
- [x] Database schema: entities table with role-based access (pharmacy, hospital, distributor, clinic, admin)
- [x] Database schema: drugs table (official catalog with is_official flag)
- [x] Database schema: drug_alternatives table
- [x] Database schema: offers table with is_free_text support and auto-expiry
- [x] Database schema: requests table with is_free_text support and auto-expiry and urgency
- [x] Database schema: matches table with scoring
- [x] Database schema: conversations and messages tables
- [x] Database schema: conversations with contact_revealed flag (mutual consent)
- [x] Database schema: notifications table
- [x] Database schema: geographic hierarchy (regions, governorates, cities)
- [x] Seed geographic data for Yemen (regions, governorates, cities)
- [x] Seed official drug catalog
- [x] Auth: entity registration with admin approval workflow
- [x] Auth: role-based access control (admin, pharmacy, hospital, distributor, clinic)
- [x] API: offers CRUD with auto-expiry after 30 days
- [x] API: requests CRUD with auto-expiry after 30 days
- [x] API: matching engine (drug match, location, urgency, quantity)
- [x] API: messaging system
- [x] API: contact revelation (mutual consent)
- [x] API: notifications (in-app + email)
- [x] API: market intelligence endpoints (shortage/surplus indices, trends)
- [x] API: drug alternatives management
- [x] Background job: auto-expire offers and requests after 30 days (cron daily at 02:00 UTC)
- [x] Background job: matching engine triggers (runs on offer/request creation)

## Remaining Gaps
- [x] Matches page: list detected matches with scores, accept/reject actions
- [x] Drug alternatives: view existing links, per-drug lookup, unlink
- [x] Mobile/tablet responsive polish and testing

## Frontend
- [x] Design system: elegant color palette, typography, spacing
- [x] Landing page with platform introduction
- [x] Entity registration page
- [x] Admin panel: entity verification queue
- [x] Admin panel: drug catalog management
- [x] Admin panel: market signals review
- [x] Offer creation and listing page
- [x] Request creation and listing page
- [x] Search with full-text (brand, generic, active ingredient) and free-text input
- [x] Matching results display
- [x] Real-time messaging UI
- [x] Contact revelation UI (mutual consent flow)
- [x] Notifications center
- [x] Market intelligence dashboard (shortage/surplus indices, trends, Yemen heat map)
- [x] Drug alternatives management UI
- [x] Geographic filter (Region → Governorate → City)
- [x] Entity profile and role-based navigation
- [x] Responsive design for all screens
