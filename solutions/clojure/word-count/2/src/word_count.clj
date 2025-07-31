(ns word-count
  (:require [clojure.string :as str]))

(defn word-count [s]
  (-> s
      .toLowerCase
      (str/replace #"\P{Alnum}+" " ")
      (str/split #"\p{Blank}+")
      frequencies))