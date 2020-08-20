INSERT INTO cc_guest_log(
 code ,
  guestcode  ,
  officename  ,
  guestnum ,
  customtype ,
  possibility  ,
  communication  ,
  custclass ,
  channel ,
  othertel ,
  thepublic ,
	email ,
	province2 ,
	city2 ,
	remark ,
	
	
	yofficename ,
  yguestnum ,
  ycustomtype  ,
  ypossibility ,
  ycommunication ,
  ycustclass ,
  ychannel ,
  yothertel ,
  ythepublic ,
	yemail ,
	yprovince2 ,
	ycity2 ,
	
	yremark ,
	createdby ,--创建人
	created )
select NEXTVAL('seq_cc_guest_log'),
	code  ,
  officename  ,
  guestnum ,
  customtype ,
  possibility  ,
  communication  ,
  custclass ,
  channel ,
  othertel ,
  thepublic ,
	email ,
	province2 ,
	city2 ,
	remark ,
	
	${fld:company} ,
  	${fld:guestnumall} ,
  ${fld:cc_birthall}  ,
  ${fld:possibility4} ,
  ${fld:communicationall} ,
  ${fld:custcation} ,
  ${fld:cc_channelall} ,
  ${fld:cc_officetel} ,
  ${fld:thepublicall} ,
	${fld:cc_email} ,
	${fld:province2} ,
	${fld:city2} ,
	${fld:cc_remark} ,
    '${def:user}',
	{ts '${def:timestamp}'}
from cc_guest where code=${fld:cc_code}