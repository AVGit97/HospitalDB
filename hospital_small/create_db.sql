DROP DATABASE IF EXISTS hospital; 

CREATE DATABASE hospital; 

USE hospital; 

CREATE TABLE all_data 
  ( 
     id                          CHAR(40) NOT NULL, 
     amka                        CHAR(20) NOT NULL, 
     surname                     VARCHAR(40) NOT NULL, 
     name                        VARCHAR(40) NOT NULL, 
     phone                       VARCHAR(15), 
     email                       VARCHAR(40), 
     roomid                      CHAR(40) NOT NULL, 
     roomno                      VARCHAR(7) NOT NULL, 
     nobeds                      INT NOT NULL, 
     appointment                 CHAR(40) NOT NULL, 
     appointment_date            DATE NOT NULL, 
     equipment_id                CHAR(40), 
     equipment_model             CHAR(20), 
     equipment_serialno          VARCHAR(20), 
     equipment_description       VARCHAR(240), 
     equipment_manufacturer_name VARCHAR(100), 
     equipment_release_date      DATE, 
     equipment_check_date        DATE, 
     equipment_usage_cost        DECIMAL(10, 2), 
     medicine_id                 CHAR(40), 
     medicine_name               VARCHAR(100), 
     medicine_company_name       VARCHAR(100), 
     medicine_price              DECIMAL(10, 2), 
     medicine_price_datefrom     DATE, 
     medicine_price_dateto       DATE, 
     doctor_id                   CHAR(40) NULL, 
     doctor_name                 VARCHAR(40), 
     doctor_surname              VARCHAR(40), 
     doctor_type                 VARCHAR(40), 
     doctor_gender               VARCHAR(8), 
     doctor_salary               DECIMAL(10, 2), 
     doctor_experience           DECIMAL(10, 2),
     main_doctor                 bool
  ); 
CREATE TABLE patient 
  ( 
     id      CHAR(40) NOT NULL, 
     amka    CHAR(20) NOT NULL, 
     surname VARCHAR(40) NOT NULL, 
     name    VARCHAR(40) NOT NULL, 
     phone   VARCHAR(15), 
     email   VARCHAR(40), 
     PRIMARY KEY (id) 
  ); 

CREATE TABLE equipment 
  ( 
     id                CHAR(40) NOT NULL, 
     model             CHAR(20) NOT NULL, 
     serialno          VARCHAR(20) NOT NULL, 
     description       VARCHAR(240) NOT NULL, 
     manufacturer_name VARCHAR(100), 
     release_date      DATE, 
     check_date        DATE, 
     usage_cost        DECIMAL(10, 2), 
     PRIMARY KEY (id) 
  ); 

INSERT INTO equipment (id, model, serialno, description) VALUE('0', 'None', 'None', 'None');

CREATE TABLE employee 
  ( 
     id               CHAR(40) NOT NULL, 
     employee_name    VARCHAR(40) NOT NULL, 
     employee_surname VARCHAR(40) NOT NULL, 
     gender           VARCHAR(8) NOT NULL, 
     salary           DECIMAL(10, 2), 
     employee_type    VARCHAR(40), 
     doctor_type      VARCHAR(40), 
     experience       DECIMAL(10, 2), 
     PRIMARY KEY (id) 
  ); 

CREATE TABLE medicine 
  ( 
     id            CHAR(40) NOT NULL, 
     medicine_name VARCHAR(100) NOT NULL, 
     company_name  VARCHAR(100) NOT NULL, 
     PRIMARY KEY (id) 
  ); 
INSERT INTO medicine (id, medicine_name, company_name) VALUE('0', 'None', 'None');

CREATE TABLE medicineprice 
  ( 
     medicine_id CHAR(40) NOT NULL, 
     price       DECIMAL(10, 2) NOT NULL, 
     datefrom    DATE NOT NULL, 
     dateto      DATE NOT NULL, 
     PRIMARY KEY (medicine_id, datefrom), 
     FOREIGN KEY (medicine_id) REFERENCES medicine(id) 
  ); 

INSERT INTO medicineprice (medicine_id, price, datefrom, dateto) VALUE('0', 0, '1980/01/01', '2100/12/31');

CREATE TABLE rooms 
  ( 
     id          CHAR(40) NOT NULL, 
     roomno      VARCHAR(7) NOT NULL, 
     nobeds      INT NOT NULL, 
     PRIMARY KEY ( id)
  ); 

CREATE TABLE appointment 
  ( 
     id           CHAR(40) NOT NULL, 
     patient_id   CHAR(40) NOT NULL, 
     room_id      CHAR(40) NOT NULL, 
     appoint_date DATE NOT NULL, 
     PRIMARY KEY (id), 
     FOREIGN KEY (patient_id) REFERENCES patient(id), 
     FOREIGN KEY (room_id) REFERENCES rooms(id) 
  ); 

CREATE TABLE appointmentrelations 
  ( 
     appointment_id CHAR(40) NOT NULL, 
     medicine_id    CHAR(40) NOT NULL, 
     datefrom       DATE NOT NULL, 
     equipment_id   CHAR(40) NOT NULL, 
     employee_id    CHAR(40) NOT NULL, 
     main_doctor    BOOL, 
     PRIMARY KEY (appointment_id, medicine_id, datefrom, equipment_id, employee_id), 
     FOREIGN KEY (appointment_id) REFERENCES appointment(id), 
     FOREIGN KEY (medicine_id, datefrom)REFERENCES medicineprice(medicine_id,  datefrom), 
     FOREIGN KEY (equipment_id) REFERENCES equipment(id), 
     FOREIGN KEY (employee_id) REFERENCES employee(id) 
  ); 
