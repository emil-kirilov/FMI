#lang racket

(define (prime n i)
  (if (> (+ 1 (quotient n 2)) i)
      (if (= 0 (modulo n i))
          #f
          (prime n (+ 1 i)))
      #t))

(define (prime? n)
  (if (prime n 2)
      #t
      #f))

(define (generate n i)
  (if (< n 0)
      (- i 1)
      (if (prime? i)
          (generate (- n 1) (+ 1 i))
          (generate n (+ 1 i)))))
      
  

(define (nth-prime n)
  (generate n 1))