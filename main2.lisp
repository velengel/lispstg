(defun load-png-image (source-file)
		(sdl:convert-to-display-format :surface (sdl:load-image source-file)
																																	:enable-alpha t
																																	:pixel-alpha t))


(defun main ()
  (sdl:with-init ()
		 (sdl:window 640 480 :title-caption "test")
		 (setf (sdl:frame-rate) 60)
			(sdl:initialise-default-font sdl:*font-10x20*)
			(let ((img (load-png-image "test.png")))

																	
		 (sdl:update-display)
					
		 (sdl:with-events ()
				  (:quit-event () t)
											(:key-down-event (:key key)
											 (when (sdl:key= key :sdl-key-escape)
												 (sdl:push-quit-event)))
											(:idle ()

												(sdl:clear-display sdl:*black*)
												(sdl:draw-box-* 10
																												20
																												30
																												40
																												:color sdl:*magenta*
																												:stroke-color sdl:*white*)
												(sdl:draw-filled-circle-* 100
																																						200
																																						30
																																						:color sdl:*red*)
												(sdl:draw-surface-at-* img
																																		 200
																																		 100)
												(sdl:draw-string-solid-*
													(format nil "~,2F" (sdl:average-fps))
													300
													400)
												

											 (sdl:update-display))))))
