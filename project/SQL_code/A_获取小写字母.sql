create function get_letter (@str nvarchar(200))
returns nvarchar(200)
as
begin
    while patindex('%[^a-z ]%',@str)>0
	begin
        set @str = stuff(@str, patindex('%[^a-z ]%',@str), 1,'')
	end
	return @str
end

--print dbo.get_letter('¹ş¹şa bc123')