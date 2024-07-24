use theaterdbkursovoi;

CREATE INDEX indPer ON [Personal] ([Name], [Surname]);
select Name, Surname from Personal