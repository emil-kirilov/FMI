#lang racket

(define (re m n)
  (modulo m n))

(define (gsd m n)
  (if (< m n)
      (let ((remainder (re n m)))
        (if (= remainder 0)
            m
            (gsd m remainder)))
      (let ((remainder (re m n)))
        (if (= remainder 0)
            n
            (gsd n remainder)))))
        
