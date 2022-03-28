create or replace view myview(view_A, view_B, view_C) as
select S.id, S.name, S.taka
from money S;

select * from myview;

commit;
