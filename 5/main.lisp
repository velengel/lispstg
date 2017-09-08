(defconstant +sqrt-2+ (sqrt 2))

(load "key-state" :external-format :utf-8)

(defun load-png-image (source-file)
	(sdl:convert-to-display-format :surface (sdl:load-image source-file)
																 :enable-alpha t
																 :pixel-alpha t))

(defun main ()
	(sdl:with-init ()
								 (sdl:window 640 480 :title-caption "test")
								 (setf (sdl:frame-rate) 60)
								 (let ((current-key-state (make-instance 'key-state))
											 (x 0)
											 (y 0)
											 (speed 5)
											 (player-img (load-png-image "player.png")))

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

																		 (let ((dx 0) (dy 0))
																			 (with-slots (up down right left) current-key-state
																									 (cond (right (incf dx speed))
																												 (left (decf dx speed)))
																									 (cond (up (decf dy speed))
																												 (down (incf dy speed))))
																			 (when (and (/= dx 0) (/= dy 0))
																				 (setf dx (/ dx +sqrt-2+) dy (/ dy +sqrt-2+)))
																			 (incf x dx)
																			 (incf y dy))

																		 (sdl:draw-surface-at-* player-img (round x) (round y))
																		 (sdl:update-display))))))