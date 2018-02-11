;; some vector related functions
(in-package :starwar-lib)

;; fix any rad to: -pi/2 ~ 3pi/2
(defun rad-fix (rad)
  (let ((r (mod rad (* 2 pi))))
    (- r (if (and (< r (* pi 2))
		  (> r (* pi 1.5)))
	     (* pi 2)
	     0))))

(defmacro vx (v)
  `(aref ,v 0))

(defmacro vy (v)
  `(aref ,v 1))

(defun vector-norm (vect)
  (let* ((x (vx vect))
	 (y (vy vect))
	 (a (sqrt (+ (* x x) (* y y)))))
    (vector (/ x a) (/ y a))))

(defun vector-length (vect)
  (let ((x (vx vect)) (y (vy vect)))
    (sqrt (+ (* x x) (* y y)))))

;; from -pi/2 ~ 3pi/2
(defun vec2rad (vect)
  (let ((x (vx vect)) (y (vy vect)))
    (when (or (not (vectorp vect))
	      (and (zerop x) (zerop y)))
      (error "must vector without all zero!"))
    (if (zerop x)
	(if (plusp y) (/ pi 2) (/ pi -2))
	(let ((rad (atan (/ y x))))
	  (+ rad (if (minusp x) pi 0))))))

;; rad should be from -pi/2~3pi/2
;; the vector returned are NOT normalized!!!
(defun rad2vec (rad)
  (when (or (> rad (* pi 1.5)) (< rad (* pi -0.5)))
    (error "rad not in range"))
  (cond
    ((= rad (/ pi 2)) #(0 1))
    ((= rad (* pi 1.5)) #(0 -1))
    (t (if (> rad (* pi 0.5))
	   (vector -1 (- (tan rad)))
	   (vector 1 (tan rad))))))

(defun vector+ (a b)
  (if (not (and (vectorp a) (vectorp b)))
      (error "A and B must be vector!"))
  (let ((x0 (vx a))
	(x1 (vx b))
	(y0 (vy a))
	(y1 (vy b)))
    (vector (+ x0 x1) (+ y0 y1))))

(defun vector- (a b)
  (if (not (and (vectorp a) (vectorp b)))
      (error "A and B must be vector!"))
  (let ((x0 (vx a))
	(x1 (vx b))
	(y0 (vy a))
	(y1 (vy b)))
    (vector (- x0 x1) (- y0 y1))))

(defun vector* (a n)
  (cond ((and (vectorp a) (numberp n))
	 (let ((x (vx a))
	       (y (vy a)))
	   (vector (* n x) (* n y))))
	((and (vectorp a) (vectorp n))
	 (let ((x0 (vx a))
	       (x1 (vx n))
	       (y0 (vy a))
	       (y1 (vy n)))
	   (vector (* x0 x1) (* y0 y1))))
	(t (error "not supported *!"))))

(defun vector-floor (vect)
  (vector (floor (vx vect)) (floor (vy vect))))

(defun distance (x1 y1 x2 y2)
  "the distance of two points"
  (let ((x (- x1 x2)) (y (- y1 y2)))
    (sqrt (+ (* x x) (* y y)))))

(defun distance-less-than-p (x1 y1 x2 y2 r)
  (let ((x (- x1 x2)) (y (- y1 y2)))
    (<= (+ (* x x) (* y y)) (* r r))))

(defun random-vect (n)
  (vector (random-with-neg n) (random-with-neg n)))
