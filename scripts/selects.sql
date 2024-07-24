use theaterdbkursovoi;
-- select to table personal
select *from Personal;
select count(*) from Personal;
SELECT * FROM Personal WHERE Salary > 1000;
SELECT Name,Surname, Salary FROM personal WHERE salary < 10000;
-- select to table role
select *from Role;
select count(*) from Role;
SELECT * FROM Role WHERE Experience = 10;
--select to table spectacle
select count(*) from Spectacle;
select * from Spectacle;
select *from Spectacle where AvailableSeats >100;
select NameOfSpectacle, Description  from Spectacle where AvailableSeats <150;
select NameOfSpectacle, Description, AvailableSeats from Spectacle where Price < 200;
select NameOfSpectacle, Description, AvailableSeats from Spectacle where NameOfSpectacle like 'D%';
Select NameOfSpectacle from Spectacle join Shedule on  Shedule.ID_Spectacle = Spectacle.ID_Spectacle;
--select to table client
Select Email from Client;
select * from Client;
Select count(*) from Client;
Select Email From Client where Second_Name like'%%r';
select Password from Client where Login like 'dgt7%';
-- select t table basket
select *from Basket;
select ID_Client from Basket;
select count(*) from Basket;
select ID_Ticket from Basket;
select *from Ticket;
select *from Shedule;

SELECT s.NameOfSpectacle, s.Description, s.Price, s.AvailableSeats, sh.Data_Time
FROM Shedule sh
INNER JOIN Spectacle s ON sh.ID_Spectacle = s.ID_Spectacle
WHERE sh.Data_Time = '2023-05-12';


select ID_Person from Personal;