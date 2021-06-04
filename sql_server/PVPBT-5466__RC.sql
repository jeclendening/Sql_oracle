--------------------RC---------Database RC_SYLOGENT_GATEKEEPER -------------------------
--
-- Database: RC_SYLOGENT_GATEKEEPER
-- Table: Account
-- Column: email
-- Records affected: 169
--
-- 
-- Selects the records that will be changed
--
use [RC_SYLOGENT_GATEKEEPER]

SELECT * from Account where 
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--Test for the replace and substring
--
--
--
select Replace(a.Email, substring(a.Email,CHARINDEX('@', a.Email, 0) + 1, 100), 'pubstrat.com') as Email
FROM Account a
where substring(a.Email,CHARINDEX('@', a.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')

--
--​
-- This section converts non sylogent emails to pubstrat.com 
-- 
--
use [RC_SYLOGENT_GATEKEEPER]

go

begin transaction
update Account set Email = REPLACE(Email,
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100), 'pubstrat.com') where 
substring(Email,CHARINDEX('@', Email, 0) +
 1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com')

select * from Account where Email  like '%pubstrat%' and Email <> ''

rollback
--commit
--

--
------------------------------Database RC_SYLOGENT_PUBSTRAT--------------------------------------------------------
--
--
-- Database: RC_SYLOGENT_PUBSTRAT
-- Table: tblUser
-- Column: Email
-- Number of records affected: 3
--
-- Selects the records that will be changed
--
use [RC_SYLOGENT_PUBSTRAT]

SELECT * from tblUser where 
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--Test for replace and substring
--
--
select Replace(u.Email, substring(u.Email,CHARINDEX('@', u.Email, 0) + 1, 100), 'pubstrat.com')  as Email
FROM tblUser u
where substring(u.Email,CHARINDEX('@', u.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
-- This section converts the non sylogent emails to @pubstrat.com 
--
use [RC_SYLOGENT_PUBSTRAT]
go

begin transaction
update tblUser set Email = REPLACE(Email,
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100), 'pubstrat.com') where 
substring(Email,CHARINDEX('@', Email, 0) +
 1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com')

select * from tblUser where Email  like '%pubstrat%' and Email <> ''

rollback
--commit

