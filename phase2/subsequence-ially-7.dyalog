 sseq←{
     ⍝ Task 1 of Problem 7 (Phase II):
     ⍝ Find a (possibly non-contiguous) occurrence of the subsequence ⍵ in ⍺

     filtered←⍺/⍨⍺∊⍵                   ⍝ Only keep symbols from the subalphabet defined by ⍵
     indices←(⍺∊⍵)/⍳⍴⍺                 ⍝ Where do the appropriately filtered symbols reside?
     f←⍵⍷filtered                      ⍝ Find the substring ⍵ in the filtered string
     found←∨/f                         ⍝ Are there any matches?
     ifound←¯1+(⍳⍴⍵)+⊃⍸f               ⍝ Indices of the first match
     (1⍴found)(ifound⍴⍨found×⍴ifound)  ⍝ If no matches are found, we reshape the indices into ⍬
 }
