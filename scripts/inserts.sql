use theaterdbkursovoi;

insert into Spectacle (ID_Spectacle, NameOfSpectacle, Description, Price, AvailableSeats) 
values (1,'Tomato - Plum With Basil', 'Disp fx of head of r rad, 7thQ', 100, 234);
insert into Spectacle (ID_Spectacle, NameOfSpectacle, Description, Price, AvailableSeats) 
values (2,'Table Cloth 72x144 White', 'Nondisp fx of acromial pro', 112, 23),
       (3,'Beef - Rib Eye Aaa', 'Pasngr in pk-up/van injured in clsn w nonmtr vehicle in traf', 150, 56),
	   (4,'Buttons', 'Toxic effect of tetrachloroethylene, assault, subs encntr', 90, 34),
	   (5,'Wine - Jafflin Bourgongone', 'Displ transverse fx shaft of l ulna', 78, 130),
	   (6,'Pork - Inside', 'Contact with metalworking machines, subsequent encounter', 124, 234),
	   (7,'Tea - Mint', 'Abnormality of plasma protein', 47, 135),
	   (8,'Spice - Onion Powder Granulated', 'Disease of blood and blood-forming organs, unspecified',200, 20),
	   (9,'Silicone Paper 16.5x24', 'Type I occipital condyle fracture, right side, unspecified',89, 312),
	   (10,'Oil - Shortening,liqud, Fry', 'Subluxation of T11/T12 thoracic vertebra, subs encntr',95, 107);

insert into Role (ID_Role, ID_Person, NameOfRole, Experience)
values (89637054,94194018,'Otello', 6),
       (28518159,21747169,'Romeo', 9),
	   (61072186,88233425,'Juliet', 5),
	   (94307323,22519323,'Old pork', 3),
	   (89173274,70779141,'Tomato', 7);
insert into Peromance(ID_Person,ID_Spectacle)
values (89173274,1),
(89173274,1),
( 56565874,1),
(3185177,2),
(99340603,3),
( 35375843,1),
(12756058,4),
(68229707,2),
(78784963,7),
(81015787,9),
(14221305,6),
(21410814,2),
(56713151,3),
(156203,7),
(86895301,8),
(97357658,10),
(4856524,10),
(28932346,4),
(14386464,8),
(55537881,3),
( 55891101,8),
(18019996,9);
insert into Shedule(ID_Shedule, ID_Spectacle, Data_Time)
values (1,2,'14-05-2023'),
(2,2,'24-05-2023'),
(3,1,'12-05-2023'),
(4,3,'30-05-2023'),
(5,6,'21-05-2023'),
(6,8,'01-06-2023'),
(7,7,'04-06-2023'),
(8,7,'07-06-2023'),
(9,10,'05-06-2023'),
(10,9,'12-06-2023'),
(11,9,'23-06-2023'),
(12,1,'11-07-2023'),
(13,1,'09-07-2023'),
(14,4,'17-07-2023'),
(15,4,'21-07-2023'),
(16,5,'08-08-2023'),
(17,3,'18-08-2023'),
(18,6,'29-08-2023');
insert into Ticket(ID_Ticket,ID_Shedule,Price,Count)
values (1,1,336,3),
(2,7,141,3),
(3,3,200,2),
(4,3,400,4),
(5,2,112,1),
(6,18,124,1),
(7,9,190,2),
(8,5,248,2),
(9,4,300,2),
(10,13,1500,15),
(11,11,356,4),
(12,17,450,3),
(13,8,141,3),
(14,15,180,2),
(15,13,100,1),
(16,1,112,1),
(17,16,390,5);
insert into Client(ID_Client,First_Name,Second_Name,Email,Login,Password)
values (1,'Ann', 'Colins', 'awijfh34.com', 'fnnc234','ddjyy55i8'),
       (2,'Ben', 'Uwolis', 'dfjlrlfn.com', 'kdoie8wb','8893hi3h'),
	   (3,'Mary', 'Franck', 'MF12032.com', 'mfkeo32','1404ouweb'),
	   (4,'Andy', 'Gray', 'MrGray.com', 'guhnkhkl8658','8799b9y'),
	   (5,'Holly', 'Klarck', 'MrsKlarck.com', 'klrck2323','nnvvkl778'),
	   (6,'Vivien', 'Marck', 'Marck2.com', 'weriu387894','1378qwerty'),
	   (7,'Jenny', 'Kim', 'bpkim.com', '1239uiwe','nkoi8339'),
	   (8,'Joon', 'Lee', 'bee6679.com', 'beez800','567oiydrfgh'),
	   (9,'Boby', 'Weil', 'khfewin.com', 'qkhoein34','jfow77hf');
insert into Basket(ID_Basket,ID_Client,ID_Ticket)
values (1,1,17),
       (2,5,14),
	   (3,3,9),
	   (4,7,2),
	   (5,4,4),
	   (6,2,13),
	   (7,2,15);



	   insert into Basket(ID_Basket,ID_Client,ID_Ticket)
values (2,1,5);


 insert into Basket(ID_Basket,ID_Client,ID_Ticket)
values (10,1,5);


