⍝ Problem 1 - Bacteria
⍝ The aim is to output the percentage of G or C in the string ⍵
bacteria←{100×+/(⍵∊'GC')÷≢⍵}

⍝ Problem 2 - Index of
⍝ The expression here must compute index of (dyadic ⍳) except for the elements that do not belong to ⍺.
⍝ The elements of ⍵ not found in ⍺ should return 0 instead of 1+≢⍺.
indexOf←{(1+≢⍺)|⍺⍳⍵} ⍝ Here, we naïvely return the remainder of the division of ⍺⍳⍵ by 1+≢⍺

⍝ Problem 3 - Multiplicity
⍝ Which elements of ⍵ are multiples of each element of ⍺?
⍝ Return them as a vector (in the order of ⍺) of vectors (in the order of ⍵).
multiplicity←{(⍵/⍨⊢)¨0=(,⍺)∘.|⊂,⍵} ⍝ Here, we ravel ⍵ and ⍺ in case either is a scalar
⍝ Then, we compute the nested vector of remainders of division of each ⍵ by each ⍺.
⍝ The last operation is a filter of ⍵.
⍝ Perhaps, enclosing each vector of remainders is clumsy, but I have not thought of another way of getting rid
⍝ of spurious zeros.

⍝ Problem 4 - Square pegs, round holes
⍝ Abbreviated statement: we wish to return the differences in the area of disks
⍝ and squares inscribed in circles limiting disks. The argument ⍵ is the vector of diameters
⍝ of the disks.
sprh←(○ 2*⍨2÷⍨⊢)-(2÷⍨2*⍨⊢) ⍝ This expression is quite naïve: take compute the areas, then subtract.

⍝ Problem 5 - Rect-ify
⍝ The goal is to plant ⍵ trees in the nodes of a rectangular grid so that
⍝ - all the nodes of the grid are occupied
⍝ - no trees remain
⍝ - the (integer) sides of the grid are the closest possible.
⍝ For example, 9 becomes:
⍝ ⍋ ⍋ ⍋
⍝ ⍋ ⍋ ⍋
⍝ ⍋ ⍋ ⍋, or 3 3
⍝ Similarly, 8 becomes:
⍝ ⍋ ⍋ ⍋ ⍋
⍝ ⍋ ⍋ ⍋ ⍋, or 2 4
rectify←{0=⍵:2⍴0 ⋄ (⍵÷md),⍨md←⌈/⍸0=⍵|⍨d←⍳⌊⍵*0.5}
⍝ The idea here is to pick the (compatible) divisors of ⍵ right from the middle
⍝ of the array of divisors of ⍵.
⍝ The guard 0=⍵:2⍴0 is to ensure returning 0 0 for the zero argument.
⍝ Without the guard, ⌈/⍬, where ⍬≡⍳0, returns the lowest floating point value.

⍝ Problem 6 - Fischer random chess
⍝ Here, the argument ⍵ is a permutation of the lowest row of chess pieces.
⍝ The function must validate the input ⍵ against 2 conditions:
⍝ 1) The Bishops must be placed on opposite-color squares.
⍝ 2) The King must be placed on a square between the rooks.
⍝ Notation: the identity permutation is 'RNBQKBNR' for the whites.
chess←{(2|(+/∘⍸'B'=⊢) ⍵)∧'RKR'≡('KR'∊⍨⍵)/⍵}
⍝ This solution consists of validating ⍵ agains 2 predicates:
⍝ - all pieces that are either King or Rook are exactly 'RKR' when filtered
⍝ - the sum of the indices of the Bishops is odd (only works when 2 bishops are provided in the permutation).

⍝ Problem 7 - Can you feel the magic?
⍝ Here, we check whether the argument (a matrix) is a magic square.
magic←(⊃∧.=⊢)(+/⌽⍉⍨1*⍴∘⊢),(+/1 1⍉⊢),(+/⊢),+⌿
⍝ This solution concatenates the sums:
⍝ - of rows (+/⊢)
⍝ - of columns (+⌿)
⍝ - of the diagonal (+/1 1⍉⊢) and the antidiagonal (+/⌽⍉⍨1*⍴∘⊢)
⍝ The left-most expression checks if its argument (the vector of sums)
⍝ is a vector of replicas of one element (⊃∧.=⊢).

⍝ Problem 8 - Time to make a difference
⍝ The arguments ⍺ and ⍵ are vectors of the form [[days] hours] minutes.
⍝ Days and hours are optional.
⍝ The goal is to compute the difference between ⍺ and ⍵ in minutes.
⍝ Edge cases, such as time→summer time transitions and leap secons are disregarded.
timediff←|(0 24 60⊥¯3↑⊣)-0 24 60⊥¯3↑⊢
⍝ Here, we decode ⍺ and ⍵ in bases inf, 24, 60 and find the absolute value
⍝ of the difference of the decoded values.

⍝ Problem 9 - In the long run
⍝ Given a vector of integers of length at least 2, we wish to compute the length
⍝ of the longest:
⍝ - strictly ascending
⍝ - strictly descending
⍝ - strictly flat
⍝ run. The type of the movement is deduced from the movement relative to each previous value.
⍝ In practical terms, this means that in a length-2 vector, we return 1 whatever happens.
⍝ The vector 1 2 3 5 5 5 6 4 3 has the longest run 2 3 5
⍝              ^ ^ ^           , the first element 1 is excluded from it.
run←{-⌊/2-/((2≠/¯13,×2-/⍵),1)/⍳⍴⍵}
⍝ This solution compresses the indices (⍳⍴⍵) of ⍵ with the binary mask (2≠/¯13,×2-/⍵),1.
⍝ Note that 1 is concatenated to the end of pairwise comparisons. This is because we want the last element
⍝ of the sequence to belong in the run that ends with it. One needs only to imagine a length-2 vector
⍝ to understand why this is necessary.
⍝ ¯13 is an arbitrary constant prepended to the signum vector ×2-/⍵ to systematically exclude
⍝ the first element from any run while padding the signum vector to the shape of ⍵.

⍝ Problem 10 - On the right side
⍝ Here, we wish to right-align a character or a character vector or a nested vector of character vectors ⍵
⍝ to form a character matrix of width ⍺.
rightAlign←{d1←1=≡⍵ ⋄ e←(⊂⍣d1) ⍵ ⋄ ↑(-⍺)↑¨e}
⍝ Note the first 2 expressions: d1←1=≡⍵ (is ⍵ of depth 1?)
⍝ and e←(⊂⍣d1)⍵ (enclose ⍵ if its depth is 1, or, equivalently d1 is 1).
⍝ This rather clumsy contraption serves only to make the expression ↑(-⍺)↑¨e work with



