use [LIVE_PS_ASTELLAS];

Select Distinct tu.LastName,
      tu.FirstName,
      tu.Email,
        case tu.Disabled 
	      when 0 then 'Enabled'
		  when 1 then 'Disabled'end as 'Enabled/Disabled',
        case tu.Deleted
	      when 0 then 'NO'
		  when 1 then 'YES'end as 'Deleted', 
	  ppm.Name as Product,
	  puat.Text as 'Access Level',
	    case tu.ExternalPerson 
	      when 0 then 'Internal'
		  when 1 then 'External'
		  else '' end as [Resource type]
from LIVE_PS_ASTELLAS.dbo.tblUser tu
Join LIVE_PS_ASTELLAS.dbo.PSProgramUser pu on pu.UserID = tu.UserID 
LEFT JOIN LIVE_PS_ASTELLAS.dbo.PSUserAccessType puat on puat.UserAccessTypeID = pu.AccessID
Join LIVE_PS_ASTELLAS.dbo.PSProgramResources ppr on ppr.UserID = tu.UserID
LEFT JOIN LIVE_PS_ASTELLAS.dbo.PSResourceType prt on ppr.ResourceTypeID = prt.ResourceTypeID
LEFT JOIN LIVE_PS_ASTELLAS.dbo.PSProgram ppm on ppm.ProgramID = pu.ProgramID
LEFT JOIN AppUsageLog al on al.UserID = tu.UserID 
where tu.ExternalPerson = 0 and puat.UserAccessTypeID != 0
and al.LastRequest >= '2016-03-01'
--and al.LastRequest >= '@Request.idStartDate~'