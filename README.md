# abcl-websocket-client
### _alejandrozf_

This is a simple websocket client for ABCL

It uses the websocket client API defined since Java 11 (See https://docs.oracle.com/en/java/javase/11/docs/api/java.net.http/java/net/http/WebSocket.html)

Examples of usage:


```
ABCL-WEBSOCKET-CLIENT> (connect-websocket
                        "ws://localhost:7000/myws"
                        :on-open ((print "Connected!"))
                        :on-text ((print (decode-buffer-message message)))
                        :on-close ((print "Closing ...")))
#<jdk.internal.net.http.common.MinimalFuture jdk.internal.net.http.common.Min.... {127F0D9C}>

"Connected!"
ABCL-WEBSOCKET-CLIENT> (send-text "Sofía")
NIL

"Sofía"
ABCL-WEBSOCKET-CLIENT>
```

## License

MIT
