
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/W150IW.pdf").

%                       FirstNames   Teachers         Wood
solution([['Third',	     'Ella',     'Mrs. Rocek',    'Yew'       ],       
          ['Fourth',     'Ricky',    'Mrs. Smith',    'Poplar'    ],    
          ['Sixth',      'Diana',    'Mr. Ackerman',  'Brazilwood'],
          ['Fifteenth',  'Myles',    'Mr. Mockel',    'Cherrywood']]).

firstnames(['Ella', 'Ricky', 'Diana', 'Myles']).
teachers(['Mrs. Rocek', 'Mrs. Smith', 'Mr. Ackerman','Mr. Mockel']).
woods(['Yew','Poplar','Brazilwood','Cherrywood']).

slowsolve(T) :-
	T = [['Third',	     N1, T1, W1],       
          ['Fourth',     N2, T2, W2],    
          ['Sixth',      N3, T3, W3],
          ['Fifteenth',  N4, T4, W4]],
    teachers(Teachers), permutation([T1, T2, T3, T4], Teachers),
    firstnames(Names), permutation([N1, N2, N3, N4], Names),
    woods(Woods), permutation([W1, W2, W3, W4], Woods),
    clue1(T), % N T _
    clue2(T), % N T W
    clue3(T), % N _ W
    clue4(T), % N T _ 
    clue5(T), % N T _
    clue7(T), % N T _ 
    clue6(T), % _ T W
    clue8(T), % _ T _ 
    clue9(T), % _ _ W
    clue10(T),% N _ W
    clue11(T).% N _ W


solve(T) :-
	T = [['Third',	     N1, T1, W1],       
          ['Fourth',     N2, T2, W2],    
          ['Sixth',      N3, T3, W3],
          ['Fifteenth',  N4, T4, W4]],
    teachers(Teachers), permutation([T1, T2, T3, T4], Teachers),
    clue8(T), % _ T _ 
    firstnames(Names), permutation([N1, N2, N3, N4], Names),
    clue1(T), % N T _
    clue4(T), % N T _ 
    clue5(T), % N T _
    clue7(T), % N T _ 
    woods(Woods), permutation([W1, W2, W3, W4], Woods),
    clue2(T), % N T W
    clue3(T), % N _ W
    clue10(T),% N _ W
    clue11(T),% N _ W
    clue6(T), % _ T W
    clue9(T). % _ _ W

% 1. Mr. Ackerman's student is Diana.
clue1(T) :- member([_, 'Diana', 'Mr. Ackerman', _], T).

% 2. Of Mrs. Smith's student and Ella, one has the table made of poplar and the other came in third place.
clue2(T) :- 
    member([P1,  _, 'Mrs. Smith', W1], T), 
    member([P2, 'Ella', T2, W2], T), 
    T2 \= 'Mrs. Smith', 
    (W1='Poplar', P2='Third';
     W2='Poplar', P1='Third').

% 3. The person in third place has the table made of yew.
clue3(T) :- member(['Third', _, _, 'Yew'], T).

% 4. Mr. Mockel's student is not Ella.
clue4(T) :- member([_, N, 'Mr. Mockel', _], T), N\='Ella'.

% 5. The person in sixth place is not Ricky and didn't have Mr. Mockel as a teacher.
clue5(T) :-
    member(['Sixth', N, Teacher, _], T), 
    N \= 'Ricky',
    Teacher \= 'Mr. Mockel'.

% 6. The person whose table is made of cherrywood didn't have Mr. Ackerman as a teacher.
clue6(T):-
    member([_, _, Teacher, 'Cherrywood'], T), 
    Teacher \= 'Mr. Ackerman'.


place('Third', 3).
place('Fourth', 4).
place('Sixth', 6).
place('Fifteenth', 15).

% 7. Mrs. Rocek's student finished before Ricky.
clue7(T) :-
    member([P1, _, 'Mrs. Rocek', _], T),
    member([P2, 'Ricky', _, _], T),
    place(P1, Pos1),
    place(P2, Pos2),
    Pos1 < Pos2. 

% 8. Mrs. Smith's student finished after Mrs. Rocek's student.
clue8(T) :-
    member([P1, _, 'Mrs. Rocek', _], T),
    member([P2, _, 'Mrs. Smith', _], T),
    place(P1, Pos1),
    place(P2, Pos2),
    Pos1 < Pos2. 

% 9. The person in fourth place doesn't have a table made of cherrywood.
clue9(T) :- 
    member(['Fourth', _, _, W], T), 
    W \= 'Cherrywood'.

% 10. The person whose table is made of poplar is not Myles.
clue10(T) :- 
    member([_, N, _, 'Poplar'], T), 
    N \= 'Myles'.

% 11. Either the person whose table is made of brazilwood or the person whose table is made of cherrywood is Diana.    
clue11(T) :- 
    member([_, 'Diana', _, W], T), 
    (W = 'Brazilwood'; W = 'Cherrywood').


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
