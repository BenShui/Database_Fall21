select distinct( cyk.cy), a.bihua f, b.bihua c,c.bihua t,d.bihua f from XHZD a,XHZD b, XHZD c ,XHZD d,cyk
where left(RTRIM(cyk.cy),1)=a.zi 
	and SUBSTRING(cyk.cy,2,1)=b.zi 
	and SUBSTRING(cyk.cy,3,1)=c.zi 
	and SUBSTRING(cyk.cy,4,1)=d.zi 
	and a.bihua=b.bihua	
	and b.bihua=c.bihua
	and c.bihua=d.bihua
	