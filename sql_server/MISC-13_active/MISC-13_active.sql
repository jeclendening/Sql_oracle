use LIVE_PS_MAIN
--Select
--       count(tu.Disabled) as StatusCount,
--	   ppm.Name
--from tblUser tu
--Join PSProgramUser pu on pu.UserID = tu.UserID 
--JOIN AppUsageLog al on al.UserID = tu.UserID 
--LEFT JOIN PSProgram ppm on ppm.ProgramID = pu.ProgramID
--LEFT JOIN PSUserAccessType puat on puat.UserAccessTypeID = pu.AccessID
--where ppm.Name is not null
--     and ppm.Name not like '%Z%' 
--     and tu.Disabled = 0
--	 and al.LastRequest > '2016-02-01'
--     and ppm.Name = '@Request.islName~' 
--	 and al.LastRequest <= '@Request.idStartDate~' 
--group by tu.Disabled, ppm.Name

select Replace(tu.Disabled, 0, 'Inactive') as Active_status
FROM tblUser tu
Left JOIN AppUsageLog al on al.UserID = tu.UserID 
where al.LastRequest < '2016-02-01' 
