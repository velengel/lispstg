(defconstant +sqrt-2+ (sqrt 2))

(load "key-state.lisp" :external-format :utf-8)
(load "game-field.lisp" :external-format :utf-8)
(load "player.lisp" :external-format :utf-8)
(load "enemy.lisp" :external-format :utf-8)
(load "enemy-manager.lisp" :external-format :utf-8)

(defun load-png-image (source-file)
  (sdl:convert-to-display-format :surface (sdl:load-image source-file)
				 :enable-alpha t
				 :pixel-alpha t))

(defun main ()
  (sdl:with-init ()
		 (sdl:window 640 480 :title-caption "test")
		 (setf (sdl:frame-rate) 60)
		 (let* ((current-key-state (make-instance 'key-state))
			(game-field (make-instance 'game-field
						   :width 640
						   :height 480
						   :x 0
						   :y 0))

			(player (make-instance 'player
														 :x (/ (game-field-width game-field) 2)
														 :y (/ (game-field-height game-field) 2)
														 :width 64
														 :height 64
														 :speed 5
														 :image (load-png-image "player.bmp")))

       (enemy-manager (make-instance 'enemy-manager)))
     (dotimes (i 10)
       (add-enemy enemy-manager
                  (make-instance
                    'enemy
                    :x (+ 32 (* i (/ (game-field-width game-field) 10)))
                    :y 0
                    :width 64
                    :height 64
                    :vx 1
                    :vy 1
                    :image (load-png-image "enemy.bmp"))))

		   (sdl:update-display)

		   (sdl:with-events ()
				    (:quit-event () t)
				    (:key-down-event (:key key)
														 (if (sdl:key= key :sdl-key-escape)
															 (sdl:push-quit-event)
															 (update-key-state key t current-key-state)))
						(:key-up-event (:key key)
													 (update-key-state key nil current-key-state))
						(:idle ()
									 (sdl:clear-display sdl:*black*)
									 (update-player player current-key-state game-field)
									 (update-enemies enemy-manager)
									 (draw-player player game-field)
									 (draw-enemies enemy-manager game-field)
									 (sdl:update-display))))))
