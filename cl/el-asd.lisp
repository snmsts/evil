(load-system :named-readtables)

(defpackage :lem.evil.el
  (:use :cl)
  #+sbcl(:local-nicknames (:cfw :lem.evil.el))
  (:export #+sbcl :calendar-mode))

(in-package :lem.evil.el)

(defun read-character-literal (stream char)
  (declare (ignore char))
  (loop :with p :for cc :of-type character = (read-char stream t nil t)
     :collect (if (char/= cc #\\)
                  cc
                  (ecase (setf p (read-char stream t nil t))
                    ((#\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\0)
                     (setq cc #\Null)
                     (unread-char p stream)
                     (code-char (let ((*read-base* 8)) (read stream t nil t))))
                    (#\C (setq cc #\Null)
                         (read-char stream t nil t) ;; skip #\-
                         (let ((c (read-char stream t nil t)))
                           (cond ((char<= #\a c #\z) (code-char (1+ (- (char-code c) (char-code #\a)))))
                                 ((char<= #\A c #\Z) (code-char (1+ (- (char-code c) (char-code #\A))))))))
                    (#\x (setq cc #\Null)
                         (code-char (let ((*read-base* 16)) (read stream t nil t))))
                    ((#\; #\" #\\ #\s #\( #\) #\[ #\]) (setq cc #\Null) p)
                    (#\n (setq cc #\Null) #\Newline)
                    (#\t (setq cc #\Null) #\Tab)
                    (#\r (setq cc #\Null) #\Return)))
     :into res
     :finally (return (if (characterp (car res)) (car res) res))
     :while (char= cc #\\)))

(named-readtables:defreadtable syntax
  (:merge :standard)
  (:macro-char #\? #'read-character-literal t))

(in-package :asdf)

(defclass lem.evil.el (cl-source-file)
  ((type :initform "el")))

(defmethod perform ((o compile-op) (c lem.evil.el))
  (let ((*package* (find-package :lem.evil.el))
        (*readtable* (named-readtables:find-readtable 'lem.evil.el::syntax)))
    (perform-lisp-compilation o c)))

(defmethod perform ((o load-op) (c lem.evil.el))
  (let ((*package* (find-package :lem.evil.el)))
    (perform-lisp-load-fasl o c)))
