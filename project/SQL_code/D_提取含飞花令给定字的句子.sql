create function process_feihualing(@str nvarchar(200), @a nvarchar(10))
returns nvarchar(100)
as
begin
    declare @res nvarchar(100), @i int, @j int, @k int
	set @i = patindex('%'+@a+'%',@str)
	if patindex('%¡£%',reverse(substring(@str,1,@i)))=0
	begin
	    set @j = 1
	end
	else
	begin
	    set @j = 2+@i-patindex('%¡£%',reverse(substring(@str,1,@i)))
	end
	set @k = @i+patindex('%[¡£.]%',substring(@str,@i,len(@str)))-1
	return substring(@str,@j,@k-@j+1)
end

select top 10 *,dbo.process_feihualing(contents,'´º') from shige_full
where contents like '%´º%'