(ns phone-number)

(def ^:private invalid-number "0000000000")

(defn number [s]
  (let [n (apply str (re-seq #"\p{Digit}+" s))
        size (count n)]
    (cond
      (= 10 size) n
      (and (= 11 size) (clojure.string/starts-with? n "1")) (subs n 1)
      :else invalid-number)))

(defn area-code [s]
  (subs (number s) 0 3))

(defn pretty-print [s]
  (let [n (number s)]
    (str \( (subs n 0 3) \)
         \space (subs n 3 6) \- (subs n 6))))