
($console-log ($concat "filename: " $__filename))
($console-log ($concat "dirname: "  $__dirname))
($console-log ($concat "profile: "  $__profile))

($let ex ($require "liyad-lisp-pkg-example" "lisp"))

;; Benchmarks
($console-time) ($console-log "tarai(12, 6, 0): " (::ex:tarai 12 6 0)) ($console-time-end)
($console-time) ($console-log "fib(10): " (::ex:fib 10)) ($console-time-end)
($console-time) ($console-log "fac(10): " (::ex:fac 10)) ($console-time-end)
 