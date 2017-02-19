#lang racket

(define (fibo n x y)
  (if (> n 0)
      (fibu (- n 1) (+ x y) x)
      x))

(define (fib n)
  (fibo n 0 1))
  