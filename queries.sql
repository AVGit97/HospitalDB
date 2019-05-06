# 1
select id, employee_name, employee_surname, salary
	from employee
	order by salary desc limit 10;

# 2
drop view if exists temp1, temp2;
create view temp1 as select distinct employee_id, patient_id
	from appointmentrelations, appointment
	where appointmentrelations.appointment_id=appointment.id;

create view temp2 as select employee_id, count(*) as patients from temp1 group by employee_id;
select employee.id, employee_name, employee_surname, temp2.patients from employee, temp2
	where employee.id=temp2.employee_id and temp2.patients=(select max(patients) from temp2);

# 3
select id, model, serialno, check_date
	from equipment
	where check_date <= LAST_DAY(curdate());

# 4
drop view if exists temp3, temp4;
create view temp3 as select distinct appointment_id, medicine_id from appointmentrelations;

create view temp4 as select medicine_id, count(*) as times_used from temp3 group by medicine_id;
select medicine_id, medicine_name, company_name, times_used from temp4, medicine
	where temp4.medicine_id=medicine.id and times_used=(select max(times_used) from temp4);

# 5
drop view if exists temp3, temp4, temp5;
create view temp3 as select distinct appointment_id, equipment_id from appointmentrelations;

create view temp4 as select equipment_id, count(*) as times_used from temp3 group by equipment_id;
create view temp5 as
	select equipment.id, equipment.serialno, equipment.model, equipment.manufacturer_name, datediff(curdate(), equipment.release_date) div 365 as age, times_used
		from temp4, equipment
		where temp4.equipment_id=equipment.id;

select *, times_used/age as ratio from temp5
	order by ratio desc limit 1;

# 6
drop view if exists temp5, temp6, temp7, temp8, temp9;

create view temp5 as
select distinct appointmentrelations.appointment_id, appointmentrelations.medicine_id, medicineprice.price
	from appointmentrelations, medicineprice
	where medicineprice.medicine_id=appointmentrelations.medicine_id and medicineprice.datefrom=appointmentrelations.datefrom;

create view temp6 as
	select distinct appointmentrelations.appointment_id, appointmentrelations.equipment_id, usage_cost
		from appointmentrelations, equipment
		where appointmentrelations.equipment_id=equipment.id;

create view temp7 as
	select appointment_id, sum(price) as medSum
		from temp5
		group by appointment_id;

create view temp8 as
	select appointment_id, sum(usage_cost) as eqSum
		from temp6
		group by appointment_id;

create view temp9 as
select appointment_id, medSum+eqSum as paidSum from (
	select temp7.appointment_id, medSum, eqSum
		from temp7, temp8
		where temp7.appointment_id=temp8.appointment_id
) as t;

select patient.id, patient.name, patient.surname, paidSum
	from appointment, temp9, patient
	where appointment.id=temp9.appointment_id and appointment.patient_id=patient.id
	order by paidSum desc limit 20;

# 7 (reuses temp5, temp6, temp7, temp8, temp9 views)
select patient_id, name, surname, sum(paidSum)
	from temp9, appointment, patient
	where appointment.id=temp9.appointment_id
	and appointment.patient_id=patient.id
	group by patient_id
	order by sum(paidSum) desc limit 20;
