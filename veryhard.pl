
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/T654QK.pdf").

solution([[1983, "Natasha", "Neptunia Cruise", "Puerto Rico"],
[1984, "Paula", "Silver Shores Cruise", "Jamaica"],
[1985, "Greg", "Trinity Cruise", "Grenada"],
[1986, "Miranda", "Caprica Cruise", "Martinique"],
[1987, "Cory", "Baroness Cruise", "Barbados"],
[1988, "Andre", "Azure Seas Cruise", "Saint Lucia"]]).

solve(T) :-
	% TODO: Implement this to solve the puzzle
	T = [ [1983, N1, C1, D1],
	      [1984, N2, C2, D2],
	      [1985, N3, C3, D3],
	      [1986, N4, C4, D4],
	      [1987, N5, C5, D5],
	      [1988, N6, C6, D6]],
	permutation([N1, N2, N3, N4, N5, N6], ["Natasha", "Paula", "Greg", "Miranda", "Cory", "Andre"]),
	clue11(T),
	permutation([D1, D2, D3, D4, D5, D6], ["Puerto Rico", "Jamaica", "Grenada", "Martinique", "Barbados", "Saint Lucia"]),
	clue3(T),
	clue4(T),
	clue9(T),
	clue10(T),
	clue12(T),
	permutation([C1, C2, C3, C4, C5, C6], ["Neptunia Cruise", "Silver Shores Cruise", "Trinity Cruise", "Caprica Cruise", "Baroness Cruise", "Azure Seas Cruise"]),
	clue1(T),
	clue2(T),
	clue5(T),
	clue6(T),
	clue7(T),
	clue8(T), 
	true.

% Clue 1: The Traveler who took the 1984 cruise wasn't on the Caprica Cruise.
clue1(T) :-
 member([1984, _, C, _], T), C \= "Caprica Cruise".

 % Clue 2: Of the person who took the 1986 cruise and the person who took the Trinity cruise, one is Greg and the 
 % other went to Martinique
clue2(T) :-
 (   member([1986, "Greg", _, _], T), 
     member([ _, _, "Trinity Cruise", "Martinique"], T)) ;
 (   member([1986, _, _, "Martinique"], T), 
     member([ _, "Greg", "Trinity Cruise", _], T)).

 % Clue 3: Natasha is either the traveler who took the 1983 cruise or the traveler who went to Jamaica.
clue3(T) :-
 member([1983, "Natasha", _, _], T) ;
 member([ _, "Natasha", _, "Jamaica"], T).

% Clue 4: Paula went to Jamaica
clue4(T) :-
 member([ _, "Paula", _, "Jamaica"], T).

% Clue 5: The person who went to Puerto Rico wasn't on the Azure Seas cruise.
clue5(T) :-
 member([ _, _, C, "Puerto Rico"], T), C \= "Azure Seas Cruise".

% Clue 6: Of Cory and Greg, one was on the 1985 cruise and the other took the Baroness cruise.
clue6(T) :-
(   member([1985, "Greg", _, _], T), 
    member([ _, "Cory", "Baroness Cruise", _], T)) ;
(   member([1985, "Cory", _, _], T), 
    member([ _, "Greg", "Baroness Cruise", _], T)).

% Clue 7: The traveler who took the Azure Seas cruise set sail 2 years after the person who went to Martinique.
clue7(T) :-
 member([A1, _, "Azure Seas Cruise", _], T),
 member([A2, _, _, "Martinique"], T), 
 A1 =:= A2 + 2.

% Clue 8:  The person who took the 1983 cruise took the Neptunia cruise.
clue8(T) :-
 member([1983, _, "Neptunia Cruise", _], T).

 % Clue 9: The person who took the 1987 cruise went to Barbados.
clue9(T) :-
 member([1987, _, _, "Barbados"], T).


 % Clue 10: Andre set sail sometime after the person who took the Baroness cruise.
clue10(T) :-
 member([A1, "Andre", _, _], T), 
 member([A2, _, "Baroness Cruise", _], T), 
 A1 > A2.

 % Clue 11: Cory wasn't on the 1986 cruise.
clue11(T) :-
 member([C, "Cory", _, _], T), C \= 1986.
   

   % Clue 12: Paula set sail 1 year before the person who went to Grenada.
clue12(T) :-
 member([A1, "Paula", _, _], T), 
 member([A2, _, _, "Grenada"], T), 
 A1 =:= A2 - 1.





check :- 
	% Confirm that the correct solution is found
	solution(S), (solve(S); not(solve(S)), writeln("Fails Part 1: Does  not eliminate the correct solution"), fail),
	% Make sure S is the ONLY solution 
	not((solve(T), T\=S, writeln("Failed Part 2: Does not eliminate:"), print_table(T))),
	writeln("Found 1 solutions").

print_table([]).
print_table([H|T]) :- atom(H), format("~|~w~t~20+", H), print_table(T). 
print_table([H|T]) :- is_list(H), print_table(H), nl, print_table(T). 


% Show the time it takes to conform that there are no incorrect solutions
checktime :- time((not((solution(S), solve(T), T\=S)))).
