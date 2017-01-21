#lang racket

(define (fast-pow a b)
  (if (= b 0)
      1
      (if (= 0 (modulo b 2))
         (fast-pow (* a a) (/ b 2))
         (* a (fast-pow a (- b 1))))))

(define (pow-r a b)
  (if (= b 0)
      1
      (* a (pow-r a (- b 1)))))

(define (pow-tail-r a b res)
  (if (= b 0)
      res
      (pow-tail-r a (- b 1) (* a res))))