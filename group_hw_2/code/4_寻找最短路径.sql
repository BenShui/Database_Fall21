--���ݲ²⣬���·��Ӧ����4�����ڣ�����ֱ�Ӳ���ö�ٵ��㷨
--�ȼ����м�ֻ��һ���������ͷΪxin����βΪlao
select * from idioms
where trim(reverse(substring(reverse(py),1,patindex('%[^a-z]%',reverse(py)))))='lao' and substring(py,1,patindex('%[^a-z]%',py))='xin'
--���ֲ��޽�������ǳ��������ʣ�����һ���ʿ�ͷΪxin���ڶ����ʽ�βΪlao�����ҵ�һ���ʵĽ�β��ڶ����ʵĿ�ͷһ��
select a.cy, b.cy
from idioms a, idioms b
where substring(b.py,1,patindex('%[^a-z]%',b.py))=trim(reverse(substring(reverse(a.py),1,patindex('%[^a-z]%',reverse(a.py)))))
and b.py!='��' and substring(a.py,1,patindex('%[^a-z]%',a.py))='xin' and trim(reverse(substring(reverse(b.py),1,patindex('%[^a-z]%',reverse(b.py)))))='lao'