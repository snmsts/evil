(in-package :lem.evil.el)

(defmacro declare-function (name &body body)
  (declare (ignore name body)))

(defun add-hook (var val)
  (declare (ignore name body)))

(defmacro defgroup (name &body body)
  (declare (ignore name body)))

(defmacro defcustom (name val doc &rest ignore)
  (declare (ignore ignore))
  `(progn
     (defvar ,name ,val ,doc)
     (export '(,name))))

(defun make-variable-buffer-local (&rest r)
  (declare (ignore r)))

(defun woman ()
  )

(defmacro defface (&rest r)
  (declare (ignore r)))

(defun put  (&rest r)
  (declare (ignore r)))

(defmacro defconst (name value &optional doc)
  `(defconstant ,name
     (if (boundp ',name)
         (symbol-value ',name)
         ,value)
     ,@(when doc (list doc))))

(defun make-keymap ()
  (lem:make-keymap))

(defun make-sparse-keymap ()
  (lem:make-keymap))

(defparameter load-file-name
  (truename (merge-pathnames
             "../"
             (make-pathname
              :defaults (or #.*compile-file-pathname*
                            *load-pathname*)
              :name "evil-vars"
              :type "el"))))

(defun file-name-directory (path)
  (let ((p (namestring (make-pathname :defaults path :name nil :type nil))))
    (subseq p 0 (1- (length p)))))

(defun concat (&rest params)
  (format nil "~{~A~}" params))

(defun file-exists-p (path)
  (probe-file path))

(defmacro with-temp-buffer (&body body)
  `(progn
     ,@body))

(defmacro eval-when-compile (&body body)
  `(progn
     ,@body))

(defun suppress-keymap (map o)
  (declare (ignoere map o)))

(defun make-ring (num)
  (declare (ignoere num)))

(defvar minibuffer-local-map nil)
(defun set-keymap-parent (map1 map2)
  (declare (ignoere map1 map2)))

