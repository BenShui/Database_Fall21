select * into shige_full
from (select * from song 
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%'
union
select * from tang
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%'
union
select * from han
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%'
union
select * from nanbei
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%'
union
select * from sui
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%'
union
select * from weijin
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%'
union
select * from yuan
where contents not like '%¡õ%' 
and ttitle not like '%¡õ%'
and contents not like '%?%'
and ttitle not like '%?%') a