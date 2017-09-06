(defgeneric update-key-state (key key-press key-state)
	(:documentation "update the state of keys"))
	
(defmacro defkeystate (name &rest key-maps)
	`(progn
		(defclass ,name ()
			,(loop for k in key-maps collect `(,(car k) :initform nil)))
		,(let ((key (gensym)) (key-press (gensym)) (key-state (gensym)))
			`(defmethod update-key-state (,key ,key-press (,key-state ,name))
				(with-slots ,(mapcar #'car key-maps) ,key-state
					(cond ,@(loop for k in key-maps
						collect `((sdl:key= ,key ,(cadr k))
						(setf ,(car k) ,key-press)))))))))
						
						
						
(defkeystate key-state
	(right :sdl-key-right)
	(left :sdl-key-left))