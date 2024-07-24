use theaterdbkursovoi;
ALTER TABLE Client ALTER COLUMN Login ADD MASKED WITH (FUNCTION = 'partial(0,"****",4)');
ALTER TABLE Client ALTER COLUMN Password ADD MASKED WITH (FUNCTION = 'default()');


create user op01 without login;
grant select on dbo.Client to op01;
execute AS user= 'op01'
SELECT *FROM Client
revert

select * from Basket

create user client without login;
grant execute on [dbo].[ob_SpectacleSelectAll] to client
grant execute on  [dbo].[ob_SheduleSelectAll] to client
grant execute on  [dbo].[sp_InsertTicket2] to client
grant execute on  [dbo].[ob_TicketDeleteItem] to client
grant execute on  [dbo].[AddClient] to client
grant execute on  [dbo].[AddToBasket] to client
grant execute on  [dbo].[RemoveFromBasket] to client
grant select on dbo.Basket to client
execute as user ='client';
select * from Basket;
revert;

create user moder without login;
grant execute on [dbo].[ob_SpectacleSelectAll] to moder
grant execute on  [dbo].[ob_SheduleSelectAll] to moder
grant execute on [dbo].[AddSpectacle1] to moder
grant execute on  [dbo].[ob_PersonalSelectAll] to moder
grant execute on [dbo].[ob_SpectacleSelectAll] to moder
grant execute on  [dbo].[ob_ActorToSpectacleSelectAll]  to moder
grant execute on [dbo].[ob_SpectacleSelectAll] to moder
grant execute on  [dbo].[sp_InsertShedule] to moder
grant execute on [dbo].[ob_PersonalDeleteItem2] to moder
grant execute on  [dbo].[ob_SpectacleDeleteItem] to moder
grant execute on [dbo].[ob_SheduleDeleteItem] to moder
grant execute on  [dbo].[DeleteClient] to moder
execute as user= 'moder'
revert 