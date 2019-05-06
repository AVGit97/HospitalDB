update all_data
set all_data.equipment_id=ifnull(all_data.equipment_id, 0),
    all_data.medicine_id=ifnull(all_data.medicine_id, 0);

#_______________________________________________________________________________________________________#

insert into employee
select distinct doctor_id, doctor_name, doctor_surname, doctor_gender, doctor_salary, doctor_type, doctor_type, doctor_experience
from all_data;

insert into equipment
select distinct equipment_id, equipment_model, equipment_serialno, equipment_description, equipment_manufacturer_name, equipment_release_date, equipment_check_date, equipment_usage_cost
from all_data
where equipment_id!='0';

insert into medicine
select distinct medicine_id, medicine_name, medicine_company_name
from all_data
where medicine_id!='0';

insert into medicineprice
select distinct medicine_id, medicine_price, medicine_price_datefrom, medicine_price_dateto
from all_data
where medicine_id!='0';

insert into patient select distinct id, amka, surname, name, phone, email
from all_data;

insert into rooms select distinct roomid, roomno, nobeds
from all_data;

insert into appointment
select distinct appointment, id, roomid, appointment_date
from all_data;

insert into appointmentrelations
select distinct appointment, all_data.medicine_id, medicineprice.datefrom, equipment_id, doctor_id, main_doctor
from all_data, medicineprice
where all_data.medicine_id=medicineprice.medicine_id and all_data.medicine_price_datefrom=medicineprice.datefrom;

#_______________________________________________________________________________________________________#

select distinct appointment, medicine_id, equipment_id, doctor_id, main_doctor
from all_data;

select * from all_data;

select * from appointment;
select * from appointmentrelations;
select * from employee;
select * from equipment;
select * from medicine;
select * from medicineprice;
select * from patient;
select * from rooms;
