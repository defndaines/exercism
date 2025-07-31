(ns roman-numerals)

(def ^:private romans
  [1000 "M" 900 "CM" 500 "D" 400 "CD"
    100 "C"  90 "XC"  50 "L"  40 "XL"
     10 "X"   9 "IX"   5 "V"   4 "IV"
      1 "I"])

(defn ^:private romanize [n, acc, pairs]
  (if (zero? n)
    (apply str acc)
    (let [[deci roman] (first pairs)]
      (if (>= n deci)
        (romanize (- n deci) (concat acc roman) pairs)
        (romanize n acc (rest pairs))))))

(defn numerals [n]
  (romanize n "" (partition 2 romans)))