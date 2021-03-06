use LIVE_PS_ASTELLAS
SELECT Distinct tu.[UserID],
       tu.[Email],
       tu.[FirstName],
       tu.[LastName],
       tu.[Address1],
       tu.[CompanyID],
       tu.[CreationDate],
       case tu.Deleted
	      when 0 then 'NO'
		  when 1 then 'YES'end as 'Deleted',
       case tu.Disabled 
	      when 0 then 'Enabled'
		  when 1 then 'Disabled'end as 'Enabled/Disabled',
	   case tu.ExternalPerson 
	      when 0 then 'Internal'
		  when 1 then 'External'
		  else '' end as [Resource type],
       Case 
	      When count(Distinct aul.LogID) >= 1 and aul.LastRequest >= '2016-03-01' then 'YES'
		  When count(Distinct aul.LogID) <= 1  and aul.LastRequest < '2016-03-01' then 'NO' 
	   End as [Active],
	   Case 
	     When count(Distinct aul.LogID) > 1 then 'YES'
	     When count(Distinct aul.LogID) <= 1  then 'NO' 
	   End as [Logged on]
 FROM tblUser tu 
  LEFT JOIN AppUsageLog aul on aul.UserID = tu.UserID
  LEFT Join PSProgramUser pu on pu.UserID = tu.UserID 
  LEFT JOIN PSUserAccessType puat on puat.UserAccessTypeID = pu.AccessID
  Left Join PSProgramResources ppr on ppr.UserID = tu.UserID
  LEFT JOIN PSResourceType prt on ppr.ResourceTypeID = prt.ResourceTypeID
  LEFT JOIN PSProgram ppm on ppm.ProgramID = pu.ProgramID
where tu.ExternalPerson = 0 and puat.UserAccessTypeID != 0
 and aul.LastRequest  > '2016-01-01' -- between '@Request.idStartDate~' and '@Request.idEndDate~' 
group by tu.[UserID],
       tu.[Email],
       tu.[FirstName],
       tu.[LastName],
       tu.[Address1],
       tu.[CompanyID],
       tu.[CreationDate],
       tu.[Deleted],
       tu.[Disabled],
	   tu.ExternalPerson,
	    aul.LastRequest