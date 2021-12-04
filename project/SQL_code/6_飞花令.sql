create proc feihualing(
    @ling nvarchar(10)
)
as 
begin
    select top 1 *, dbo.process_feihualing(contents,'%'+@ling+'%') juzi
    from shige_full
    where patindex('%'+@ling+'%',contents)>0
    order by NEWID()
end


