(defclass player ()
					((x
						:initarg :x
						:initform 0
						:documentation "x-coordinate of center point")
					 (y
						:initarg :y
						:initform 0
						:documentation "y-coordinate of center point")
					 (width
						:initarg :width
						:initform 64
						:documentation "width")
					 (height
						:initarg :height
						:initform 64
						:documentation "height")
					 (speed
						:initarg :speed
						:initform 5
						:documentation "speed")
					 (image
						:initarg :image
						:initform (error "designate the file of the image of own machine.")
						:documentation "image")))

(defgeneric update-player (player key-state game-field)
						(:documentation "update the state of own machine"))
(defgeneric draw-player (player game-field)
						(:documentation "draw own machine"))

(defmethod update-player ((player player)
													(key-state key-state)
													(game-field game-field))
					 (move-by-input player key-state)
					 (fix-position player game-field))

(defmethod move-by-input ((player player) (key-state key-state))
					 (let ((dx 0) (dy 0))
						 (with-slots (up down right left) key-state
												 (with-slots (speed) player
																		 (cond (right (incf dx speed))
																					 (left (decf dx speed)))
																		 (cond (up (decf dy speed))
																					 (down (incf dy speed)))))
						 (when (and (/= dx 0) (/= dy 0))
							 (setf dx (/ dx +sqrt-2+) dy (/ dy +sqrt-2+)))
						 (with-slots (x y) player
												 (incf x dx)
												 (incf y dy))))

(defmethod fix-position ((player player) (game-field game-field))
					 (with-slots (x y width height) player
											 (let ((field-width (game-field-width game-field))
														 (field-height (game-field-height game-field))
														 (width/2 (/ width 2))
														 (height/2 (/ height 2)))
												 (when (< (- x width/2) 0) (setf x width/2))
												 (when (< (- y height/2) 0) (setf y height/2))
												 (when (> (+ x width/2) field-width)
													 (setf x (- field-width width/2)))
												 (when (> (+ y height/2) field-height)
													 (setf y (- field-height height/2))))))

(defmethod draw-player ((player player) (game-field game-field))
					 (with-slots (x y width height image) player
											 (sdl:draw-surface-at-* image
																							(round (+ (game-field-x game-field)
																												(- x (/ width 2))))
																							(round (+ (game-field-y game-field)
																												(- y (/ height 2)))))))

