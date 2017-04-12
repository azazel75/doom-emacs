;;; test/core/autoload/test-message.el

(def-test-group! core/autoload/message
  (ert-deftest ansi-format ()
    (let ((noninteractive t))
      (should (equal (ansi-format! "Hello %s" "World") "Hello World"))
      (should (equal (ansi-format! (red "Hello %s" "World")) "[31mHello World[0m"))
      (should (equal (ansi-format! (green "Hello %s" "World"))
                     (format "\e[%dm%s\e[0m"
                             (cdr (assq 'green doom-ansi-fg))
                             "Hello World")))))

  (ert-deftest ansi-format-nested ()
    (let ((noninteractive t))
      (should (equal (ansi-format! (bold (red "Hello %s" "World")))
                     (format "\e[%dm%s\e[0m" 1 (format "\e[%dm%s\e[0m" 31 "Hello World"))))
      (should (equal (ansi-format! (red (bold "Hello %s" "World")))
                     (format "\e[%dm%s\e[0m" 31 (format "\e[%dm%s\e[0m" 1 "Hello World"))))))

  (ert-deftest ansi-format-apply ()
    (let ((noninteractive t))
      (should (equal (ansi-format! (color 'red "Hello %s" "World"))
                     (ansi-format! (red "Hello %s" "World"))))
      (should (equal (ansi-format! (color (if nil 'red 'blue) "Hello %s" "World"))
                     (ansi-format! (blue "Hello %s" "World")))))))

