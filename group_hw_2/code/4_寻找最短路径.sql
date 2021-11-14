--根据猜测，最短路径应该在4个以内，我们直接采用枚举的算法
--先假设中间只有一个成语，即开头为xin，结尾为lao
select * from idioms
where trim(reverse(substring(reverse(py),1,patindex('%[^a-z]%',reverse(py)))))='lao' and substring(py,1,patindex('%[^a-z]%',py))='xin'
--发现并无结果，于是尝试两个词，即第一个词开头为xin，第二个词结尾为lao，并且第一个词的结尾与第二个词的开头一致
select a.cy, b.cy
from idioms a, idioms b
where substring(b.py,1,patindex('%[^a-z]%',b.py))=trim(reverse(substring(reverse(a.py),1,patindex('%[^a-z]%',reverse(a.py)))))
and b.py!='无' and substring(a.py,1,patindex('%[^a-z]%',a.py))='xin' and trim(reverse(substring(reverse(b.py),1,patindex('%[^a-z]%',reverse(b.py)))))='lao'