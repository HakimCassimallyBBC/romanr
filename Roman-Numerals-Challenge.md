Academy Coding Challenge \#1
================
Megan Stodel
10/11/2020

    source('roman_numerals.R')

Here are some that work:

    unroman('III')

    ## [1] 3

    unroman('XIX')

    ## [1] 19

    unroman('MDCCXCVI')

    ## [1] 1796

The additional constraints
--------------------------

-   You can’t repeat a Unit character more than 3 times (e.g. IIII,
    XXXX, etc. are disallowed)

<!-- -->

    unroman('IIII')

    ## Error in unroman("IIII"): Do not repeat I, X or C more than 3 times consecutively.

-   You can’t repeat a Five character (e.g. VV, LL, DD are disallowed)

<!-- -->

    unroman('VV')

    ## Error in unroman("VV"): Do not repeat V, D, or L.

-   You can only subtract a unit from next highest five/unit, (e.g. IV
    and IX are allowed, but IL and IM aren’t)

<!-- -->

    unroman('IV')

    ## [1] 4

    unroman('IL')

    ## Error in set_rules(later_letters, "I", 1, total): You are trying to subtract I in an impossible way.

-   You can only subtract a single unit (e.g. IIX is disallowed)

<!-- -->

    unroman('IIX')

    ## Error in set_rules(later_letters, "I", 1, total): You can only use I once to subtract.

-   You can’t subtract and add units to same number (e.g. IXI is
    disallowed)

<!-- -->

    unroman('IXI')

    ## Error in set_rules(later_letters, "I", 1, total): You can't add and subtract the same letter.

-   Except for subtractions, all digits are in nonincreasing order

<!-- -->

    unroman('XXMC')

    ## Error in set_rules(later_letters, "X", 10, total): You are trying to subtract X in an impossible way.

-   What happens in the case of an invalid roman numeral like “ABCDE”?

<!-- -->

    unroman('ABCDE')

    ## Error in unroman("ABCDE"): Invalid characters used; only I V C L C D M are valid characters.

-   What happens in the case of a malformed numeral like “ICXXXXIIVV”?

<!-- -->

    unroman("ICXXXIIV")

    ## Error in set_rules(later_letters, "I", 1, total): You are trying to subtract I in an impossible way.
