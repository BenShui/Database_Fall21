declare @str nvarchar(200)

if object_id('tempdb.dbo.#array') is not null  --�ж���ʱ���Ƿ��Ѿ�����
   drop table #array
create table #array(ch nvarchar(20))

--ȫ���ĳ�qiyan���ɴ������ԵĴ�Ƶ��
declare cur scroll cursor for 
    select fenci from wuyan_fenci
open cur
fetch first from cur into @str
while @@FETCH_STATUS = 0
begin
    insert into #array(ch) select ltrim(dbo.get_letter(value))+ltrim(dbo.get_hanzi_num(value)) from 
    string_split(replace(replace(@str,'��','��'),'_w',''),'��')
	fetch next from cur into @str
end
close cur
deallocate cur

select ch, count(*) cnt into wuyan_muban
from #array
where ch is not null and ch<>' '
group by ch 
order by cnt desc
update wuyan_muban set ch=replace(ch,'0','')
drop table #array