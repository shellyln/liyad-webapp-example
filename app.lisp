
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


;; Controller functions
($defun output-render-result (e html req res) ($if ($not e)
    ($last
        (::res@writeHead 200 (# (Content-Type "text/html")))
        (::res@end ($concat "<!DOCTYPE html>" html)) )
    ($last
        (::res@writeHead 500 (# (Content-Type "text/plain")))
        (::res@end ($concat "Error: " e)) ) ))

($defun output-render-result-with-trans (e html req res)
    ;; Finalize date
    ($then ($if ($not e) (::db:commit) (::db:rollback))
        ;; Process the rendering result.
        (|-> ()    use (e html req res) (output-render-result e           html req res))
        (|-> (err) use (e html req res) (output-render-result ($or e err) html req res)) ))

($defun build-page (req res page)
    (|-> (data) use (req res page)
        ($render
            ;; LSX notation
            (page data)
            ;; Renderer
            (|-> (e html) use (req res)
                (output-render-result-with-trans e html req res) ))))

($defun view-with-trans (req res pipes page)
    ($then
        ($resolve-pipe nil
            ;; Fetch data (from Model layer)
            (-> (data) (::db:begin))
            ...pipes
            ;; TODO: transaction should or should not complete before rendering???
            ;; Render (View layer)
            (build-page req res page) )
        ;; Errors on fetching data or rendering
        (-> () nil) (|-> (e) use (req res)
            (output-render-result-with-trans e null req res) )))


;; Defining partial page components.
($defun page-header-footer (title-text content-node)
    (html
        (head (title title-text))
        (body (div "this is the header")
              ($=for ($range 1 3)
                  content-node
                  $data)
              (div "this is the footer") )))


;; Register url handlers to web server.
(::srv:#get "/" (-> (req res)
    ($let u (::url:parse ::req:url))
    (::res@writeHead 200 (# (Content-Type "text/html")))
    (::res@end ($concat "hit / ," ::req:method "," ::u:path)) ))


;; It need LSX profile and bootstrap javascript file.
(::srv:#get "/lsx" (-> (req res)
    ($let q-res (#)) ($let q-res-push
        (|-> (name) use (q-res)
            (|-> (data) use (q-res name)
                ($set (q-res ($eval name)) data) ($last data) )))
    ;; Data pipeline definition for rendering the page.
    ($let pipes ($list
        (-> (data) (::db:query "select * from x")) (q-res-push "r1")
        (-> (data) (::db:query "select * from y")) (q-res-push "r2")
        (-> (data) (::db:query "select * from z")) (q-res-push "r3") ))
    ;; Declarative view definition.
    ($let page (|-> (data) use (req res q-res)
        ($let u (::url:parse ::req:url))
        (page-header-footer "Welcome to LSX example"
            (div (h1 (Hello (@ (name ::u:path))))
                (p ($datetime-to-iso-string ($now)))
                """p@{(style (color "red"))}
                Good morning.
                %%%(h4 "last query result: " data)
                %%%(h4 "all results: " ($json-stringify q-res))
                """ )) ))
    ;; Process data and render the view.
    (view-with-trans req res pipes page) ))


;; Start server.
(::srv:serve 3000) ($last "start server")
