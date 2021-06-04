
--Merck: Report provide a listing of all submissions for the authors in the attached list

use LIVE_MERCK_SAM

SELECT	r.CompanyRequestId as [SubmissionID], 
		r.RequestName as Title,
		arfd0.ElementValue as [Category of Work],
		arfd1.ElementValue as [Meeting Name],
		arfd2.ElementValue as [Journal Name],
		--arfd3.ElementValue as [Lead Author],
		arfd4.ElementValue as [All Authors],
		ISNULL(rt.Name, '') as [Document Type],
		ISNULL(s.StatusName, '') as [Status],
		wii.CreateDate as [Date of Submission]

FROM Requests r LEFT JOIN RequestTypes rt ON r.RequestTypeId = rt.Id
				LEFT JOIN WorkflowInstanceItems wii on wii.RequestId = r.RequestId
				LEFT JOIN StatusCodes s on s.StatusId = wii.StatusId
				------------------------------------------------------------------------------------------
				LEFT JOIN ArchiveRequestFormData arfd0 ON arfd0.RequestId = r.RequestId 
				AND arfd0.ElementTitle = 'Category of Work' AND arfd0.Id = (SELECT MAX(a.Id)
																		FROM ArchiveRequestFormData a
																		WHERE a.RequestId = r.RequestId
                                                                        AND a.ElementTitle = 'Category of Work'
                                                                        AND a.ElementValue <> ''
                                                                        AND a.ElementValue IS NOT NULL)
				
				
				LEFT JOIN ArchiveRequestFormData arfd1 ON arfd1.RequestId = r.RequestId 
				AND arfd1.ElementTitle = 'Meeting Name' AND arfd1.Id = (SELECT MAX(a.Id)
																		FROM ArchiveRequestFormData a
																		WHERE a.RequestId = r.RequestId
                                                                        AND a.ElementTitle = 'Meeting Name'
                                                                        AND a.ElementValue <> ''
                                                                        AND a.ElementValue IS NOT NULL)
				LEFT JOIN ArchiveRequestFormData arfd2 ON arfd2.RequestId = r.RequestId 
				AND arfd2.ElementTitle = 'Journal Name' AND arfd2.Id = (SELECT MAX(b.Id)
																		FROM ArchiveRequestFormData b
																		WHERE b.RequestId = r.RequestId
																	    AND b.ElementTitle = 'Journal Name'
																	    AND b.ElementValue <> '') 
				------------------------------------------------------------------------------------------
				--LEFT JOIN ArchiveRequestFormData arfd3 ON arfd3.RequestId = r.RequestId 
				--AND arfd3.ElementTitle = 'Lead Author' 
				--AND arfd3.Id = (SELECT MAX(c.Id)
				--				FROM ArchiveRequestFormData c
				--				WHERE c.RequestId = r.RequestId
				--				AND c.ElementTitle = 'Lead Author'
				--				AND c.ElementValue <> '') 
				LEFT JOIN ArchiveRequestFormData arfd4 ON arfd4.RequestId = r.RequestId 
				AND arfd4.ElementTitle in('Merck Authors', 'Non-Merck Authors', 'Lead Author') 
				AND arfd4.Id = (SELECT MAX(d.Id)
								FROM ArchiveRequestFormData d
								WHERE d.RequestId = r.RequestId
								AND d.ElementTitle in('Merck Authors', 'Non-Merck Authors', 'Lead Author')
								AND	(d.ElementValue like '%nelsenl%' or d.ElementValue like '%Nelsen, Linda%' or d.ElementValue like '%Nelsen Linda%'
								  or d.ElementValue like '%martina%'or d.ElementValue like '%Nguyen, Allison%' or d.ElementValue like '%Nguyen Allison%'
								  or d.ElementValue like '%mehtavi%'or d.ElementValue like '%Mehta, Vinay%' or d.ElementValue like '%Mehta Vinay%'
								  or d.ElementValue like '%Marsicom%'or d.ElementValue like '%Marsico, Mark%' or d.ElementValue like '%Marsico Mark%'
								  or d.ElementValue like '%lubwama%'or d.ElementValue like '%Lubwama, Robert%' or d.ElementValue like '%Lubwama Robert%'
								  or d.ElementValue like '%peterse%'or d.ElementValue like '%Peter, Senaka%' or d.ElementValue like '%Peter Senaka%'
								  or d.ElementValue like '%hejin%'or d.ElementValue like '%He, Jinghua%' or d.ElementValue like '%He Jinghua%'
								  or d.ElementValue like '%lizhiwen%'or d.ElementValue like '%Liu, Zhiwen%' or d.ElementValue like '%Liu Zhiwen%'
								  or d.ElementValue like '%chenyong%'or d.ElementValue like '%Chen, Yong%' or d.ElementValue like '%Chen Yong%'
								  or d.ElementValue like '%goodnowk%'or d.ElementValue like '%Brodovicz, Kimberly%' or d.ElementValue like '%Brodovicz Kimberly%'
								  or d.ElementValue like '%mcneilla%'or d.ElementValue like '%McNeill, Annie%' or d.ElementValue like '%McNeill Annie%'
								  or d.ElementValue like '%Norquist%'or d.ElementValue like '%Norquist, Josephine%' or d.ElementValue like '%Norquist Josephine%'
								  or d.ElementValue like '%Rameyden%'or d.ElementValue like '%Ramey, Dena%' or d.ElementValue like '%Ramey Dena%'
								  or d.ElementValue like '%zhouwei2%'or d.ElementValue like '%Zhou, Wei%' or d.ElementValue like '%Zhou Wei%'
								))
WHERE arfd4.ElementValue is not null