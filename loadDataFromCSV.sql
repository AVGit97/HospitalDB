load data infile
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hospital_sample.csv'
into table all_data
columns terminated by ';'
optionally enclosed by '"';
