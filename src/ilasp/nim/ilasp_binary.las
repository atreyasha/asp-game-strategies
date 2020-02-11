%------------------------------- BACKGROUND KNOWLEDGE --------------------------------------
%Configuration
removable(1..6).

% Roles (Players)
role(a).
role(b).

% Action selection
legal(X,remove(P,N)) :- true(has(P,M)), removable(N), N<=M, true(control(X)), not terminal.
0 { does(X,A)} 1 :- legal(X,A), not terminal.
:- does(X,Y), does(X,Z), Y < Z.
:- not does(X,_), true(control(X)), not terminal.

% State transition
next(control(b)) :- true(control(a)).
next(control(a)) :- true(control(b)).
next(has(P,N-M)) :- does(_,remove(P,M)), true(has(P,N)).
next(has(P,N)) :- not does(_,remove(P,_)), true(has(P,N)).

% Define goal and terminal states
goal(X,1):- true(has(p1,0)), true(has(p2,0)), true(has(p3,0)), true(control(X)).
terminal :- goal(_,_).

%------------------------- EXTRA INFORMATION TO PERFORM STRATEGY -----------------------------

% Define predicates to learn real strategy
binary(0,0,0,0).
binary(1,0,0,1).
binary(2,0,1,0).
binary(3,0,1,1).
binary(4,1,0,0).
binary(5,1,0,1).
binary(6,1,1,0).
binary(7,1,1,1).

totals(B14+B24+B34,B12+B22+B32,B11+B21+B31) :- next(has(P1,N1)), binary(N1,B14,B12,B11), next(has(P2,N2)), binary(N2,B24,B22,B21), next(has(P3,N3)), binary(N3,B34,B32,B31),P1!=P2,P2!=P3,P3!=P1.

%Expected strategy
% :~ totals(V0,V1,V2), V0\2 != 0.[1@1, 1587, V0, V1, V2]
% :~ totals(V0,V1,V2), V1\2 != 0.[1@1, 1591, V0, V1, V2]
% :~ totals(V0,V1,V2), V2\2 != 0.[1@1, 1595, V0, V1, V2]

%------------------------------- LANGUAGE BIAS --------------------------------------

#constant(amount,0).
#constant(amount,1).
#constant(amount,2).
#constant(amount,3).

#modeo(1,totals(var(total),var(total),var(total)),(positive)).
% #modeo(1,totals(const(amount),const(amount),const(amount)),(positive)).
#modeo(1,var(total)\2!=0).
#weight(-1).
#weight(1).
#maxp(2).

%------------------------------- EXAMPLES --------------------------------------


#pos(e0,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e1,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e0,e1).

#pos(e2,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e3,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e2,e3).

#pos(e4,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e5,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(3,1)). 
}).
#brave_ordering(e4,e5).

#pos(e6,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e7,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#brave_ordering(e6,e7).

#pos(e8,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e9,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e8,e9).

#pos(e10,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e11,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e10,e11).

#pos(e12,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e13,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e12,e13).

#pos(e14,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e15,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(3,1)). 
}).
#brave_ordering(e14,e15).

#pos(e16,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e17,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#brave_ordering(e16,e17).

#pos(e18,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e19,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e18,e19).

#pos(e20,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e21,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e20,e21).

#pos(e22,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e23,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e22,e23).

#pos(e24,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e25,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e24,e25).

#pos(e26,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e27,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e26,e27).

#pos(e28,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(3,1)). 
}).
#pos(e29,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e28,e29).

#pos(e30,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(3,1)). 
}).
#pos(e31,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e30,e31).

#pos(e32,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,2)). true(has(2,1)). does(a,remove(1,1)). 
}).
#pos(e33,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,2)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e32,e33).

#pos(e34,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,3)). does(b,remove(1,2)). 
}).
#pos(e35,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,3)). does(b,remove(1,1)). 
}).
#brave_ordering(e34,e35).

#pos(e36,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(2,1)). true(has(1,2)). does(a,remove(1,1)). 
}).
#pos(e37,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(2,1)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e36,e37).

#pos(e38,{}, {}, {
 true(control(b)). true(has(2,1)). true(has(3,1)). true(has(1,4)). does(b,remove(1,3)). 
}).
#pos(e39,{}, {}, {
 true(control(b)). true(has(2,1)). true(has(3,1)). true(has(1,4)). does(b,remove(1,2)). 
}).
#brave_ordering(e38,e39).

#pos(e40,{}, {}, {
 true(control(b)). true(has(2,1)). true(has(3,1)). true(has(1,4)). does(b,remove(1,3)). 
}).
#pos(e41,{}, {}, {
 true(control(b)). true(has(2,1)). true(has(3,1)). true(has(1,4)). does(b,remove(1,4)). 
}).
#brave_ordering(e40,e41).

#pos(e42,{}, {}, {
 true(control(a)). true(has(1,5)). true(has(3,1)). true(has(2,1)). does(a,remove(1,4)). 
}).
#pos(e43,{}, {}, {
 true(control(a)). true(has(1,5)). true(has(3,1)). true(has(2,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e42,e43).

#pos(e44,{}, {}, {
 true(control(a)). true(has(1,5)). true(has(3,1)). true(has(2,1)). does(a,remove(1,4)). 
}).
#pos(e45,{}, {}, {
 true(control(a)). true(has(1,5)). true(has(3,1)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e44,e45).

#pos(e46,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,2)). true(has(2,1)). does(a,remove(1,1)). 
}).
#pos(e47,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,2)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e46,e47).

#pos(e48,{}, {}, {
 true(control(a)). true(has(2,1)). true(has(3,1)). true(has(1,3)). does(a,remove(1,2)). 
}).
#pos(e49,{}, {}, {
 true(control(a)). true(has(2,1)). true(has(3,1)). true(has(1,3)). does(a,remove(1,3)). 
}).
#brave_ordering(e48,e49).

#pos(e50,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,0)). does(a,remove(1,4)). 
}).
#pos(e51,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e50,e51).

#pos(e52,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,3)). 
}).
#pos(e53,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,4)). 
}).
#brave_ordering(e52,e53).

#pos(e54,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,3)). 
}).
#pos(e55,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(2,1)). 
}).
#brave_ordering(e54,e55).

#pos(e56,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,3)). 
}).
#pos(e57,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,1)). 
}).
#brave_ordering(e56,e57).

#pos(e58,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,3)). 
}).
#pos(e59,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,4)). does(b,remove(1,2)). 
}).
#brave_ordering(e58,e59).

#pos(e60,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,1)). true(has(2,0)). does(b,remove(1,4)). 
}).
#pos(e61,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,1)). true(has(2,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e60,e61).

#pos(e62,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e63,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#brave_ordering(e62,e63).

#pos(e64,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e65,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e64,e65).

#pos(e66,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e67,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e66,e67).

#pos(e68,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e69,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e68,e69).

#pos(e70,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e71,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e70,e71).

#pos(e72,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e73,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e72,e73).

#pos(e74,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(3,1)). 
}).
#pos(e75,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e74,e75).

#pos(e76,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(3,1)). 
}).
#pos(e77,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e76,e77).

#pos(e78,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e79,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e78,e79).

#pos(e80,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e81,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e80,e81).

#pos(e82,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e83,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e82,e83).

#pos(e84,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e85,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e84,e85).

#pos(e86,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e87,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,4)). 
}).
#brave_ordering(e86,e87).

#pos(e88,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e89,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e88,e89).

#pos(e90,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e91,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e90,e91).

#pos(e92,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e93,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e92,e93).

#pos(e94,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e95,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e94,e95).

#pos(e96,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(3,0)). true(has(2,0)). does(b,remove(1,2)). 
}).
#pos(e97,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(3,0)). true(has(2,0)). does(b,remove(1,3)). 
}).
#brave_ordering(e96,e97).

#pos(e98,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e99,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e98,e99).

#pos(e100,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,3)). does(a,remove(1,1)). 
}).
#pos(e101,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,3)). does(a,remove(2,2)). 
}).
#brave_ordering(e100,e101).

#pos(e102,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,3)). does(a,remove(1,1)). 
}).
#pos(e103,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,3)). does(a,remove(1,3)). 
}).
#brave_ordering(e102,e103).

#pos(e104,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,3)). does(a,remove(1,1)). 
}).
#pos(e105,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,3)). does(a,remove(1,2)). 
}).
#brave_ordering(e104,e105).

#pos(e106,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,0)). true(has(1,2)). does(b,remove(1,1)). 
}).
#pos(e107,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,0)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e106,e107).

#pos(e108,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e109,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e108,e109).

#pos(e110,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e111,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e110,e111).

#pos(e112,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,1)). true(has(1,3)). does(b,remove(1,3)). 
}).
#pos(e113,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,1)). true(has(1,3)). does(b,remove(2,1)). 
}).
#brave_ordering(e112,e113).

#pos(e114,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,1)). does(a,remove(1,4)). 
}).
#pos(e115,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e114,e115).

#pos(e116,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e117,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e116,e117).

#pos(e118,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e119,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e118,e119).

#pos(e120,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e121,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e120,e121).

#pos(e122,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e123,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e122,e123).

#pos(e124,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e125,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e124,e125).

#pos(e126,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e127,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e126,e127).

#pos(e128,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e129,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e128,e129).

#pos(e130,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e131,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,4)). 
}).
#brave_ordering(e130,e131).

#pos(e132,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e133,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(2,2)). true(has(3,0)). does(b,remove(1,3)). 
}).
#brave_ordering(e132,e133).

#pos(e134,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e135,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e134,e135).

#pos(e136,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e137,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e136,e137).

#pos(e138,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e139,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e138,e139).

#pos(e140,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e141,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#brave_ordering(e140,e141).

#pos(e142,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e143,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e142,e143).

#pos(e144,{}, {}, {
 true(control(a)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e145,{}, {}, {
 true(control(a)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e144,e145).

#pos(e146,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e147,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(3,1)). 
}).
#brave_ordering(e146,e147).

#pos(e148,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e149,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e148,e149).

#pos(e150,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(3,0)). true(has(1,2)). does(b,remove(1,1)). 
}).
#pos(e151,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(3,0)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e150,e151).

#pos(e152,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,0)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e153,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,0)). true(has(2,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e152,e153).

#pos(e154,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,0)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e155,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,0)). true(has(2,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e154,e155).

#pos(e156,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,0)). true(has(1,3)). does(b,remove(1,3)). 
}).
#pos(e157,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,0)). true(has(1,3)). does(b,remove(3,1)). 
}).
#brave_ordering(e156,e157).

#pos(e158,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,3)). true(has(2,1)). does(a,remove(1,2)). 
}).
#pos(e159,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,3)). true(has(2,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e158,e159).

#pos(e160,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,1)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e161,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,1)). true(has(2,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e160,e161).

#pos(e162,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e163,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#brave_ordering(e162,e163).

#pos(e164,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e165,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e164,e165).

#pos(e166,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e167,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e166,e167).

#pos(e168,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e169,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e168,e169).

#pos(e170,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e171,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e170,e171).

#pos(e172,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e173,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e172,e173).

#pos(e174,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(3,1)). 
}).
#pos(e175,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e174,e175).

#pos(e176,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(3,1)). 
}).
#pos(e177,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e176,e177).

#pos(e178,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e179,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e178,e179).

#pos(e180,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e181,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e180,e181).

#pos(e182,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e183,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e182,e183).

#pos(e184,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e185,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e184,e185).

#pos(e186,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(b,remove(1,2)). 
}).
#pos(e187,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(b,remove(1,3)). 
}).
#brave_ordering(e186,e187).

#pos(e188,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,3)). true(has(2,1)). does(b,remove(1,3)). 
}).
#pos(e189,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,3)). true(has(2,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e188,e189).

#pos(e190,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e191,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e190,e191).

#pos(e192,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e193,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e192,e193).

#pos(e194,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e195,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e194,e195).

#pos(e196,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e197,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e196,e197).

#pos(e198,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e199,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e198,e199).

#pos(e200,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e201,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e200,e201).

#pos(e202,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e203,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e202,e203).

#pos(e204,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e205,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e204,e205).

#pos(e206,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e207,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#brave_ordering(e206,e207).

#pos(e208,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e209,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e208,e209).

#pos(e210,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e211,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e210,e211).

#pos(e212,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e213,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e212,e213).

#pos(e214,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e215,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,4)). 
}).
#brave_ordering(e214,e215).

#pos(e216,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e217,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,3)). 
}).
#brave_ordering(e216,e217).

#pos(e218,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e219,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(3,1)). 
}).
#brave_ordering(e218,e219).

#pos(e220,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e221,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,2)). 
}).
#brave_ordering(e220,e221).

#pos(e222,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e223,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(2,2)). 
}).
#brave_ordering(e222,e223).

#pos(e224,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e225,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,4)). does(a,remove(2,1)). 
}).
#brave_ordering(e224,e225).

#pos(e226,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,2)). true(has(2,1)). does(a,remove(1,1)). 
}).
#pos(e227,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,2)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e226,e227).

#pos(e228,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,3)). does(b,remove(1,2)). 
}).
#pos(e229,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,1)). true(has(1,3)). does(b,remove(1,1)). 
}).
#brave_ordering(e228,e229).

#pos(e230,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(3,1)). true(has(2,0)). does(b,remove(1,3)). 
}).
#pos(e231,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(3,1)). true(has(2,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e230,e231).

#pos(e232,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e233,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#brave_ordering(e232,e233).

#pos(e234,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e235,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e234,e235).

#pos(e236,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e237,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e236,e237).

#pos(e238,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e239,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e238,e239).

#pos(e240,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e241,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e240,e241).

#pos(e242,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e243,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e242,e243).

#pos(e244,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(3,1)). 
}).
#pos(e245,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e244,e245).

#pos(e246,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(3,1)). 
}).
#pos(e247,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e246,e247).

#pos(e248,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e249,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e248,e249).

#pos(e250,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e251,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e250,e251).

#pos(e252,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e253,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e252,e253).

#pos(e254,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e255,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e254,e255).

#pos(e256,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e257,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,3)). true(has(2,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e256,e257).

#pos(e258,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e259,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e258,e259).

#pos(e260,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e261,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e260,e261).

#pos(e262,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e263,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e262,e263).

#pos(e264,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e265,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e264,e265).

#pos(e266,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(b,remove(1,1)). 
}).
#pos(e267,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e266,e267).

#pos(e268,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(b,remove(1,1)). 
}).
#pos(e269,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(b,remove(1,3)). 
}).
#brave_ordering(e268,e269).

#pos(e270,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(b,remove(1,1)). 
}).
#pos(e271,{}, {}, {
 true(control(b)). true(has(1,3)). true(has(2,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e270,e271).

#pos(e272,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e273,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#brave_ordering(e272,e273).

#pos(e274,{}, {}, {
 true(control(a)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e275,{}, {}, {
 true(control(a)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e274,e275).

#pos(e276,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e277,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(3,1)). 
}).
#brave_ordering(e276,e277).

#pos(e278,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e279,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e278,e279).

#pos(e280,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e281,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e280,e281).

#pos(e282,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e283,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(2,1)). 
}).
#brave_ordering(e282,e283).

#pos(e284,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e285,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,3)). 
}).
#brave_ordering(e284,e285).

#pos(e286,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e287,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,4)). 
}).
#brave_ordering(e286,e287).

#pos(e288,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e289,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(1,5)). true(has(2,2)). does(b,remove(2,2)). 
}).
#brave_ordering(e288,e289).

#pos(e290,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e291,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e290,e291).

#pos(e292,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e293,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e292,e293).

#pos(e294,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e295,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e294,e295).

#pos(e296,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e297,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e296,e297).

#pos(e298,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e299,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e298,e299).

#pos(e300,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(3,0)). true(has(1,2)). does(b,remove(1,1)). 
}).
#pos(e301,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(3,0)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e300,e301).

#pos(e302,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,5)). true(has(2,0)). does(a,remove(1,4)). 
}).
#pos(e303,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,5)). true(has(2,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e302,e303).

#pos(e304,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,5)). true(has(2,0)). does(a,remove(1,4)). 
}).
#pos(e305,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,5)). true(has(2,0)). does(a,remove(1,5)). 
}).
#brave_ordering(e304,e305).

#pos(e306,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(a,remove(2,3)). 
}).
#pos(e307,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e306,e307).

#pos(e308,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,5)). true(has(2,1)). does(a,remove(1,5)). 
}).
#pos(e309,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,5)). true(has(2,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e308,e309).

#pos(e310,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e311,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e310,e311).

#pos(e312,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(a,remove(1,1)). 
}).
#pos(e313,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e312,e313).

#pos(e314,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e315,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e314,e315).

#pos(e316,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e317,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e316,e317).

#pos(e318,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,1)). 
}).
#pos(e319,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e318,e319).

#pos(e320,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,1)). 
}).
#pos(e321,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,3)). 
}).
#brave_ordering(e320,e321).

#pos(e322,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,1)). 
}).
#pos(e323,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e322,e323).

#pos(e324,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,0)). does(b,remove(1,3)). 
}).
#pos(e325,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,0)). does(b,remove(1,4)). 
}).
#brave_ordering(e324,e325).

#pos(e326,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(a,remove(1,1)). 
}).
#pos(e327,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e326,e327).

#pos(e328,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,0)). true(has(1,3)). does(b,remove(1,2)). 
}).
#pos(e329,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,0)). true(has(1,3)). does(b,remove(1,3)). 
}).
#brave_ordering(e328,e329).

#pos(e330,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,0)). true(has(1,3)). does(b,remove(1,2)). 
}).
#pos(e331,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,0)). true(has(1,3)). does(b,remove(1,1)). 
}).
#brave_ordering(e330,e331).

#pos(e332,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(3,0)). true(has(1,2)). does(b,remove(1,1)). 
}).
#pos(e333,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(3,0)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e332,e333).

#pos(e334,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e335,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,4)). 
}).
#brave_ordering(e334,e335).

#pos(e336,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e337,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e336,e337).

#pos(e338,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e339,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e338,e339).

#pos(e340,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e341,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e340,e341).

#pos(e342,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,1)). does(a,remove(1,4)). 
}).
#pos(e343,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,4)). true(has(2,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e342,e343).

#pos(e344,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e345,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e344,e345).

#pos(e346,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e347,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e346,e347).

#pos(e348,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e349,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e348,e349).

#pos(e350,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e351,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e350,e351).

#pos(e352,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e353,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,2)). does(b,remove(2,1)). 
}).
#brave_ordering(e352,e353).

#pos(e354,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e355,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,2)). does(b,remove(1,4)). 
}).
#brave_ordering(e354,e355).

#pos(e356,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e357,{}, {}, {
 true(control(b)). true(has(1,4)). true(has(3,0)). true(has(2,2)). does(b,remove(2,2)). 
}).
#brave_ordering(e356,e357).

#pos(e358,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(b,remove(2,3)). 
}).
#pos(e359,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e358,e359).

#pos(e360,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e361,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e360,e361).

#pos(e362,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(a,remove(2,3)). 
}).
#pos(e363,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e362,e363).

#pos(e364,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e365,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e364,e365).

#pos(e366,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e367,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e366,e367).

#pos(e368,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(b,remove(1,1)). 
}).
#pos(e369,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e368,e369).

#pos(e370,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e371,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e370,e371).

#pos(e372,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(2,2)). 
}).
#pos(e373,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(2,1)). 
}).
#brave_ordering(e372,e373).

#pos(e374,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(2,2)). 
}).
#pos(e375,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e374,e375).

#pos(e376,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e377,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e376,e377).

#pos(e378,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e379,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,3)). 
}).
#brave_ordering(e378,e379).

#pos(e380,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e381,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e380,e381).

#pos(e382,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e383,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,2)). 
}).
#brave_ordering(e382,e383).

#pos(e384,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e385,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,3)). 
}).
#brave_ordering(e384,e385).

#pos(e386,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e387,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(2,1)). 
}).
#brave_ordering(e386,e387).

#pos(e388,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e389,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(2,3)). 
}).
#brave_ordering(e388,e389).

#pos(e390,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e391,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,2)). 
}).
#brave_ordering(e390,e391).

#pos(e392,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e393,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,4)). 
}).
#brave_ordering(e392,e393).

#pos(e394,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(1,1)). 
}).
#pos(e395,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,4)). does(a,remove(2,2)). 
}).
#brave_ordering(e394,e395).

#pos(e396,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e397,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e396,e397).

#pos(e398,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(b,remove(1,1)). 
}).
#pos(e399,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e398,e399).

#pos(e400,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e401,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e400,e401).

#pos(e402,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e403,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,3)). 
}).
#brave_ordering(e402,e403).

#pos(e404,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e405,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e404,e405).

#pos(e406,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e407,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,2)). does(a,remove(2,2)). 
}).
#brave_ordering(e406,e407).

#pos(e408,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,0)). true(has(1,2)). does(a,remove(1,1)). 
}).
#pos(e409,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,0)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e408,e409).

#pos(e410,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e411,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e410,e411).

#pos(e412,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(a,remove(2,3)). 
}).
#pos(e413,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e412,e413).

#pos(e414,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e415,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e414,e415).

#pos(e416,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,1)). 
}).
#pos(e417,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e416,e417).

#pos(e418,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,1)). 
}).
#pos(e419,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e418,e419).

#pos(e420,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,1)). 
}).
#pos(e421,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(b,remove(2,3)). 
}).
#brave_ordering(e420,e421).

#pos(e422,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e423,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e422,e423).

#pos(e424,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(b,remove(2,3)). 
}).
#pos(e425,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#brave_ordering(e424,e425).

#pos(e426,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e427,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,3)). 
}).
#brave_ordering(e426,e427).

#pos(e428,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e429,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e428,e429).

#pos(e430,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e431,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e430,e431).

#pos(e432,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e433,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,4)). 
}).
#brave_ordering(e432,e433).

#pos(e434,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e435,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e434,e435).

#pos(e436,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e437,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,5)). 
}).
#brave_ordering(e436,e437).

#pos(e438,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(1,2)). 
}).
#pos(e439,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,5)). true(has(3,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e438,e439).

#pos(e440,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#pos(e441,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e440,e441).

#pos(e442,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e443,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e442,e443).

#pos(e444,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,3)). 
}).
#pos(e445,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e444,e445).

#pos(e446,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e447,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e446,e447).

#pos(e448,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(b,remove(2,3)). 
}).
#pos(e449,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e448,e449).

#pos(e450,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(b,remove(1,1)). 
}).
#pos(e451,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e450,e451).

#pos(e452,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e453,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e452,e453).

#pos(e454,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e455,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e454,e455).

#pos(e456,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e457,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e456,e457).

#pos(e458,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e459,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e458,e459).

#pos(e460,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e461,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e460,e461).

#pos(e462,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#pos(e463,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e462,e463).

#pos(e464,{}, {}, {
 true(control(b)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(b,remove(2,1)). 
}).
#pos(e465,{}, {}, {
 true(control(b)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(b,remove(2,2)). 
}).
#brave_ordering(e464,e465).

#pos(e466,{}, {}, {
 true(control(b)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(b,remove(2,1)). 
}).
#pos(e467,{}, {}, {
 true(control(b)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e466,e467).

#pos(e468,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e469,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e468,e469).

#pos(e470,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e471,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e470,e471).

#pos(e472,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e473,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,3)). 
}).
#brave_ordering(e472,e473).

#pos(e474,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e475,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e474,e475).

#pos(e476,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e477,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e476,e477).

#pos(e478,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e479,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e478,e479).

#pos(e480,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e481,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e480,e481).

#pos(e482,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,3)). 
}).
#pos(e483,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e482,e483).

#pos(e484,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(a,remove(1,1)). 
}).
#pos(e485,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e484,e485).

#pos(e486,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(1,2)). true(has(3,0)). does(b,remove(1,1)). 
}).
#pos(e487,{}, {}, {
 true(control(b)). true(has(2,0)). true(has(1,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e486,e487).

#pos(e488,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e489,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e488,e489).

#pos(e490,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e491,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e490,e491).

#pos(e492,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,3)). does(a,remove(1,1)). 
}).
#pos(e493,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,3)). does(a,remove(1,2)). 
}).
#brave_ordering(e492,e493).

#pos(e494,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,3)). does(a,remove(1,1)). 
}).
#pos(e495,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,3)). does(a,remove(1,3)). 
}).
#brave_ordering(e494,e495).

#pos(e496,{}, {}, {
 true(control(b)). true(has(2,1)). true(has(3,1)). true(has(1,2)). does(b,remove(1,1)). 
}).
#pos(e497,{}, {}, {
 true(control(b)). true(has(2,1)). true(has(3,1)). true(has(1,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e496,e497).

#pos(e498,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,1)). does(a,remove(1,3)). 
}).
#pos(e499,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e498,e499).

#pos(e500,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,1)). does(a,remove(1,3)). 
}).
#pos(e501,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,1)). does(a,remove(1,4)). 
}).
#brave_ordering(e500,e501).

#pos(e502,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e503,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e502,e503).

#pos(e504,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e505,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e504,e505).

#pos(e506,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e507,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e506,e507).

#pos(e508,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e509,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e508,e509).

#pos(e510,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e511,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#brave_ordering(e510,e511).

#pos(e512,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#pos(e513,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e512,e513).

#pos(e514,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e515,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#brave_ordering(e514,e515).

#pos(e516,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#pos(e517,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e516,e517).

#pos(e518,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e519,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e518,e519).

#pos(e520,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e521,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e520,e521).

#pos(e522,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(2,2)). 
}).
#pos(e523,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,1)). true(has(3,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e522,e523).

#pos(e524,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e525,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e524,e525).

#pos(e526,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(3,1)). 
}).
#pos(e527,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e526,e527).

#pos(e528,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(3,1)). 
}).
#pos(e529,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e528,e529).

#pos(e530,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e531,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e530,e531).

#pos(e532,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e533,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e532,e533).

#pos(e534,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e535,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e534,e535).

#pos(e536,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,1)). true(has(2,1)). does(a,remove(1,2)). 
}).
#pos(e537,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,1)). true(has(2,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e536,e537).

#pos(e538,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,1)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e539,{}, {}, {
 true(control(a)). true(has(1,3)). true(has(3,1)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e538,e539).

#pos(e540,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,0)). does(a,remove(1,4)). 
}).
#pos(e541,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,1)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e540,e541).

#pos(e542,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e543,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e542,e543).

#pos(e544,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,0)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e545,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,0)). true(has(3,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e544,e545).

#pos(e546,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,0)). true(has(3,0)). does(b,remove(2,2)). 
}).
#pos(e547,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,0)). true(has(3,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e546,e547).

#pos(e548,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(a,remove(2,3)). 
}).
#pos(e549,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e548,e549).

#pos(e550,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(a,remove(1,1)). 
}).
#pos(e551,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e550,e551).

#pos(e552,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e553,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e552,e553).

#pos(e554,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e555,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e554,e555).

#pos(e556,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e557,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e556,e557).

#pos(e558,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e559,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e558,e559).

#pos(e560,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e561,{}, {}, {
 true(control(b)). true(has(2,3)). true(has(1,2)). true(has(3,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e560,e561).

#pos(e562,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e563,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e562,e563).

#pos(e564,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(b,remove(1,3)). 
}).
#pos(e565,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,0)). does(b,remove(1,4)). 
}).
#brave_ordering(e564,e565).

#pos(e566,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,1)). does(b,remove(1,4)). 
}).
#pos(e567,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,1)). does(b,remove(1,2)). 
}).
#brave_ordering(e566,e567).

#pos(e568,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e569,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e568,e569).

#pos(e570,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,0)). true(has(2,0)). does(a,remove(1,3)). 
}).
#pos(e571,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(3,0)). true(has(2,0)). does(a,remove(1,4)). 
}).
#brave_ordering(e570,e571).

#pos(e572,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e573,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e572,e573).

#pos(e574,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e575,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e574,e575).

#pos(e576,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e577,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e576,e577).

#pos(e578,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e579,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e578,e579).

#pos(e580,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e581,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,2)). does(b,remove(2,2)). 
}).
#brave_ordering(e580,e581).

#pos(e582,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e583,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,2)). does(b,remove(1,4)). 
}).
#brave_ordering(e582,e583).

#pos(e584,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,2)). does(b,remove(1,2)). 
}).
#pos(e585,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,4)). true(has(2,2)). does(b,remove(2,1)). 
}).
#brave_ordering(e584,e585).

#pos(e586,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,0)). true(has(2,2)). does(b,remove(2,1)). 
}).
#pos(e587,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(1,0)). true(has(2,2)). does(b,remove(2,2)). 
}).
#brave_ordering(e586,e587).

#pos(e588,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e589,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e588,e589).

#pos(e590,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e591,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e590,e591).

#pos(e592,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(b,remove(2,3)). 
}).
#pos(e593,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e592,e593).

#pos(e594,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e595,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e594,e595).

#pos(e596,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(a,remove(2,3)). 
}).
#pos(e597,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e596,e597).

#pos(e598,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e599,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e598,e599).

#pos(e600,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e601,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e600,e601).

#pos(e602,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(b,remove(1,1)). 
}).
#pos(e603,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,0)). true(has(2,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e602,e603).

#pos(e604,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e605,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e604,e605).

#pos(e606,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(2,2)). 
}).
#pos(e607,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(2,1)). 
}).
#brave_ordering(e606,e607).

#pos(e608,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(2,2)). 
}).
#pos(e609,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,1)). true(has(2,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e608,e609).

#pos(e610,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e611,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e610,e611).

#pos(e612,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e613,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(a,remove(2,3)). 
}).
#brave_ordering(e612,e613).

#pos(e614,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e615,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(a,remove(1,2)). 
}).
#brave_ordering(e614,e615).

#pos(e616,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(a,remove(2,1)). 
}).
#pos(e617,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,0)). true(has(1,2)). does(a,remove(2,2)). 
}).
#brave_ordering(e616,e617).

#pos(e618,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e619,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,3)). 
}).
#brave_ordering(e618,e619).

#pos(e620,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e621,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e620,e621).

#pos(e622,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e623,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e622,e623).

#pos(e624,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e625,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e624,e625).

#pos(e626,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e627,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,4)). 
}).
#brave_ordering(e626,e627).

#pos(e628,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e629,{}, {}, {
 true(control(a)). true(has(1,4)). true(has(2,3)). true(has(3,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e628,e629).

#pos(e630,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,3)). 
}).
#pos(e631,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e630,e631).

#pos(e632,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,3)). 
}).
#pos(e633,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e632,e633).

#pos(e634,{}, {}, {
 true(control(a)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(a,remove(2,1)). 
}).
#pos(e635,{}, {}, {
 true(control(a)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(a,remove(2,2)). 
}).
#brave_ordering(e634,e635).

#pos(e636,{}, {}, {
 true(control(a)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(a,remove(2,1)). 
}).
#pos(e637,{}, {}, {
 true(control(a)). true(has(1,1)). true(has(3,1)). true(has(2,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e636,e637).

#pos(e638,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e639,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e638,e639).

#pos(e640,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e641,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e640,e641).

#pos(e642,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e643,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,3)). 
}).
#brave_ordering(e642,e643).

#pos(e644,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(b,remove(1,1)). 
}).
#pos(e645,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(b,remove(1,2)). 
}).
#brave_ordering(e644,e645).

#pos(e646,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(b,remove(1,1)). 
}).
#pos(e647,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e646,e647).

#pos(e648,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,0)). true(has(3,0)). does(b,remove(1,1)). 
}).
#pos(e649,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,0)). true(has(3,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e648,e649).

#pos(e650,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,0)). true(has(2,1)). does(a,remove(1,2)). 
}).
#pos(e651,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,0)). true(has(2,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e650,e651).

#pos(e652,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,0)). true(has(2,1)). does(a,remove(1,2)). 
}).
#pos(e653,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,0)). true(has(2,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e652,e653).

#pos(e654,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e655,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,3)). true(has(1,0)). does(a,remove(2,3)). 
}).
#brave_ordering(e654,e655).

#pos(e656,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(a,remove(1,1)). 
}).
#pos(e657,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(1,2)). true(has(2,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e656,e657).

#pos(e658,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e659,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e658,e659).

#pos(e660,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,3)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e661,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,3)). true(has(3,0)). does(b,remove(2,3)). 
}).
#brave_ordering(e660,e661).

#pos(e662,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,3)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e663,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,3)). true(has(3,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e662,e663).

#pos(e664,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,3)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e665,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,3)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e664,e665).

#pos(e666,{}, {}, {
 true(control(a)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e667,{}, {}, {
 true(control(a)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e666,e667).

#pos(e668,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e669,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(3,1)). 
}).
#brave_ordering(e668,e669).

#pos(e670,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#pos(e671,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e670,e671).

#pos(e672,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,1)). true(has(2,2)). does(a,remove(2,1)). 
}).
#pos(e673,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,1)). true(has(2,2)). does(a,remove(2,2)). 
}).
#brave_ordering(e672,e673).

#pos(e674,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,1)). true(has(2,2)). does(a,remove(2,1)). 
}).
#pos(e675,{}, {}, {
 true(control(a)). true(has(3,1)). true(has(1,1)). true(has(2,2)). does(a,remove(1,1)). 
}).
#brave_ordering(e674,e675).

#pos(e676,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e677,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e676,e677).

#pos(e678,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e679,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e678,e679).

#pos(e680,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(2,2)). 
}).
#pos(e681,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(3,1)). true(has(1,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e680,e681).

#pos(e682,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,0)). true(has(3,0)). does(a,remove(2,1)). 
}).
#pos(e683,{}, {}, {
 true(control(a)). true(has(2,2)). true(has(1,0)). true(has(3,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e682,e683).

#pos(e684,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e685,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,1)). 
}).
#brave_ordering(e684,e685).

#pos(e686,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e687,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e686,e687).

#pos(e688,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e689,{}, {}, {
 true(control(b)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e688,e689).

#pos(e690,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,2)). does(b,remove(3,1)). 
}).
#pos(e691,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,2)). does(b,remove(1,2)). 
}).
#brave_ordering(e690,e691).

#pos(e692,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,2)). does(b,remove(3,1)). 
}).
#pos(e693,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,2)). does(b,remove(1,1)). 
}).
#brave_ordering(e692,e693).

#pos(e694,{}, {}, {
 true(control(a)). true(has(2,0)). true(has(1,2)). true(has(3,0)). does(a,remove(1,1)). 
}).
#pos(e695,{}, {}, {
 true(control(a)). true(has(2,0)). true(has(1,2)). true(has(3,0)). does(a,remove(1,2)). 
}).
#brave_ordering(e694,e695).

#pos(e696,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(b,remove(1,2)). 
}).
#pos(e697,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(b,remove(3,1)). 
}).
#brave_ordering(e696,e697).

#pos(e698,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(b,remove(1,2)). 
}).
#pos(e699,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(b,remove(1,1)). 
}).
#brave_ordering(e698,e699).

#pos(e700,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,2)). 
}).
#pos(e701,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,4)). 
}).
#brave_ordering(e700,e701).

#pos(e702,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,2)). 
}).
#pos(e703,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(3,1)). 
}).
#brave_ordering(e702,e703).

#pos(e704,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,2)). 
}).
#pos(e705,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(2,3)). 
}).
#brave_ordering(e704,e705).

#pos(e706,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,2)). 
}).
#pos(e707,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(2,1)). 
}).
#brave_ordering(e706,e707).

#pos(e708,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,2)). 
}).
#pos(e709,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(2,2)). 
}).
#brave_ordering(e708,e709).

#pos(e710,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,2)). 
}).
#pos(e711,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,4)). does(b,remove(1,1)). 
}).
#brave_ordering(e710,e711).

#pos(e712,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(2,2)). 
}).
#pos(e713,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,1)). does(b,remove(1,1)). 
}).
#brave_ordering(e712,e713).

#pos(e714,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#pos(e715,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e714,e715).

#pos(e716,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e717,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e716,e717).

#pos(e718,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,1)). 
}).
#pos(e719,{}, {}, {
 true(control(b)). true(has(2,2)). true(has(3,0)). true(has(1,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e718,e719).

#pos(e720,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e721,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e720,e721).

#pos(e722,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e723,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e722,e723).

#pos(e724,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(a,remove(1,1)). 
}).
#pos(e725,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(a,remove(1,2)). 
}).
#brave_ordering(e724,e725).

#pos(e726,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(a,remove(1,1)). 
}).
#pos(e727,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e726,e727).

#pos(e728,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,1)). 
}).
#pos(e729,{}, {}, {
 true(control(b)). true(has(1,0)). true(has(2,2)). true(has(3,0)). does(b,remove(2,2)). 
}).
#brave_ordering(e728,e729).

#pos(e730,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e731,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e730,e731).

#pos(e732,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e733,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e732,e733).

#pos(e734,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,1)). 
}).
#pos(e735,{}, {}, {
 true(control(a)). true(has(3,0)). true(has(2,2)). true(has(1,0)). does(a,remove(2,2)). 
}).
#brave_ordering(e734,e735).

#pos(e736,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,0)). true(has(3,0)). does(b,remove(1,1)). 
}).
#pos(e737,{}, {}, {
 true(control(b)). true(has(1,2)). true(has(2,0)). true(has(3,0)). does(b,remove(1,2)). 
}).
#brave_ordering(e736,e737).

#pos(e738,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e739,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(1,1)). 
}).
#brave_ordering(e738,e739).

#pos(e740,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(1,2)). 
}).
#pos(e741,{}, {}, {
 true(control(a)). true(has(1,2)). true(has(3,1)). true(has(2,0)). does(a,remove(3,1)). 
}).
#brave_ordering(e740,e741).

#pos(e742,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,3)). 
}).
#pos(e743,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,0)). does(a,remove(2,1)). 
}).
#brave_ordering(e742,e743).

#pos(e744,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,3)). 
}).
#pos(e745,{}, {}, {
 true(control(b)). true(has(3,1)). true(has(2,3)). true(has(1,0)). does(b,remove(2,1)). 
}).
#brave_ordering(e744,e745).

#pos(e746,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e747,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,3)). 
}).
#brave_ordering(e746,e747).

#pos(e748,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e749,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(1,1)). 
}).
#brave_ordering(e748,e749).

#pos(e750,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,2)). 
}).
#pos(e751,{}, {}, {
 true(control(a)). true(has(2,3)). true(has(3,1)). true(has(1,1)). does(a,remove(2,1)). 
}).
#brave_ordering(e750,e751).

#pos(e752,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,3)). 
}).
#pos(e753,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,5)). 
}).
#brave_ordering(e752,e753).

#pos(e754,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,3)). 
}).
#pos(e755,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,4)). 
}).
#brave_ordering(e754,e755).

#pos(e756,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,3)). 
}).
#pos(e757,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,1)). 
}).
#brave_ordering(e756,e757).

#pos(e758,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,3)). 
}).
#pos(e759,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(3,1)). 
}).
#brave_ordering(e758,e759).

#pos(e760,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(1,3)). 
}).
#pos(e761,{}, {}, {
 true(has(1,5)). true(has(2,3)). true(has(3,1)). true(control(a)). does(a,remove(2,1)). 
}).
#brave_ordering(e760,e761).