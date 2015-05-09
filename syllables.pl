%% Vowels
vowel("a"). vowel("ā"). vowel("i"). vowel("ī"). vowel("u"). vowel("ū").
vowel("ṛ"). vowel("ṝ"). vowel("ḷ"). vowel("ḹ"). vowel("e"). vowel("ai").
vowel("o"). vowel("au").

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

%% terminal/2 :: A terminal letter from each varga
terminal(kavarga, "ṅ"). terminal(cavarga, "ñ"). terminal(ṭavarga, "ṇ").
terminal(tavarga, "n"). terminal(pavarga, "m").

%% syllable/1 :: A syllable is any of the above consonant sounds
syllable(X):- kavarga(X).
syllable(X):- cavarga(X).
syllable(X):- ṭavarga(X).
syllable(X):- tavarga(X).
syllable(X):- pavarga(X).
syllable(X):- semivowel(X).
syllable(X):- s_sound(X).
syllable(X):- h_sound(X).

%% syllable/2 :: A syllable given its varga
syllable(kavarga, X):- kavarga(X).
syllable(cavarga, X):- cavarga(X).
syllable(ṭavarga, X):- ṭavarga(X).
syllable(tavarga, X):- tavarga(X).
syllable(pavarga, X):- pavarga(X).
syllable(semivowel, X):- semivowel(X).
syllable(s_sound, X):- s_sound(X).
syllable(h_sound, X):- h_sound(X).

%% consonant/2 :: A consonant is a syllable with "a" (full sound)
consonant(X, Ans):-
    syllable(X),
    string_concat(X, "a", Ans).

%% compound_consonant/2 :: A compound consonant is a letter from same varga
compound_consonant(X, Y, Ans):-
    syllable(Varga, X), syllable(Varga, Y),
    terminal(Varga, Y), X \== Y,
    string_concat(Y, "a", Complete_Y),
    string_concat(X, Complete_Y, Ans).
