---می خواهیم دیتابیسی با 8 جدول بسازیم، لذا اکسلهای فوق را فراخوانی میکنیم( گرچه دارای موضوعات مخلفی هستند)
--create database db_university
use [db_university]
----سوال برای ما پیاده سازی چند تابع، ویو و استورپروسیجر است.
-----Q1 functions 
----First we want to count women who studied in Urima and their total score was more than 15, we want to give them present:
select*from [dbo].[tatal$]
select [جنسيت], [محل تحصيل], [معدل]
from [dbo].[tatal$]
where [محل تحصيل]=N'اروميه' and [جنسيت]=N'زن' and [معدل]>15
order by [معدل] desc

----The other columns
select*from [dbo].[tatal$total14000725]
--------بیشترین مقطع نحصیلی
select top 5 [مقطع تحصيلي], count([مقطع تحصيلي])
from [dbo].[tatal$total14000725]
group by [مقطع تحصيلي]
order by count([مقطع تحصيلي]) desc
---------داده ها نشان می دهد افراد به تحصیلات آکادمیک علاقه بیشتری دارند!

-----Join
----In 14000s columns
select*from
[dbo].['1400_06$'] left join [dbo].['140004$']
on
[dbo].['1400_06$'].[کد شعبه]=[dbo].['140004$'].[کد شعبه]
----در بالا دو تا از جداول را از چپ به یکدیگر متصل کردیم


select*from [dbo].[Sheet1$]
------dbo_sheet
----a people who are business administer
select [جنسيت],[رشته تحصيلي]
from [dbo].[Sheet1$]
where [رشته تحصيلي] like N'مديريت بازرگاني'
-------------------
select [جنسيت],[تاريخ تولد],
1403-left(convert(bigint,[تاريخ تولد]),4) as 'سن'
, left(convert(bigint,[تاريخ تولد]),4) as 'سال'
,substring(convert(nvarchar(max),convert(bigint,[تاريخ تولد])),5,2) as 'ماه'
,substring(convert(nvarchar(max),convert(bigint,[تاريخ تولد])),7,2) as 'روز'
from [dbo].[tatal$total14000725]
where 1403-left(convert(bigint,[تاريخ تولد]),4)<50
go
-------سال، ماه،روز و سن افراد زیر 50 سال را استخراج کنید تا برای کار استخدام شوند.


-----Aggrigate function
SELECT [رشته تحصيلي] , COUNT(*) AS 'تعداد دانشجویان'
FROM [dbo].[Sheet1$]
GROUP BY [رشته تحصيلي];
-----گروهبندی افراد با استفاده از رشته های مختلف

----Q2
-----Views
select*from [dbo].['140005$']

use [db_university]
go
----CREATE VIEW [dbo].[v_k] 
as
select*from [dbo].['140005$']
where [ناکارامد]>100
-----------------
--update [dbo].[v_k]
set [ناکارامد]='0'
where [ناکارامد]>100
-------------------در بالا شعبه هایی که ناکارآمدی بیشتر از 100 دارند را بجاش 0 میذاریم(به نوعی حذف شده)

-------View for average score of students
CREATE VIEW avg_score as
SELECT 
    [رشته تحصيلي], 
    AVG([معدل]) AS ميانگين_معدل
FROM [dbo].[Sheet1$]
GROUP BY [رشته تحصيلي];
-------میانگین معدلها براساس رشته های مختلف محاسبه میشود.


------Q3
----stored procedure
---CREATE PROCEDURE ByKeyword
    @Keyword NVARCHAR(50)
AS
BEGIN
    SELECT [رشته تحصيلي],[كد مديريت]
    FROM [dbo].[tatal$total14000725]
    WHERE [رشته تحصيلي] LIKE '%' + @Keyword + '%';
END;
EXEC dbo.ByKeyword @Keyword = N'مديريت بازرگاني';


----CREATE PROCEDURE dbo.DeleteStudent
    @StudentID INT
AS
BEGIN
    DELETE FROM [dbo].[Sheet1$]
    WHERE [كدواحد سازماني] = @StudentID;
END;
EXEC dbo.DeleteStudent @StudentID = 70;
select*from [dbo].[Sheet1$]

