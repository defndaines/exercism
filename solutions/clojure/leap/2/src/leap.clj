(ns leap)

(defn ^:private divisible-by? [n year]
  (zero? (rem year n)))

(defn leap-year? [year]
  (condp divisible-by? year
    400 true
    100 false
    4 true
    false))