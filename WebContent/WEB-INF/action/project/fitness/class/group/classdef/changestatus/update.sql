update cc_classdef
set status= ${fld:status}
where code in (select regexp_split_to_table(${fld:code},',') from dual)
and org_id = ${def:org}
