Use [LIVE_MERCK_SAM]
SELECT vmr.CompanyRequestId,
       vmr.RequestType,
	   vmr.RequestName,
       vmr.Description,
       arfd0.ElementValue as [Category of Work], 
	   vmr.StatusName
	   
FROM vwMyRequests2 vmr
LEFT JOIN ArchiveRequestFormData arfd0 ON arfd0.RequestId = vmr.RequestId 
AND arfd0.ElementTitle = 'Category of Work' AND arfd0.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle = 'Category of Work'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfd2 ON arfd2.RequestId = vmr.RequestId 
AND arfd2.ElementTitle = 'Meeting Name' AND arfd2.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle = 'Meeting Name'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL) 
where vmr.StatusName not in ('Withdrawn', 'Draft')
order by vmr.CompanyRequestId desc