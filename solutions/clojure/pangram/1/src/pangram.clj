(ns pangram)

(defn pangram? [s]
  (= 26
     (-> s
         clojure.string/lower-case
         (clojure.string/replace #"\P{Alpha}" "")
         distinct
         count)))