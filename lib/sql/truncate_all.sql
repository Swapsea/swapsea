BREAK;

/* END OF SEASON CLEANUP */

-- Conforms to Australian Privacy Principles, removing PII data not needed.

TRUNCATE table activities;
TRUNCATE table ar_internal_metadata;
TRUNCATE table awards;
-- clubs
TRUNCATE table emails;
TRUNCATE table leads;
TRUNCATE table notice_acknowledgements;
-- notices
TRUNCATE table offers;
-- UPDATE offers SET mobile='', email='', comment='';

TRUNCATE table outreach_patrol_sign_ups;
TRUNCATE table outreach_patrols;
-- TRUNCATE table patrol_members
DELETE FROM patrol_members WHERE user_id > 100;
-- patrols
TRUNCATE table proficiencies;
TRUNCATE table proficiency_signups;
TRUNCATE table requests;
-- roles
TRUNCATE table rosters;
-- schema_migrations
TRUNCATE table staging_awards;
TRUNCATE table staging_patrol_members;
TRUNCATE table staging_users;
TRUNCATE table swaps;
DELETE FROM users WHERE id > 100;
UPDATE users SET sign_in_count = 0;
DELETE FROM users_roles WHERE user_id > 100;
