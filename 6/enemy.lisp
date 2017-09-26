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
    :documentation "speed of y-direction")
   (width
    :initarg :width
    :initform 128
    :documentation "width")
   (height
    :initarg :height
    :initform 128
    :documentation "height")
   (image
    :initarg :image
    :initform (error "designate the image file of enemy.")
    :documentation "image")))

(defgeneric update-enemy (enemy)
  (:documentation "update the state of enemys"))
(defgeneric draw-enemy (enemy game-field)
  (:documentation "draw the enemys"))

(defmethod update-enemy ((enemy enemy))
  (with-slots (x y vx vy) enemy
	      (incf x vx)
	      (incf y vy)))

(defmethod draw-enemy ((enemy enemy) (game-field game-field))
  (with-slots (x y width height image) enemy
	      (sdl:draw-surface-at-* image
				     (round (+ (game-field-x game-field)
					       (- x (/ width 2))))
				     (round (+ (game-field-y game-field)
					       (- y (/ height 2)))))))
