program life;

{Casey Astiz
 CS313
 life.p}


uses crt;

const
   size	=  38;

type
   board = array[1..size, 1..size] of integer; 


	  
var z,g	: integer;
procedure drawboard(var tobedrawn : board); {this procedure takes in a board array and prints it out}
  begin
      for g:=1 to size do
      begin
	 for z:=1 to size do
	    begin
	    if tobedrawn[z,g] = 1 then
	       begin
		  write('# ');
	       end
	    else
	       begin
	       write('. ');
	       end;
	    end;
	 writeln();
      end
      
   end;



var new         : board; {local variables}
var i,c, count	: integer;
procedure updateboard(var old : board); {this procedure takes in the old board and sets old to the new board}
begin
   
   for i:= 1 to size do
   begin
      for c:= 1 to size do
      begin
	 count := 0;
	 count := count + old[(i+size-1) mod size, c];
	 count := count + old[(i+1) mod size, c];
	 count := count + old[i, (c+size-1) mod size];
	 count := count + old[i, (c+1) mod size];
	 count := count + old[(i+size-1) mod size, (c+size-1) mod size];
	 count := count + old[(i+size-1) mod size, (c+1) mod size];
	 count := count + old[(i+1) mod size, (c+size-1) mod size];
	 count := count + old[(i+1) mod size, (c+1) mod size];
	 if old[i,c] = 1 then
	 begin
	    if count = 2 then
	       new[i,c] := 1;
	    if count = 3 then
	       begin
	       new[i,c] := 1;
	       end
	    else
	       new[i,c] := 0;
	 end
	 else
	 begin
	    if count = 3 then
	       begin
	       new[i,c] := 1;
	       end
	    else
	       new[i,c] := 0;
	 end;
      end;
   end;
   
   old:= new;
   
end;


var s,f : integer;
procedure generations(var old : board; start: integer); {This procedure produces the generations and asks for user input}
begin
   writeln('How many iterations (0 to end)? ');
   read(s);
   for f:=1 to s do
   begin
      gotoxy(1,1);
      writeln('Game Of Life (38x38) -- Generation ', f+start, ': ');
      updateboard(old);
      drawboard(old);
   end;
   generations(old, s);
end;



{ main program -------------------- }
var
   oldboard : board;
   r,l    : integer;
   alive    : integer;
begin
   ClrScr;
   GotoXY(1, 1);
   randomize;
   for r:= 1 to size do
      begin
	 for l:=1 to size do
  	    begin
	       alive := random(2);
	       oldboard[r,l] := alive;
	    end
      end;
   writeln('Game Of Life (38x38) -- Generation 0: ');
   drawboard(oldboard);
   generations(oldboard, 0);
end.
