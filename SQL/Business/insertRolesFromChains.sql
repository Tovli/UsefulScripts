set identity_insert roles on
insert into roles (roleid, rolename)
select chainid as roleid, chainName as rolename
from chains
where chainid not in (select roleid from roles)
and chainid in (100012,300053,300121,300057,100020,100008,300251,300071,300224,100015,90000,300105,100012,100016,300182,300183,300741,300224,100015,300105,100010,300224,300495,100041,100020,100016)
union
select chaingroupid as roleid, chaingroupName as rolename
from chaingroups
where chaingroupid not in (select roleid from roles)
and chaingroupid in (100012,300053,300121,300057,100020,100008,300251,300071,300224,100015,90000,300105,100012,100016,300182,300183,300741,300224,100015,300105,100010,300224,300495,100041,100020,100016)
set identity_insert roles off


insert into rolechains (roleid, chainid)
select roleid, chainid
from chains c, roles r
where chainid not in (select chainid from rolechains where roleid = r.roleid)
and (c.chainid = r.roleid or c.chainGroupid = r.roleid)
and roleid not in (100005,
100010,
100023,
100055,
300733)
and chainid > 40