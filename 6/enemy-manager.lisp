(defclass enemy-manager ()
  ((enemies
     :initform nil
     :documentation "Managed enemies")))

(defgeneric add-enemy (enemy-manager enemy)
  (:documentation "add managed enemies"))
(defgeneric update-enemies (enemy-manager)
            (:documentation "update the state of enemies"))
(defgeneric draw-enemies (enemy-manager game-field)
            (:documentation "draw enemies"))

(defmethod add-enemy ((enemy-manager enemy-manager) (enemy enemy))
  (with-slots (enemies) enemy-manager
    (push enemy enemies)))

(defmethod update-enemies ((enemy-manager enemy-manager))
  (with-slots (enemies) enemy-manager
    (dolist (enemy enemies)
      (update-enemy enemy))))

(defmethod draw-enemies ((enemy-manager enemy-manager)
                         (game-field game-field))
  (with-slots (enemies) enemy-manager
    (dolist (enemy enemies)
      (draw-enemy enemy game-field))))


