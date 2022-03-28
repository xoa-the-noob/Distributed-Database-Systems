create or replace view myview as
select S.id, S.name, S.taka
from money S;

select * from myview;

commit;
