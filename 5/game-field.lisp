(defclass game-field ()
					((width
						:reader game-field-width
						:initarg :width
						:initform 0
						:documentation "width of display")
					 (height
						:reader game-field-height
						:initarg :height
						:initform 0
						:documentation "height of display")
					 (x
						:reader game-field-x
						:initarg :x
						:initform 0
						:documentation "x-coordinate of the upper left of display")
					 (y
						:reader game-field-y
						:initarg :y
						:initform 0
						:documentation "y-coordinate of the upper right of display")))


