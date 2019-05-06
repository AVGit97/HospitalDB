CREATE TABLE ������� (
	�������_�������� numeric(15, 0) NOT NULL PRIMARY KEY,
	�����_�������� varchar(50),
	������������_������� varchar(100),
	����_�������� numeric(8, 3),
	������_������_����� Date,
	����_������_����� Date
);

CREATE TABLE ������� (
	���� numeric(8, 0) NOT NULL PRIMARY KEY,
	����� varchar(50),
	������� varchar(50),
	�������� varchar(14),
	Email varchar(254)
);

CREATE TABLE �������_���� (
	�������_������ varchar(50) NOT NULL PRIMARY KEY,
	���� numeric(8, 0) FOREIGN KEY REFERENCES �������(����)
);

CREATE TABLE ��������� (
	�������_��������� varchar(50) NOT NULL PRIMARY KEY,
	����� varchar(50),
	������� varchar(50),
	���� varchar(7) NOT NULL CHECK (���� IN ('������', '�������')),
	������ numeric(9, 3),
	�����_��������� varchar(11) NOT NULL CHECK (�����_��������� IN ('�������', '����������', '�������', '�����������')),
	�������� numeric(3, 1)
);

CREATE TABLE ������� (
	�������_������� varchar(50) NOT NULL PRIMARY KEY,
	�������_��������� varchar(50) FOREIGN KEY REFERENCES ���������(�������_���������),
	�����_������� varchar(10) NOT NULL CHECK(�����_������� IN ('�������', '����������', '����������'))
);

CREATE TABLE ������� (
	�������_�������� varchar(50) NOT NULL PRIMARY KEY,
	�������_�������� varchar(5),
	�������_��������� numeric(2, 0),
	�������_��������� varchar(50) FOREIGN KEY REFERENCES ���������(�������_���������),
);

CREATE TABLE �������� (
	�������_�������� varchar(50) NOT NULL PRIMARY KEY,
	����������_�������� Date,
	�������_������ varchar(50) FOREIGN KEY REFERENCES �������_����(�������_������),
	�������_������� varchar(50) FOREIGN KEY REFERENCES �������(�������_�������)
);

CREATE TABLE ���������� (
	�������_���������� varchar(50) NOT NULL PRIMARY KEY,
	������� varchar(50),
	���������_������� varchar(20),
	��������� text,
	�����_��������������� varchar(100),
	����������_��������� Date,
	����������_��������_������� Date,
	�������_�������� varchar(50) FOREIGN KEY REFERENCES �������(�������_��������)
);

CREATE TABLE �������� (
	�������_��������� varchar(50) NOT NULL PRIMARY KEY,
	�������_�������� varchar(50) FOREIGN KEY REFERENCES ��������(�������_��������),
	�������_�������� varchar(50) FOREIGN KEY REFERENCES �������(�������_��������),
	����������_��������� Date
);

CREATE TABLE ��������_����������(
	�������_�������� varchar(50) FOREIGN KEY REFERENCES ��������(�������_��������),
	�������_���������� varchar(50) FOREIGN KEY REFERENCES ����������(�������_����������),
	������_������ numeric(8, 3),
	PRIMARY KEY (�������_��������, �������_����������)
);

CREATE TABLE ��������_������� (
	�������_�������� varchar(50) FOREIGN KEY REFERENCES ��������(�������_��������),
	�������_�������� numeric(15, 0) FOREIGN KEY REFERENCES �������(�������_��������),
	PRIMARY KEY (�������_��������, �������_��������)
);

CREATE TABLE �������� (
	�������_�������� varchar(50) FOREIGN KEY REFERENCES ��������(�������_��������),
	�������_��������� varchar(50) FOREIGN KEY REFERENCES ���������(�������_���������),
	PRIMARY KEY (�������_��������, �������_���������)
);
