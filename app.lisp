
($console-error ($concat "file: " $__filename))
($console-error ($concat "dir: " $__dirname))

($let ex ($require "liyad-lisp-pkg-example"))

;; Benchmarks
($console-time) ($console-log (::ex:tarai 12 6 0)) ($console-time-end)
($console-time) ($console-log (::ex:fib 10)) ($console-time-end)
($console-time) ($console-log (::ex:fac 10)) ($console-time-end)
 

;; Run the web server on port 3000.
($let url ($node-require "url"))
($let srv ($require "liyad-lisp-pkg-example"))
; ($let db  ($node-require "./db.js"))


;; Register url handlers to web server.
(::srv:#get "/" (-> (req res)
    ($let u (::url:parse ::req:url))
    (::res@writeHead 200 (# (Content-Type "text/html")))
    (::res@end ($concat "hit / ," ::req:method "," ::u:path)) ))


($defun output-render-result (e html req res) ($if html
    ($last
        (::res@writeHead 200 (# (Content-Type "text/html")))
        (::res@end ($concat "<!DOCTYPE html>" html)) )
    ($last
        (::res@writeHead 500 (# (Content-Type "text/plain")))
        (::res@end ($concat "Error: " e)) ) ))


($defun page-header-footer (title-text content-node)
    (html
        (head (title title-text))
        (body (div "this is the header")
              content-node
              (div "this is the footer") )))


;; It need LSX profile and bootstrap javascript file.
(::srv:#get "/lsx" (-> (req res)
    ($let u (::url:parse ::req:url))
    ; ($resolve-pipe (::db:query "") (-> (data) ($render ..)) )
    ($render
        ;; LSX notation
        (page-header-footer "Welcome to LSX example"
            (div (h1 (Hello (@ (name ::u:path))))
                """p@{(style (color "red"))}
                Good morning.
                """ ))
        ;; Process the rendering result.
        (|-> (e html) use (req res)
            (output-render-result e html req res) ))))


;; Start server.
(::srv:serve 3000) ($last "start server")
