------------------------------Test----------Database TEST_PS_MAIN ---------------------------------
--
--
-- Database TEST_PS_MAIN
-- table tblUser
-- column email
-- Number of records affected 71
--
--
use [TEST_PS_MAIN]
--
--Selects the records that will be changed
--
--
SELECT * from tblUser where 
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altruis.com','pubstrat.com')
--
--
--
--Test for replace and substring
--
--
select Replace(u.Email, substring(u.Email,CHARINDEX('@', u.Email, 0) + 1, 100), 'pubstrat.com') as Email
FROM tblUser u
where substring(u.Email,CHARINDEX('@', u.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altruis.com','pubstrat.com')
--
--
--
-- This section converts the non sylogent emails to @pubstrat.com 
--
--
--use [TEST_PS_MAIN]
go

begin transaction
update tblUser set Email = REPLACE(Email,
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100), 'pubstrat.com') where 
substring(Email,CHARINDEX('@', Email, 0) +
 1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altruis.com')

select * from tblUser where Email  like '%pubstrat%' and Email <> ''

rollback
--commit

------------------------------------------Database TEST_PS_MAIN_GATE--------------------------------------------------------------------
--
-- Database TEST_PS_MAIN_GATE
-- table Account
-- column email
-- Number of records affected 55
--
use TEST_PS_MAIN_GATE
--
--
--Selects the records that will be changed
--
--
SELECT * from Account where 
substring(Email,CHARINDEX('@', Email, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')

--
--
--
--Test for replace and substring
--
--
select Replace(a.Email, substring(a.Email,CHARINDEX('@', a.Email, 0) + 1, 100), 'pubstrat.com') as email
FROM Account a
where substring(a.Email,CHARINDEX('@', a.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--
-- This section converts the non sylogent emails to @pubstrat.com
--
--

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
-------------------------------------Database TEST_PS_MAIN_CC---------------------------------------------------
-- Database TEST_PS_MAIN_CC
-- table tblUser
-- column email
-- Number of records affected 126
--
--
--Selects the records that will be changed
--

Use TEST_PS_MAIN_CC

SELECT * from Person p 
where substring(email,CHARINDEX('@', p.Email, 0) + 1, 100) 
     not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')

--
-- 
-- Test for the replace and substring

select Replace(p.Email, substring(p.Email,CHARINDEX('@', p.Email, 0) + 1, 100), 'pubstrat.com') as Email
FROM Person p
where substring(p.Email,CHARINDEX('@', p.Email, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
use [TEST_PS_MAIN_CC]
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

-- The only emails in this table are userIds if they are linked to email you may want to convert as well
-- 
--
use [TEST_PS_MAIN_CC]
--
-- Database DEMO_PS_SYLOGENT_CC
-- table Account
-- column userId
-- records affected 5595
--
--Selects the records that will be changed
--
SELECT * from Account where 
substring(UserID,CHARINDEX('@', UserID, 0) + 
1, 100) not in ('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--
--Test for replace and substring
--
use [TEST_PS_MAIN_CC]
--

select Replace(a.UserID, substring(a.UserID,CHARINDEX('@', a.UserID, 0) + 1, 100), 'pubstrat.com')  as UserId
FROM Account a
where substring(a.UserID,CHARINDEX('@', a.UserID, 0) +  1, 100) not in 
('sylogent.com','ternarysoftware.com','','ternarystudios.com','epeerview.com','altrius.com','pubstrat.com')
--
--
--This section converts non sylogent emails to pubstrat.com
--
--go

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
