declare @temp nvarchar(30),@num nvarchar(6),@ty nvarchar(10)
declare @str nvarchar(2),@s nvarchar(10)=' ',@res nvarchar(200)=' '
declare @i int=0, @n int, @step int = 1, @m int=4, @yunjiao nvarchar(100)
while @step<=@m
begin
    select @res = ' ',@i=0
    select top 1 @temp = ch from wuyan_muban
    where cnt>20
    order by NEWID()
    set @num = substring(@temp,patindex('%[0-9]%',@temp),len(@temp))
	set @num = replace(replace(@num,'_',''),'-','')
    set @ty = substring(@temp, 1, patindex('%[0-9]%',@temp)-1)
    declare cur scroll cursor for
        select value from string_split(@ty, ' ')
    open cur
    fetch first from cur into @str
    while @@FETCH_STATUS=0
    begin
        set @i = @i+1
	    set @n = cast(substring(@num,@i,1) as int)
		if @i=len(rtrim(ltrim(@num))) and @step>1
		begin
		    select top 1 @s=ci from wuyan_ci_full
	        where cixing=@str and len(rtrim(ltrim(ci)))=@n
			and cnt>100 and py=@yunjiao
		    order by NEWID()
			if len(ltrim(rtrim(@s)))<>@n
		    begin
		    select top 1 @s=ci from wuyan_ci_full
	        where cixing=@str and len(rtrim(ltrim(ci)))=@n
			and cnt>1 and py=@yunjiao
		    order by NEWID()
		    end
		end
		else
		begin
	        select top 1 @s=ci from wuyan_ci_full
	        where cixing=@str and len(rtrim(ltrim(ci)))=@n
			and cnt>100
		    order by NEWID()
			if len(ltrim(rtrim(@s)))<>@n
		    begin
		    select top 1 @s=ci from wuyan_ci_full
	        where cixing=@str and len(rtrim(ltrim(ci)))=@n
			and cnt>1
		    order by NEWID()
		    end
		end
 	    set @res=concat(@res,@s)
	    fetch next from cur into @str
    end
    close cur 
	deallocate global cur
	if len(ltrim(rtrim(@res)))=5
	begin
	    if @step=1
		begin
		    select @yunjiao=substring(reverse(rtrim(py)),patindex('%[aeiou]%',reverse(rtrim(py))),1) from xhzd where zi=substring(rtrim(@res),len(rtrim(@res)),1)
		end
        print ltrim(@res)
	    set @step = @step+1
	end
end
--创建存储过程
create proc wuyan_suiji(
    @m int
)
as
begin
    declare @temp nvarchar(30),@num nvarchar(6),@ty nvarchar(10)
    declare @str nvarchar(2),@s nvarchar(10)=' ',@res nvarchar(200)=' '
    declare @i int=0, @n int, @step int = 1, @res_out nvarchar(400)='', @yunjiao nvarchar(100)
    while @step<=@m
    begin
        select @res = ' ',@i=0
        select top 1 @temp = ch from wuyan_muban
            where cnt>20
            order by NEWID()
        set @num = substring(@temp,patindex('%[0-9]%',@temp),len(@temp))
	    set @num = replace(replace(@num,'_',''),'-','')
        set @ty = substring(@temp, 1, patindex('%[0-9]%',@temp)-1)
        declare cur scroll cursor for
            select value from string_split(@ty, ' ')
        open cur
        fetch first from cur into @str
        while @@FETCH_STATUS=0
        begin
            set @i = @i+1
	        set @n = cast(substring(@num,@i,1) as int)
			if @i=len(rtrim(ltrim(@num))) and @step>1
		    begin
		        select top 1 @s=ci from wuyan_ci_full
	            where cixing=@str and len(rtrim(ltrim(ci)))=@n
			    and cnt>100 and py=@yunjiao
		        order by NEWID()
			    if len(ltrim(rtrim(@s)))<>@n
		        begin
		            select top 1 @s=ci from wuyan_ci_full
	                where cixing=@str and len(rtrim(ltrim(ci)))=@n
			        and cnt>1 and py=@yunjiao
		            order by NEWID()
		        end
		    end
	        else
		    begin
	            select top 1 @s=ci from wuyan_ci_full
	            where cixing=@str and len(rtrim(ltrim(ci)))=@n
			    and cnt>100
		        order by NEWID()
			    if len(ltrim(rtrim(@s)))<>@n
		        begin
		            select top 1 @s=ci from wuyan_ci_full
	                where cixing=@str and len(rtrim(ltrim(ci)))=@n
			        and cnt>1
		            order by NEWID()
		        end
		    end
 	        set @res=concat(@res,@s)
	        fetch next from cur into @str
        end
        close cur 
	    deallocate global cur
	    if len(ltrim(rtrim(@res)))=5
	    begin
		    if @step=1
			begin
			    select @yunjiao=substring(reverse(rtrim(py)),patindex('%[aeiou]%',reverse(rtrim(py))),1) from xhzd where zi=substring(rtrim(@res),len(rtrim(@res)),1)
			end
            set @res_out=concat(@res_out,@res)
	        set @step = @step+1
	    end
    end
	select @res_out
end

--调用存储过程
declare @m int = 4
exec wuyan_suiji @m
