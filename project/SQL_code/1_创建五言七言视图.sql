create view wuyan as
select * from shige_full
where contents like '[߹-��][߹-��][߹-��][߹-��][߹-��][����]%'

create view qiyan as
select * from shige_full
where contents like '[߹-��][߹-��][߹-��][߹-��][߹-��][����]%'