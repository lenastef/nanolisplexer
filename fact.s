; Notkun: (main)
; Fyrir:  Ekkert
; Eftir:  B�i� er a� skrifa 100!
(define (main)
  (writeln (++ "100! = " (fact2 (bigInteger 1) 100)))
)

; Notkun: (fact2 x n)
; Fyrir:  x og n eru heilt�lur, n>=0,
;         x er BigInteger.
; Gildi:  Heiltalan n!*x sem BigInteger
(define (fact2 x n)
  (if (== n 0)
      x
      (fact2 (* x n) (- n 1))
  )
)