
($console-log ($concat "filename: " $__filename))
($console-log ($concat "dirname: "  $__dirname))

($let ex ($require "liyad-lisp-pkg-example" "lisp"))

;; Benchmarks
($console-time) ($console-log "tarai(12, 6, 0): " (::ex:tarai 12 6 0)) ($console-time-end)
($console-time) ($console-log "fib(10): " (::ex:fib 10)) ($console-time-end)
($console-time) ($console-log "fac(10): " (::ex:fac 10)) ($console-time-end)
 

;; Run the web server on port 3000.
($let url ($node-require "url"))
($let srv ($require "liyad-lisp-pkg-example" "lisp"))
($let db  ($node-require "./db.js"))


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
              ($=for ($range 1 3)
                  content-node
                  $data)
              (div "this is the footer") )))


;; It need LSX profile and bootstrap javascript file.
(::srv:#get "/lsx" (-> (req res)
    ($let u (::url:parse ::req:url))
    ($then ($resolve-pipe (::db:query "")
        (|-> (data) use (req res u) ($render
            ;; LSX notation
            (page-header-footer "Welcome to LSX example"
                (div (h1 (Hello (@ (name ::u:path))))
                    (p ($datetime-to-iso-string ($now)))
                    """p@{(style (color "red"))}
                    Good morning.
                    %%%(h4 data)
                    """ ))
            ;; Process the rendering result.
            (|-> (e html) use (req res)
                (output-render-result e html req res) ))))
        (-> () nil)
        (|-> (e) use (req res)
            (output-render-result e null req res)) )))


;; Start server.
(::srv:serve 3000) ($last "start server")
