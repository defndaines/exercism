(ns etl)

(defn multimap-invert
  "Returns the map with the each value mapped to the keys.
  An optional transform function can be passed to apply to each value."
  ([coll] (multimap-invert identity coll))
  ([tr coll]
   (reduce
     (fn [acc [k vs]]
       (reduce (fn [a e] (assoc a e k)) acc (map tr vs)))
     {}
     coll)))

(defn transform [legacy-data]
  (multimap-invert clojure.string/lower-case legacy-data))