(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
             (else (filter p? (cdr l)))))


(define (foldr op nv l)
  (if (null? l) l
      (op (car l) (foldr op nv (cdr l)))))

(define (foldl op nv l)
  (if (null? l) l
      (foldl op (op nv (car l)) (cdr l))))

(define (my-length l)
  (if (null? l) 0
      (+ 1 (my-length (cdr l)))))

(define (nth l index)
  (if (null? l)
      #f
      (if (= index 0)
          (car l)
          (nth list (- index 1)))))

(define (my-map f l)
  (if (null? l)
      l
      (cons (f (car l)) (my-map f (cdr l)))))

(define (meetTwice? f g a b)
  (twice (lambda (x) (= (f x) (g x))) (range a b)))

(define (twice predicate list)
  (if (null? list)
      #f
      (if (predicate (car list))
          (any? predicate (cdr list))
          (twice predicate (cdr list)))))

(define (any? predicate list)
  (if (null? list)
      #f
      (if (predicate (car list))
          #t
          (any? predicate (cdr list)))))

(define (range a b)
  (if (> a b)
      '()
      (cons a (range (+ 1 a) b))))

(define (maxDuplicate L)
  (apply max (map (lambda (l) (findMaxDuplicate l))  L)))
  ;(map (lambda (l) (cddr l)) L))

  
(define (findMaxDuplicate l)
  (my-max (filter (lambda (x) (member x (remove-once x l))) l)))
  ;(filter (lambda (x) (member x (remove-once x l))) l))
  
(define (my-max list)
  (define (find-max list curMax)
    (if (null? list) curMax
        (if (< curMax (car list))
            (find-max (cdr list) (car list))
            (find-max (cdr list) curMax))))
  (if (null? list)
      -inf.0
      (find-max list (car list))))

(define (remove-once x list)
  (if (null? list) list
      (if (= x (car list))
          (cdr list)
          (cons (car list) (remove-once x (cdr list))))))

(define (checkMatrix? m k)
  (all? (lambda (boolean) (if boolean #t #f)) (map (lambda (l) (any? (lambda (x) (= 0 (remainder x k)))  l)) m)))

(define (all? p list)
  (if (null? list)
      #t
      (if (p (car list))
          (all? p (cdr list))
          #f)))

(define (longestDescending list)
  (map (lambda (x) all-dec-sorted list (car list)) list))

(define (all-dec-sorted list curEl)
  (if (null? list) list
      (if (<= (car list) curEl)
          (cons (car list) (all-dec-sorted (cdr list) (car list)))
          '())))
          ;(all-dec-sorted list (car list)))))

(define (sum-digits k)
  (if (= 0 x)
      (+ (reminder x 10) (sum-digits (quotient x 10)))))
  
;(define (min-sum-digit a b k)
; (apply min (filter (lambda (x) (= 0 (remainder x k))) (map (lambda (x) (/ x k)) (map sum-digits (range a b))))))

  (define (average f g)
    (lambda (x) (/ (+ (f x) (g x)) 2)))

  (define (accumulate op nv term a b next)
    (if (> a b)
        nv
        (op (term a) (accumulate op nv term (next a) b next))))

  (define (g i)
    (lambda (x) (expt i x)))
  (define (calprod f n)
    (accumulate * 1 (lambda (i) (average f (g i)) i)) 1 n (lambda (i) (+ 1 i)))

(define (occurences-list val list)
    (length (filter (lambda (x) (= x val)) list)))

(define (occur list1 list2)
  (map (lambda (x) (occurences-list x list2)) list1))
  
  