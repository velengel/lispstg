(defclass enemy ()
					((x
						:initarg :x
						:initform 0
						:documentation "center x-coordinate")
					 (y
						:initarg :y
						:initform 0
						:documentation "center y-coordinate")
					 (vx
						:initarg :vx
						:initform 0
						:documentation "speed of x-direction")
					 (vy
						:initarg :vy
						:initform 0
						:documentation "