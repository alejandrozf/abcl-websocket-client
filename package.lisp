;;;; package.lisp
(defun get-java-version ()
  (java:jstatic
   (java:jmethod "java.lang.System" "getProperty" "java.lang.String")
   "java.lang.System"
   "java.runtime.version"))


(let* ((java-version (parse-integer (get-java-version) :junk-allowed t)))
  (unless (>= java-version 11)
    (error "Java 11 or higher is required for this code")))


(defpackage #:abcl-websocket-client
  (:use #:cl))
