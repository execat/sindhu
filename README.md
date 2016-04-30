# sindhu

Sandhi resolver written in Prolog.

The rest of the README uses [ITRANS](https://en.wikipedia.org/wiki/ITRANS).

## How sandhis work?

The basic principle of sandhi is that two vowels should not be next to each other. In Devanagari, available vowels are as follows:















## ITRANS helper

| Devanāgarī                        | ITRANS  |
|-----------------------------------|---------|
| अ                                 | a       |
| आ                                 | aa      |
| इ                                 | i       |
| ई                                 | I/ii    |
| उ                                 | u       |
| ऊ                                 | U/uu    |
| ए                                 | e       |
| ऐ                                 | ai      |
| ओ                                 | o       |
| औ                                 | au      |
| ऋ                                 | RRi/R^i |
| ॠ                                 | RRI/R^I |
| ऌ                                 | LLi/L^i |
| ॡ                                 | LLI/L^I |
| अं (added as anusvāra)             | .m/N/.m |
| अः                                 | H       |
| अँ                                 | .N      |
| ् (virāma/halant)                  | .h      |
| ऽ (avagraha:elision during sandhi) | .a     |
| Om symbol                         | OM,AUM  |

The Devanāgarī consonant letters include an implicit 'a' sound. In all of the transliteration systems, that 'a' sound must be represented explicitly.

| Devanāgarī | ITRANS |
|------------|--------|
| क          | ka     |
| ख          | kha    |
| ग          | ga     |
| घ          | gha    |
| ङ          | ~Na    |
| च          | cha    |
| छ          | Cha    |
| ज          | ja     |
| झ          | jha    |
| ञ          | ~na    |
| ट          | Ta     |
| ठ          | Tha    |
| ड          | Da     |
| ढ          | Dha    |
| ण          | Na     |
| त          | ta     |
| थ          | tha    |
| द          | da     |
| ध          | dha    |
| न          | na     |
| प          | pa     |
| फ          | pha    |
| ब          | ba     |
| भ          | bha    |
| म          | ma     |
| य          | ya     |
| र          | ra     |
| ल          | la     |
| व          | va/wa  |
| श          | sha    |
| ष          | Sha    |
| स          | sa     |
| ह          | ha     |

| Devanāgarī | ITRANS     |
|-----------|-------------|
| क्ष        | kSa/kSha/xa |
| त्र        | tra         |
| ज्ञ        | GYa/j~na    |
| श्र        | shra        |

| Devanāgarī | ITRANS  |
|-----------|----------|
| क़         | qa       |
| ख़         | Kha      |
| ग़         | Ga       |
| ज़         | za       |
| फ़         | fa       |
| ड़         | .Da/Ra   |
| ढ़         | .Dha/Rha |
