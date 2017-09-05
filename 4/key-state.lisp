(defgeneric update-key-state (key key-press key-state)
	    (:documentation "update the state of keys"))

(defclass key-state ()
					((right
						:initform nil
						:documentation "the state of right movement key")
					 (left
						:initform nil
						:documentation "the state of left movement key")))

(defmethod update-key-state (key key-press (key-state key-state))
					 (with-slots (right left) key-state
											 (cond ((sdl:key= key :sdl-key-right)
															(setf right key-press))
														 ((sdl:key= key :sdl-key-left)
															(setf left key-press)))))