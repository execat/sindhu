%%
%% Vowels
%%

%% List of vowels
vowel("a"). vowel("ā"). vowel("i"). vowel("ī"). vowel("u"). vowel("ū").
vowel("ṛ"). vowel("ṝ"). vowel("ḷ"). vowel("ḹ"). vowel("e"). vowel("ai").
vowel("o"). vowel("au").

% These can combine only with vowels
% vowel("ḥ"). vowel("ṃ"). vowel("'").

%% <== http://learnsanskrit.org/sounds/review

%% Establish relation between long and short vowels
long("a", "ā").
long("i", "ī").
long("u", "ū").
long("ṛ", "ṝ").
long("ḷ", "ḹ").
long("e", "ai").
long("o", "au").

%% Establish relation between vowels and semivowels

%% Strength heirarchy of vowels
strong("a", "ā"). strong("ā", "ā").
strong("i", "e"). strong("ī", "e"). strong("e", "ai"). strong("ai", "ai").
strong("u", "o"). strong("ū", "o"). strong("o", "au"). strong("au", "au").
strong("r", "ar"). strong("ṝ", "ar"). strong("ar", "ār"). strong("ār", "ār").

%% Semivowel mapping
semivowel("i", "y"). semivowel("ī", "y"). semivowel("e", "y"). semivowel("ai", "y").
semivowel("ṛ", "r"). semivowel("ṝ", "r"). semivowel("ar", "r"). semivowel("ār", "r").
semivowel("u", "v"). semivowel("ū", "v"). semivowel("o", "v"). semivowel("au", "v").

% ==>

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
%% ya-varga
semivowel("y"). semivowel("r"). semivowel("l"). semivowel("v").
yavarga(X):- semivowel(X).
%% śa-varga
s_sound("ś"). s_sound("ṣ"). s_sound("s").
h_sound("h").
śavarga(X):- s_sound(X).
śavarga(X):- h_sound(X).

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
syllable(yavarga, X):- yavarga(X).
syllable(śavarga, X):- śavarga(X).
syllable(no_sound, X):- no_sound(X).

%%
%% Consonant forming rules
%% These two are not used anywhere and probably need to get better
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

%%
%% Rule 1
%%

% Similar vowels rule
% Examples:
% sandhi(["bha", "va"], ["a", "r", "ju", "na"], Ans).
%   Ans = ["bha", "vā", "r", "ju", "na"] .
% sandhi(["da", "g", "dha"], ["a", "ra", "ṇ", "ya"], Ans).
%   Ans = ["da", "g", "dhā", "ra", "ṇ", "ya"] .
% sandhi(["su"], ["u", "kta"], Ans).
%   Ans = ["sū", "kta"] .
sandhi(Xs, Ys, Ans):-
    % Split
    split_tail(Xs, Xs_body, Xs_tail),
    split_head(Ys, Ys_head, Ys_rest),

    % Test
    % Condition: similar vowels while combining
    Xs_tail = [Xs_last_string],
    Ys_head = [Ys_first_string],
    decompose(Sx_syllable, Sx_vowel, Xs_last_string),
    decompose(Sy_syllable, Sy_vowel, Ys_first_string),
    Sx_vowel == Sy_vowel,
    Sy_syllable == "",

    % Combine
    long(Sy_vowel, S_combine),
    string_concat(Sx_syllable, S_combine, S_Ans),
    S_combine_word = [S_Ans],

    % Get part 1
    append(Xs_body, S_combine_word, Ans_1),
    % Combine part 1 with rest of the word
    append(Ans_1, Ys_rest, Ans),
    print("Rule 1").

%%
%% Rule 2
%%

% Dissimilar vowels rule
% Examples:
% sandhi(["rā", "ja"], ["i", "n", "dr", "aḥ"], Ans).
%   Ans = ["rā", "je", "n", "dr", "aḥ"] .
% sandhi(["hi", "ta"], ["u", "pa", "de", "ś", "aḥ"], Ans).
%   Ans = ["hi", "to", "pa", "de", "ś", "aḥ"] .
% sandhi(["ta", "s", "ya"], ["au", "dā", "r", "ya", "m"], Ans).
%   Ans = ["ta", "s", "yau", "dā", "r", "ya", "m"] ;
% Failure: mahā ṛṣiḥ → maharṣiḥ (महा ऋषिः → महर्षिः)
sandhi(Xs, Ys, Ans):-
    % Split
    split_tail(Xs, Xs_body, Xs_tail),
    split_head(Ys, Ys_head, Ys_rest),

    % Test
    % Condition: dissimilar vowels while combining
    Xs_tail = [Xs_last_string],
    Ys_head = [Ys_first_string],
    decompose(Sx_syllable, Sx_vowel, Xs_last_string),
    decompose(Sy_syllable, Sy_vowel, Ys_first_string),
    member(Sx_vowel, ["a", "ā"]),
    Sy_syllable == "",

    % Combine
    strong(Sy_vowel, S_combine),
    string_concat(Sx_syllable, S_combine, S_Ans),
    S_combine_word = [S_Ans],

    % Get part 1
    append(Xs_body, S_combine_word, Ans_1),
    % Combine part 1 with rest of the word of word 2
    append(Ans_1, Ys_rest, Ans),
    print("Rule 2").

%%
%% Rule 3
%%

% Change the first vowel to semivowel
% Examples
% sandhi(["i", "ti"], ["ā", "ha"], Ans).
%   Ans = ["i", "ty", "ā", "ha"] .
% sandhi(["a", "pi"], ["a", "sya"], Ans).
%   Ans = ["a", "py", "a", "sya"] .
% sandhi(["ma", "dhu"], ["i", "va"], Ans).
%   Ans = ["ma", "dhv", "i", "va"] .
sandhi(Xs, Ys, Ans):-
    % Split
    split_tail(Xs, Xs_body, Xs_tail),

    % Test
    % Condition: dissimilar vowels while combining
    Xs_tail = [Xs_last_string],
    decompose(Sx_syllable, Sx_vowel, Xs_last_string),
    % Change this to member
    not(member(Sx_vowel, ["a", "ā"])),

    % Combine
    semivowel(Sx_vowel, S_combine),
    string_concat(Sx_syllable, S_combine, S_Ans),
    S_combine_word = [S_Ans],

    % Get part 1
    append(Xs_body, S_combine_word, Ans_1),
    % Combine part 1 with rest of the word of word 2
    append(Ans_1, Ys, Ans),
    print("Rule 3").

%%
%% Rule 4
%%

simple_vowel_rule("i", "iy").
simple_vowel_rule("ī", "iy").
simple_vowel_rule("u", "uv").
simple_vowel_rule("ū", "uv").
simple_vowel_rule("ṝ", "ir").

% Change the both the vowels
% Examples
% sandhi(["dhī"], ["i"], Ans).
%   Ans = ["dhy", "i"] ;
%   Ans = ["dhiy", "i"] .
% sandhi(["bhū"], ["i"], Ans).
%   Ans = ["bhv", "i"] ;
%   Ans = ["bhuv", "i"] ;
% sandhi(["gṝ"], ["a"], Ans), sandhi(Ans, "ti", Ans_final).
sandhi(Xs, Ys, Ans):-
    % Split
    split_tail(Xs, Xs_body, Xs_tail),

    % Test
    % Condition: dissimilar vowels while combining
    Xs_tail = [Xs_last_string],
    decompose(Sx_syllable, Sx_vowel, Xs_last_string),
    member(Sx_vowel, ["i", "ī", "u", "ū", "ṝ"]),

    % Combine
    simple_vowel_rule(Sx_vowel, S_combine),
    string_concat(Sx_syllable, S_combine, S_Ans),
    S_combine_word = [S_Ans],

    % Get part 1
    append(Xs_body, S_combine_word, Ans_1),
    % Combine part 1 with rest of the word of word 2
    append(Ans_1, Ys, Ans),
    print("Rule 4").

% sandhi(["vi", "d", "yā"], ["ā", "la", "ya", "ḥ"], Ans).
% sandhi(["na", "ma", "si"], ["ī", "ś", "va", "ra", "m"], Ans). FAILS
% sandhi(["bhā", "nu"], ["u", "da", "ya", "ḥ"], Ans). TWO WRONG ANSWERS
% sandhi(["pi", "tṛ"], ["ṝ", "ṇa", "m"], Ans). FAILS
%
% sandhi(["u", "pa"], ["i", "n", "dra", "ḥ"], Ans).
% sandhi(["sū", "r", "ya"], ["u", "dayaḥ"], Ans).
% sandhi(["g", "rī", "ṣ", "ma"], ["ṛ", "tu", "ḥ"], Ans). FAILS
% sandhi(["ta", "va"], ["ḷ", "va", "r", "ṇa", "ḥ"], Ans).
%
% kṛṣṇa + ekatvam = kṛṣṇaikatvam
% bhava + oṣadham = bhavauṣadham
% bhoga + aiśvaryam = bhogaiśvaryam
% paśyatha + augham = paśyathaugham
%
% ati + utratam = atyutratam
% madhu + etat = madhvetat
% pitṛ + ājñā = pitrājñā
% ḷ + ākṝtiḥ = lākṝtiḥ
%
% ati + utratam = atyutratam
% madhu + etat = madhvetat
% pitṛ + ājñā = pitrājñā
% ḷ + ākṝtiḥ = lākṝtiḥ
%
%
% te + āsan = tayāsan or ta āsan
% te + iha = tayiha or ta iha
%
% prabho + ehi = prabhavehi or prabha ehi
% munaye + anna = munaye'nna
% prabho + adhunā = prabho'dhunā
%
% tasmai + adāt = tasmāyadāt or tasmā adāt
% tasmai + uttam = tasmāyuttam or tasmā uttam
%
% tau + iha = tāviha or tā iha
% tau + eva = tāveva or tā eva
%
% hari + etau = hari etau
% viṣṇū + emau = viṣṇū emau
% gaṅge + amū = gaṅge amū
%
% brahmā + ṛṣiḥ = brahmārṣi or brahmā ṛṣiḥ
% sapta + ṛṣīṇām = saptarṣīṇām or sapta ṛṣīṇām

%%
%% Utilities
%%

%% Decompose helper
decompose(Syllable, Vowel, Ans):-
    syllable(Syllable),
    vowel(Vowel),
    string_concat(Syllable, Vowel, Ans).

%% Gets first element
split_head(Xs, Xs_first, Xs_rest):-
    append(Xs_first, Xs_rest, Xs),
    length(Xs_first, 1).

%% Gets last element
split_tail(Xs, Xs_body, Xs_tail):-
    append(Xs_body, Xs_tail, Xs),
    length(Xs_tail, 1).
