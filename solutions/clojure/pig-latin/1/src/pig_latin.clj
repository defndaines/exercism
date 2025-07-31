(ns pig-latin
  (:require [clojure.string :as s]))

(def exceptions #"^([aeiou]|yt|xr).*")

(def lead-consonants #"([^aeiou]*qu|[^aeiou]*)([aeiou].*)")

(defn- pig-word [w]
  (if (re-matches exceptions w)
    (str w "ay")
    (if-let [[_ head tail] (re-matches lead-consonants w)]
      (str tail head "ay")
      (str w "ay"))))

(defn translate [phrase]
  (->>
    (s/split phrase #"\s")
    (map pig-word)
    (s/join " ")))