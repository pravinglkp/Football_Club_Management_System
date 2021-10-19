--1


delete from bid
where bid_id='B#01';


--2

delete from trainings
where training_id='T#03';



--3


update clubs set mgr_id='SM07M' where club_id='RM#46';
update trainings set mgr_id='SM07M' where mgr_id='ZZ01M';


delete from managers 
where mgr_id='ZZ01M';

delete from managers 
where mgr_id in (
    select mgr_id from clubs 
    where club_id='RM#46'
    );


--4

delete from players 
where player_id='P#04';


-----------------------------------

--Modification
--1

update users set status='Banned'
where user_id =(select user_id from players
                where player_id='P#23');

--2

alter session set nls_timestamp_format='HH12:Mi AM';            

update trainings
set tdate= TO_DATE('21/01/2020', 'DD/MM/YYYY'),ttime=to_timestamp('05:00 AM')
where training_id='T#11';


--3

update clubs
set total_matches_played =(total_matches_played+1),win =(win+1)
where club_id='IM#24';


--4

update bid
set amount='U160 M'
where bid_id='B#21';


---------------------------------------



--1

select name,nationality,skill_star,position,nvl(bid_amount,'not bid by any club') from users right outer join players 
on users.user_id=players.user_id;

--2

select club_name,nullif(win,0),nullif(lose,0),nullif(draw,0),nullif(goals,0),nullif(trophies,0) from clubs;

--3

select club_name,points from clubs order by points desc;

--4

select name,experience from users natural join managers
where mgr_id in (select mgr_id from clubs
                where club_id='MC#13');

select name,experience from users,managers,clubs
where club.club_id='MC#13' and club.mgr_id=managers.mgr_id and users.user_id=managers.user_id;

--5
select name,'Manager' as Role from users natural join managers
where mgr_id in (select mgr_id from clubs
                where club_id='MC#13');
union
select name,'Player' as Role from users natural join managers
where club_id='MC#13';
--6

select player_id,rating,skill_star from players
where player_id='P#23';

--7

select trainings.training_id,trainings.tdate,trainings.ttime,count(training_for.player_id) from trainings, training_for 
where trainings.training_id=training_for.training_id
group by tr.training_id;


select training_id,count(player_id)
from training_for
group by training_id
having count(player_id)<2;

--8

select club_name,goals,trophies from clubs 
where exists (
    select mgr_id from managers
    where managers.mgr_id=clubs.mgr_id and club_id='IM#24'
);




select mgr_id from managers
where exist (
    select club_id from club
    where clubs.mgr_id =managers.mgr_id
)