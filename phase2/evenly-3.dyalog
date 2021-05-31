 Divvy←{   
     ⍝ Problem 3 - divide a vector ⍵ into ⍺ parts as evenly as possible while preserving order.
     w←⍵⍴⍨⊃1,⍨⍴⍵                                   ⍝ Reshape scalars
     n←⍴w                                          ⍝ Length of ⍵
     overflowing←⌈⍺÷⍨⍴w                            ⍝ Length of large subvectors
     underflowing←⌊⍺÷⍨⍴w                           ⍝ Length of small subvectors
     diff←(⍴w)-underflowing×⍺                      ⍝ The number of subvectors to shorten
     gaps←(diff⍴overflowing),(⍺-diff)⍴underflowing ⍝ Lengths of subvectors combined
     rotations←¯1×¯1⌽+\gaps                        ⍝ Rotations of replication masks
     rotations[1]←0                                ⍝ The first mask starts from the first element of w
     rreps←⍺∘{1 0/⍨⍵,n-⍵}¨gaps                     ⍝ Bitmasks for the elements of w
     masks←rotations⌽¨rreps                        ⍝ Rotated bit masks

     w∘{⍵/⍺}¨masks                                 ⍝ Enclosed w replicated over all appropriate bitmasks
 }
