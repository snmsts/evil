(load
 (merge-pathnames "cl/el-asd.lisp"
                  (make-pathname :defaults *load-pathname* :type nil :name nil)))

(defsystem evil
  :version "0.0.0"
  :author "SANO Masatoshi"
  :license "GPLv3"
  :depends-on (:lem)
  :components ((:module "cl"
                :components
                ((:file "el")))
               (:lem.evil.el "evil-vars")
               (:lem.evil.el "evil-digraphs")
               ;;(:lem.evil.el "evil-common")
               )
  :description "to manupulate source for implement evil for lem"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op evil-test))))
