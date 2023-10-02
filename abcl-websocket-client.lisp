;;;; abcl-websocket-client.lisp

(in-package #:abcl-websocket-client)


(defparameter *websocket* nil)


(defparameter *websockets* '())


(defun decode-buffer-message (message)
  (java:jcall (java:jmethod "java.nio.CharBuffer" "toString") message))


(defparameter *request-method* (java:jmethod "java.net.http.WebSocket" "request" "long"))


(defmacro connect-websocket (ws &key on-open on-text on-binary on-ping on-pong on-close on-error)
  `(java:jcall

    (java:jmethod "java.net.http.WebSocket$Builder" "buildAsync" "java.net.URI" "java.net.http.WebSocket$Listener")

    (java:jcall
     (java:jmethod "java.net.http.HttpClient" "newWebSocketBuilder")
     (java:jstatic
      (java:jmethod "java.net.http.HttpClient" "newHttpClient")
      "java.net.http.HttpClient"))

    (java:jcall
     (java:jmethod "java.net.URI" "create" "java.lang.String")
     "java.net.URI"
     ,ws)

    (java:jinterface-implementation
     "java.net.http.WebSocket$Listener"
     "onBinary" (lambda (websocket data last)
                  (declare (ignorable websocket data last))
                  (progn ,@on-binary))

     "onPong" (lambda (websocket message)
                (declare (ignorable websocket message))
                (progn ,@on-pong))

     "onPing" (lambda (websocket message)
                (declare (ignorable websocket message))
                (progn ,@on-ping))

     "onClose" (lambda (websocket status-code reason)
                 (declare (ignorable websocket status-code reason))
                 (progn ,@on-close))

     "onOpen" (lambda (websocket)
                (setf *websocket* websocket)
                (push websocket *websockets*)
                (progn ,@on-open)
                (java:jcall *request-method* *websocket* 1)
                java:+null+)

     "onText" (lambda (websocket message last)
                (declare (ignorable websocket message last))
                (progn ,@on-text)
                (java:jcall *request-method* *websocket* 1)
                java:+null+)

     "onError" (lambda (websocket error)
                 (declare (ignorable websocket error))
                 (progn ,@on-error)))))


(defun send-text (message &optional (websocket *websocket*) (last t))
  (tagbody (java:jcall
            (java:jmethod "java.net.http.WebSocket" "sendText" "java.lang.CharSequence" "boolean")
            websocket message last)))


(defun stop-connection (&optional (websocket *websocket*))
  (java:jcall (java:jmethod "java.net.http.WebSocket" "abort") websocket))
