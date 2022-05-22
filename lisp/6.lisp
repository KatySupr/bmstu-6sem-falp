;; задание 1 - done
(defun all-num-minus-10 (lst) 
    (mapcar #'(lambda (x)
        (cond ((null x) Nil)
              ((numberp x) (- x 10))
              ((listp x) (all-num-minus-10 x))
              (t x))) lst))
;; (print (all-num-minus-10 '(10 (a b 20) 30)))
;; задание 2 - done
(defun all-num-mult-a (num lst) (mapcar #'(lambda (x) (* num x)) lst))
;; (print (all-num-mult-a 2 '(1 3 2.05)))
(defun all-num-mult-b (num lst) 
    (mapcar #'(lambda (x) 
        (cond ((null x) Nil)
              ((numberp x) (* num x))
              ((listp x) (all-num-mult-b num x))
              (t x))) lst))
;; (print (all-num-mult-b 4 '(a 3 (b 1.0 (9 ahdk)) 0)))
;; задание 3 - done
(defun my-reverse (lst &optional (buf-lst Nil))
    (cond ((null lst) buf-lst)
          (t (my-reverse (cdr lst) (cons (car lst) buf-lst)))))
;; (print (my-reverse '(a b c (d e) f)))
(defun palyndrom-lst (lst) (reduce #'(lambda (x y) (and x y)) 
    (mapcar #'equalp lst (my-reverse lst))))
;; (print (palyndrom-lst '(a b c (d e) c b a)))
;; (print (palyndrom-lst '(a)))
;; задание 4 - done
(defun set-size (sett &optional (size 0))
    (cond ((null sett) size)
          (t (set-size (cdr sett) (+ size 1)))))
(defun set-include (set1 set2)
    (reduce #'(lambda (x y) (and x y)) (mapcar #'(lambda (x) (reduce #'(lambda (x y) (or x y)) x)) 
        (mapcar #'(lambda (elem) (maplist #'(lambda (x) (equalp (car x) elem)) set2)) set1))))
;; (print (set-include '(a b c) '(a d e c b)))
(defun set-equal (set1 set2) (and (= (set-size set1) (set-size set2))
    (set-include set1 set2) (set-include set2 set1)))
;; (print (set-equal '(a b d (c e)) '((c e) d a b)))
;; задание 5 - done
(defun all-square-num (lst) (mapcar #'(lambda (x) (* x x)) lst))
;; (print (all-square-num '(1 2 3 4)))
;; задание 6 - задание 9 из 5 лр - done
(defun get-between (num1 num2 lst)
    (cond ((null lst) Nil)
          (t (reduce #'(lambda (x y) (if (< num1 y num2) (cons y x) x)) lst :initial-value Nil))))
;; (print (get-between 3 10 '(8 12 3 9 1.0)))
(defun insert-elem (lst elem &optional (before-lst Nil))
    (cond ((and (null lst) (not (null before-lst))) (append before-lst (cons elem Nil)))
          ((null lst) (cons elem Nil))
          ((< elem (car lst)) (append before-lst (cons elem Nil) lst))
          (t (insert-elem (cdr lst) elem (append before-lst (cons (car lst) Nil))))))
(defun sort-lst (lst)
    (cond ((null lst) Nil)
          (t (reduce #'(lambda (sorted x) (insert-elem sorted x)) lst :initial-value Nil))))
(defun select-between (num1 num2 lst)
    (cond ((null lst) Nil)
          ((< num2 num1) (sort-lst (get-between num2 num1 lst)))
          (t (sort-lst (get-between num1 num2 lst)))))
;; (print (select-between 3 9.184 '(0 8 7.1 3 9 1.0)))
;; задание 7 - дописать re-roll - done
(defun my-reverse (lst &optional (buf-lst Nil))
    (cond ((null lst) buf-lst)
          (t (my-reverse (cdr lst) (cons (car lst) buf-lst)))))
(defun re-roll (lst &optional (res-lst Nil))
    (cond ((null lst) res-lst)
;         ;   (t (re-roll (cdr lst) (cons (car lst) res-lst)))))
          (t (re-roll (cdr lst) (mapcar #'(lambda (x) (cons x res-lst)) (car lst))))))
(defun cartesian-product (lst1 lst2)
    (cond ((and (null lst1) (null lst2)) Nil)
          ((null lst1) lst2)
          ((null lst2) lst1)
          (t (re-roll (mapcar #'(lambda (x) (mapcar #'(lambda (y) (cons x (cons y Nil))) lst2)) lst1)))))
;; (print (cartesian-product '(a b (c d)) '((f) e k)))
(defun decart (lst1 lst2)  ;; из лекции
    (mapcan #'(lambda (x)
        (mapcar #'(lambda (y) (list x y)) lst2)) lst1))
;; (print (decart '(a b (c d)) '((f) e k)))
;; задание 8
;; (print (reduce #'+ 0))
;; (print (reduce #'+ ()))
;; задание 9 - done
(defun len-list (lst &optional (cnt 0))
    (cond ((null lst) cnt)
          (t (len-list (cdr lst) (+ cnt 1)))))
(defun len-list-of-list (lst)
    (cond ((null lst) 0)
          (t (reduce #'+ (mapcar #'len-list lst)))))
(print (len-list-of-list '((a b) (c d) (e f d))))
