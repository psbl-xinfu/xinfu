select 
DISTINCT list_id
list_id,
list_text,
score.term_score
from 
t_term_score  score
right join t_term_type_score type on score.tuid=type.score_term_id
right join t_term_item_score item on  item.score_type_id=type.tuid
right join t_term_list_score list  on  list.score_item_id=item.tuid
where
score.tuid=${fld:tuid}