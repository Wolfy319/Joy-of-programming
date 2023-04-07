(write-line "Hello World")
(defun boolean-implies (a b)
    (IF (EQ a t) b t)
)

(defun fake-for-loop (i end)
    (when (<= i end)
        (print i)
    (fake-for-loop (+ i 1) 10)))

;; Test for loop function   
(fake-for-loop 1 10)

;; Test boolean-implies function
(print (boolean-implies t nil))
(print (boolean-implies t t))
(print (boolean-implies nil nil))
(print (boolean-implies nil t))
