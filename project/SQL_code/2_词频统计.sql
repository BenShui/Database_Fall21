declare @str nvarchar(200)

if object_id('tempdb.dbo.#array') is not null  --判断临时表是否已经存在
   drop table #array
create table #array(ch nvarchar(20))

--全部改成qiyan即可创建七言的词频库
declare cur scroll cursor for 
    select fenci from wuyan_fenci
open cur
fetch first from cur into @str
while @@FETCH_STATUS = 0
begin
    insert into #array(ch) select value from
    string_split(@str,' ')
    where patindex('%[吖-座]%', value)>0
	fetch next from cur into @str
end
close cur
deallocate cur

select ch, count(*) cnt into wuyan_cipin 
from #array group by ch order by cnt desc
drop table #array

select * from wuyan_cipin order by cnt desc

create view wuyan_ci_full as
select a.*,replace(substring(a.ch,patindex('%[a-z]%',a.ch)-1, len(a.ch)),'_','') cixing,
replace(substring(a.ch,1,charindex('_',a.ch)),'_','') ci,
substring(reverse(rtrim(b.py)),patindex('%[aeiou]%',reverse(rtrim(b.py))),1) py 
from wuyan_cipin a, xhzd b
where b.zi=substring(rtrim(replace(substring(a.ch,1,charindex('_',a.ch)),'_','')),len(rtrim(replace(substring(a.ch,1,charindex('_',a.ch)),'_',''))),1)

select * from wuyan_ci_full