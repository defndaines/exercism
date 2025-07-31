(ns armstrong-numbers)

(defn digits
  "Get a sequence of digits for a given number."
  [n]
  (loop [ds '()
         x n]
    (if (zero? x)
      ds
      (recur (conj ds (mod x 10))
             (quot x 10)))))

(defn armstrong? [num]
  (let [ds (digits num)
        len (count ds)]
    (->> ds
         (map #(apply * (repeat len %)))
         (apply +)
         (= num))))
