declare @str nvarchar(50)='��������'  --��ǰ����
declare @ch nvarchar(1)='��'          --��ǰ����ĩβ��
declare @ch_py nvarchar(10) = 'xin'
declare @step int = 0,@n int = 11     --Step��ʾ��ǰ������@n��ʾ�ܲ���������������
declare @test_1 int, @test_2 int, @test_3 int
                                      --@test_1��ʾ��ǰ����ĩβ���ڳ�����м��������=0��ʾ�޷�����
                                      --@test_2��ʾ����@str�Ƿ��Ѿ��ڽ���г��ֹ�
									  --@test_3��ʾ����@str�Ƿ������#imp�����ܱ�

if object_id('tempdb.dbo.#array') is not null  --�ж���ʱ���Ƿ��Ѿ�����
   drop table #array
create table #array(step int primary key, cy_res nvarchar(50))--������ʱ��������ʾ�������

if object_id('tempdb.dbo.#imp') is not null  --�ж���ʱ���Ƿ��Ѿ�����
   drop table #imp
create table #imp(cy_imp nvarchar(50) primary key)--���������ܽ�����ȥ�Ĵʱ�

while @step<@n                        --��ʼѭ��
begin
    if @test_1 = 0 or @str is NULL    --���@test_1��ȻΪ0��˵����һ���������⣬û�취�ҵ�@test_1>0����һ������
	begin
	    if @test_3=0 and @str is not NULL
		    insert into #imp(cy_imp) values(@str)     --���벻���ܱ�
		set @str = (select cy_res from #array where step=@step-1)
		if (select count(*) from #imp where cy_imp=@str)=0 and @str is not NULL
		    insert into #imp(cy_imp) values(@str)
		print @ch_py
		set @step = @step-2     --���ص�����֮ǰ
		set @str = (select cy_res from #array where step=@step)
		set @ch = substring(reverse(@str),patindex('%[߹-��]%',reverse(@str)),1)
		delete from #array where step>@step   --ɾ���м�ļ�¼
	end
    else
	    insert into #array(step, cy_res) values(@step, @str) --����ǰ���������ʱ��
	declare cur  scroll cursor for                       --�����α꣬Ѱ�ҳ�����п�ͷ�ֵ��ڵ�ǰ��β�ֵĳ���
	    select cy from idioms where substring(py,1,patindex('%[^a-z]%',py))=@ch_py
	open cur
	fetch first from cur into @str  --�ӵ�һ�������ʼȡ����Ϊ��ǰ����
	while @@FETCH_STATUS=0
	begin
	    set @ch = substring(reverse(@str),patindex('%[߹-��]%',reverse(@str)),1)--���µ�ǰ��β��
		set @ch_py = (select top 1 PYM from pinyin where HZ=@ch)
		select @test_1 = count(*) from idioms
		    where substring(py,1,patindex('%[^a-z]%',py))=@ch_py
		select @test_2 = count(*) from #array
		    where cy_res = @str
		select @test_3 = count(*) from #imp
		    where cy_imp = @str
		if @test_1>0 and  @test_2=0 and @test_3=0 and @str is not NULL--�����δ����ʱ��#array�г��֣�Ҳ�����ڽ�β�����ڳ�������ҵ�ƥ��Ŀ�ͷ�֣����˳��α�
		    break
		else                           --��֮�������α��ҵ���һ��������Ϊ��ǰ�������Ѱ��
		    fetch next from cur into @str
	end
	close cur                          --�ر��α�
    deallocate global cur              --�ͷ��α�
	set @step = @step + 1              --ǰ��һ��
end
select * from #array                   --��ʾ���
order by step                          --���ղ�������
drop table #array                      --ɾ����ʱ��
select * from #imp                     --�鿴�����ܱ�
drop table #imp                        --ɾ�������ܱ�
