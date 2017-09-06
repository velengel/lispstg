(defgeneric update-key-state (key key-press key-state)
	    (:documentation "update the state of keys"))

(defclass key-state ()
					((right
						:initform nil
						:documentation "the state of right movement key")
					 (left
						:initform nil
						:documentation "the state of left movement key")
						(up
						:initform nil
						:documentation "the state of up movement key")
						(down
						:initform nil
						:documentation "the state of down movement key")))

(defmethod update-key-state (key key-press (key-state key-state))
					 (with-slots (right left up down) key-state
											 (cond ((sdl:key= key :sdl-key-right)
															(setf right key-press))
														 ((sdl:key= key :sdl-key-left)
															(setf left key-press))
															((sdl:key= key :sdl-key-up)
															(setf up key-press))
														 ((sdl:key= key :sdl-key-down)
															(setf down key-press)))))