

CREATE LOGIN readonlylogin WITH password='VeryStrongPassword';

CREATE USER reader FROM LOGIN readonlylogin;

EXEC sp_addrolemember 'db_datareader', 'readonlyuser';