create view wuyan as
select * from shige_full
where contents like '[ß¹-×ù][ß¹-×ù][ß¹-×ù][ß¹-×ù][ß¹-×ù][£¬¡£]%'

create view qiyan as
select * from shige_full
where contents like '[ß¹-×ù][ß¹-×ù][ß¹-×ù][ß¹-×ù][ß¹-×ù][£¬¡£]%'