;; ---------------------- MAIN FUNCTIONS -------------------------

(defun boolean-implies (a b)
    (IF (EQ a t) b t)
)

;; ---------------------- UTILITY FUNCTIONS ---------------------- 

;; Get the element at the target index in a list
(defun get-element-at (i target elements) 
    (if (= i target) ;; Check if i == desired index
        (car elements) ;; If true, return first element of list
        (when (<= i target) ;; If false, increment i and pop list, then loop
            (get-element-at (+ i 1) target (cdr elements)))))

;; Loop from i to end 
(defun fake-for-loop (i end)
    (when (<= i end)
        (;; Looping logic goes here)
    (fake-for-loop (+ i 1) 10)))

;; ---------------------- UNIT TESTS -----------------------------

;; Test for loop function   
(fake-for-loop 1 10)

;; Test boolean-implies function
(print (boolean-implies t nil))
(print (boolean-implies t t))
(print (boolean-implies nil nil))
(print (boolean-implies nil t))
