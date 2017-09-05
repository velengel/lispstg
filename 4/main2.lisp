(load "key-state" :external-format :utf-8)

(defun main ()
	(sdl:with-init ()
			 (sdl:window 640 480 :title-caption "test")
								 (setf (sdl:frame-rate) 60)
								 (sdl:initialise-default-font sdl:*font-10x20*)
								 (let ((current-key-state (make-instance 'key-state)))

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
																		(with-slots (right left) current-key-state
																		(sdl:draw-string-solid-* (format nil "right:~:[no~;yes~]" right)
																		10 20)
																		(sdl:draw-string-solid-* (format nil "left:~:[no~;yes~]" left)
																		10 40))
																		(sdl:update-display))))))