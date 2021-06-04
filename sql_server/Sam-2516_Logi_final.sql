use LIVE_MERCK_SAM
SELECT     [Meeting Date], 
  rvc.[Meeting/Journal Name], 
  rvc.Type, 
  rvc.[Item Number], 
  rvc.Title, 
  rvc.[Lead Author], 
  rvc.Submitter, 
  rvc.[Submitters Department] as [Submitters Department],
  rvc.CompoundID as [Compound ID],
  rvc.ArticleName as [Article Name],
  rvc.YearOfPublication as [Year Of Publication],
  rvc.MonthsOfPublication as [Months Of Publication],
  rvc.Volume,
  rvc.Issue,
  rvc.InclusivePageNumbers as [Inclusive Page Numbers],
  rvc.CreateDate as [Create Date]

FROM   Reporting.vwVisualCommunicationsAlert rvc
LEFT JOIN Requests r ON r.CompanyRequestId = rvc.[Item Number]
LEFT JOIN Users u ON r.CreateById = u.UserId
Where u.userid NOT IN (15,17,21,28,29,30,31,32,33,121,140611,140612) and
(rvc.[CreateDate] between '@Request.idStartDate~' and '@Request.idEndDate~')
and (('' in (@SingleQuote.Request.islType~)) or (replace(rvc.Type, ',', ' ') in (@SingleQuote.Request.islType~)))	 
--and rvc.Type = '@Request.islType~'
--order by rvc.[Item Number]