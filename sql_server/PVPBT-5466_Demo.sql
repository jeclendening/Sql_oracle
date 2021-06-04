
-- Script to replace non sylogent emails with pubstrat.com
-- 
----------------------------------------Database DEMO_PS_SYLOGENT --------------------------------------------------------------
--
-- Database: DEMO_PS_SYLOGENT
-- Table: tblUser
-- Column: Email
-- Number of records affected: 227
--
-- Selects the records that will be changed
--
use [DEMO_PS_SYLOGENT]

SELECT * from tblUser where 
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--Test for replace and substring comment out before running
--
--
select Replace(u.Email, substring(u.Email,CHARINDEX('@', u.Email, 0) + 1, 100), 'pubstrat.com') as Email
FROM tblUser u
where substring(u.Email,CHARINDEX('@', u.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')

-- This section converts the non sylogent emails to @pubstrat.com 

use [DEMO_PS_SYLOGENT]
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
--
--
---------------------------Database  DEMO_PS_SYLOGENT_CC-------------------------------------------------------------------------------

-- Database: DEMO_PS_SYLOGENT_CC 
-- Table: Person 
-- Column: email
-- number of records affected 114636

use [DEMO_PS_SYLOGENT_CC]
--
SELECT * from Person p where 
substring(p.Email,CHARINDEX('@', p.Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--
-- 
-- Test for the replace and substring

select Replace(p.Email, substring(p.Email,CHARINDEX('@', p.Email, 0) + 1, 100), 'pubstrat.com') as Email
FROM Person p
where substring(p.Email,CHARINDEX('@', p.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')

--
-- 
use [DEMO_PS_SYLOGENT_CC]
--
--This section converts non sylogent emails to pubstrat.com 
--​
go

begin transaction
update Person set Email = REPLACE(Email,
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100), 'pubstrat.com') where 
substring(Email,CHARINDEX('@', Email, 0) +
 1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com')

select * from Person where Email  like '%pubstrat%' and Email <> ''

rollback
--commit

--
--
--
--
-- The emails in this table are userIds if they are linked to email you will want to convert as well
-- 
--
--
--
-- Database DEMO_PS_SYLOGENT_CC
-- table Account
-- column userId
-- records affected 13287
--
--Selects the records that will be changed

use [DEMO_PS_SYLOGENT_CC]

SELECT * from Account where 
substring(UserID,CHARINDEX('@', UserID, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--
--Test for replace and substring
--

select Replace(a.UserID, substring(a.UserID,CHARINDEX('@', a.UserID, 0) + 1, 100), 'pubstrat.com') as UserId
FROM Account a
where substring(a.UserID,CHARINDEX('@', a.UserID, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')

--
--This section converts non sylogent emails to pubstrat.com
--
go

begin transaction
update Account set UserID = REPLACE(UserID,
substring(UserID,CHARINDEX('@', UserID, 0) + 
1, 100), 'pubstrat.com') where 
substring(UserID,CHARINDEX('@', UserID, 0) +
 1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com')

select * from Account where UserID  like '%pubstrat%' and UserID <> ''

--rollback
commit
--
--
--

--
--
--
-----------------------------------------Database DEMO_PS_SYLOGENT_GATE------------------------------------------------------
--
--
-- Database: DEMO_PS_SYLOGENT_GATE
-- Table: Account
-- Column: email
-- Records affected: 116
--
-- 
-- Selects the records that will be changed
--
use [DEMO_PS_SYLOGENT_GATE]

SELECT * from Account where 
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--Test for the replace and substring
--
--
--
select Replace(a.Email, substring(a.Email,CHARINDEX('@', a.Email, 0) + 1, 100), 'pubstrat.com')  as Email
FROM Account a
where substring(a.Email,CHARINDEX('@', a.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--​
-- This section converts non sylogent emails to pubstrat.com 
-- 
--
use [DEMO_PS_SYLOGENT_GATE]

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