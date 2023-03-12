
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/I559QK.pdf").


solution([[350, "Christian", "Cooking", "A Single Kiss"],
[710, "Julius", "Photography", "Sad to See You"],
[1300, "Cash", "Astronomy", "All By Myself"],
[2060, "Katie", "Reading", "Moon River"],
[2080, "Jaylin", "Bird Watching", "One More Time"]]).

solve(T) :-
	T = [ [350, N1, H1, S1],
                 [710, N2, H2, S2],
	           [1300, N3, H3, S3],
	            [2060, N4, H4, S4],
	           [2080, N5, H5, S5] ],
           permutation([N1, N2, N3, N4, N5], ["Christian", "Julius", "Cash", "Katie", "Jaylin"]),
    permutation([H1, H2, H3, H4, H5], ["Cooking", "Photography", "Astronomy", "Reading", "Bird Watching"]),
    permutation([S1, S2, S3, S4, S5], ["A Single Kiss", "Sad to See You", "All By Myself", "Moon River", "One More Time"]),
    clue1(T),
    clue2(T),
    clue3(T),
    clue4(T),
    clue5(T),
    clue6(T),
    clue7(T),
    clue8(T),
    clue9(T),
    clue10(T),
    clue11(T),    
	true.


% 1. The 5 people were the singer known for Moon River, the person who enjoys Photography, the one who recieved the 
% % $2080 reward, Cash, and the singer known for A Single Kiss
 clue1(T) :- 
member([A1, _, _, "Moon River"], T),
member([A2, _, "Photography", _], T), 
member([2080, _, _, _], T), 
member([A3, "Cash", _, _], T), 
member([A4, _, _, "A Single Kiss"], T),
A1 \= A2, A1 \= 2080, A1 \= A3, A1 \= A4, 
A2 \= 2080, A2 \= A3, A2 \= A4,
A3 \= 2080, A3 \= A4,
A4 \= 2080.

%2. The one who revcieved the $1300 reward doesn't sing Sad to See You.
clue2(T) :-
member([1300, _, _, C], T), C \= "Sad to See You".

%3. Of Katie and Julius, one earned the $2060 reward and the other is famous for the song Sad to See You
%% 	Might need to write C, V for C not being Sad to See You and V being not 2060
clue3(T) :-
(   member([2060, "Katie", _, _], T), 
member([_, "Julius", _, "Sad to See You"], T)) ;
(   member([2060, "Julius", _, _], T),
member([_, "Katie", _, "Sad to See You"], T)). 

%4. The singer known for Moon River recieved a larger reward than Julius
clue4(T) :-
member([A1, _, _, "Moon River"], T),
member([A2, "Julius", _, _], T), 
A1 > A2.

%5. The person who enjoys astronomy was rewarded less than the singer known for Moon River
clue5(T) :-
	member([A1, _, _, "Moon River"], T),
	member([A2, _, "Astronomy", _], T), 
	A1 > A2.

%6. The singer known for One More Time does not enjoy astronomy.
clue6(T) :-
member([_, _, C, "One More Time"], T), C \= "Astronomy".

%7. Christian was rewarded less than the person who enjoys photography.
clue7(T) :-
member([A1, "Christian", _, _], T),
member([A2, _, "Photography", _], T), 
A1 < A2. 

%8. Either the singer known for A Single Kiss or the singer known for All By Myself enjoys cooking
clue8(T) :-
member([_, _, "Cooking", "A Single Kiss"], T) ;
member([_, _, "Cooking", "All By Myself"], T).

%9. The singer known for All By Myself does not enjoy cooking. 
clue9(T) :-
member([_, _, C, "All By Myself"], T), C \= "Cooking".

%10. The one who received the $350 reward is famous for the song A Single Kiss
clue10(T) :-
member([350, _, _, "A Single Kiss"], T).

%11. The person who enjoys bird watching is Jaylin. 
clue11(T) :-
member([_, "Jaylin", "Bird Watching", _], T).

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
