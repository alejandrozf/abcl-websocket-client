;;;; abcl-websocket-client.asd

(asdf:defsystem #:abcl-websocket-client
  :description "simple websocket client for ABCL"
  :author "alejandrozf"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "abcl-websocket-client")))
