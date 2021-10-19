

-----------------------------------------------------------------------------------------------
---------------------------------------------Function------------------------------------------
-----------------------------------------------------------------------------------------------
create or replace function managerofaclub(clb clubs.club_id%type) return users.name%type is
	cursor	mgr_det	is  select users.name from users,clubs,managers 
	                    where clubs.club_id=clb and clubs.mgr_id=managers.mgr_id 
                        and managers.user_id=users.user_id;
	mgr_rec mgr_det%rowtype;
	
    begin
		open mgr_det;
		fetch mgr_det into mgr_rec;
		return mgr_rec.name;
	end;

variable mgrname varchar2;

exec :mgrname:=managerofaclub('LV#72');

print mgrname;


------------------------------------------------------------------------------------------------

set serveroutput on;


create or replace function players_status(plr_id players.player_id%type) return users.status%type is
	cursor      plyr_crs is select player_id,status 
                            from players,users
				            where players.user_id=users.user_id;
	plyr_rec	plyr_crs%rowtype;
	
    begin
		open plyr_crs;
		loop
			fetch plyr_crs into plyr_rec;
			exit when plyr_crs%notfound;
			if plr_id=plyr_rec.player_id then
				return plyr_rec.status;
			end if;
		end loop;
		close plyr_crs;
	end;



variable status_var varchar2;

exec :status_var:= players_status('P#23');

print status_var;

---------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------
--------------------------------------------Procedure------------------------------------------
-----------------------------------------------------------------------------------------------


set serveroutput on;

create or replace procedure loginacc(id users.user_id%type,pwd users.password%type) is
	cursor 		user_det is select user_id,password from users;
	user_rec	user_det%rowtype;
	datanotfound number := 0;
	
    begin
		open user_det;
		loop
			fetch user_det into user_rec;
            exit when user_det%notfound;
			if id=user_rec.user_id then
				datanotfound:=1;
				if pwd=user_rec.password then
					dbms_output.put_line('Welcome '||id||' You are successfully logged in');
				else
					dbms_output.put_line('Invalid User id or password');
				end if;
            end if;
		end loop;
        if datanotfound=0 then
				dbms_output.put_line('No such user found');
		end if;
        close user_det;
	end;





exec loginacc('U#23','password1');


-----------------------------------------------------------------------------------------------


create or replace procedure playersofclub (clb clubs.club_id%type) is
	cursor  plr_crs	is  select name from players,users
					    where players.club_id=clb and players.user_id=users.user_id;
	plr_rec	plr_crs%rowtype;

	begin
		open plr_crs;
		dbms_output.put_line('Players of club '||clb||' are :');
		loop	
			fetch plr_crs into plr_rec;
			exit when plr_crs%notfound;
			dbms_output.put_line(plr_rec.name);
		end loop;
        close plr_crs;
    end;


exec playersofclub('RM#46');


-----------------------------------------------------------------------------------------------
commit;