select taka from money
where id = (select id
from money
where name = 'A');