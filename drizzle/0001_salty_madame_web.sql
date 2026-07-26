CREATE TABLE `cities` (
	`id` int AUTO_INCREMENT NOT NULL,
	`governorateId` int,
	`name` varchar(100) NOT NULL,
	`nameAr` varchar(100),
	`latitude` decimal(10,8),
	`longitude` decimal(11,8),
	CONSTRAINT `cities_id` PRIMARY KEY(`id`),
	CONSTRAINT `city_name_idx` UNIQUE(`name`)
);
--> statement-breakpoint
CREATE TABLE `conversations` (
	`id` int AUTO_INCREMENT NOT NULL,
	`matchId` int NOT NULL,
	`offerEntityId` int NOT NULL,
	`requestEntityId` int NOT NULL,
	`contactRevealed` boolean NOT NULL DEFAULT false,
	`offerEntityRevealed` boolean NOT NULL DEFAULT false,
	`requestEntityRevealed` boolean NOT NULL DEFAULT false,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `conversations_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `drugAlternatives` (
	`id` int AUTO_INCREMENT NOT NULL,
	`sourceDrugId` int NOT NULL,
	`alternativeDrugId` int NOT NULL,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `drugAlternatives_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `drugs` (
	`id` int AUTO_INCREMENT NOT NULL,
	`brandName` varchar(200) NOT NULL,
	`brandNameAr` varchar(200),
	`genericName` varchar(200) NOT NULL,
	`genericNameAr` varchar(200),
	`manufacturer` varchar(200),
	`dosageForm` varchar(100),
	`strength` varchar(100),
	`category` enum('antibiotics','analgesics','cardiovascular','respiratory','gastrointestinal','neurological','endocrine','antifungal','antiviral','oncology','dermatological','ophthalmological','vitamins','other') NOT NULL,
	`isOfficial` boolean NOT NULL DEFAULT true,
	`isActive` boolean NOT NULL DEFAULT true,
	`isDeleted` boolean NOT NULL DEFAULT false,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `drugs_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `entities` (
	`id` int AUTO_INCREMENT NOT NULL,
	`userId` int,
	`name` varchar(200) NOT NULL,
	`type` enum('pharmacy','hospital','distributor','clinic') NOT NULL,
	`status` enum('pending','verified','suspended') NOT NULL DEFAULT 'pending',
	`licenseNumber` varchar(100),
	`contactPerson` varchar(200),
	`phone` varchar(30),
	`regionId` int,
	`governorateId` int,
	`cityId` int,
	`address` text,
	`isDeleted` boolean NOT NULL DEFAULT false,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `entities_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `governorates` (
	`id` int AUTO_INCREMENT NOT NULL,
	`regionId` int,
	`name` varchar(100) NOT NULL,
	`nameAr` varchar(100),
	CONSTRAINT `governorates_id` PRIMARY KEY(`id`),
	CONSTRAINT `gov_name_idx` UNIQUE(`name`)
);
--> statement-breakpoint
CREATE TABLE `marketSignals` (
	`id` int AUTO_INCREMENT NOT NULL,
	`signalType` enum('shortage','surplus','invisible_inventory','price_anomaly','trend_shift') NOT NULL,
	`drugId` int,
	`regionId` int,
	`governorateId` int,
	`severity` enum('low','medium','high','critical') NOT NULL DEFAULT 'medium',
	`confidence` int DEFAULT 0,
	`generatedFrom` text,
	`status` enum('new','acknowledged','dismissed','resolved') NOT NULL DEFAULT 'new',
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `marketSignals_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `matches` (
	`id` int AUTO_INCREMENT NOT NULL,
	`offerId` int NOT NULL,
	`requestId` int NOT NULL,
	`matchScore` decimal(5,2) NOT NULL,
	`drugMatchScore` decimal(5,2),
	`locationMatchScore` decimal(5,2),
	`urgencyMatchScore` decimal(5,2),
	`quantityMatchScore` decimal(5,2),
	`status` enum('suggested','accepted','rejected') NOT NULL DEFAULT 'suggested',
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `matches_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `messages` (
	`id` int AUTO_INCREMENT NOT NULL,
	`conversationId` int NOT NULL,
	`senderEntityId` int NOT NULL,
	`messageText` text NOT NULL,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `messages_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `notifications` (
	`id` int AUTO_INCREMENT NOT NULL,
	`userId` int NOT NULL,
	`type` enum('match_found','new_message','offer_expired','request_expired','signal_alert') NOT NULL,
	`title` varchar(300) NOT NULL,
	`body` text,
	`isRead` boolean NOT NULL DEFAULT false,
	`relatedEntityId` int,
	`relatedType` varchar(50),
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `notifications_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `offers` (
	`id` int AUTO_INCREMENT NOT NULL,
	`entityId` int NOT NULL,
	`drugId` int,
	`isFreeText` boolean NOT NULL DEFAULT false,
	`freeTextName` varchar(200),
	`freeTextNameAr` varchar(200),
	`quantity` int NOT NULL,
	`unit` varchar(50) NOT NULL,
	`expiryDate` date,
	`price` decimal(10,2),
	`currency` varchar(3) DEFAULT 'USD',
	`status` enum('active','closed','expired') NOT NULL DEFAULT 'active',
	`expiresAt` timestamp NOT NULL,
	`isDeleted` boolean NOT NULL DEFAULT false,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `offers_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `regions` (
	`id` int AUTO_INCREMENT NOT NULL,
	`name` varchar(100) NOT NULL,
	`nameAr` varchar(100),
	CONSTRAINT `regions_id` PRIMARY KEY(`id`),
	CONSTRAINT `regions_name_idx` UNIQUE(`name`)
);
--> statement-breakpoint
CREATE TABLE `requests` (
	`id` int AUTO_INCREMENT NOT NULL,
	`entityId` int NOT NULL,
	`drugId` int,
	`isFreeText` boolean NOT NULL DEFAULT false,
	`freeTextName` varchar(200),
	`freeTextNameAr` varchar(200),
	`quantity` int NOT NULL,
	`unit` varchar(50) NOT NULL,
	`urgency` enum('low','medium','high','critical') NOT NULL DEFAULT 'medium',
	`maxPrice` decimal(10,2),
	`currency` varchar(3) DEFAULT 'USD',
	`status` enum('open','closed','expired') NOT NULL DEFAULT 'open',
	`expiresAt` timestamp NOT NULL,
	`isDeleted` boolean NOT NULL DEFAULT false,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `requests_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
ALTER TABLE `cities` ADD CONSTRAINT `cities_governorateId_governorates_id_fk` FOREIGN KEY (`governorateId`) REFERENCES `governorates`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `conversations` ADD CONSTRAINT `conversations_matchId_matches_id_fk` FOREIGN KEY (`matchId`) REFERENCES `matches`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `conversations` ADD CONSTRAINT `conversations_offerEntityId_entities_id_fk` FOREIGN KEY (`offerEntityId`) REFERENCES `entities`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `conversations` ADD CONSTRAINT `conversations_requestEntityId_entities_id_fk` FOREIGN KEY (`requestEntityId`) REFERENCES `entities`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `drugAlternatives` ADD CONSTRAINT `drugAlternatives_sourceDrugId_drugs_id_fk` FOREIGN KEY (`sourceDrugId`) REFERENCES `drugs`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `drugAlternatives` ADD CONSTRAINT `drugAlternatives_alternativeDrugId_drugs_id_fk` FOREIGN KEY (`alternativeDrugId`) REFERENCES `drugs`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `entities` ADD CONSTRAINT `entities_userId_users_id_fk` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `entities` ADD CONSTRAINT `entities_regionId_regions_id_fk` FOREIGN KEY (`regionId`) REFERENCES `regions`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `entities` ADD CONSTRAINT `entities_governorateId_governorates_id_fk` FOREIGN KEY (`governorateId`) REFERENCES `governorates`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `entities` ADD CONSTRAINT `entities_cityId_cities_id_fk` FOREIGN KEY (`cityId`) REFERENCES `cities`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `governorates` ADD CONSTRAINT `governorates_regionId_regions_id_fk` FOREIGN KEY (`regionId`) REFERENCES `regions`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `marketSignals` ADD CONSTRAINT `marketSignals_drugId_drugs_id_fk` FOREIGN KEY (`drugId`) REFERENCES `drugs`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `marketSignals` ADD CONSTRAINT `marketSignals_regionId_regions_id_fk` FOREIGN KEY (`regionId`) REFERENCES `regions`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `marketSignals` ADD CONSTRAINT `marketSignals_governorateId_governorates_id_fk` FOREIGN KEY (`governorateId`) REFERENCES `governorates`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `matches` ADD CONSTRAINT `matches_offerId_offers_id_fk` FOREIGN KEY (`offerId`) REFERENCES `offers`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `matches` ADD CONSTRAINT `matches_requestId_requests_id_fk` FOREIGN KEY (`requestId`) REFERENCES `requests`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_conversationId_conversations_id_fk` FOREIGN KEY (`conversationId`) REFERENCES `conversations`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `messages` ADD CONSTRAINT `messages_senderEntityId_entities_id_fk` FOREIGN KEY (`senderEntityId`) REFERENCES `entities`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `notifications` ADD CONSTRAINT `notifications_userId_users_id_fk` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `offers` ADD CONSTRAINT `offers_entityId_entities_id_fk` FOREIGN KEY (`entityId`) REFERENCES `entities`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `offers` ADD CONSTRAINT `offers_drugId_drugs_id_fk` FOREIGN KEY (`drugId`) REFERENCES `drugs`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `requests` ADD CONSTRAINT `requests_entityId_entities_id_fk` FOREIGN KEY (`entityId`) REFERENCES `entities`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE `requests` ADD CONSTRAINT `requests_drugId_drugs_id_fk` FOREIGN KEY (`drugId`) REFERENCES `drugs`(`id`) ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE INDEX `city_gov_idx` ON `cities` (`governorateId`);--> statement-breakpoint
CREATE INDEX `conv_match_idx` ON `conversations` (`matchId`);--> statement-breakpoint
CREATE INDEX `conv_offer_entity_idx` ON `conversations` (`offerEntityId`);--> statement-breakpoint
CREATE INDEX `conv_request_entity_idx` ON `conversations` (`requestEntityId`);--> statement-breakpoint
CREATE INDEX `alt_source_idx` ON `drugAlternatives` (`sourceDrugId`);--> statement-breakpoint
CREATE INDEX `alt_target_idx` ON `drugAlternatives` (`alternativeDrugId`);--> statement-breakpoint
CREATE INDEX `drug_brand_idx` ON `drugs` (`brandName`);--> statement-breakpoint
CREATE INDEX `drug_generic_idx` ON `drugs` (`genericName`);--> statement-breakpoint
CREATE INDEX `drug_category_idx` ON `drugs` (`category`);--> statement-breakpoint
CREATE INDEX `drug_official_idx` ON `drugs` (`isOfficial`);--> statement-breakpoint
CREATE INDEX `entity_type_idx` ON `entities` (`type`);--> statement-breakpoint
CREATE INDEX `entity_status_idx` ON `entities` (`status`);--> statement-breakpoint
CREATE INDEX `entity_region_idx` ON `entities` (`regionId`);--> statement-breakpoint
CREATE INDEX `entity_city_idx` ON `entities` (`cityId`);--> statement-breakpoint
CREATE INDEX `gov_region_idx` ON `governorates` (`regionId`);--> statement-breakpoint
CREATE INDEX `signal_type_idx` ON `marketSignals` (`signalType`);--> statement-breakpoint
CREATE INDEX `signal_severity_idx` ON `marketSignals` (`severity`);--> statement-breakpoint
CREATE INDEX `signal_region_idx` ON `marketSignals` (`regionId`);--> statement-breakpoint
CREATE INDEX `signal_status_idx` ON `marketSignals` (`status`);--> statement-breakpoint
CREATE INDEX `match_offer_idx` ON `matches` (`offerId`);--> statement-breakpoint
CREATE INDEX `match_request_idx` ON `matches` (`requestId`);--> statement-breakpoint
CREATE INDEX `match_status_idx` ON `matches` (`status`);--> statement-breakpoint
CREATE INDEX `msg_conv_idx` ON `messages` (`conversationId`);--> statement-breakpoint
CREATE INDEX `msg_sender_idx` ON `messages` (`senderEntityId`);--> statement-breakpoint
CREATE INDEX `notif_user_idx` ON `notifications` (`userId`);--> statement-breakpoint
CREATE INDEX `notif_read_idx` ON `notifications` (`isRead`);--> statement-breakpoint
CREATE INDEX `notif_type_idx` ON `notifications` (`type`);--> statement-breakpoint
CREATE INDEX `offer_entity_idx` ON `offers` (`entityId`);--> statement-breakpoint
CREATE INDEX `offer_drug_idx` ON `offers` (`drugId`);--> statement-breakpoint
CREATE INDEX `offer_status_idx` ON `offers` (`status`);--> statement-breakpoint
CREATE INDEX `offer_free_text_idx` ON `offers` (`isFreeText`);--> statement-breakpoint
CREATE INDEX `offer_expires_idx` ON `offers` (`expiresAt`);--> statement-breakpoint
CREATE INDEX `request_entity_idx` ON `requests` (`entityId`);--> statement-breakpoint
CREATE INDEX `request_drug_idx` ON `requests` (`drugId`);--> statement-breakpoint
CREATE INDEX `request_status_idx` ON `requests` (`status`);--> statement-breakpoint
CREATE INDEX `request_urgency_idx` ON `requests` (`urgency`);--> statement-breakpoint
CREATE INDEX `request_free_text_idx` ON `requests` (`isFreeText`);--> statement-breakpoint
CREATE INDEX `request_expires_idx` ON `requests` (`expiresAt`);