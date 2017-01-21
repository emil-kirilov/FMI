;2-ра задача
(define (checksum L)
  (all? (lambda (boolean) boolean) (number-in-other-lists? L)))

(define (number-in-other-lists? L)
  (define (sum-of-other-list? list i)
    (any-minus-i? (lambda (x) (member x (sums-lists L))) list i))
  
  (map (lambda (l i) (sum-of-other-list? l i)) L (range 0 (length L))))

(define (range a b)
  (if (> a (- b 1))
      '()
      (cons a (range (+ 1 a) b))))

(define (sums-lists L)
  (map (lambda (l) (sum-list l)) L))

(define (sum-list l)
  (if (null? l)
      0
      (+
       (car l)
       (sum-list (cdr l)))))

(define (any? pred list)
  (if (null? list)
      #f
      (if (pred (car list))
          #t
          (any? pred (cdr list)))))

(define (any-minus-i? pred list i)
  (if (null? list)
      #f
      (if (= i 0)
          (any? pred (cdr list))
          (if (pred (car list))
              #t
              (any-minus-i? pred (cdr list) (- i 1))))))

(define (all? pred list)
  (if (null? list)
      #t
      (if (pred (car list))
          (all? pred (cdr list))
          #f)))

;3-та задача
(define (exists-increasing? m)
  (any? incr-list? (transpose m)))

(define (incr-list? list)
  (define (helper list prevEl)
    (if (null? list)
        #t
        (if (< (car list) prevEl)
            #f
            (helper (cdr list) (car list)))))
  
  (if (null? list)
      #t
      (helper (cdr list) (car list))))

(define (transpose m)
  (map (lambda (i) (take-column-i m i)) (range 0 (width m))))

(define (width m)
  (if (null? m)
      0
      (if (null? (car m))
          0
          (length (car m)))))

(define (take-column-i m i)
  (map (lambda (l) (take-ith i l)) m))

(define (take-ith i list)
  (if (null? list)
      #f
      (if (= i 0)
          (car list)
          (take-ith (- i 1) (cdr list)))))
  
;4-та задача
(define (prev-look-and-say list)
  (if (invalid-list? list)
      #f
      (let ((encounters (take-even list))
            (numbers (take-odd list)))
            (if (invalid-numbers? numbers)
                #f
                (build-list encounters numbers)))))

(define (build-list enc nums)
  (flatten (map (lambda (e n) (construct e n)) enc nums)))

(define (flatten list)
  (if (null? list)
      '()
      (append (car list) (flatten (cdr list)))))
  
(define (construct times n)
  (if (= 0 times)
      '()
      (cons n (construct (- times 1) n))))

(define (invalid-list? list)
  (if (null? list)
      #t
      (if (= 1 (remainder (length list) 2))
          #t
          #f)))

(define (invalid-numbers? list)
  (define (first list)
    (if (null? list)
        +inf.0
        (car list)))
  
  (if (null? list)
      #f
      (if (= (car list) (first (cdr list)))
          #t
          (invalid-numbers? (cdr list)))))

(define (take-odd list)
  (filter number? (map (lambda (i x) (if (= 1 (remainder i 2)) x)) (range 0 (length list)) list)))

(define (take-even list)
  (filter number? (map (lambda (i x) (if (= 0 (remainder i 2)) x)) (range 0 (length list)) list)))

(define (filter pred list)
  (if (null? list)
      '()
      (if (pred (car list))
          (cons (car list) (filter pred (cdr list)))
          (filter pred (cdr list)))))
