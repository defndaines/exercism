(ns roman-numerals)

(defn m [n]
  (let [z (rem (quot n 1000) 5)]
    (when (> 4 z 0)
      (repeat z \M))))

(defn cm [n]
  (when (> (rem n 1000) 899)
    "CM"))

(defn d [n]
  (when (> 900 (rem n 1000) 499)
    "D"))

(defn cd [n]
  (when (= 4 (rem (quot n 100) 10))
    "CD"))

(defn c [n]
  (let [z (rem (quot n 100) 5)]
    (when (> 4 z 0)
      (repeat z \C))))

(defn xc [n]
  (when (> (rem n 100) 89)
    "XC"))

(defn l [n]
  (when (> 90 (rem n 100) 49)
    "L"))

(defn xl [n]
  (when (= 4 (rem (quot n 10) 10))
    "XL"))

(defn x [n]
  (let [z (rem (quot n 10) 5)]
    (when (> 4 z 0)
      (repeat z \X))))

(defn ix [n]
  (when (= 9 (rem n 10))
    "IX"))

(defn v [n]
  (when (> 9 (rem n 10) 4)
    "V"))

(defn iv [n]
  (when (= 4 (rem n 10))
    "IV"))

(defn i [n]
  (let [z (rem n 5)]
    (when (> 4 z 0)
      (repeat z \I))))

(def rules [m cm d cd c xc l xl x ix v iv i])

(defn numerals [n]
  (apply str
         (reduce (fn [acc e] (concat acc (e n)))
                 '()
                 rules)))