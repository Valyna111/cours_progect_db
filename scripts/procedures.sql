use theaterdbkursovoi;

go
CREATE PROCEDURE [dbo].[AddSpectacle1]
(
    @ID_Spectacle int,
    @NameOfSpectacle nvarchar(50),
    @Description nvarchar(200),
    @Price int,
    @AvailableSeats int
)
AS
    SET NOCOUNT ON;

    INSERT INTO [Spectacle] ([ID_Spectacle], [NameOfSpectacle], [Description], [Price], [AvailableSeats])
    VALUES (@ID_Spectacle, @NameOfSpectacle, @Description, @Price, @AvailableSeats);


go

EXEC [dbo].[AddSpectacle1] 
    @ID_Spectacle= 16,
    @NameOfSpectacle = 'Название спектакля4',
    @Description = 'Описание спектакля4',
    @Price = 100,
    @AvailableSeats = 2;

GO

CREATE PROCEDURE [dbo].[ob_PersonalSelectAll] -- для выборки всех записей сотрудников
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  


	SELECT * FROM   [dbo].[Personal] 
	
go
EXEC [dbo].[ob_PersonalSelectAll]
go

CREATE PROCEDURE [dbo].[ob_SpectacleSelectAll] -- для выборки всех записей спектаклей
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  



	SELECT * FROM [dbo].[Spectacle]
	
GO
exec [dbo].[ob_SpectacleSelectAll]
go
CREATE PROCEDURE [dbo].[ob_SheduleSelectAll] -- для выборки всех записей распиания
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRANSACTION

	SELECT [Spectacle].[ID_Spectacle], [Spectacle].[NameOfSpectacle], [Shedule].[Data_Time] FROM [dbo].[Shedule] INNER JOIN Spectacle ON [Spectacle].ID_Spectacle = [Shedule].ID_Spectacle
	go
	exec [ob_SheduleSelectAll]
	go
	CREATE PROCEDURE [dbo].[ob_ActorToSpectacleSelectAll] -- для выборки всех сотрудников в спектакле !!!
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  



	SELECT [Spectacle].[NameOfSpectacle], [Personal].[Name], [Personal].[Surname],  [Personal].[ID_Role] FROM [dbo].[Spectacle] INNER JOIN [Peromance] ON [Peromance].[ID_Spectacle] = [Spectacle].[ID_Spectacle] INNER JOIN [Personal] ON [Peromance].[ID_Person] = [Personal].[ID_Person]
	GO 
	EXEC [dbo].[ob_ActorToSpectacleSelectAll]
	GO
	CREATE PROCEDURE [dbo].[sp_InsertTicket2] -- для добавления билета
	@ID_Ticket int,
	@ID_Shedule int ,
	@Price int,
	@Count int

AS
INSERT INTO [Ticket] ([ID_Ticket], [ID_Shedule], [Price], [Count])
    VALUES (@ID_Ticket, @ID_Shedule, @Price, @Count)
	go 
	exec  [dbo].[sp_InsertTicket2]
	@ID_Ticket=20,
	@ID_Shedule=21 ,
	@Price=100,
	@Count=2

GO


CREATE PROCEDURE [dbo].[sp_InsertShedule] -- для добавления расписания
@ID_Shedule int,
@ID_Spectacle int, 
@Data_Time date

AS
INSERT INTO [Shedule] (ID_Shedule,ID_Spectacle ,Data_Time)
    VALUES (@ID_Shedule,@ID_Spectacle, @Data_Time)

go
exec [dbo].[sp_InsertShedule]
 @ID_Shedule=21,
@ID_Spectacle= 16, 
@Data_Time= '16-05-2023';
GO

CREATE PROCEDURE [dbo].[ob_PersonalDeleteItem2] -- для удаления одного сотрудника
@id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	


	DELETE FROM [dbo].[Personal] WHERE [ID_Person] = @id

	go
	
	exec  [dbo].[ob_PersonalDeleteItem2]
	@id =276;
	


	go
CREATE PROCEDURE [dbo].[ob_SpectacleDeleteItem] -- для удаления одного спектакль
@id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	


	DELETE FROM [dbo].[Spectacle] WHERE [ID_Spectacle] = @id
	go 
	exec [dbo].[ob_SpectacleDeleteItem]
	@id=15;
GO

CREATE PROCEDURE [dbo].[ob_SheduleDeleteItem] -- для удаления одного расписания
@id int,
@DateSpec date
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	


	DELETE FROM [dbo].[Shedule] WHERE [ID_Spectacle] = @id AND [Data_Time] = @DateSpec
	go 
	exec [dbo].[ob_SheduleDeleteItem]
	@id = 20,
	@DateSpec='17-12-2023';
GO

CREATE PROCEDURE [dbo].[ob_TicketDeleteItem] -- для удаления одного ticket
@id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	

	DELETE FROM [dbo].[Ticket] WHERE [ID_Ticket] = @id
 go
 exec [dbo].[ob_TicketDeleteItem]
 @id=19
 go
 CREATE PROCEDURE [dbo].[AddClient]
    @ID_Client int,
    @First_Name nvarchar(50),
    @Second_Name nvarchar(50),
    @Email nvarchar(50),
    @Login nvarchar(20),
    @Password nvarchar(20)
AS

  
 

    INSERT INTO [dbo].[Client] ([ID_Client],[First_Name], [Second_Name], [Email], [Login], [Password])
    VALUES (@ID_Client,@First_Name, @Second_Name, @Email, @Login, @Password);

	go
	EXEC [dbo].[AddClient] 
	@ID_Client =10,
    @First_Name = N'Иван',
    @Second_Name = N'Иванов',
    @Email = N'ivan@mail.com',
    @Login = N'ivan',
    @Password = N'123456';
	GO
	CREATE PROCEDURE [dbo].[AddToBasket]
	@ID_Basket int,
    @ID_Client INT,
    @ID_Ticket INT
AS

    
    INSERT INTO [Basket] ([ID_Basket],[ID_Client], [ID_Ticket])
    VALUES (@ID_Basket, @ID_Client, @ID_Ticket);
    
    go
	EXEC
	[dbo].[AddToBasket]
	@ID_Basket= 9,
	@ID_Client = 1,
	@ID_Ticket = 2;


	go
CREATE PROCEDURE [dbo].[RemoveFromBasket]
    @ID_Basket int
AS

    SET NOCOUNT ON;
    
    DELETE FROM [Basket]
    WHERE [ID_Basket] = @ID_Basket;

go
CREATE PROCEDURE [dbo].[DeleteClient]
    @ID_Client INT
AS

    SET NOCOUNT ON;
    
    DELETE FROM [Client]
    WHERE [ID_Client] = @ID_Client;
go
EXEC [dbo].[DeleteClient] @ID_Client = 10;
