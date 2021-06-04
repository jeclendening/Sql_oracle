use [TEST_PS_ASTELLAS]


begin tran
insert into Reports (Id, 
					 ReportTypeId, 
					 Name, 
					 [Description], 
					 url, 
					 IsCompanyAdminOnly, 
					 IsCompetitorHidden, 
					 RequiredAccessRole,
                     FeatureId, 
                     Sort, 
                     IsActive)
                     
              values (NEWID(), 
                      '11E66EE2-8298-4B91-A4A4-86CCCBADE940',  --- select * from dbo.ReportTypes where Name = 'Reports' ------ Id = '11E66EE2-8298-4B91-A4A4-86CCCBADE940'
                      'Publications Summary Report', 
                      'Displays stacked bar graph that depicts the different kinds of publications and the amount.', 
                      'javascript:openNamedWindow("_blank","LogiReportViewer.aspx?rdReport=Publications_Summary_Report&ProgramID={1}")', 
                      0, 
                      1, 
                      15, 
                      null, 
                      23, 
                      1)

rollback
--commit
go