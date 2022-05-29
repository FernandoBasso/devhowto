(import srfi-1)

(apply +(map (lambda (x) (* x x)) '(1 2 3)))

(fold (lambda (x y) (+ y (* x x))) 0 '(1 2 3))
