ALTER TABLE Schedule
add PhraseCategoryID int,
    PartnerPhraseCategoryID int

alter table TopCategoryHeader
add HideInScheduler bit default(0)

update TopCategoryHeader set HideInScheduler = 0 

alter table PhraseCategoryHeader
add HideInScheduler bit default(0)