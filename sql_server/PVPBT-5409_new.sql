use [LIVE_PS_ASTELLAS];

Select Distinct tu.LastName,
      tu.FirstName,
      tu.Email,
      case tu.Disabled 
	    when 0 then 'Active'
		when 1 then 'Inactive'end as 'ACTIVE/INACTIVE',
      case tu.Deleted
	    when 0 then 'NO'
		when 1 then 'YES'end as 'Deleted', 
	  ppm.Name as product,
	  puat.Text as 'Access Level',
	  prt.ResourceType,
	  case tu.ExternalPerson 
	      when 0 then 'Internal'
		  when 1 then 'External'
		  else '' end as [Internal/External]
	 
from LIVE_PS_ASTELLAS.dbo.tblUser tu
Join LIVE_PS_ASTELLAS.dbo.PSProgramUser pu on pu.UserID = tu.UserID 
LEFT JOIN LIVE_PS_ASTELLAS.dbo.PSUserAccessType puat on puat.UserAccessTypeID = pu.AccessID
Join LIVE_PS_ASTELLAS.dbo.PSProgramResources ppr on ppr.UserID = tu.UserID
LEFT JOIN LIVE_PS_ASTELLAS.dbo.PSResourceType prt on ppr.ResourceTypeID = prt.ResourceTypeID
LEFT JOIN LIVE_PS_ASTELLAS.dbo.PSProgram ppm on ppm.ProgramID = pu.ProgramID
--Join LIVE_ASTELLAS_SYQUENCE.dbo.ExternalSystemEntityUsers eu on eu.UserId = tu.UserID
Where tu.CompanyID = 232 --and tu.Deleted = 0 and tu.Disabled = 0