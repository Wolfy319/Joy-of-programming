;; ---------------------- MAIN FUNCTIONS -------------------------

(defun boolean-implies (a b)
    (IF (EQ a t) b t)
)

; boolean xor
(defun boolean-xor (a b)
  (if (not (equal a b)) t nil))

; using implication function to get bi-implication
(defun bi-imp (a b)
  (let ((x (boolean-implies a b)))
    (let ((y (boolean-implies b a)))
      (if (equal x y)
          t
          nil))))

;; Member of a Set
(defun set-member (set target)
    (let ((frst (first set)))
        (if (eq frst target)
            t
            (if (eq frst Nil)
                nil
                (set-member (cdr set) target)))))

;; Uses union to return a sorted list of two sets w/o duplicates
(defun set-union (set-1 set-2)
  (if (eq nil set-2)
      (sort set-1 #'<)
      (let ((elem (car set-2)))
        (if (set-member set-1 elem)
            (set-union set-1 (cdr set-2))
            (set-union (cons elem set-1) (cdr set-2))))))


;Intersection
(defun set-intersection (set-1 set-2)
  (cond ((eq nil set-1) nil)
        ((eq nil set-2) nil)
        ((set-member set-2 (car set-1))
         (cons (car set-1) (set-intersection (cdr set-1) set-2)))
        (t (set-intersection (cdr set-1) set-2))))

;; Test
(print(set-intersection '(1 2 3) '())) ;;Nil
(print(set-intersection '(2 3) '(2 2 2 3))) ;(2 3)

;Return Difference
 (defun set-diff (set-1 set-2)
  (labels ((helper (lst1 lst2 acc)
                   (cond ((null lst1) acc)
                         ((not (member (car lst1) lst2 :test #'equal))
                          (helper (cdr lst1) lst2 (cons (car lst1) acc)))
                         (t (helper (cdr lst1) lst2 acc)))))
    (helper set-1 set-2 '())))

(defun list-to-set (lst)
  "Convert a list to a set (i.e., a list with no duplicates)"
  (labels ((helper (src acc)
                   (cond ((null src) acc)
                         ((not (member (car src) acc :test #'equal))
                          (helper (cdr src) (cons (car src) acc)))
                         (t (helper (cdr src) acc)))))
    (helper lst '())))

(print (set-diff `(1 2 3) `(2 5 6)))

(defun boolean-eval (list)
    ; Initialize variables
    (let* (
        (operator (first list))
        ; Evaluate each argument in case it's an expression
        (arg1 (parse (second list)))
        (arg2 (parse (third list))))
    ; Handle boolean logic
    (print arg2)
    (cond ((equal operator `and ) (and arg1 arg2))
        ((equal operator `or ) (or arg1 arg2))
        ((equal operator `not ) (not arg1))
        ((equal operator `xor ) (boolean-xor arg1 arg2))
        ((equal operator `implies ) (boolean-implies arg1 arg2))
        ((equal operator `iff ) (bi-imp arg1 arg2))
    ))
)



; test
(print (set-member `(1 2) 3)) ;Nil
(print (set-member `(1 4) 4)) ;T
;; ---------------------- UTILITY FUNCTIONS ---------------------- 

;; Parse an argument
(defun parse (arg)
  (cond ((equal arg t) t)
        ((equal arg nil) nil)
        (t (first arg) (second arg) (third arg))
  )
)

;; Get the element at the target index in a list
(defun get-element-at (i target elements) 
    (if (= i target) ;; Check if i == desired index
        (car elements) ;; If true, return first element of list
        (when (<= i target) ;; If false, increment i and pop list, then loop
            (get-element-at (+ i 1) target (cdr elements)))))

;; Loop from i to end 
(defun fake-for-loop (i end)
    (when (<= i end)
        (print i)
        ;; Looping logic goes here)
    (fake-for-loop (+ i 1) end)))

(defun list-to-set (lst)
  "Convert a list to a set (i.e., a list with no duplicates)"
  (let ((result '()))
    (dolist (x lst)
      (unless (member x result :test #'equal)
        (setq result (cons x result))))
    result))

;; ---------------------- UNIT TESTS -----------------------------

;; Test for loop function   
(fake-for-loop 1 10)

;; Test set-union function
(print (set-union '(1 2) '(2 4)))

;; Test boolean-implies function
(print (boolean-implies t nil)) ;
(print (boolean-implies t t))
(print (boolean-implies nil nil))
(print (boolean-implies nil t))
