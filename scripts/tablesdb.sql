use theaterdbkursovoi;

go

CREATE TABLE [Role]                                 --Таблица ролей
(
[ID_Role] int constraint PK_Role primary key  ,
[ID_Person] int,
[NameOfRole] nvarchar (50),
[Experience] int
)

CREATE TABLE [Personal]                                 --Таблица персонала
(
[ID_Person] int constraint PK_Person primary key,
[ID_Role] int ,
[Name] nvarchar(50),
[Surname] nvarchar (50),
[Gender] char default 'M' check([Gender] = 'M' or [Gender] ='W'),
[Mobile] varchar(13) ,
[On_holiday] nvarchar(10) default 'true',
[Salary] int,
[Bankcard_number] int
)

CREATE TABLE [Spectacle]                              --Таблица спектаклей
(
[ID_Spectacle] int constraint PK_Spectacle primary key ,
[NameOfSpectacle] nvarchar (50),
[Description] nvarchar (200),
[Price] int,
[AvailableSeats] int
)
CREATE TABLE [Peromance]                              --Таблица представлений дял связи многии ко многим
(
[ID_Person] int constraint FK_PerfomancePersonSpectacle foreign key references [Personal](ID_Person),
[ID_Spectacle] int constraint FK_PerfomanceSpectaclePerson foreign key references [Spectacle](ID_Spectacle)
)
CREATE TABLE [Shedule]                              --Таблица расписание
(
[ID_Shedule] int constraint PK_Shedule primary key ,
[ID_Spectacle] int constraint FK_Spectacle foreign key references [Spectacle](ID_Spectacle),
[Data_Time] date
)
CREATE TABLE [Ticket]                              --Таблица билетов
(
[ID_Ticket] int constraint PK_Ticket primary key ,
[ID_Shedule] int constraint FK_TicketShedule foreign key references [Shedule](ID_Shedule),
[Price] int,
[Count] int
)
CREATE TABLE [Client]
(
[ID_Client] int constraint PK_Client primary key ,
[First_Name] nvarchar(50),
[Second_Name] nvarchar(50),
[Email] nvarchar(50),
[Login] nvarchar(20) not null,
[Password] nvarchar(20) not null
)

CREATE TABLE [Basket]
(
[ID_Basket] int constraint PK_Basket primary key ,
[ID_Client] int constraint FK_ClientBasket foreign key references [Client](ID_Client),
[ID_Ticket] int constraint FK_ClientTicket foreign key references [Ticket](ID_Ticket)
)


DECLARE @Personal VARCHAR(MAX)
 
SELECT @Personal= BulkColumn FROM OPENROWSET(BULK'D:\kursovoi_db\scripts\tableInsert.json', SINGLE_BLOB) JSON;
SELECT @Personal as SingleRow_Column
 
IF (ISJSON(@Personal) = 1) 
 BEGIN 
   PRINT 'Imported JSON is Valid' 
 END 
ELSE 
 BEGIN 
   PRINT 'Invalid JSON Imported' 
 END 
 
SELECT * FROM OPENJSON(@Personal, '$.Personal.Personals')
 
 
SELECT ID_Person,ID_Role, Name, Surname, Gender, Mobile, On_holiday, Salary, Bankcard_number
FROM OPENJSON(@Personal, '$.Personal.Personals')
WITH(
    ID_Person int '$.ID_Person',
	ID_Role int '$.ID_Role',
	Name nvarchar(50) '$.Name',
	Surname nvarchar(50) '$.Surname',
	Gender char '$.Gender',
	
	Mobile varchar(13) '$.Mobile',
	On_holiday nvarchar(10) '$.On_holiday',
	Salary int '$.Salary',
	Bankcard_number int '$.Bankcard_number'
)  
 
 INSERT INTO Personal
  SELECT ID_Person,ID_Role, Name, Surname, Gender,Mobile, On_holiday, Salary, Bankcard_number
  FROM OPENJSON(@Personal, '$.Personal.Personals')
  WITH(
      ID_Person int '$.ID_Person',
	ID_Role int '$.ID_Role',
	Name nvarchar(50) '$.Name',
	Surname nvarchar(50) '$.Surname',
	Gender char '$.Gender',
	
	Mobile varchar(13) '$.Mobile',
	On_holiday nvarchar(10) '$.On_holiday',
	Salary int '$.Salary',
	Bankcard_number int '$.Bankcard_number'
  )
  select * from Personal;
  select *from Spectacle;
 SELECT (
    SELECT
        ID_Spectacle, 
        NameOfSpectacle,
        Description,
		Price,
		AvailableSeats
    FOR JSON PATH, 
        INCLUDE_NULL_VALUES, 
        WITHOUT_ARRAY_WRAPPER
    )
FROM Spectacle
GO

Drop table Basket;
Drop table Client;
DROP TABLE [Ticket];                              --Удаление всего
DROP TABLE [Shedule];
DROP TABLE [Peromance];
DROP TABLE [Spectacle];
DROP TABLE [Personal];
DROP TABLE [Role];


go

CREATE TRIGGER trg_SubtractFromAvailableSeats
ON Basket
AFTER INSERT
AS
BEGIN
    UPDATE Spectacle
    SET AvailableSeats = AvailableSeats - 1
    WHERE ID_Spectacle IN (SELECT ID_Spectacle FROM inserted);
END;
go
select AvailableSeats from Spectacle;
go
CREATE TRIGGER trg_CheckDuplicateTicketInBasket
ON Basket
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Basket b ON b.ID_Ticket = i.ID_Ticket
        GROUP BY b.ID_Ticket
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('This ticket has already been added to the basket', 16, 1)
        ROLLBACK TRANSACTION
    END
END


DECLARE @sql varchar(1000)
SET @sql = 'bcp "SELECT ID_Role, ID_Person,NameOfRole ' + 
    'Experience FROM dbo.Role ' + 
    'FOR JSON PATH, INCLUDE_NULL_VALUES" ' +
    'queryout  "D:\kursovoi_db\scripts\roles.json" ' + 
    '-c -S DESKTOP-V5FOP2V -d theaterdbkursovoi -T'
EXEC sys.XP_CMDSHELL @sql
go
DECLARE @sql varchar(1000)
SET @sql = 'bcp "SELECT ID_Basket,ID_Client, ' + 
    ' ID_Ticket FROM dbo.Basket ' + 
    'FOR JSON PATH, INCLUDE_NULL_VALUES" ' +
    'queryout  "D:\kursovoi_db\scripts\basket.json" ' + 
    '-c -S DESKTOP-V5FOP2V -d theaterdbkursovoi -T'
EXEC sys.XP_CMDSHELL @sql
GO
DECLARE @sql varchar(1000)
SET @sql = 'bcp "SELECT ID_Client,First_Name,Second_Name, Email, Login ' + 
    'Password FROM dbo.Client ' + 
    'FOR JSON PATH, INCLUDE_NULL_VALUES" ' +
    'queryout  "D:\kursovoi_db\scripts\clients.json" ' + 
    '-c -S DESKTOP-V5FOP2V -d theaterdbkursovoi -T'
EXEC sys.XP_CMDSHELL @sql
GO
DECLARE @sql varchar(1000)
SET @sql = 'bcp "SELECT ID_Ticket,ID_Shedule,Price ' + 
    'Count FROM dbo.Ticket ' + 
    'FOR JSON PATH, INCLUDE_NULL_VALUES" ' +
    'queryout  "D:\kursovoi_db\scripts\tickets.json" ' + 
    '-c -S DESKTOP-V5FOP2V -d theaterdbkursovoi -T'
EXEC sys.XP_CMDSHELL @sql
GO
DECLARE @sql varchar(1000)
SET @sql = 'bcp "SELECT ID_Shedule,ID_Spectacle ' + 
    'Data_Time FROM dbo.Shedule ' + 
    'FOR JSON PATH, INCLUDE_NULL_VALUES" ' +
    'queryout  "D:\kursovoi_db\scripts\shedule.json" ' + 
    '-c -S DESKTOP-V5FOP2V -d theaterdbkursovoi -T'
EXEC sys.XP_CMDSHELL @sql

go
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'xp_cmdshell', 1;
GO
RECONFIGURE;
GO
sp_configure 'xp_cmdshell', 0;
GO
RECONFIGURE;
GO

select @@SERVERNAME


