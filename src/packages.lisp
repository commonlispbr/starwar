(in-package :cl-user)
(defpackage :starwar
  (:use :cl :starwar-lib)
  (:documentation "this is the star war game!")
  (:export :main :run :make-binary))
