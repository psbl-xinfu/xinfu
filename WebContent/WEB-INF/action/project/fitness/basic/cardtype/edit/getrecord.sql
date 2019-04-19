select	
c.code,
c.name,
c.type,
c.giveday,
c.remark,
c.ptcount,
c.scale*100 as scale,
c.bgcolor,
c.cardcategory,
 f.cardfee::NUMERIC(18,2),
 f.minfee::NUMERIC(18,2),
 count,
 daycount,
 moneyleft::NUMERIC(18,2), --zzn 储值金额

 mealdiscount*100 as mealdiscount,
 drinkdiscount*100 as drinkdiscount,
 jsdiscount*100 as jsdiscount,
 swimdiscount*100 as swimdiscount,
 singlediscount*100 as singlediscount,
 classdiscount*100 as classdiscount,
 scaletype,
 (select union_id from cc_cardcategory g where c.cardcategory=g.code and g.org_id=${def:org}) as union_id,
	c.maxusernum,
	c.opencarddeadline
from cc_cardtype c
left join  cc_cardtype_fee  f on  c.code=f.cardtype and  f.org_id=${def:org}
where
c.code = ${fld:id}  and c.org_id=${def:org}
