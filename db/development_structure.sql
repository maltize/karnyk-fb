CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fb_user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_fb_user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_messages_on_fb_user_id` (`fb_user_id`),
  KEY `index_messages_on_target_fb_user_id` (`target_fb_user_id`),
  KEY `index_messages_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20110127212338');