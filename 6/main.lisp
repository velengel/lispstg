(defconstant +sqrt-2+ (sqrt 2))

(load "key-state.lisp" :external-format :utf-8)
(load "key-state.lisp" :external-format :utf-8)
(load "key-state.lisp" :external-format :utf-8)
(load "key-state.lisp" :external-format :utf-8)

(defun load-png-image (source-file)
  (sdl:convert-to-display-format :surface (sdl:load-image source-file)
				 :enable-alpha t
				 :pixel-alpha t))

(defun main ()
  (sdl:with-init ()
		 (sdl:window 640 480 :title-caption "test")
		 (setf (sdl:frame-rate
