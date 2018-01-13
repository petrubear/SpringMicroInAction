DROP TABLE IF EXISTS licenses;

CREATE TABLE licenses (
  license_id        VARCHAR(100) PRIMARY KEY NOT NULL,
  organization_id   TEXT NOT NULL,
  license_type      TEXT NOT NULL,
  product_name      TEXT NOT NULL,
  license_max       INT   NOT NULL,
  license_allocated INT,
  comment           VARCHAR(100));

INSERT INTO licenses (license_id,  organization_id, license_type, product_name, license_max, license_allocated)
VALUES ('f3831f8c-c338-4ebe-a82a-e2fc1d1ff78a', 'e254f8c-c442-4ebe-a82a-e2fc1d1ff78a', 'user','customer-crm-co', 100,5);
INSERT INTO licenses (license_id,  organization_id, license_type, product_name, license_max, license_allocated)
VALUES ('t9876f8c-c338-4abc-zf6a-ttt1', 'e254f8c-c442-4ebe-a82a-e2fc1d1ff78a', 'user','suitability-plus', 200,189);
INSERT INTO licenses (license_id,  organization_id, license_type, product_name, license_max, license_allocated)
VALUES ('38777179-7094-4200-9d61-edb101c6ea84', '442adb6e-fa58-47f3-9ca2-ed1fecdfe86c', 'user','HR-PowerSuite', 100,4);
INSERT INTO licenses (license_id,  organization_id, license_type, product_name, license_max, license_allocated)
VALUES ('08dbe05-606e-4dad-9d33-90ef10e334f9', '442adb6e-fa58-47f3-9ca2-ed1fecdfe86c', 'core-prod','WildCat Application Gateway', 16,16);


DROP TABLE IF EXISTS organizations;

CREATE TABLE organizations (
  organization_id        VARCHAR(100) PRIMARY KEY NOT NULL,
  name                   TEXT NOT NULL,
  contact_name           TEXT NOT NULL,
  contact_email          TEXT NOT NULL,
  contact_phone          TEXT   NOT NULL);

INSERT INTO organizations (organization_id, name, contact_name, contact_email, contact_phone)
VALUES ('e254f8c-c442-4ebe-a82a-e2fc1d1ff78a', 'customer-crm-co', 'Mark Balster', 'mark.balster@custcrmco.com', '823-555-1212');

INSERT INTO organizations (organization_id, name, contact_name, contact_email, contact_phone)
VALUES ('442adb6e-fa58-47f3-9ca2-ed1fecdfe86c', 'HR-PowerSuite', 'Doug Drewry','doug.drewry@hr.com', '920-555-1212');


DROP TABLE IF EXISTS abtesting;

CREATE TABLE abtesting (
  service_name      VARCHAR(100) PRIMARY KEY NOT NULL,
  active            VARCHAR(1) NOT NULL,
  endpoint          VARCHAR(100) NOT NULL,
  weight            INT);

INSERT INTO abtesting (service_name, active,  endpoint, weight) VALUES ('organizationservice', 'Y','http://localhost:8083/organizationservice',5);


DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS user_orgs;

CREATE  TABLE users (
  user_name VARCHAR(100) NOT NULL ,
  password VARCHAR(100) NOT NULL ,
  enabled boolean NOT NULL ,
  PRIMARY KEY (user_name));

CREATE TABLE user_roles (
  user_role_id SERIAL,
  user_name varchar(100) NOT NULL,
  role varchar(100) NOT NULL,
  PRIMARY KEY (user_role_id));

CREATE TABLE user_orgs (
  organization_id   VARCHAR(100)  NOT NULL,
  user_name         VARCHAR(100)   NOT NULL,
  PRIMARY KEY (user_name));

INSERT INTO users(user_name,password,enabled) VALUES ('john.carnell','$2a$04$NX3QTkBJB00upxKeaKqFBeoIVc9JHvwVnj1lItxNphRj34wNx5wlu', true);
INSERT INTO users(user_name,password,enabled) VALUES ('william.woodward','$2a$04$lM2hIsZVNYrQLi8mhvnTA.pheZtmzeivz6fyxCr9GZ6YSfP6YibCW', true);

INSERT INTO user_roles (user_name, role) VALUES ('john.carnell', 'ROLE_USER');
INSERT INTO user_roles (user_name, role) VALUES ('william.woodward', 'ROLE_ADMIN');
INSERT INTO user_roles (user_name, role) VALUES ('william.woodward', 'ROLE_USER');

INSERT INTO user_orgs (organization_id, user_name) VALUES ('d1859f1f-4bd7-4593-8654-ea6d9a6a626e', 'john.carnell');
INSERT INTO user_orgs (organization_id, user_name) VALUES ('42d3d4f5-9f33-42f4-8aca-b7519d6af1bb', 'william.woodward');
