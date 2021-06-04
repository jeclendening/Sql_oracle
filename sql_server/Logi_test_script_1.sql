use LIVE_MERCK_SAM
Select Distinct vwvc.[Item Number] as [OSTIC ID],                                                            
 vwvc.Title, 
 vwvc.Submitter, 
 vwvc.[Submitters Department], 
 wii.CreateDate as [Date Submitted], 
 vmr.StatusName as Status, 
 CONVERT(NVARCHAR(10), v.[Timestamp], 101) AS [Date Approved],
 arfda1.ElementValue as [Compound Number],
  arfda.ElementValue as [Business Driver],
 vwvc.Type,
 arfdb.ElementValue as  Category, 
 arfd1.ElementValue as [Review Type], --(Note: Review Type = Standard or Expedited) 
 arfd2.ElementValue  as [Meeting Name],
 arfd3.ElementValue as [Meeting Start],
 --Meeting Venue
 arfd4.ElementValue as [Journal Name], 
 arfd5.ElementValue as [Lead Author],
 arfd6.ElementValue as Manager,
 -- [Manager Approval]
 arfd7.ElementValue as Contacts,
 arfd8.ElementValue as [Requested Reviewers],
 ruc.FullName as Approvers,
 arfd9.ElementValue as Topics,
 arfd10.ElementValue as [Article Name],
 arfd11.ElementValue as [Year of Publication],
 arfd12.ElementValue as [Months of Publication],
 arfd13.ElementValue as Volume,
 arfd14.ElementValue as Issue,
 arfd15.ElementValue as [Inclusive Page Numbers]
  
FROM  vwMyRequests vmr
JOIN Reporting.vwVisualCommunicationsAlert vwvc on vwvc.[Item Number] = vmr.[CompanyRequestId] 
LEFT JOIN WorkflowInstanceItems wii on vmr.RequestId = wii.RequestId
--JOIN [dbo].[ArchiveRequests] Arr on arr.RequestId = vmr.RequestId
LEFT JOIN vwRequestUserComments ruc on ruc.RequestId = wii.RequestId
JOIN (SELECT ar1.RequestId, ar1.Timestamp
       FROM ArchiveRequests ar1
        JOIN Requests r1 on r1.RequestId = ar1.RequestId
       WHERE ar1.SurrogateKey = (SELECT MAX(ar2.SurrogateKey)
                                 FROM ArchiveRequests ar2
                                 WHERE r1.RequestId = ar2.RequestId
                                   AND ar2.SurrogateKey < (SELECT MIN(ar3.SurrogateKey)
 	 			    		   						       FROM ArchiveRequests ar3
					    								   WHERE r1.RequestId = ar3.RequestId
						    							     AND ar3.StatusName = 'Approved'))) v on v.RequestId = vmr.RequestId

LEFT JOIN ArchiveRequestFormData arfda1 ON arfda1.RequestId = vmr.RequestId 
AND arfda1.ElementTitle in ('Compound numbers', 'Compound MK, L, SCH and ORG Numbers') AND arfda1.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle in ('Compound numbers', 'Compound MK, L, SCH and ORG Numbers')
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfda ON arfda.RequestId = vmr.RequestId 
AND arfda.ElementTitle = 'Business driver for disclosure' AND arfda.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle = 'Business driver for disclosure'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfdb ON arfdb.RequestId = vmr.RequestId 
AND arfdb.ElementTitle = 'Category of Work' AND arfdb.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Category of Work'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfd1 ON arfd1.RequestId = vmr.RequestId 
AND arfd1.ElementTitle = 'Review Type' AND arfd1.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle = 'Review Type'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)
   
 LEFT JOIN ArchiveRequestFormData arfd2 ON arfd2.RequestId = vmr.RequestId 
AND arfd2.ElementTitle = 'Meeting Name' AND arfd2.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle = 'Meeting Name'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL) 

 LEFT JOIN ArchiveRequestFormData arfd3 ON arfd3.RequestId = vmr.RequestId 
AND arfd3.ElementTitle = 'Meeting Date' AND arfd3.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle = 'Meeting Date'
                                                             AND a.ElementValue <> ''
															 AND a.ElementValue IS NOT NULL)

 LEFT JOIN ArchiveRequestFormData arfd4 ON arfd4.RequestId = vmr.RequestId 
AND arfd4.ElementTitle = 'Journal Name' AND arfd4.Id = (SELECT MAX(a.Id)
														  FROM ArchiveRequestFormData a
														  WHERE a.RequestId = vmr.RequestId
														  AND a.ElementTitle = 'Journal Name'
														  AND a.ElementValue <> ''
														  AND a.ElementValue IS NOT NULL) 

  LEFT JOIN ArchiveRequestFormData arfd5 ON arfd5.RequestId = vmr.RequestId AND arfd5.ElementTitle 
in('Merck Authors', 'Non-Merck Authors', 'Lead Author') AND arfd5.Id = (SELECT MAX(a.Id)
                                                                       FROM ArchiveRequestFormData a
                                                                       WHERE a.RequestId = vmr.RequestId
                                                                       AND a.ElementTitle in('Merck Authors', 'Non-Merck Authors', 'Lead Author')
                                                                       AND a.ElementValue <> ''
																	   AND a.ElementValue IS NOT NULL)   

LEFT JOIN ArchiveRequestFormData arfd6 ON arfd6.RequestId = vmr.RequestId 
AND arfd6.ElementTitle = 'Your Manager' AND arfd6.Id = (SELECT MAX(a.Id)
														  FROM ArchiveRequestFormData a
														  WHERE a.RequestId = vmr.RequestId
														  AND a.ElementTitle = 'Your Manager'
														  AND a.ElementValue <> ''
														  AND a.ElementValue IS NOT NULL) 

LEFT JOIN ArchiveRequestFormData arfd7 ON arfd7.RequestId = vmr.RequestId 
AND arfd7.ElementTitle = 'contacts' AND arfd7.Id = (SELECT MAX(a.Id)
														  FROM ArchiveRequestFormData a
														  WHERE a.RequestId = vmr.RequestId
														  AND a.ElementTitle = 'contacts'
														  AND a.ElementValue <> ''
														  AND a.ElementValue IS NOT NULL) 

LEFT JOIN ArchiveRequestFormData arfd8 ON arfd8.RequestId = vmr.RequestId 
AND arfd8.ElementTitle = 'Requested Reviewers' AND arfd8.Id = (SELECT MAX(a.Id)
														  FROM ArchiveRequestFormData a
														  WHERE a.RequestId = vmr.RequestId
														  AND a.ElementTitle = 'Requested Reviewers'
														  AND a.ElementValue <> ''
														  AND a.ElementValue IS NOT NULL) 

LEFT JOIN ArchiveRequestFormData arfd9 ON arfd9.RequestId = vmr.RequestId 
AND arfd9.ElementTitle = 'Topics' AND arfd9.Id = (SELECT MAX(a.Id)
														  FROM ArchiveRequestFormData a
														  WHERE a.RequestId = vmr.RequestId
														  AND a.ElementTitle = 'Topics'
														  AND a.ElementValue <> ''
														  AND a.ElementValue IS NOT NULL) 

LEFT JOIN ArchiveRequestFormData arfd10 ON arfd10.RequestId = vmr.RequestId 
AND arfd10.ElementTitle = 'Article Title' AND arfd10.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Article Title'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfd11 ON arfd11.RequestId = vmr.RequestId 
AND arfd11.ElementTitle = 'Year of Publication' AND arfd11.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Year of Publication'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)


LEFT JOIN ArchiveRequestFormData arfd12 ON arfd12.RequestId = vmr.RequestId 
AND arfd12.ElementTitle = 'Month(s) of Publication' AND arfd12.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Month(s) of Publication'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfd13 ON arfd13.RequestId = vmr.RequestId 
AND arfd13.ElementTitle = 'Volume' AND arfd13.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Volume'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfd14 ON arfd14.RequestId = vmr.RequestId 
AND arfd14.ElementTitle = 'Issue' AND arfd14.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Issue'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)

LEFT JOIN ArchiveRequestFormData arfd15 ON arfd15.RequestId = vmr.RequestId 
AND arfd15.ElementTitle = 'Inclusive Page Numbers' AND arfd15.Id = (SELECT MAX(a.Id)
															FROM ArchiveRequestFormData a
															WHERE a.RequestId = vmr.RequestId
                                                             AND a.ElementTitle Like 'Inclusive Page Numbers'
                                                             AND a.ElementValue <> ''
                                                             AND a.ElementValue IS NOT NULL)


WHERE  wii.CreateDate Between '2014-01-01' and getdate()
      and arfd1.ElementValue = 'Standard' or arfd1.ElementValue  = 'Expedited'