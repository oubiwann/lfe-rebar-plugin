(defmodule lfe-rebar-plugin
  (export all)
  (import
    (from lists
      (filter 2)
      (flatten 1)
      (map 2))
    (from lfe-utils
      (tuple? 1))
    (from lfe-rebar-plugin-utils
      (get-base-dir 1)
      (base-dir? 1)
      (run-in-basedir 3)
      (run-in-other-dirs 3))))

(include-lib "include/lfe-rebar-records.lfe")

(defun filter-plugins (option)
  ""
  (if (tuple? option)
    (if (== (element 1 option) 'plugins)
      (element 2 option))))

(defun not-false? (expr)
  (=/= expr 'false))

(defun get-plugins (options)
  (flatten
    (filter
      #'not-false?/1
      (map #'filter-plugins/1 options))))

(defun list-plugins (config app-file)
  ""
  (case (base-dir? config)
    ('true
      (progn
        (let* ((opts (config-opts config))
               (plugins (get-plugins opts)))
          (: io format '"~p~n" (list plugins)))))
    ('false 'ok)))

(defun help (parent-config commands)
  (: io format '"~p~n" commands))

(defun print-default-commands ()
  (: rebar_utils sh
    '"rebar -c"
    '(#(use_stdout true) return_on_error)))

(defun get-commands-help ()
  (print-default-commands)
  (: io format '"
Commands for the '~s' rebar plugin:

  list-plugins\t\t\t     List all the plugins defined for the current dir
  commands\t\t\t     List both the default commands and those for the plugins
  ~n" (list (MODULE))))

(defun call-commands-help (plugin)
  (eval `(: ,plugin get-commands-help)))

(defun commands (config app-file)
  (run-in-basedir
    config
    app-file
    (lambda ()
      (let ((plugins (get-plugins (config-opts config))))
        (map #'call-commands-help/1 plugins))))
  'ok)
