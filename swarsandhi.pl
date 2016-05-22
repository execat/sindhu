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

guna(i, e).
guna(u, o).
guna(ṛ, ar).
guna(ḷ, al).

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
%% [māl, ā], [lṛ, kāraḥ], [māl, al, kāraḥ]

resolve(X_body, X_last, Y_head, Y_rest, XY, Type):-
    % Validate
    validate(X_body, X_last, Y_head, Y_rest),
    % Check if the first is a or ā
    member(X_last, [a, ā]),
    % Check if the second is any of the rest
    member(Y_head, [i, ī, u, ū, ṛ, ṝ, ḷ]),
    % Find the guṇa
    guna(Y_head, Guna),

    append([X_body], [Guna], T1),
    append(T1, [Y_rest], XY),
    % Set type
    Type = 'guṇa'.

% Disable validate
validate(_, _, _, _).

% Validate block
validate(X_body, X_last, Y_head, Y_rest):-
    % Make sure the words are in the dictionary
    atom_concat(X_body, X_last, X), dictionary(X),
    atom_concat(Y_head, Y_rest, Y), dictionary(Y).
dictionary(X):- fail.

% Use atomic_list_concat(Result, X) to get the final answer
