use TEST_PS_MAIN;

Select tu.email, 
       case tu.Disabled 
	      when 0 then 'Active'
		  when 1 then 'Inactive'end as 'ACTIVE/INACTIVE',
		ppm.Name as product
from tblUser tu
Join PSProgramUser pu on pu.UserID = tu.UserID 
LEFT JOIN PSProgram ppm on ppm.ProgramID = pu.ProgramID
LEFT JOIN PSUserAccessType puat on puat.UserAccessTypeID = pu.AccessID
where tu.ExternalPerson = 0 and puat.UserAccessTypeID != 0
