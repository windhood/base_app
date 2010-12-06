CREATE TABLE "admin_notes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "resource_id" integer NOT NULL, "resource_type" varchar(255) NOT NULL, "admin_user_id" integer, "admin_user_type" varchar(255), "body" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "admin_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "password_salt" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "username" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "slugs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "sluggable_id" integer, "sequence" integer DEFAULT 1 NOT NULL, "sluggable_type" varchar(40), "scope" varchar(255), "created_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "password_salt" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "username" varchar(255) NOT NULL, "bio" text, "name" varchar(255), "created_at" datetime, "updated_at" datetime, "getting_started" bool);
CREATE INDEX "index_admin_notes_on_admin_user_type_and_admin_user_id" ON "admin_notes" ("admin_user_type", "admin_user_id");
CREATE INDEX "index_admin_notes_on_resource_type_and_resource_id" ON "admin_notes" ("resource_type", "resource_id");
CREATE UNIQUE INDEX "index_admin_users_on_email" ON "admin_users" ("email");
CREATE UNIQUE INDEX "index_admin_users_on_reset_password_token" ON "admin_users" ("reset_password_token");
CREATE UNIQUE INDEX "index_admin_users_on_username" ON "admin_users" ("username");
CREATE UNIQUE INDEX "index_slugs_on_n_s_s_and_s" ON "slugs" ("name", "sluggable_type", "sequence", "scope");
CREATE INDEX "index_slugs_on_sluggable_id" ON "slugs" ("sluggable_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "index_users_on_username" ON "users" ("username");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('201011181421');

INSERT INTO schema_migrations (version) VALUES ('20101013060634');

INSERT INTO schema_migrations (version) VALUES ('20101013060704');

INSERT INTO schema_migrations (version) VALUES ('20101118222041');

INSERT INTO schema_migrations (version) VALUES ('20101204003047');