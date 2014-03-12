(defmodule lfe-rebar-plugin-utils
  (export all)
  (import
    (from lists
      (filter 2)
      (flatten 1)
      (map 2))
    (from lfe-utils
      (tuple? 1))))

(include-lib "include/lfe-rebar-records.lfe")

(defun get-base-dir (config-data)
  "Get the top-level directory for the project."
  (case (: dict find 'base_dir (config-xconf config-data))
    ((tuple 'ok dir) dir)
    ('error "")))

(defun base-dir? (config-data)
  "Useful as a predicate for checks."
  (==
    (: rebar_utils get_cwd)
    (get-base-dir config-data)))

(defun run-in-basedir (config app-file func)
  "We only want to execute this function when the plugin is running in the
  base directory."
  ;(: lfe-utils dump-data '"debug-config-data.erl" config)
  (case (base-dir? config)
    ('true (funcall func))
    ('false 'ok)))

(defun run-in-other-dirs (config app-file func)
  "We want to execute this function whenever the plugin is not running in the
  base directory."
  ;(: lfe-utils dump-data '"debug-config-data.erl" config)
  (case (not (base-dir? config))
    ('true (funcall func))
    ('false 'ok)))
