-- I/ Création de la bdd. 
CREATE DATABASE eval_em_cinema CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;


-- II / Création de toutes les tables

-- --------
use eval_em_cinema; 

CREATE TABLE Roles(
  id CHAR(32) PRIMARY KEY NOT NULL , 
  name VARCHAR(100) NOT NULL UNIQUE
) engine= INNODB;

CREATE TABLE Users(
  id CHAR(32) NOT NULL PRIMARY KEY, 
  name VARCHAR(30) NOT NULL, 
  lastName VARCHAR(30) NOT NULL,
  email VARCHAR(100),
  Password CHAR(60) NOT NULL,
  dateOfBirth Date NOT NULL, 
  CreditCard CHAR(60),
  Id_Role CHAR(36), 
    FOREIGN KEY(Id_Role) REFERENCES Roles(id) 
) engine= INNODB; 



CREATE TABLE Tickets(
  id CHAR(32)PRIMARY KEY NOT NULL , 
  category VARCHAR(30) NOT NULL, 
  price DECIMAL(4,2)
) engine= INNODB;


CREATE TABLE Movies(
  id CHAR(32) PRIMARY KEY NOT NULL ,
  title VARCHAR(30) NOT NULL,  
  duration TIME NOT NULL, 
  director VARCHAR(30), 
  synopsis TEXT(300)
) engine= INNODB;

CREATE TABLE Complexes(
  id CHAR(32) PRIMARY KEY NOT NULL , 
  name VARCHAR(36),
  adress VARCHAR(200) NOT NULL, 
  postalCode VARCHAR(15) NOT NULL
) engine= INNODB;

CREATE TABLE MovieRooms(
  id CHAR(32) PRIMARY KEY NOT NULL,
  Id_Complexe CHAR(36),
  numero INT, 
  nbPlace BIGINT(255),
    FOREIGN KEY (Id_Complexe) REFERENCES Complexes(id)
    
) engine= INNODB;

CREATE TABLE Sessions(
  id CHAR(32) PRIMARY KEY NOT NULL ,
  Id_MovieRoom CHAR(36) NOT NULL, 
  Id_Movie CHAR(36) NOT NULL,
  StartTime DATETIME NOT NULL, 
  placeAvalable BIGINT(255) default null, 
    FOREIGN KEY (Id_Movie) REFERENCES Movies(id),
    FOREIGN KEY (Id_MovieRoom) REFERENCES MovieRooms(id)
) engine= INNODB;

CREATE TABLE Sales( 
    id CHAR(32) PRIMARY KEY NOT NULL , 
    Id_Session CHAR(32) NOT NULL, 
    Id_Ticket CHAR(32) NOT NULL, 
    Quantity INT(100), 
    Id_User CHAR(32) NOT NULL, 
    date DATETIME DEFAULT NOW(), 
    FOREIGN KEY (Id_Session) REFERENCES Sessions(id), 
    FOREIGN KEY (Id_Ticket) REFERENCES Tickets(id), 
    FOREIGN KEY (Id_User) REFERENCES Users(id), 
    UNIQUE(id)
) engine= INNODB;


-- ----------

-- III/ Insertion de données dans les table
-- 1) les données entièrement à la main

--    a) Tickets

INSERT INTO Tickets (id, category, price) 
VALUES ("51155c6498d811edb766e8f1002ad19a", "Kids", 5.90 ), ("51155d9a98d811edb766e8f1002ad19a", "Students", 7.60), ("51155da498d811edb766e8f1002ad19a", "Full Price", 9.20);

--    b) Roles 

INSERT INTO Roles(id, name) 
VALUES  ("ecae02d2974f11edb766e8f1002ad19a", "Customer"), 
		    ("ecae02e6974f11edb766e8f1002ad19a", "Cashier");


--  2) Données générées totalement ou partiellement en automatiques grace à https://mockaroo.com

    --a) Movies 

insert INTO Movies (id, title, duration, director, synopsis)
VALUES ("410fe2d2975011edb766e8f1002ad19a", "Avatar: The Way of Water", "3:12:00", "James Cameron", "Jake Sully and Ney'tiri have formed a family and are doing everything to stay together. However, they must leave their home and explore the regions of Pandora. When an ancient threat resurfaces, Jake must fight a difficult war against the humans."),
("410fe2fa975011edb766e8f1002ad19a", "Tirailleurs", "1:40:00", "Mathieu Vadepied", "1917. Bakary Diallo s'enrôle dans l'armée française pour rejoindre Thierno, son fils de 17 ans, qui a été recruté de force. Envoyés sur le front, père et fils vont devoir affronter la guerre ensemble."),
("410fe304975011edb766e8f1002ad19a","Les Cyclades", "1:50:00", "Marc Fitoussi", "Adolescentes, Blandine et Magalie étaient inséparables. Les années ont passé et elles se sont perdues de vue. Alors que leurs chemins se croisent de nouveau, elles décident de faire ensemble le voyage dont elles ont toujours rêvé. Direction la Grèce !"), 
("410fe30e975011edb766e8f1002ad19a", "Tempête", "1:49:00","Christian Duguay","Née dans le haras de ses parents, Zoé a grandi au milieu des chevaux et n’a qu’un rêve : devenir jockey ! Tempête, une pouliche qu’elle voit naître, va devenir son alter ego. Mais un soir d'orage, Tempête, affolée, renverse Zoé et vient briser son rêve."),
("410fe318975011edb766e8f1002ad19a","Chœur de Rockers","1:31:00", "Ida Techer, Luc Bricault", "Alex, chanteuse dont la carrière peine à décoller, accepte un drôle de job : faire chanter des comptines à une chorale de retraités. Elle découvre un groupe de séniors ingérables qui ne rêve que d’une chose, chanter du rock !"),
("410fe322975011edb766e8f1002ad19a","Cet été-là", "1:39:00", "Eric Lartigau", "Dune a 11 ans. Depuis toujours, chaque été, elle traverse la France avec ses parents pour passer les vacances dans leur vieille maison des Landes. Là-bas, Mathilde, 9 ans, l’attend de pied ferme. Une amitié sans failles. Mais cet été-là ne sera pas un été de plus."),
("410fe32c975011edb766e8f1002ad19a", "Caravage", "1:58:00", "Michele Placido","Italie 1609. Accusé de meurtre, Le Caravage a fui Rome et s’est réfugié à Naples. Soutenu par la puissante famille Colonna, Le Caravage tente d’obtenir la grâce de l’Église pour revenir à Rome. Le Pape décide alors de faire mener par un inquisiteur, l’Ombre, une enquête sur le peintre dont l’art est jugé subversif."),
("410fe336975011edb766e8f1002ad19a", "M3GAN", "1:42:00", "Gerard Johnstone", "M3GAN est un miracle technologique, une cyber poupée dont l’intelligence artificielle est programmée pour être la compagne idéale des enfants et la plus sûre alliée des parents."), 
("410fe337975011edb766e8f1002ad19a", "Les Banshees d'Inisherin", "1:54:00", "Martin McDonagh", "Sur Inisherin - une île isolée au large de la côte ouest de l'Irlande - deux compères de toujours, Padraic et Colm, se retrouvent dans une impasse lorsque Colm décide du jour au lendemain de mettre fin à leur amitié."),
("410fe340975011edb766e8f1002ad19a", "L'Emprise du démon", "1:33:00", "Oliver Park", "Alors qu’ils attendent leur premier enfant, Claire et Arthur décident de renouer les liens familiaux. Le couple s’installe dans l'entreprise de pompes funèbres tenue par le père d’Arthur. Mais l’arrivée d’un mystérieux cadavre va les faire basculer dans l’horreur.");

-- b) Users
-- every passord is encrypted with bcrypt (https://bcrypt-generator.com)

    --Customers 

insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("55e8854e98d911edb766e8f1002ad19a", 'Teresa', 'Tomashova', 'ttomashova2r@google.pl', '1927-11-09', '3546475660717160', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c0fb37e9bff11edb766e8f1002ad19a", 'Marya', 'Gratten', 'mgratten0@constantcontact.com', '1983-11-26', '5602259618851839', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c10a3a69bff11edb766e8f1002ad19a", 'Niccolo', 'Greg', 'ngreg1@google.com', '1921-01-11', '502062279287702823', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c1190ae9bff11edb766e8f1002ad19a", 'Enriqueta', 'Fitzsimon', 'efitzsimon2@ebay.com', '1947-07-14', '3574473461696014', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c11d2b29bff11edb766e8f1002ad19a", 'Nellie', 'Baudts', 'nbaudts3@behance.net', '1924-08-12', '201982984492534', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c1252829bff11edb766e8f1002ad19a", 'Corrina', 'Jest', 'cjest4@biblegateway.com', '1941-01-07', '3534695617253345', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c1299ea9bff11edb766e8f1002ad19a", 'Gabrielle', 'Billham', 'gbillham5@google.com.br', '1976-05-18', '3553957181419413', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c12e0d09bff11edb766e8f1002ad19a", 'Shawn', 'Oxenford', 'soxenford6@woothemes.com', '1974-11-06', '3552922513348616', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values ("0c1335a89bff11edb766e8f1002ad19a", 'Flore', 'Biggerdike', 'fbiggerdike7@mashable.com', '1954-02-12', '6333906588535313', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Adelind', 'Durbyn', 'adurbyn8@arstechnica.com', '2010-04-28', '633379057652039075', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Tamara', 'Martygin', 'tmartygin9@comsenz.com', '1953-05-09', '374283657706669', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Myrtie', 'Cussons', 'mcussonsa@engadget.com', '2004-01-22', '4041594729015250', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Britte', 'Laxson', 'blaxsonb@tripod.com', '1970-03-23', '5007667508891965', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Marrissa', 'Learmont', 'mlearmontc@sogou.com', '2018-03-14', '3568819078528412', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Barclay', 'Reside', 'bresided@imageshack.us', '2002-08-29', '3564695544596843', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Urban', 'Rottgers', 'urottgerse@shareasale.com', '1956-11-05', '3587305218432464', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Hewet', 'Stuffins', 'hstuffinsf@dailymail.co.uk', '2003-07-21', '5610484604202603', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Hilliary', 'Wapple', 'hwappleg@digg.com', '1938-04-13', '374283531081842', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Harlene', 'Bilney', 'hbilneyh@digg.com', '1984-10-07', '4508141225287359', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Luke', 'Cornuau', 'lcornuaui@plala.or.jp', '1969-10-29', '372301448050643', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Galina', 'Gager', 'ggagerj@mozilla.com', '2000-09-18', '3542835523698023', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Gothart', 'Brookbank', 'gbrookbankk@gravatar.com', '2008-09-28', '5482338975371824', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Meggi', 'Gatteridge', 'mgatteridgel@pbs.org', '1980-08-25', '67710232907895725', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Marcelle', 'Novill', 'mnovillm@guardian.co.uk', '1956-11-30', '3564257561622596', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Correy', 'Lickorish', 'clickorishn@gnu.org', '1995-11-27', '67598986214219187', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Joelly', 'Vidgen', 'jvidgeno@nhs.uk', '2000-11-11', '5158260937413952', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Shanta', 'Calabry', 'scalabryp@google.ru', '1973-06-13', '3568756350325440', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Polly', 'Nurdin', 'pnurdinq@nymag.com', '1973-03-12', '5602241378049457', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Gwenora', 'Ayto', 'gaytor@51.la', '1942-05-29', '3546918349622728', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Nadeen', 'Meugens', 'nmeugenss@ucoz.ru', '2016-08-12', '5602238135951348', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Odella', 'MacDirmid', 'omacdirmidt@house.gov', '1935-07-08', '374283979302221', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Cicily', 'Whitmore', 'cwhitmoreu@barnesandnoble.com', '1933-10-24', '337941421601260', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Annabela', 'Battey', 'abatteyv@gnu.org', '1938-09-18', '3583871624303494', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Wilmer', 'McNeice', 'wmcneicew@columbia.edu', '1985-06-17', '4405756182525550', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Lorinda', 'Querrard', 'lquerrardx@soundcloud.com', '2006-01-27', '201543135960678', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Deonne', 'Mongain', 'dmongainy@mayoclinic.com', '2008-08-23', '6767210079071722464', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Eddi', 'Larkworthy', 'elarkworthyz@altervista.org', '1990-11-22', '4911333882326809', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Dolly', 'Devas', 'ddevas10@amazon.co.jp', '2010-10-12', '3576082069297774', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Creigh', 'Bunton', 'cbunton11@fda.gov', '1976-04-11', '3560304222838601', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Corilla', 'Jeske', 'cjeske12@acquirethisname.com', '2011-07-01', '3564646364936320', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Sherie', 'Harwick', 'sharwick13@dmoz.org', '1951-04-13', '6761928562436939', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Veradis', 'Petcher', 'vpetcher14@reverbnation.com', '1933-09-11', '5018511957384899', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Penelope', 'Shaul', 'pshaul15@sfgate.com', '2001-09-19', '3538962429366590', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Karlie', 'McCrorie', 'kmccrorie16@wikispaces.com', '1923-04-03', '3546631379072538', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Dasie', 'Lauderdale', 'dlauderdale17@rediff.com', '1979-11-04', '3566428610903661', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Moyra', 'Tolwood', 'mtolwood18@wordpress.org', '1936-09-24', '3552136537285049', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Inessa', 'Konert', 'ikonert19@boston.com', '1926-11-21', '5602219955348880', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Jenna', 'Enderlein', 'jenderlein1a@psu.edu', '1960-02-20', '3581720886042856', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Noami', 'Coyish', 'ncoyish1b@goodreads.com', '1960-10-02', '201777928956341', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Jocko', 'Moyle', 'jmoyle1c@si.edu', '1950-07-06', '5337892518759355', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Hurley', 'Targetter', 'htargetter1d@bluehost.com', '1976-05-21', '3580920840471644', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Shelia', 'Trimming', 'strimming1e@illinois.edu', '1987-01-18', '5322979493084169', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Wallie', 'Rivel', 'wrivel1f@go.com', '2007-09-24', '3547062861712903', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Kora', 'Scrigmour', 'kscrigmour1g@dedecms.com', '1952-10-31', '3580456255579597', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Isak', 'Jarrold', 'ijarrold1h@alexa.com', '1987-12-10', '3553863359760051', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Shurlock', 'Ferrara', 'sferrara1i@diigo.com', '2009-12-22', '491142188471308844', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Vinnie', 'Gingedale', 'vgingedale1j@newsvine.com', '1962-01-10', '30454213730347', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Carilyn', 'Dowe', 'cdowe1k@walmart.com', '1959-12-26', '3588763889579790', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Hilary', 'Baskerville', 'hbaskerville1l@wordpress.com', '1999-02-15', '3588835363772594', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Alister', 'Happert', 'ahappert1m@toplist.cz', '1942-12-17', '3553658155566797', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Armstrong', 'Gooderidge', 'agooderidge1n@cmu.edu', '1982-04-14', '3561696717276505', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Bobina', 'Blackler', 'bblackler1o@reverbnation.com', '1923-04-27', '5641825855414870', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Bethany', 'Pennoni', 'bpennoni1p@answers.com', '1944-08-06', '5283942810995779', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Trevor', 'Ketley', 'tketley1q@delicious.com', '2008-08-03', '5220569649676431', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Gus', 'Mayoral', 'gmayoral1r@loc.gov', '1957-11-16', '3538662072113584', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Karolina', 'Sainsbury-Brown', 'ksainsburybrown1s@bigcartel.com', '1992-12-09', '3574922656301525', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Tamar', 'Dalloway', 'tdalloway1t@webs.com', '2013-10-16', '3568026274972721', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Arther', 'Gimber', 'agimber1u@webeden.co.uk', '1928-07-10', '5100146341942844', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Nils', 'Allot', 'nallot1v@friendfeed.com', '2009-04-18', '5100139612380836', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Clea', 'Hazelgreave', 'chazelgreave1w@4shared.com', '1971-06-27', '4175004134974834', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Putnem', 'Dehm', 'pdehm1x@cnet.com', '1962-06-28', '3566134778941929', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Eolande', 'Ciccoloi', 'eciccoloi1y@fda.gov', '2012-07-12', '3575729156189634', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Hedi', 'Keedy', 'hkeedy1z@netscape.com', '1922-09-28', '6709242277698189844', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Vivien', 'Jandourek', 'vjandourek20@blogspot.com', '1954-06-06', '6393901930306858', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Barbi', 'Leeburne', 'bleeburne21@php.net', '1941-09-09', '56101699611956342', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Leona', 'Baudino', 'lbaudino22@apache.org', '1947-09-11', '3580933358338824', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Lancelot', 'Hollingsbee', 'lhollingsbee23@live.com', '1991-08-19', '3554179198709665', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Dorelia', 'Hundey', 'dhundey24@sfgate.com', '1986-03-24', '30097309680536', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Katharyn', 'Culverhouse', 'kculverhouse25@narod.ru', '1968-05-06', '6767035829143409', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'King', 'McNeice', 'kmcneice26@unblog.fr', '1953-07-05', '3565748813727257', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Clarice', 'Caudelier', 'ccaudelier27@forbes.com', '1976-12-02', '56022277687402867', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Sharai', 'Batstone', 'sbatstone28@forbes.com', '1976-04-24', '5508672298308935', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Sky', 'Chazelas', 'schazelas29@posterous.com', '1938-11-23', '3573423034256193', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Pascal', 'Lomen', 'plomen2a@ed.gov', '1941-05-16', '6371474621557243', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Buddie', 'Sneesby', 'bsneesby2b@samsung.com', '2018-03-22', '3575935093364236', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Brandi', 'Haddrell', 'bhaddrell2c@macromedia.com', '1996-05-10', '4041375560604', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Annabela', 'Alexandre', 'aalexandre2d@symantec.com', '1977-11-12', '337941294710347', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Giuditta', 'Giacomucci', 'ggiacomucci2e@nytimes.com', '1920-11-04', '3561794768439716', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Fleming', 'Imbrey', 'fimbrey2f@ycombinator.com', '1925-03-09', '3546359909772993', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Jed', 'Albrook', 'jalbrook2g@china.com.cn', '1980-07-14', '374283481907285', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Constantine', 'Staddon', 'cstaddon2h@acquirethisname.com', '1984-05-02', '67611594470715451', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Regen', 'Ponton', 'rponton2i@omniture.com', '1955-06-10', '5610927446937091', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Graeme', 'Willgrass', 'gwillgrass2j@archive.org', '1980-11-15', '3582446647051924', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Stephana', 'Lenz', 'slenz2k@netscape.com', '1920-05-04', '3565762671586473', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Zondra', 'Gueny', 'zgueny2l@netlog.com', '1937-11-11', '3550530452568813', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Jeanelle', 'Whimpenny', 'jwhimpenny2m@xrea.com', '1952-02-23', '3589251464469065', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Amerigo', 'Fronks', 'afronks2n@upenn.edu', '1955-10-24', '5559540944030187', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Silva', 'Reddan', 'sreddan2o@list-manage.com', '2006-07-28', '3575551173720179', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Jilleen', 'Rickaert', 'jrickaert2p@hostgator.com', '1961-03-08', '3586797370099100', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Charlton', 'Thomsson', 'cthomsson2q@tripod.com', '1990-08-02', '56022519327929563', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");
insert into Users (id, name, lastName, email, dateOfBirth, CreditCard, Id_Role, Password) values (REPLACE(UUID(),"-",""), 'Terese', 'Tomashov', 'ttomashov2r@google.pl', '1927-10-09', '3546475640717160', "ecae02d2974f11edb766e8f1002ad19a","$2a$12$eVnqDVAxekxXG.A/aaNpOeMfHei6lCzrVd2siYO/QOKQtm/P4TBHm");


-- cashier(20) 2 par complexe

insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55ea900098d911edb766e8f1002ad19a", 'Baxy', 'Draayer', 'bdraayer0@thetimes.co.uk', '1958-09-25', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55ebec5298d911edb766e8f1002ad19a", 'Melisse', 'Daskiewicz', 'mdaskiewicz1@prlog.org', '1919-11-05', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55ed6fdc98d911edb766e8f1002ad19a", 'Corny', 'Ovesen', 'covesen2@chron.com', '1926-05-18', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55eede8098d911edb766e8f1002ad19a", 'Jennie', 'Di Gregorio', 'jdigregorio3@google.pl', '1947-08-07', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f0560298d911edb766e8f1002ad19a", 'Ailey', 'Bouttell', 'abouttell4@seattletimes.com', '1960-12-18', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f1b74a98d911edb766e8f1002ad19a", 'Sloane', 'Figliovanni', 'sfigliovanni5@economist.com', '1975-11-25', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f328a098d911edb766e8f1002ad19a", 'Lexie', 'Woan', 'lwoan6@webeden.co.uk', '1985-11-24', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f47e8a98d911edb766e8f1002ad19a", 'Madison', 'Mounsie', 'mmounsie7@pen.io', '2016-06-13', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f5eacc98d911edb766e8f1002ad19a", 'Kaylil', 'Tales', 'ktales8@topsy.com', '1944-08-28', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f7513298d911edb766e8f1002ad19a", 'Bertha', 'Eixenberger', 'beixenberger9@berkeley.edu', '2001-05-08', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55f8afbe98d911edb766e8f1002ad19a", 'Tonnie', 'Gradley', 'tgradleya@wiley.com', '1934-09-25', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55fa1a9898d911edb766e8f1002ad19a", 'Harcourt', 'Lemerie', 'hlemerieb@so-net.ne.jp', '1942-02-23', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55fcedea98d911edb766e8f1002ad19a", 'Drucill', 'Han', 'dhanc@geocities.com', '1947-04-16', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55fe5e3298d911edb766e8f1002ad19a", 'Creighton', 'Jeaycock', 'cjeaycockd@livejournal.com', '1933-12-08', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("55ffc06a98d911edb766e8f1002ad19a", 'Prudi', 'Shee', 'psheee@sphinn.com', '2007-08-07', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("56011bcc98d911edb766e8f1002ad19a", 'Odilia', 'Atkinson', 'oatkinsonf@over-blog.com', '2002-06-11', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("56027bac98d911edb766e8f1002ad19a", 'Fransisco', 'Ferns', 'ffernsg@arizona.edu', '1922-03-16', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("5603dd4e98d911edb766e8f1002ad19a", 'Florance', 'Baseke', 'fbasekeh@weebly.com', '1934-09-23', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("5605379898d911edb766e8f1002ad19a", 'Tabbie', 'Canellas', 'tcanellasi@google.co.jp', '1961-04-02', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');
insert into Users (id, name, lastName, email, dateOfBirth, Id_Role, Password) values ("5d5c48a698d911edb766e8f1002ad19a", 'Solly', 'Murtell', 'smurtellj@ifeng.com', '1939-08-23', 'ecae02e6974f11edb766e8f1002ad19a','$2a$12$dKN690WJUAzGLuyxVBNpXe1GO89Cz7syXzcrtFDpAow5Amr9266Ba');



-- c) Complexes

insert into Complexes (id, name, adress, postalCode) values ("f0bddf8e975711edb766e8f1002ad19a","Complexe 1",'PO Box 50270', '9845');
insert into Complexes (id, name, adress, postalCode) values ("f0c05bf6975711edb766e8f1002ad19a","Complexe 2",'Suite 82', '92314');
insert into Complexes (id, name, adress, postalCode) values ("f0c1e76e975711edb766e8f1002ad19a","Complexe 3",'Suite 22', '969-7208');
insert into Complexes (id, name, adress, postalCode) values ("f0c39064975711edb766e8f1002ad19a","Complexe 4",'Apt 359', '97000');
insert into Complexes (id, name, adress, postalCode) values ("f0c56f7e975711edb766e8f1002ad19a","Complexe 5",'18th Floor', '686 04');

-- d) MovieRoom

Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('dbf4b1bf7b9f44429f5f25602641bbd7', "f0bddf8e975711edb766e8f1002ad19a", 300, 1);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('93284b4ef00b463c8ce6573692adadc0', "f0bddf8e975711edb766e8f1002ad19a", 350, 2);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('13ab3bcd16d147a793a0b1b5dd8232f3', "f0bddf8e975711edb766e8f1002ad19a", 400, 3);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('e2bdd1f00d8442f3a4671f366e156bde', "f0bddf8e975711edb766e8f1002ad19a", 200, 4);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('644e4b28f12540f8953c501ff5662d8e', "f0bddf8e975711edb766e8f1002ad19a", 300, 5);

Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('11820bf49f374bf8a311e8053312341f', "f0c05bf6975711edb766e8f1002ad19a", 200, 1);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('4d1ea252472840af9e4da8d1e0b10d29', "f0c05bf6975711edb766e8f1002ad19a", 300, 2);

Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('8af2db8d37884fe282e0d91b487f765c', "f0c1e76e975711edb766e8f1002ad19a", 350, 1);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('8cd39408a1a44ed986e4e5c332d84f88', "f0c1e76e975711edb766e8f1002ad19a", 400, 2);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('ca60252a411f4a37aa257e3efdc330b8', "f0c1e76e975711edb766e8f1002ad19a", 200, 3);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('3b1efdef89424991b22f3fc8bcbb288f', "f0c1e76e975711edb766e8f1002ad19a", 300, 4);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('ecd5c46ea4774fa690efd71f29b1c69c', "f0c1e76e975711edb766e8f1002ad19a", 350, 5);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('bf8d6679351d4ec99eb58bb3346606e5', "f0c1e76e975711edb766e8f1002ad19a", 400, 6);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('1439da46b9d9466e8853d678957901e6', "f0c1e76e975711edb766e8f1002ad19a", 200, 7);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('9a159b7cb92f41108fb28c89056659bd', "f0c1e76e975711edb766e8f1002ad19a", 300, 8);

Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('099e407ae3114178a502728bac72005a', "f0c39064975711edb766e8f1002ad19a", 350, 1);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('584962b745214041aced3a798f8024db', "f0c39064975711edb766e8f1002ad19a", 400, 2);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('856d525d34e54717b68bae4ec9103609', "f0c39064975711edb766e8f1002ad19a", 200, 3);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('2c35333325c446c3b366997473cb1fa4', "f0c39064975711edb766e8f1002ad19a", 300, 4);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('83dc6a405bcd4a939e9ab8b96a1f3cae', "f0c39064975711edb766e8f1002ad19a", 350, 5);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('1c2353e922434f6a895f695b54faa249', "f0c39064975711edb766e8f1002ad19a", 400, 6);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('2722617f99be4b6e807ee478210628b5', "f0c39064975711edb766e8f1002ad19a", 200, 7);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('f0968000d86a489c9de4bc8415dca676', "f0c39064975711edb766e8f1002ad19a", 300, 8);

Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('2d5074fee75147e18ebe13fe5718e118', "f0c56f7e975711edb766e8f1002ad19a", 350, 1);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('5a8c35d0af8f46a89a22c748468caeac', "f0c56f7e975711edb766e8f1002ad19a", 400, 2);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('5617cba08de5499bb6a9976a9c94de96', "f0c56f7e975711edb766e8f1002ad19a", 200, 3);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('dd86e2db03ae4380a8da9a98d201d329', "f0c56f7e975711edb766e8f1002ad19a", 300, 4);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('556f30bc5c7340b289574a65d9576f85', "f0c56f7e975711edb766e8f1002ad19a", 350, 5);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('6da1131622ee4201b2ed81b22a939f74', "f0c56f7e975711edb766e8f1002ad19a", 400, 6);
Insert into MovieRooms (id, Id_Complexe, nbPlace, numero) VALUES ('377cdc3cdbb24bfd892a8237f32df180', "f0c56f7e975711edb766e8f1002ad19a", 200, 7);

-- e) session 


INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289b431498e811edu756e8f1102ad19a",'dbf4b1bf7b9f44429f5f25602641bbd7',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289e661698e811edu756e8f1102ad19a","93284b4ef00b463c8ce6573692adadc0","410fe2fa975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a02fd298e811edu756e8f1102ad19a","13ab3bcd16d147a793a0b1b5dd8232f3","410fe304975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a1f8f898e811edu756e8f1102ad19a","e2bdd1f00d8442f3a4671f366e156bde","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a3fa4a98e811edu756e8f1102ad19a","644e4b28f12540f8953c501ff5662d8e","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289b431498e811etu756e8f1102ad19a",'dbf4b1bf7b9f44429f5f25602641bbd7',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 13:32:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289e661698e811etu756e8f1102ad19a","93284b4ef00b463c8ce6573692adadc0","410fe2fa975011edb766e8f1002ad19a","2000-01-01 12:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a02fd298e811etu756e8f1102ad19a","13ab3bcd16d147a793a0b1b5dd8232f3","410fe304975011edb766e8f1002ad19a","2000-01-01 12:10:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a1f8f898e811etu756e8f1102ad19a","e2bdd1f00d8442f3a4671f366e156bde","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a3fa4a98e811etu756e8f1102ad19a","644e4b28f12540f8953c501ff5662d8e","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("299b432498e811edb756e8f1102ad19a",'11820bf49f374bf8a311e8053312341f',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 13:32:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("299e662698e811edb756e8f1102ad19a","4d1ea252472840af9e4da8d1e0b10d29","410fe2fa975011edb766e8f1002ad19a","2000-01-01 12:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("299b431498e811edb756e8f1102ad19a",'11820bf49f374bf8a311e8053312341f',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("299e661698e811edb756e8f1102ad19a","4d1ea252472840af9e4da8d1e0b10d29","410fe2fa975011edb766e8f1002ad19a","2000-01-01 10:00:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289b431498e811edb756e8f1102ad19a",'9a159b7cb92f41108fb28c89056659bd',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289e661698e811edb756e8f1102ad19a","1439da46b9d9466e8853d678957901e6","410fe2fa975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a02fd298e811edb756e8f1102ad19a","bf8d6679351d4ec99eb58bb3346606e5","410fe304975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a1f8f898e811edb756e8f1102ad19a","ecd5c46ea4774fa690efd71f29b1c69c","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a3fa4a98e811edb756e8f1102ad19a","3b1efdef89424991b22f3fc8bcbb288f","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a57aa098e811edb756e8f1102ad19a","ca60252a411f4a37aa257e3efdc330b8","410fe318975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a7216698e811edb756e8f1102ad19a","8cd39408a1a44ed986e4e5c332d84f88","410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a7216698e851edb756e8f1102ad19a","8af2db8d37884fe282e0d91b487f765c","410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289b431498e811edb756e8f1102ac19a",'9a159b7cb92f41108fb28c89056659bd',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 13:32:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289e661698e811edb756e8f1102ac19a","1439da46b9d9466e8853d678957901e6","410fe2fa975011edb766e8f1002ad19a","2000-01-01 12:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a02fd298e811edb756e8f1102ac19a","bf8d6679351d4ec99eb58bb3346606e5","410fe304975011edb766e8f1002ad19a","2000-01-01 12:10:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a1f8f898e811edb756e8f1102ac19a","ecd5c46ea4774fa690efd71f29b1c69c","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a3fa4a98e811edb756e8f1102ac19a","3b1efdef89424991b22f3fc8bcbb288f","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a57aa098e811edb756e8f1102ac19a","ca60252a411f4a37aa257e3efdc330b8","410fe318975011edb766e8f1002ad19a","2000-01-01 11:51:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a7216698e811edb756e8f1102ac19a","8cd39408a1a44ed986e4e5c332d84f88","410fe2d2975011edb766e8f1002ad19a","2000-01-01 11:59:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a7216698e851edb756e8f1102ac19a","8af2db8d37884fe282e0d91b487f765c","410fe2d2975011edb766e8f1002ad19a","2000-01-01 11:59:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289b431498e811edb756e8f1002ad19a",'f0968000d86a489c9de4bc8415dca676',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("289e661698e811edb756e8f1002ad19a","2722617f99be4b6e807ee478210628b5","410fe2fa975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a02fd298e811edb756e8f1002ad19a","1c2353e922434f6a895f695b54faa249","410fe304975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a1f8f898e811edb756e8f1002ad19a","83dc6a405bcd4a939e9ab8b96a1f3cae","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a3fa4a98e811edb756e8f1002ad19a","2c35333325c446c3b366997473cb1fa4","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a57aa098e811edb756e8f1002ad19a","856d525d34e54717b68bae4ec9103609","410fe318975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a7216698e811edb756e8f1002ad19a","584962b745214041aced3a798f8024db","410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("28a7216698e851edb756e8f1002ad19a","099e407ae3114178a502728bac72005a","410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("389b431498e811edb756e8f1002ad19a",'f0968000d86a489c9de4bc8415dca676',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 13:32:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("389e661698e811edb756e8f1002ad19a","2722617f99be4b6e807ee478210628b5","410fe2fa975011edb766e8f1002ad19a","2000-01-01 12:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("38a02fd298e811edb756e8f1002ad19a","1c2353e922434f6a895f695b54faa249","410fe304975011edb766e8f1002ad19a","2000-01-01 12:10:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("38a1f8f898e811edb756e8f1002ad19a","83dc6a405bcd4a939e9ab8b96a1f3cae","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("38a3fa4a98e811edb756e8f1002ad19a","2c35333325c446c3b366997473cb1fa4","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("38a57aa098e811edb756e8f1002ad19a","856d525d34e54717b68bae4ec9103609","410fe318975011edb766e8f1002ad19a","2000-01-01 11:51:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("38a7216698e811edb756e8f1002ad19a","584962b745214041aced3a798f8024db","410fe2d2975011edb766e8f1002ad19a","2000-01-01 11:59:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("38a7216798e811edb756e8f1002ad19a","099e407ae3114178a502728bac72005a","410fe2d2975011edb766e8f1002ad19a","2000-01-01 11:59:00" );

INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("299b431498e811edb766e8f1002ad19a",'377cdc3cdbb24bfd892a8237f32df180',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("299e661698e811edb766e8f1002ad19a","2d5074fee75147e18ebe13fe5718e118","410fe2fa975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("29a02fd298e811edb766e8f1002ad19a","556f30bc5c7340b289574a65d9576f85","410fe304975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("29a1f8f898e811edb766e8f1002ad19a","5617cba08de5499bb6a9976a9c94de96","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("29a3fa4a98e811edb766e8f1002ad19a","5a8c35d0af8f46a89a22c748468caeac","410fe30e975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("29a57aa098e811edb766e8f1002ad19a","6da1131622ee4201b2ed81b22a939f74","410fe318975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("29a7216698e811edb766e8f1002ad19a","dd86e2db03ae4380a8da9a98d201d329","410fe2d2975011edb766e8f1002ad19a","2000-01-01 10:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("cf4c661a98db11edb766e8f1002ad19a",'377cdc3cdbb24bfd892a8237f32df180',"410fe2d2975011edb766e8f1002ad19a","2000-01-01 13:32:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("f3a9bf8098e011edb766e8f1002ad19a","2d5074fee75147e18ebe13fe5718e118","410fe2fa975011edb766e8f1002ad19a","2000-01-01 12:00:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("f3abdc2a98e011edb766e8f1002ad19a","556f30bc5c7340b289574a65d9576f85","410fe304975011edb766e8f1002ad19a","2000-01-01 12:10:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("f3ad24cc98e011edb766e8f1002ad19a","5617cba08de5499bb6a9976a9c94de96","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("f3ae7a8e98e011edb766e8f1002ad19a","5a8c35d0af8f46a89a22c748468caeac","410fe30e975011edb766e8f1002ad19a","2000-01-01 12:09:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("f3afd92498e011edb766e8f1002ad19a","6da1131622ee4201b2ed81b22a939f74","410fe318975011edb766e8f1002ad19a","2000-01-01 11:51:00" );
INSERT INTO Sessions (id, Id_MovieRoom, Id_Movie, StartTime) VALUES ("f3b12bbc98e011edb766e8f1002ad19a","dd86e2db03ae4380a8da9a98d201d329","410fe2d2975011edb766e8f1002ad19a","2000-01-01 11:59:00" );

-- f) Sales

-- Initialisation du nombre de place par séance

UPDATE Sessions
INNER JOIN MovieRooms 
on MovieRooms.id = Sessions.Id_MovieRoom 
SET Sessions.placeAvalable = MovieRooms.nbPlace;

-- Création d'un trigger qui va metre à jour le nombre de place par séance à chaque vente de ticket. 

CREATE TRIGGER update_placeAvailable 
AFTER INSERT ON Sales
FOR EACH ROW
UPDATE Sessions 
SET placeAvalable = (placeAvalable - new.Quantity)
where Sessions.id = new.Id_Session;




INSERT INTO Sales(id, Id_Session, Id_Ticket, Quantity, Id_User)
VALUES(REPLACE(UUID(),"-",""), "299b431498e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 10, "55e8854e98d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155c6498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155c6498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155c6498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155c6498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155c6498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155c6498d811edb766e8f1002ad19a", 2, "55f0560298d911edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "289b431498e811edu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811etu756e8f1102ad19a","51155c6498d811edb766e8f1002ad19a", 2, "0c12e0d09bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "289e661698e811etu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c0fb37e9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a1f8f898e811etu756e8f1102ad19a","51155c6498d811edb766e8f1002ad19a", 2, "0c1335a89bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "289b431498e811edu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811etu756e8f1102ad19a","51155c6498d811edb766e8f1002ad19a", 2, "0c12e0d09bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "289e661698e811etu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c0fb37e9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a1f8f898e811etu756e8f1102ad19a","51155c6498d811edb766e8f1002ad19a", 2, "0c1335a89bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "289b431498e811edu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edu756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811etu756e8f1102ad19a","51155c6498d811edb766e8f1002ad19a", 2, "0c12e0d09bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "289e661698e811etu756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c0fb37e9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a1f8f898e811etu756e8f1102ad19a","51155c6498d811edb766e8f1002ad19a", 2, "0c1335a89bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "299b432498e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299e662698e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b431498e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 6, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "299e661698e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b432498e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299e662698e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b431498e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 8, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "299e661698e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b432498e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299e662698e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 4, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b431498e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "299e661698e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b432498e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299e662698e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b431498e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "299e661698e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a57aa098e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e851edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a57aa098e811edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e851edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a57aa098e811edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e811edb756e8f1102ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e851edb756e8f1102ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289b431498e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "289e661698e811edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a02fd298e811edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "28a1f8f898e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a3fa4a98e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a57aa098e811edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e811edb756e8f1102ac19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "28a7216698e851edb756e8f1102ac19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "389b431498e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "389e661698e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a7216798e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "38a02fd298e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a1f8f898e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a3fa4a98e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a57aa098e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a7216698e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "389b431498e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "389e661698e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a7216798e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "38a02fd298e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a1f8f898e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a3fa4a98e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a57aa098e811edb756e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "38a7216698e811edb756e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b431498e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299e661698e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "29a02fd298e811edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a1f8f898e811edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a3fa4a98e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a57aa098e811edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a7216698e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299b431498e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "299e661698e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "29a02fd298e811edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a1f8f898e811edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a3fa4a98e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a57aa098e811edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "29a7216698e811edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "cf4c661a98db11edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3a9bf8098e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3abdc2a98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ae7a8e98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "cf4c661a98db11edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3a9bf8098e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 5, "0c0fb37e9bff11edb766e8f1002ad19a"),
(REPLACE(UUID(),"-",""), "f3abdc2a98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 3, "0c1252829bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ad24cc98e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3ae7a8e98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3afd92498e011edb766e8f1002ad19a","51155d9a98d811edb766e8f1002ad19a", 7, "0c1299ea9bff11edb766e8f1002ad19a"), 
(REPLACE(UUID(),"-",""), "f3b12bbc98e011edb766e8f1002ad19a","51155da498d811edb766e8f1002ad19a", 2, "0c11d2b29bff11edb766e8f1002ad19a")


-- cette commande a été nécéssaire car j'ai trvaillé avec PHPmyAdmin elle a permis le bon déroulement des commandes GROUP BY;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');


-- IV/ création de views et d'utilisateurs. 

-- Privileges 
-- 1/ SuperAdmin : possède tous les droits sur la bdd eval_em_cinema
CREATE user 'SuperAdmin'@'localhost' IDENTIFIED BY '$2a$12$RpIBk6cilZ80PEDVac0KyOvS.3gA2QLEFNyfzWr7hyPt7bMMr/j3G'; 
grant all privileges on eval_em_cinema.* to SuperAdmin@localhost with grant option;


-- 2/ ComplexManagers 

-- Affichage des séances pour chaque complexe

-- view Complex1
CREATE view Complex1 as
SELECT Movies.title as "titre",
Sessions.StartTime as 'Commence a', 
Movies.duration as 'Durée du film', 
MovieRooms.numero AS salle, 
Sessions.id, 
ADDTIME(Sessions.StartTime, Movies.duration) AS EndTimeSession, 
ADDTIME(ADDTIME(Sessions.StartTime, Movies.duration), "00:20:00") AS AvailableAt 
FROM `Sessions` 
JOIN Movies 
ON Sessions.Id_Movie = Movies.id 
JOIN MovieRooms 
ON Sessions.Id_MovieRoom = MovieRooms.id 
where MovieRooms.Id_Complexe = "f0bddf8e975711edb766e8f1002ad19a"
order by Sessions.StartTime;


-- view complex2
CREATE view Complex2 as
SELECT Movies.title as "titre",
Sessions.StartTime as 'Commence a', 
Movies.duration as 'Durée du film', 
MovieRooms.numero AS salle, 
Sessions.id, 
ADDTIME(Sessions.StartTime, Movies.duration) AS EndTimeSession, 
ADDTIME(ADDTIME(Sessions.StartTime, Movies.duration), "00:20:00") AS AvailableAt 
FROM `Sessions` 
JOIN Movies 
ON Sessions.Id_Movie = Movies.id 
JOIN MovieRooms 
ON Sessions.Id_MovieRoom = MovieRooms.id 
where MovieRooms.Id_Complexe = "f0c05bf6975711edb766e8f1002ad19a"
order by Sessions.StartTime;


-- viewComplex3
CREATE view Complex3 as
SELECT Movies.title as "titre",
Sessions.StartTime as 'Commence a', 
Movies.duration as 'Durée du film', 
MovieRooms.numero AS salle, 
Sessions.id, 
ADDTIME(Sessions.StartTime, Movies.duration) AS EndTimeSession, 
ADDTIME(ADDTIME(Sessions.StartTime, Movies.duration), "00:20:00") AS AvailableAt 
FROM `Sessions` 
JOIN Movies 
ON Sessions.Id_Movie = Movies.id 
JOIN MovieRooms 
ON Sessions.Id_MovieRoom = MovieRooms.id 
where MovieRooms.Id_Complexe = "f0c1e76e975711edb766e8f1002ad19a"
order by Sessions.StartTime;


-- view Complex4 
CREATE view Complex4 as
SELECT Movies.title as "titre",
Sessions.StartTime as 'Commence a', 
Movies.duration as 'Durée du film', 
MovieRooms.numero AS salle, 
Sessions.id, 
ADDTIME(Sessions.StartTime, Movies.duration) AS EndTimeSession, 
ADDTIME(ADDTIME(Sessions.StartTime, Movies.duration), "00:20:00") AS AvailableAt 
FROM `Sessions` 
JOIN Movies 
ON Sessions.Id_Movie = Movies.id 
JOIN MovieRooms 
ON Sessions.Id_MovieRoom = MovieRooms.id 
where MovieRooms.Id_Complexe = "f0c39064975711edb766e8f1002ad19a"
order by Sessions.StartTime;

-- view Complex5
CREATE view Complex5 as
SELECT Movies.title as "titre",
Sessions.StartTime as 'Commence a', 
Movies.duration as 'Durée du film', 
MovieRooms.numero AS salle, 
Sessions.id, 
ADDTIME(Sessions.StartTime, Movies.duration) AS EndTimeSession, 
ADDTIME(ADDTIME(Sessions.StartTime, Movies.duration), "00:20:00") AS AvailableAt 
FROM `Sessions` 
JOIN Movies 
ON Sessions.Id_Movie = Movies.id 
JOIN MovieRooms 
ON Sessions.Id_MovieRoom = MovieRooms.id 
where MovieRooms.Id_Complexe = "f0c56f7e975711edb766e8f1002ad19a"
order by Sessions.StartTime;

-- ajouter les droits pour chaque manager sur sa vue select, insert, 
CREATE user 'ComplexeManager1'@'localhost' IDENTIFIED BY '$2a$12$2SZSkmSXPt7eTW9ooZvYC./SMMZ79PDflJaJkRu0kerJbSwZmqHNO'; 
grant select, insert, delete on Complex1 to ComplexeManager1@localhost with grant option;

CREATE user 'ComplexeManager2'@'localhost' IDENTIFIED BY '$2a$12$c5HaXFj7IUqSk4B3jixqyuJEEvfo0w4iWYlkpKWmcHDUDwK9yW7bS'; 
grant select, insert, delete on Complex2 to ComplexeManager2@localhost with grant option;

CREATE user 'ComplexeManager3'@'localhost' IDENTIFIED BY '$2a$12$ULcskBWv0Fb0ULlio6tFcuXw2HHVpoKx01eIPvFkcjljIy1pfrC6.'; 
grant select, insert, delete on Complex3 to ComplexeManager3@localhost with grant option;

CREATE user 'ComplexeManager4'@'localhost' IDENTIFIED BY '$2a$12$0ZVZL8oCX7QWSgzBrWtfneWqTuUl12dCzb/uaCWKj1sbtsclZhomm'; 
grant select, insert, delete on Complex4 to ComplexeManager4@localhost with grant option;

CREATE user 'ComplexeManager5'@'localhost' IDENTIFIED BY '$2a$12$COPFIq0P110heOYztfWmdOL4P3XKCfgU/DrRH4QJFPxQVktDH8o2e'; 
grant select, insert, delete on Complex5 to ComplexeManager5@localhost with grant option;



-- Une vue pour le total de chaque vente par complexe. 

-- Total for each sale Complex1 
CREATE view TotalSaleComplex1 as
select (Sales.Quantity*Tickets.price) as 'Total de la vente', 
Sales.date, 
Sales.Id_Session, 
MovieRooms.Id_Complexe
from Sales join Tickets 
on Sales.Id_Ticket = Tickets.id 
join Sessions 
on Sales.Id_Session = Sessions.id
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = "f0bddf8e975711edb766e8f1002ad19a"
order by Sales.date DESC; 

-- Total for each sale complex2
CREATE view TotalSaleComplex2 as
select (Sales.Quantity*Tickets.price) as 'Total de la vente', 
Sales.date, 
Sales.Id_Session, 
MovieRooms.Id_Complexe
from Sales join Tickets 
on Sales.Id_Ticket = Tickets.id 
join Sessions 
on Sales.Id_Session = Sessions.id
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = "f0c05bf6975711edb766e8f1002ad19a"
order by Sales.date DESC; 

-- Total for each sale complex3
CREATE view TotalSaleComplex3 as
select (Sales.Quantity*Tickets.price) as 'Total de la vente', 
Sales.date, 
Sales.Id_Session, 
MovieRooms.Id_Complexe
from Sales join Tickets 
on Sales.Id_Ticket = Tickets.id 
join Sessions 
on Sales.Id_Session = Sessions.id
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = "f0c1e76e975711edb766e8f1002ad19a"
order by Sales.date DESC; 

-- Total for each sale complex4
CREATE view TotalSaleComplex4 as
select (Sales.Quantity*Tickets.price) as 'Total de la vente', 
Sales.date, 
Sales.Id_Session, 
MovieRooms.Id_Complexe
from Sales join Tickets 
on Sales.Id_Ticket = Tickets.id 
join Sessions 
on Sales.Id_Session = Sessions.id
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = "f0c39064975711edb766e8f1002ad19a"
order by Sales.date DESC; 

-- Total for each sale complex5
CREATE view TotalSaleComplex5 as
select (Sales.Quantity*Tickets.price) as 'Total de la vente', 
Sales.date, 
Sales.Id_Session, 
MovieRooms.Id_Complexe
from Sales join Tickets 
on Sales.Id_Ticket = Tickets.id 
join Sessions 
on Sales.Id_Session = Sessions.id
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = "f0c56f7e975711edb766e8f1002ad19a"
order by Sales.date DESC; 

-- donner les droits de select only à chaque Manager sur sa vue 
grant select on TotalSaleComplex5 to ComplexeManager5@localhost;
grant select on TotalSaleComplex4 to ComplexeManager4@localhost;
grant select on TotalSaleComplex3 to ComplexeManager3@localhost;
grant select on TotalSaleComplex2 to ComplexeManager2@localhost;
grant select on TotalSaleComplex1 to ComplexeManager1@localhost;


-- donner les droits d'insérer une session à chaque complex manager pour son Complexe
Create view SessionCpx1 as
select Sessions.id, Sessions.Id_MovieRoom, Sessions.Id_Movie, Sessions.StartTime
from Sessions 
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = 'f0bddf8e975711edb766e8f1002ad19a';

grant insert, select on SessionCpx1 to ComplexeManager1@localhost;

-- 
Create view SessionCpx2 as
select Sessions.id, Sessions.Id_MovieRoom, Sessions.Id_Movie, Sessions.StartTime
from Sessions 
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = 'f0c05bf6975711edb766e8f1002ad19a';

grant insert, select on SessionCpx2 to ComplexeManager2@localhost;

-- 
Create view SessionCpx3 as
select Sessions.id, Sessions.Id_MovieRoom, Sessions.Id_Movie, Sessions.StartTime
from Sessions 
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = 'f0c1e76e975711edb766e8f1002ad19a';

grant insert, select on SessionCpx3 to ComplexeManager3@localhost;
--
Create view SessionCpx4 as
select Sessions.id, Sessions.Id_MovieRoom, Sessions.Id_Movie, Sessions.StartTime
from Sessions 
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = 'f0c39064975711edb766e8f1002ad19a';

grant insert, select on SessionCpx4 to ComplexeManager4@localhost;
--

Create view SessionCpx5 as
select Sessions.id, Sessions.Id_MovieRoom, Sessions.Id_Movie, Sessions.StartTime
from Sessions 
join MovieRooms
on Sessions.Id_MovieRoom = MovieRooms.id
where MovieRooms.Id_Complexe = 'f0c56f7e975711edb766e8f1002ad19a'; 

grant insert, select on SessionCpx5 to ComplexeManager5@localhost;


-- Total des ventes par complexe créer une vue accessible pour tout les complex managers only on select
create view TotalSaleCompareCPX as
select SUM((Sales.Quantity * Tickets.price)) as 'Total de la vente',
Sales.date, 
Sales.Id_Session, 
MovieRooms.Id_Complexe 
from Sales join Tickets 
on Sales.Id_Ticket = Tickets.id 
join Sessions 
on Sales.Id_Session = Sessions.id 
join MovieRooms
on MovieRooms.id = Sessions.Id_MovieRoom
group by MovieRooms.Id_Complexe
order by Sales.date DESC;

grant select on TotalSaleCompareCPX to ComplexeManager5@localhost, ComplexeManager4@localhost, ComplexeManager3@localhost, ComplexeManager2@localhost, ComplexeManager1@localhost;



-- view Complex4 
CREATE view UserView as
SELECT 
Complexes.name, 
Complexes.adress, 
Complexes.postalCode,
Movies.title as "Titre",
Sessions.StartTime as 'Commence a', 
Movies.duration as 'Durée du film', 
MovieRooms.numero AS salle, 
ADDTIME(Sessions.StartTime, Movies.duration) AS EndTimeSession
FROM `Sessions` 
JOIN Movies 
ON Sessions.Id_Movie = Movies.id 
JOIN MovieRooms 
ON Sessions.Id_MovieRoom = MovieRooms.id 
join Complexes 
on MovieRooms.Id_Complexe = Complexes.id
order by Complexes.name;

-- create the user customer 
CREATE user 'OnlineCustomer'@'localhost' IDENTIFIED BY '$2a$12$qoW5rRbc.RJEW.KaNrZNh.kio.CIdQ4YmlEkCIFNjQgf5DbD5SIg.'; 
grant select on UserView to OnlineCustomer@localhost;


-- donner les autorisations de insert into sales à userView et cashier créer un nouveau 
grant insert on Sales to OnlineCustomer@localhost; 
grant insert on Sales to  ComplexeManager5@localhost, ComplexeManager4@localhost, ComplexeManager3@localhost, ComplexeManager2@localhost, ComplexeManager1@localhost, OnlineCustomer@localhost;



