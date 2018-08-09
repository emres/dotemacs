(require 'cl) ;; Common Lisp compatibility library

(defun emre/write-installed-packages-to-file (filename)
  "Write the installed packages to a file in a form so that they
can be used directly via `load`."
  (with-temp-file filename
    (insert
     (format "%s" "(setf my-packages '")
     (format "%S" package-activated-list)
     (format "%s" ")"))))

;; Example usage to write to currently installed packages to a file:
;; (emre/write-installed-packages-to-file "packages.txt")

(defun emre/require-package (package)
    "Install the given package if it's not already installed."
    (unless (package-installed-p package)
        (unless (assoc package package-archive-contents)
        (package-refresh-contents))
        (package-install package)))

(defun emre/install-all-packages-from-file (filename)
  "Install all the packages from the given filename."
  (progn
    (load "/home/emre/packages.txt")
    (loop for package in my-packages do
          (require-package package))))
