; NanoLisp prófunarforrit.
; Höfundur: Snorri Agnarsson, desember 2021.

; Notkun: (fibo i f1 f2 n)
; Fyrir:  i og n eru heiltölur, 0 <= i <= n
;         f1 er i-ta Fibonacci talan, f2 er
;         (i+1)-ta Fibonacci talan.
; Gildi:  n-ta Fibonacci talan
(define (fibo i f1 f2 n)
  (if (== i n)
      f1
      (fibo (+ i 1) f2 (+ f1 f2) n)
  )
)

; Notkun: (main)
; Fyrir:  Ekkert
; Eftir:  Búið er að reikna og skrifa fibo(1000)
(define (main)
  (writeln (++ "fibo(1000) = "
               (fibo 0 0 (bigInteger 1) 1000)
           )
  )
)
