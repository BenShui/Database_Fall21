create function get_hanzi_num(@str nvarchar(200))
returns nvarchar(200)
as
begin
    declare @n int
	declare @res nvarchar(100)
    while patindex('%[߹-��]%',@str)>0
    begin
	if patindex('%[߹-��]%',@str)=1
	begin
	    set @res = concat(@res,ltrim(rtrim(cast(@n-1 as char))))
		set @n=0
	end
	set @n = patindex('%[^߹-��]%',@str)
	set @str = substring(@str,@n,len(@str))
	set @str = ltrim(substring(@str,patindex('%[߹-��]%',@str),len(@str)))
    end
    set @res = concat(@res,ltrim(rtrim(cast(@n-1 as char))))
	return @res
end