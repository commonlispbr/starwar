(defpackage :starwar-system
  (:use :cl :asdf))

(in-package :starwar-system)

(defsystem starwar
  :name "starwar"
  :author "xzpeter"
  :version "0.0.1"
  :license "MIT"
  :description "A very simple starwar game."
  :depends-on (:lispbuilder-sdl
	       	   :lispbuilder-sdl-ttf
	           :lispbuilder-sdl-gfx
	           :lispbuilder-sdl-mixer
	           :starwar-lib)
  :pathname "src"
  :components ((:file "packages")
               (:file "make-binary")
               (:file "globals" :depends-on ("packages"))
               (:file "hittable-circle" :depends-on ("packages"))
               (:file "classes" :depends-on ("packages"
                                             "hittable-circle"))
               (:file "star" :depends-on ("packages"
                                          "classes"
                                          "globals"
                                          "hittable-circle"))
               (:file "planet" :depends-on ("packages"
                                            "classes"
                                            "globals"
                                            "hittable-circle"
                                            "star"))
               (:file "player" :depends-on ("packages"
                                            "classes"
                                            "globals"))
               (:file "starwar" :depends-on ("packages"
                                             "globals"
                                             "hittable-circle"
                                             "star"
                                             "planet"))))
