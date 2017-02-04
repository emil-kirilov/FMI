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

(define (pp x)
  (quotient  x 2))