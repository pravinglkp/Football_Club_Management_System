

create or replace trigger useridupdate

	after update of user_id on users
	for each row
	begin

	update players
	set user_id = :new.user_id
	where user_id= :old.user_id;

	update managers
	set user_id = :new.user_id
	where user_id = :old.user_id;
	
	end;

---------------------------------------
update users
set user_id='U#01'
where user_id='U#23';



create or replace trigger pointtable

after insert or update of total_matches_played on clubs

begin
    update clubs
    set points=win * 3+draw;
    
end;

---------------------------------------------------------------
update clubs
set total_matches_played =(total_matches_played+1),win =(win+1)
where club_id='IM#24';

---------------------------------------------------------------

create or replace trigger tranining_schedule

	before delete on trainings
    for each row
    begin
    
    	delete from training_for
    	where training_id= :old.training_id;
    end;

--------------------------------------------
delete from trainings
where training_id='T#11';

----------------------------------------

commit;