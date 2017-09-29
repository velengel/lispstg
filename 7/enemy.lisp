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
    :documentation "image")
   (attack-region-radius
     :initarg :attack-radius
     :initform 10
     :documentation "attack region radius")
   (damage-region
     :accessor damage-region
     :documentation "damage-region")))

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

(defgeneric out-of-field-p (enemy game-field)
            (:documentation "judge whether enemies are out of display or not"))

(defmethod out-of-field-p ((enemy enemy) (game-field game-field))
  (with-slots (x y width height) enemy
    (let ((width/2 (/ width 2))
          (height/2 (/ height 2)))
      (or (< (+ x width/2) 0)
          (< (+ y height/2) 0)
          (> (- x width/2) (game-field-width game-field))
          (> (- y height/2) (game-field-height game-field))))))

(defmethod initialize-instance :after ((enemy enemy) &key)
  (with-slots (attack-region attack-region-radius x y) enemy
    (setf attack-region (make-instance 'circle-region
                                       :x x
                                       :y y
                                       :r attack-region-radius)))
  (with-slots (damage-region damage-region-radius x y) enemy
    (setf damage-region (make-instance 'circle-region
                                       :x x
                                       :y y
                                       :r damage-region-radius))))

(defmethod update-enemy ((enemy enemy))
  (flet ((update-hit-region (x y region)
                            (setf (circle-x region) x)
                            (setf (circle-y region) y)))
    (with-slots (x y vx vy) enemy
      (incf x vx)
      (incf y vy)
      (update-hit-region x y (attack-region enemy))
      (update-hit-region x y (damage-region enemy)))))

(defmethod draw-enemy ((enemy enemy) (game-field game-field))
  (flet ((draw-hit-region (region color)
                          (sdl:draw-circle-* (round (circle-x region))
                                             (round (circle-y region))
                                             (round (circle-radius region))
                                             :color color)))
    (with-slots (x y width height image) enemy
      (sdl:draw-surface-at-* image
                             (round (+ (game-field-x game-field)
                                       (- x (/ width 2))))
                             (round (+ (game-field-y game-field)
                                       (- y (/ height 2))))))
    (draw-hit-region (damage-region enemy) sdl:*green*)
    (draw-hit-region (attack-region enemy) sdl:*red*)))

