select 
    st.Description as ProjectType,
	pest.ProjectEndState as EndState,
	psp.name as ProjectName,
	cs.Target,
	cs.[Lead Author] as LeadAuthor,
	CONVERT(NVARCHAR(10), cs.[Submission Date], 101) AS SubmissionDate,
	CONVERT(NVARCHAR(10), cs.PublicationDate, 101) AS PublicationDate,
	cs.status,
	COUNT(distinct psp.ProjectID) as ProjectsCount 
from PSProject psp
    inner join PSProjectSubType st on psp.ProjectSubTypeID = st.ProjectSubTypeID
    INNER JOIN PSProgram pspr ON pspr.ProgramID=psp.ProgramID
    INNER JOIN PSProjectDef pspd on psp.ProjectDefID = pspd.ProjectDefID 
    INNER JOIN PSProjectEndStateType pest on psp.ProjectEndStateTypeID=pest.ProjectEndStateTypeID
	LEFT JOIN RPT_ComprehensiveStatus cs on cs.ProjectID = psp.ProjectID
where psp.StatusID in (3) AND pspr.Name NOT LIKE 'zz%' 
    and st.ProjectSubTypeID not in (6,7,12)
   -- and pspr.ProgramID = '@Request.ProgramID~'
   -- and psp.StartDate between '@Request.idStartDate~' and '@Request.idEndDate~'
    and psp.StartDate between DATEADD(year, -1, GETDATE()) AND GETDATE() 
group by st.Description, pest.ProjectEndState, psp.name, cs.Target, cs.[Lead Author], cs.[Submission Date], cs.PublicationDate, cs.status
union 
SELECT p.Description as ProjectType, 
  null as EndState, 
  null as ProjectName, 
  null as Target, 
  null as LeadAuthor, 
  null as SubmissionDate, 
  null as PublicationDate, 
  null as status, 
  0 as ProjectsCount
FROM PSProjectSubType p
WHERE ProjectSubTypeID not in (6,7,12)
order by st.Description