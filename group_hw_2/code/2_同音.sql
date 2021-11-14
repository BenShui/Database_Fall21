declare @str nvarchar(50)='不忘初心'  --当前成语
declare @ch nvarchar(1)='心'          --当前成语末尾词
declare @ch_py nvarchar(10) = 'xin'
declare @step int = 0,@n int = 11     --Step表示当前层数，@n表示总层数，即接龙次数
declare @test_1 int, @test_2 int, @test_3 int
                                      --@test_1表示当前成语末尾词在成语表中检索结果数=0表示无法接龙
                                      --@test_2表示测试@str是否已经在结果中出现过
									  --@test_3表示测试@str是否出现在#imp不可能表

if object_id('tempdb.dbo.#array') is not null  --判断临时表是否已经存在
   drop table #array
create table #array(step int primary key, cy_res nvarchar(50))--创建临时表，用于显示接龙结果

if object_id('tempdb.dbo.#imp') is not null  --判断临时表是否已经存在
   drop table #imp
create table #imp(cy_imp nvarchar(50) primary key)--创建不可能进行下去的词表

while @step<@n                        --开始循环
begin
    if @test_1 = 0 or @str is NULL    --如果@test_1仍然为0，说明上一个词有问题，没办法找到@test_1>0的下一个词了
	begin
	    if @test_3=0 and @str is not NULL
		    insert into #imp(cy_imp) values(@str)     --加入不可能表
		set @str = (select cy_res from #array where step=@step-1)
		if (select count(*) from #imp where cy_imp=@str)=0 and @str is not NULL
		    insert into #imp(cy_imp) values(@str)
		print @ch_py
		set @step = @step-2     --返回到两步之前
		set @str = (select cy_res from #array where step=@step)
		set @ch = substring(reverse(@str),patindex('%[吖-咗]%',reverse(@str)),1)
		delete from #array where step>@step   --删除中间的记录
	end
    else
	    insert into #array(step, cy_res) values(@step, @str) --将当前成语插入临时表
	declare cur  scroll cursor for                       --定义游标，寻找成语表中开头字等于当前结尾字的成语
	    select cy from idioms where substring(py,1,patindex('%[^a-z]%',py))=@ch_py
	open cur
	fetch first from cur into @str  --从第一条结果开始取，作为当前成语
	while @@FETCH_STATUS=0
	begin
	    set @ch = substring(reverse(@str),patindex('%[吖-咗]%',reverse(@str)),1)--更新当前结尾字
		set @ch_py = (select top 1 PYM from pinyin where HZ=@ch)
		select @test_1 = count(*) from idioms
		    where substring(py,1,patindex('%[^a-z]%',py))=@ch_py
		select @test_2 = count(*) from #array
		    where cy_res = @str
		select @test_3 = count(*) from #imp
		    where cy_imp = @str
		if @test_1>0 and  @test_2=0 and @test_3=0 and @str is not NULL--如果既未在临时表#array中出现，也满足在结尾字能在成语库中找到匹配的开头字，就退出游标
		    break
		else                           --反之，利用游标找到下一个成语作为当前成语，继续寻找
		    fetch next from cur into @str
	end
	close cur                          --关闭游标
    deallocate global cur              --释放游标
	set @step = @step + 1              --前进一层
end
select * from #array                   --显示结果
order by step                          --按照层数排序
drop table #array                      --删除临时表
select * from #imp                     --查看不可能表
drop table #imp                        --删除不可能表
