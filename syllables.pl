%%
%% Vowels
%%

%% List of vowels
vowel("a"). vowel("ā"). vowel("i"). vowel("ī"). vowel("u"). vowel("ū").
vowel("ṛ"). vowel("ṝ"). vowel("ḷ"). vowel("ḹ"). vowel("e"). vowel("ai").
vowel("o"). vowel("au").

%% Establish relation between long and short vowels
long("a", "ā").
long("i", "ī").
long("u", "ū").
long("ṛ", "ṝ").
long("ḷ", "ḹ").
long("e", "ai").
long("o", "au").

%% Strength heirarchy of vowels
strong("i", "e"). strong("ī", "e"). strong("e", "ai").
strong("u", "o"). strong("ū", "o"). strong("o", "au").
strong("r", "ar"). strong("ṝ", "ar"). strong("ar", "ār").

%%
%% Varga definitions
%%

%% ka-varga
kavarga("k"). kavarga("kh"). kavarga("g"). kavarga("gh"). kavarga("ṅ").
%% ca-varga
cavarga("c"). cavarga("ch"). cavarga("j"). cavarga("jh"). cavarga("ñ").
%% ṭa-varga
ṭavarga("ṭ"). ṭavarga("ṭh"). ṭavarga("ḍ"). ṭavarga("ḍh"). ṭavarga("ṇ").
%% ta-varga
tavarga("t"). tavarga("th"). tavarga("d"). tavarga("dh"). tavarga("n").
%% pa-varga
pavarga("p"). pavarga("ph"). pavarga("b"). pavarga("bh"). pavarga("m").
%% semivowels
semivowel("y"). semivowel("r"). semivowel("l"). semivowel("v").
%% s-sounds
s_sound("ś"). s_sound("ṣ"). s_sound("s").
%% h-sounds
h_sound("h").
%% no sound
no_sound("").

%% terminal/2 :: A terminal letter from each varga
terminal(kavarga, "ṅ"). terminal(cavarga, "ñ"). terminal(ṭavarga, "ṇ").
terminal(tavarga, "n"). terminal(pavarga, "m").

%%
%% Syllable forming rules
%%

%% syllable/1 :: A syllable is any of the above consonant sounds
syllable(X):- kavarga(X).
syllable(X):- cavarga(X).
syllable(X):- ṭavarga(X).
syllable(X):- tavarga(X).
syllable(X):- pavarga(X).
syllable(X):- semivowel(X).
syllable(X):- s_sound(X).
syllable(X):- h_sound(X).
syllable(X):- no_sound(X).

%% syllable/2 :: A syllable given its varga
syllable(kavarga, X):- kavarga(X).
syllable(cavarga, X):- cavarga(X).
syllable(ṭavarga, X):- ṭavarga(X).
syllable(tavarga, X):- tavarga(X).
syllable(pavarga, X):- pavarga(X).
syllable(semivowel, X):- semivowel(X).
syllable(s_sound, X):- s_sound(X).
syllable(h_sound, X):- h_sound(X).
syllable(no_sound, X):- no_sound(X).

%%
%% Consonant forming rules
%%

%% consonant/2 :: A consonant is a syllable with "a" (full sound)
consonant(X, Ans):-
    syllable(X),
    string_concat(X, "a", Ans).

%% compound_consonant/2 :: A compound consonant is a letter from same varga
compound_consonant(X, Y, Ans):-
    syllable(X), syllable(Y),
    string_concat(X, Y, Ans).

%%
%% Sandhi rules
%%

% Similar vowels rule
% Example:
% sandhi(["bha", "va"], ["a", "r", "ju", "na"], Ans).
% ["bha", "vā", "r", "ju", "na"]
sandhi(Xs, Ys, Ans):-
    % Split
    split(Xs, Xs_first, Xs_rest, Xs_last),
    split(Ys, Ys_first, Ys_rest, Ys_last),
    % Test
    % Condition: similar vowels while combining
    Xs_last = [Xs_last_string],
    Ys_first = [Ys_first_string],
    decompose(Sx_syllable, Sx_vowel, Xs_last_string),
    decompose(Sy_syllable, Sy_vowel, Ys_first_string),
    Sx_vowel == Sy_vowel,
    Sy_syllable == "",

    % Combine
    long(Sy_vowel, S_combine),
    string_concat(Sx_syllable, S_combine, S_Ans),
    S_combine_word = [S_Ans],

    append(Xs_first, Xs_rest, Ans_1),
    append(Ys_rest, Ys_last, Ans_3),
    append(Ans_1, S_combine_word, Ans_2),
    append(Ans_2, Ans_3, Ans).

%% Decompose helper
decompose(Syllable, Vowel, Ans):-
    syllable(Syllable),
    vowel(Vowel),
    string_concat(Syllable, Vowel, Ans).

%% Split helper
split(Xs, Xs_first, Xs_rest, Xs_last):-
    append(Xs_1, Xs_last, Xs),
    length(Xs_last, 1),
    append(Xs_first, Xs_rest, Xs_1).
    % With this, you can solve "bhava + arjuna" to get solution once
    % But not get solution for "su + ukta"
    % length(Xs_first, 1).
