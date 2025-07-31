(ns etl)

(defn transform [legacy-data]
  (reduce
    (fn [acc [points words]]
      (let [ws (map clojure.string/lower-case words)]
        (reduce (fn [a e] (assoc a e points)) acc ws)))
    {}
    legacy-data))