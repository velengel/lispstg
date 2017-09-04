(defun main ()
  (sdl:with-init ()
		 (sdl:window 640 480 :title-caption "test")
		 (setf (sdl:frame-rate) 60)
		 (sdl:update-display)
		 (sdl:with-events ()
				  (:quit-event () t)
											(:key-down-event (:key key)
											 (when (sdl:key= key :sdl-key-escape)
												 (sdl:push-quit-event)))
											(:idle ()

											 (sdl:update-display)))))



				  