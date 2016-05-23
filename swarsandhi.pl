vowel(X):- long_vowel(X).
vowel(X):- short_vowel(X).
long_vowel(X):- member(X, [ā, ī, ū, ṝ, ḹ, ai, au]).
short_vowel(X):- member(X, [a, i, u, ṛ, ḷ, e, o]).

longify_vowel(a, ā).
longify_vowel(i, ī).
longify_vowel(u, ū).
longify_vowel(ṛ, ṝ).
longify_vowel(ḷ, ḹ).
longify_vowel(e, ai).
longify_vowel(o, au).
longify_vowel(X, X):-
    long_vowel(X).

similar_vowel(X, Y):- longify_vowel(X, Y).
similar_vowel(X, Y):- longify_vowel(Y, X).
similar_vowel(X, X).

longest_vowel(X, Y, Longest):-
    longify_vowel(X, Longest),
    longify_vowel(Y, Longest).

%% [mṛg, a], [a, ṅkaḥ], [mṛg, ā, ṅkaḥ]
%% [tath, ā], [a, pi], [tath, ā, pi]
%% [tav, a], [ā, śā],  [tav, ā, śā]
%% [sīt, ā], [ā, gatā],  [sīt, ā, gatā]
%% [vidy, ā], [, ālayaḥ], [vidy, ā, layaḥ]
%% [mun, i], [i, ndraḥ], [mun, ī, draḥ]
%% [har, i], [īśaḥ], [har, ī, śaḥ]
%% [lakṣm, ī], [ī, śvaraḥ], [lakṣm, ī, śvaraḥ]
%% [bhān, u], [u, dayaḥ], [bhān, ū, dayaḥ]
%% [sindh, ū], [ū, rmiḥ ], [sindh, ū, rmiḥ]
%% [bh, ū], [u, dhvarm], [bh, ū, rdhvam]
%% [s, u], [u, ktiḥ ], [s, ū, ktiḥ]
%% [māt, ṛ], [ṛ, ṇam], [māt, ṝ, ṇam]
%% [pit, ṛ], [ṛ, ddhiḥ], [pit, ṝ, rddhiḥ]

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),
    % Check if the two vowels are similar
    similar_vowel(X_last, Y_head),
    % Find the longest vowel
    longest_vowel(X_last, Y_head, Longest),
    append([X_body], [Longest], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'savarṇadīrgha'.

%% [nar, a], [i, ndraḥ], [nar, e, ndraḥ]
%% [mah, ā], [i, ndraḥ], [mah, e, ndraḥ]
%% [mah, ā], [ī, śaḥ],  [mah, e, śaḥ]
%% [nar, a], [u, ttamaḥ], [nar, o, ttamaḥ]
%% [gaṅg, ā], [u, dakam], [gaṅg, o, dakam]
%% [kṛṣṇ, a], [ṛ, ddhiḥ], [kṛṣṇ, ar, ddhiḥ]
%% [mah, ā], [ṛ, ṣiḥ], [mah, ar, ṣiḥ]
%% [tav, a], [ḷ, kāraḥ], [tav, al, kāraḥ]
%% [māl, ā], [ḷ, kāraḥ], [māl, al, kāraḥ]

guna(i, e).
guna(u, o).
guna(ṛ, ar).
guna(ḷ, al).

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),
    % Check if the first is a or ā
    member(X_last, [a, ā]),
    % Check if the second is one of [i, ī, u, ū, ṛ, ṝ, ḷ]
    member(Y_head, [i, ī, u, ū, ṛ, ṝ, ḷ]),
    % Find the guṇa
    guna(Y_head, Guna),

    append([X_body], [Guna], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'guṇa'.

%% [kṛṣṇ, a], [e, katvam], [kṛṣṇ, ai, katvam]
%% [dev, a], [a, iśvaryam], [dev, ai, śvaryam]
%% [tath, ā], [e, va], [tath, ai, va]
%% [mah, ā], [a, irāvataḥ], [mah, ai, rāvataḥ]
%% [jal, a], [o, ghaḥ], [jal, au, ghaḥ]
%% [tav, a], [a, udāryam], [tav, au, dāryam]
%% [mah, ā], [o, ghaḥ], [mah, au, ghaḥ]
%% [mah, ā], [a, udāryam], [mah, au, dāryam]
%% [pr, a], [ṛ, cchati], [pr, ār, cchati]
%% [up, a], [ṛ, cchati], [up, ār, cchati]

vruddhi(e, ai).
vruddhi(ai, ai).
vruddhi(o, au).
vruddhi(au, au).
vruddhi(ṛ, ār).
vruddhi(ḷ, āl).

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),

    % Check if the first is a or ā
    member(X_last, [a, ā]),
    % Check if the second is one of [e, ai, o, au, ṛ, ḷ]
    member(Y_head, [e, ai, o, au, ṛ, ḷ]),
    % Find the vṛddhi
    vruddhi(Y_head, Vruddhi),

    append([X_body], [Vruddhi], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'vṛddhi'.

%% [yad, i], [a, pi], [yad, y, api]
%% [it, i], [ā, di], [it, y, ādiḥ]
%% [nad, ī], [a, sti], [nad, y, asti]
%% [lakṣm, ī], [ā, gacchati], [lakṣm, y, āgacchati]
%% [madh, u], [a, riḥ], [madh, v, ariḥ]
%% [sādh, u], [ā, deśaḥ], [sādh, v, ādeśa]
%% [s, u], [ā, gatama], [s, v, āgatam]
%% [vadh, ū], [ā, deśaḥ], [vadh, v, ādeśaḥ]
%% [cam, ū], [ā, gamanama], [cam, v, āgamanam]
%% [pit, ṛ], [ā, deśaḥ], [pit, r, ādeśaḥ]
%% [māt, ṛ], [ā, jñā], [māt, r, ājñā]
%% [, ḷ], [ā, kṛti], [l, ākṛti, lākṛtiḥ]
%% [, ḷ], [a, kāra], [l, akāraḥ, ]

yan(X, Y):- member(X, [i, ī]), Y = y.
yan(X, Y):- member(X, [u, ū]), Y = v.
yan(X, Y):- member(X, [ṛ, ṝ]), Y = r.
yan(ḷ, l).

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),

    % Check if the first is [i, ī, u, ū, ṛ, ṝ, ḷ]
    member(X_last, [i, ī, u, ū, ṛ, ṝ, ḷ]),
    % Check if the second is one of [a, ā]
    member(Y_head, [a, ā]),
    % Find the yaṇ
    yan(Y_head, Yan),

    append([X_body], [Yan], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'yaṇ'.

%% [har, e], [e, ], [har, ay, e]
%% [kav, e], [e, ], [kav, ay, e]
%% [na, i], [a, kaḥ], [n, āy, akaḥ]
%% [ra, i], [o, ḥ], [r, āy, oḥ]
%% [viṣṇ, o], [e, ], [viṣṇ, av, e]
%% [bhān, o], [e, ], [bhān, av, e]
%% [pa, u], [a, kaḥ], [p, āv, akaḥ]
%% [ga, u], [a, u], [g, āv, au]
%% [na, u], [a, m], [n, āv, am]

ayadi(e, ay).
ayadi(ai, āy).
ayadi(o, av).
ayadi(au, āv).

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),

    % Check if the first is a or ā
    member(X_last, [e, ai, o, au]),
    % Check if the second is a vowel
    vowel(Y_head),
    % Find the ayādi
    ayadi(Y_head, Ayadi),

    append([X_body], [Ayadi], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'ayādi'.

%% [grām, e], [a, smin], [grām, e', smin]
%% [nagar, e], [a, tra], [nagar, e', tra]
%% [sādh, o], [a, tra],  [sādh, o', tra]
%% [prabh, o], [a, tra], [prabh, o', tra]
%% [har, e], [a, va],  [har, e', va]
%% [viṣṇ, o], [a, va], [viṣṇ, o, 'va]

purvarupa(e, "e'").
purvarupa(o, "o'").

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),

    % Check if the first is e or o
    member(X_last, [e, o]),
    % Check if the second is [a]
    member(Y_head, [a]),
    % Find the pūrvarupa
    purvarupa(X_last, Purvarupa),

    append([X_body], [Purvarupa], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'pūrvarupa'.


% Disable validate
validate(_, _, _, _).

% Validate block
validate(X_body, X_last, Y_head, Y_rest):-
    % Make sure the words are in the dictionary
    atom_concat(X_body, X_last, X), dictionary(X),
    atom_concat(Y_head, Y_rest, Y), dictionary(Y).
dictionary(_):- fail.

% Use atomic_list_concat(Result, X) to get the final answer
