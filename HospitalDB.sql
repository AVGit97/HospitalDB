CREATE TABLE Φάρμακο (
	Κωδικός_Φαρμάκου numeric(15, 0) NOT NULL PRIMARY KEY,
	Όνομα_Φαρμάκου varchar(50),
	Φαρμακευτική_Εταιρία varchar(100),
	Τιμή_Φαρμάκου numeric(8, 3),
	Έναρξη_Ισχύος_Τιμής Date,
	Λήξη_Ισχύος_Τιμής Date
);

CREATE TABLE Ασθενής (
	ΑΜΚΑ numeric(8, 0) NOT NULL PRIMARY KEY,
	Όνομα varchar(50),
	Επώνυμο varchar(50),
	Τηλέφωνο varchar(14),
	Email varchar(254)
);

CREATE TABLE Ασθενής_ΑΜΚΑ (
	Κωδικός_Ασθενή varchar(50) NOT NULL PRIMARY KEY,
	ΑΜΚΑ numeric(8, 0) FOREIGN KEY REFERENCES Ασθενής(ΑΜΚΑ)
);

CREATE TABLE Υπάλληλος (
	Κωδικός_Υπαλλήλου varchar(50) NOT NULL PRIMARY KEY,
	Όνομα varchar(50),
	Επώνυμο varchar(50),
	Φύλο varchar(7) NOT NULL CHECK (Φύλο IN ('’νδρας', 'Γυναίκα')),
	Μισθός numeric(9, 3),
	Τύπος_Υπαλλήλου varchar(11) NOT NULL CHECK (Τύπος_Υπαλλήλου IN ('Γιατρός', 'Νοσηλευτής', 'Υποδοχή', 'Διοικητικός')),
	Εμπειρία numeric(3, 1)
);

CREATE TABLE Γιατρός (
	Κωδικός_Γιατρού varchar(50) NOT NULL PRIMARY KEY,
	Κωδικός_Υπαλλήλου varchar(50) FOREIGN KEY REFERENCES Υπάλληλος(Κωδικός_Υπαλλήλου),
	Τύπος_Γιατρού varchar(10) NOT NULL CHECK(Τύπος_Γιατρού IN ('Μόνιμος', 'Επισκέπτης', 'Ασκούμενος'))
);

CREATE TABLE Δωμάτιο (
	Κωδικός_Δωματίου varchar(50) NOT NULL PRIMARY KEY,
	Αριθμός_Δωματίου varchar(5),
	Αριθμός_Κρεβατιών numeric(2, 0),
	Κωδικός_Υπαλλήλου varchar(50) FOREIGN KEY REFERENCES Υπάλληλος(Κωδικός_Υπαλλήλου),
);

CREATE TABLE Ραντεβού (
	Κωδικός_Ραντεβού varchar(50) NOT NULL PRIMARY KEY,
	Ημερομηνία_Ραντεβού Date,
	Κωδικός_Ασθενή varchar(50) FOREIGN KEY REFERENCES Ασθενής_ΑΜΚΑ(Κωδικός_Ασθενή),
	Κωδικός_Γιατρού varchar(50) FOREIGN KEY REFERENCES Γιατρός(Κωδικός_Γιατρού)
);

CREATE TABLE Εξοπλισμός (
	Κωδικός_Εξοπλισμού varchar(50) NOT NULL PRIMARY KEY,
	Μοντέλο varchar(50),
	Σειριακός_Αριθμός varchar(20),
	Περιγραφή text,
	Όνομα_Κατασκευάστριας varchar(100),
	Ημερομηνία_Απόκτησης Date,
	Ημερομηνία_Επόμενου_Ελέγχου Date,
	Κωδικός_Δωματίου varchar(50) FOREIGN KEY REFERENCES Δωμάτιο(Κωδικός_Δωματίου)
);

CREATE TABLE Εισαγωγή (
	Κωδικός_Εισαγωγής varchar(50) NOT NULL PRIMARY KEY,
	Κωδικός_Ραντεβού varchar(50) FOREIGN KEY REFERENCES Ραντεβού(Κωδικός_Ραντεβού),
	Κωδικός_Δωματίου varchar(50) FOREIGN KEY REFERENCES Δωμάτιο(Κωδικός_Δωματίου),
	Ημερομηνία_Εισαγωγής Date
);

CREATE TABLE Ραντεβού_Εξοπλισμός(
	Κωδικός_Ραντεβού varchar(50) FOREIGN KEY REFERENCES Ραντεβού(Κωδικός_Ραντεβού),
	Κωδικός_Εξοπλισμού varchar(50) FOREIGN KEY REFERENCES Εξοπλισμός(Κωδικός_Εξοπλισμού),
	Κόστος_Χρήσης numeric(8, 3),
	PRIMARY KEY (Κωδικός_Ραντεβού, Κωδικός_Εξοπλισμού)
);

CREATE TABLE Ραντεβού_Φάρμακο (
	Κωδικός_Ραντεβού varchar(50) FOREIGN KEY REFERENCES Ραντεβού(Κωδικός_Ραντεβού),
	Κωδικός_Φαρμάκου numeric(15, 0) FOREIGN KEY REFERENCES Φάρμακο(Κωδικός_Φαρμάκου),
	PRIMARY KEY (Κωδικός_Ραντεβού, Κωδικός_Φαρμάκου)
);

CREATE TABLE Επίσκεψη (
	Κωδικός_Ραντεβού varchar(50) FOREIGN KEY REFERENCES Ραντεβού(Κωδικός_Ραντεβού),
	Κωδικός_Υπαλλήλου varchar(50) FOREIGN KEY REFERENCES Υπάλληλος(Κωδικός_Υπαλλήλου),
	PRIMARY KEY (Κωδικός_Ραντεβού, Κωδικός_Υπαλλήλου)
);
