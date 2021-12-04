declare @temp nvarchar(30),@num nvarchar(6),@ty nvarchar(10)
declare @str nvarchar(2),@s nvarchar(10),@res_tmp nvarchar(200)=' '
declare @i int=0, @n int, @step int = 1, @head nvarchar(200)='不忘初心'
declare @yunjiao nvarchar(10),@res nvarchar(200)=''
while @step<=len(@head)
begin
    select @res_tmp = ''
	select top 1 @res_tmp = ci from wuyan_ci_full
    where substring(ci,1,1)=substring(@head,@step,1) and cixing='n' and len(ltrim(rtrim(ci)))=2
    and cnt>1
	order by NEWID()
    set @res_tmp = @res_tmp+(select top 1 ci from wuyan_ci_full
    where cixing='v' and len(ltrim(rtrim(ci)))=1 and cnt>1
    order by NEWID())
	if @step=1
	begin
	    set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
        where cixing='n' and len(ltrim(rtrim(ci)))=2 and cnt>1
        order by NEWID())
	    select @yunjiao=substring(reverse(rtrim(py)),patindex('%[aeiou]%',reverse(rtrim(py))),1) from xhzd where zi=substring(rtrim(@res_tmp),len(rtrim(@res_tmp)),1)
	end
    else
	begin
	    set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
        where cixing='n' and len(ltrim(rtrim(ci)))=2 and py=@yunjiao and cnt>1
        order by NEWID())
	end
	if len(rtrim(ltrim(@res_tmp)))<5
	begin
	    select @res_tmp = ''
	    select top 1 @res_tmp = ci from wuyan_ci_full
        where substring(ci,1,1)=substring(@head,@step,1) and cixing='n' and len(ltrim(rtrim(ci)))=1
        and cnt>1
	    order by NEWID()
        set @res_tmp = @res_tmp+(select top 1 ci from wuyan_ci_full
            where cixing='v' and len(ltrim(rtrim(ci)))=2 and cnt>2
            order by NEWID())
	    if @step=1
	    begin
	        set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
            where cixing='n' and len(ltrim(rtrim(ci)))=2 and cnt>2
            order by NEWID())
	        select @yunjiao=substring(reverse(rtrim(py)),patindex('%[aeiou]%',reverse(rtrim(py))),1) from xhzd where zi=substring(rtrim(@res_tmp),len(rtrim(@res_tmp)),1)
	    end
        else
	    begin
	        set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
            where cixing='n' and len(ltrim(rtrim(ci)))=2 and py=@yunjiao and cnt>2
            order by NEWID())
	    end
	end
    set @res = concat(@res,' '+@res_tmp)
	set @step = @step+1
end
print @res

--生成存储过程
create proc wuyan_cangtou (
    @head nvarchar(100)
)
as
begin
	declare @temp nvarchar(30),@num nvarchar(6),@ty nvarchar(10)
	declare @str nvarchar(2),@s nvarchar(10),@res_tmp nvarchar(200)=' '
	declare @i int=0, @n int, @step int = 1
	declare @yunjiao nvarchar(10),@res nvarchar(200)
	set @res = ''
	while @step<=len(@head)
	begin
		select @res_tmp = ''
		select top 1 @res_tmp = ci from wuyan_ci_full
		where substring(ci,1,1)=substring(@head,@step,1) and cixing='n' and len(ltrim(rtrim(ci)))=2
		and cnt>1
		order by NEWID()
		set @res_tmp = @res_tmp+(select top 1 ci from wuyan_ci_full
		where cixing='v' and len(ltrim(rtrim(ci)))=1 and cnt>1
		order by NEWID())
		if @step=1
		begin
			set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
			where cixing='n' and len(ltrim(rtrim(ci)))=2 and cnt>1
			order by NEWID())
			select @yunjiao=substring(reverse(rtrim(py)),patindex('%[aeiou]%',reverse(rtrim(py))),1) from xhzd where zi=substring(rtrim(@res_tmp),len(rtrim(@res_tmp)),1)
		end
		else
		begin
			set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
			where cixing='n' and len(ltrim(rtrim(ci)))=2 and py=@yunjiao and cnt>1
			order by NEWID())
		end
		if len(rtrim(ltrim(@res_tmp)))<5
		begin
			select @res_tmp = ''
			select top 1 @res_tmp = ci from wuyan_ci_full
			where substring(ci,1,1)=substring(@head,@step,1) and cixing='n' and len(ltrim(rtrim(ci)))=1
			and cnt>1
			order by NEWID()
			set @res_tmp = @res_tmp+(select top 1 ci from wuyan_ci_full
				where cixing='v' and len(ltrim(rtrim(ci)))=2 and cnt>2
				order by NEWID())
			if @step=1
			begin
				set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
				where cixing='n' and len(ltrim(rtrim(ci)))=2 and cnt>2
				order by NEWID())
				select @yunjiao=substring(reverse(rtrim(py)),patindex('%[aeiou]%',reverse(rtrim(py))),1) from xhzd where zi=substring(rtrim(@res_tmp),len(rtrim(@res_tmp)),1)
			end
			else
			begin
				set @res_tmp = @res_tmp +(select top 1 ci from wuyan_ci_full
				where cixing='n' and len(ltrim(rtrim(ci)))=2 and py=@yunjiao and cnt>2
				order by NEWID())
			end
		end
		set @res = concat(@res,' '+@res_tmp)
		set @step = @step+1
	end
	select @res
end

--调用
--declare @head nvarchar(10)='不忘初心'
--exec wuyan_cangtou @head