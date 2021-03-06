/****** Script for SelectTopNRows command from SSMS  ******/
use [LIVE_PS_MAIN]
SELECT  tu.[UserID],
      tu.[Email],
      tu.[FirstName],
      tu.[LastName],
      tu.[CutInterest],
      tu.[CreationIP],
      tu.[Address1],
      tu.[Address2],
      tu.[Address3],
      tu.[Access_ConfAuth],
      tu. [Access_JSW],
      tu.[CompanyID],
      tu.[CreationDate],
      tu.[Deleted],
      tu.[Disabled],
      tu.[ExternalPerson],
      tu.[Access_JSandCA],
      tu.[HasCompanyWideReportAccess],
	  Case 
	     When count(Distinct aul.LogID) >= 1 then 'YES'
		 When count(Distinct aul.LogID) < 1  then 'NO' 
	  End as [Logged on]
  FROM tblUser tu
  LEFT JOIN AppUsageLog aul on aul.UserID = tu.UserID
  where tu.Email in ('sasidhar@aherf.net', 'sabbott@amagpharma.com', 'farzad720@gmail.com')
   group by tu.[UserID], tu.[Email], tu.[FirstName], tu.[LastName], tu.[CutInterest],
      tu.[CreationIP], tu.[Address1], tu.[Address2], tu.[Address3],  tu.[Access_ConfAuth],
      tu.[Access_JSW], tu.[CompanyID], tu.[CreationDate], tu.[Deleted], tu.[Disabled],
      tu.[ExternalPerson], tu.[Access_JSandCA], tu.[HasCompanyWideReportAccess]