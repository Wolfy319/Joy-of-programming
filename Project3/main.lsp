; ---------------------- MAIN FUNCTIONS -------------------------

;; Member of a Set
(defun set-member (set item)
    (let ((frst (first set)))
        (if (eq frst item)
            t
            (if (eq frst Nil)
                nil
                (set-member (cdr set) item)))))

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
  (cond ((equal nil set-1) nil)
        ((equal nil set-2) nil)
        ((set-member set-2 (car set-1))
         (cons (car set-1) (set-intersection (cdr set-1) set-2)))
        (t (set-intersection (cdr set-1) set-2))))

;Return Difference
 (defun set-diff (set-1 set-2)
  (labels ((helper (lst1 lst2 acc)
                   (cond ((null lst1) acc)
                         ((not (member (car lst1) lst2 :test #'equal))
                          (helper (cdr lst1) lst2 (cons (car lst1) acc)))
                         (t (helper (cdr lst1) lst2 acc)))))
    (helper set-1 set-2 '())))

; boolean xor
(defun boolean-xor (a b)
  (if (not (equal a b)) t nil))

; boolean implication 
(defun boolean-implies (a b)
    (IF (EQ a t) b t)
)

; using implication function to get bi-implication
(defun boolean-iff (a b)
  (let ((x (boolean-implies a b)))
    (let ((y (boolean-implies b a)))
      (if (equal x y)
          t
          nil))))

(defun boolean-eval (list)
    ; Initialize variables
    (let* (
        (operator (first list))
        ; Evaluate each argument in case it's an expression
        (arg1 (parse (second list)))
        (arg2 (parse (third list))))
    ; Handle boolean logic
    (cond ((equal operator `and ) (and arg1 arg2))
        ((equal operator `or ) (or arg1 arg2))
        ((equal operator `not ) (not arg1))
        ((equal operator `xor ) (boolean-xor arg1 arg2))
        ((equal operator `implies ) (boolean-implies arg1 arg2))
        ((equal operator `iff ) (boolean-iff arg1 arg2))
    ))
)

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

; Convert a list to a set (i.e., a list with no duplicates)

(defun list-to-set (lst)
  (labels ((helper (src acc)
                   (cond ((null src) acc)
                         ((not (member (car src) acc :test #'equal))
                          (helper (cdr src) (cons (car src) acc)))
                         (t (helper (cdr src) acc)))))
    (helper lst '())))

;; ---------------------- UNIT TESTS -----------------------------

(print "UNIT TESTING (EVERYTHING SHOULD BE T):")
(print "Test set-member function: ")
(print (equal (set-member `(1 2) 3) nil))
(print (equal (set-member `(1 4) 4) t))

(print "Test set-union function: ")
(print (equal (set-union '(1 2) '(2 4)) `(1 2 4)))
(print (equal (set-union '(1 2 3) '(4 5 6)) `(1 2 3 4 5 6)))
(print (equal (set-union '(1 2 3) '(1 2 3)) `(1 2 3)))
(print (equal (set-union '() '()) `()))
(print (equal (set-union '(1 2) '()) `(1 2)))
(print (equal (set-union '() '(3 4)) `(3 4)))



(print "Test set-intersection function: ")
(print (equal (set-intersection '(1 2) '(2 4)) '(2)))
(print (equal (set-intersection '(1 2) '(3 4)) '()))
(print (equal (set-intersection '(1 2) '(1 2)) '(1 2)))

(print "Test set-diff function: ")
(print (equal (set-diff '(1 2) '(2 4)) '(1)))
(print (equal (set-diff '(1 2) '(1 2)) '()))
(print (equal (set-diff '(1 2) '(3 4)) '(2 1)))

(print "Test boolean-xor function: ")
(print (equal (boolean-xor t nil) t))
(print (equal (boolean-xor t t) nil))
(print (equal (boolean-xor nil nil) nil))
(print (equal (boolean-xor nil t) t))


(print "Test boolean-implies function: ")
(print (equal (boolean-implies t nil) nil))
(print (equal (boolean-implies t t) t))
(print (equal (boolean-implies nil nil) t))
(print (equal (boolean-implies nil t) t))

(print "Test boolean-iff function: ")
(print (equal (boolean-iff t nil) nil))
(print (equal (boolean-iff t t) t))
(print (equal (boolean-iff nil t) nil))
(print (equal (boolean-iff nil nil) t))

(print "Test boolean-eval function: ")
(print (equal (boolean-eval `(and t nil)) nil))
(print (equal (boolean-eval `(and t t)) t))
(print (equal (boolean-eval `(or t nil)) t))
(print (equal (boolean-eval `(or nil nil)) nil))
(print (equal (boolean-eval `(not t)) nil))
(print (equal (boolean-eval `(not nil)) t))
(print (equal (boolean-eval `(xor t nil)) t))
(print (equal (boolean-eval `(xor t t)) nil))
(print (equal (boolean-eval `(implies t nil)) nil))
(print (equal (boolean-eval `(implies t t)) t))
(print (equal (boolean-eval `(iff t nil)) nil))
(print (equal (boolean-eval `(iff nil nil)) t))

(print (equal (boolean-eval `(and t (or nil t))) t))
(print (equal (boolean-eval `(implies (xor t t) (or nil t))) t))
(print (equal (boolean-eval `(or (iff t nil) (and t t))) t))
(print (equal (boolean-eval `(not (iff t nil))) t))
