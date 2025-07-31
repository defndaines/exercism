(ns poker)

(def ranks
  {"A" 0
   "K" 1
   "Q" 2
   "J" 3
   "10" 4
   "9" 5
   "8" 6
   "7" 7
   "6" 8
   "5" 9
   "4" 10
   "3" 11
   "2" 12})

(defn split-cards
  [hand]
  (map
    (fn [card]
      (let [[[c f s]] (re-seq #"(\w+)([SHCD])" card)]
        {:card c
         :face f
         :rank (ranks f)
         :suit s
         :hand hand}))
    (clojure.string/split hand #" ")))

(defn report [cards hand-rank]
  [(apply str [(conj (map :rank (sort-by :rank cards)) hand-rank)])
   (:hand (first cards))])


(defn straight-flush? [cards]
  (when (and
          (= 1 (count (set (map :suit cards))))
          (let [[a b _ _ e] (sort-by :rank cards)]
            (or (= 4 (- (:rank e) (:rank a)))
                (and (= "A" (:face a)) (= "5" (:face b))))))
    (report cards 0)))

(defn four-of-a-kind? [cards]
  (let [g (group-by :face cards)]
    (when (and (= 2 (count g))
               (let [[_ b] (sort-by (comp count second) g)]
                 (= 4 (count (second b)))))
      (report cards 1))))

(defn full-house? [cards]
  (let [g (group-by :face cards)]
    (when (and (= 2 (count g))
               (let [[a b] (sort-by (comp count second) g)]
                 (and (= 2 (count (second a)))
                      (= 3 (count (second b))))))
      (report cards 2))))

(defn flush? [cards]
  (when (= 1 (count (set (map :suit cards))))
    (report cards 3)))

(defn straight? [cards]
  (when (let [[a b c d e :as sorted] (sort-by :rank cards)]
          ;; TODO Ace low as to be sorted differently.
          (or (apply = (map + (map :rank sorted) (range 4 -1 -1)))
              (and (= "A" (:face a))
                   (= "5" (:face b))
                   (= "4" (:face c))
                   (= "3" (:face d))
                   (= "2" (:face e)))))
    (report cards 4)))

(defn three-of-a-kind? [cards]
  (let [g (group-by :face cards)]
    (when (and (= 3 (count g))
               (let [[_ _ batch] (sort-by (comp count second) g)]
                 (= 3 (count (second batch)))))
      (report cards 5))))

(defn two-pairs? [cards]
  (let [g (group-by :face cards)]
    (when (and (= 3 (count g))
               (let [[_ a b] (sort-by (comp count second) g)]
                 (and (= 2 (count (second a)))
                      (= 2 (count (second b))))))
      (report cards 6))))

(defn one-pair? [cards]
  (let [g (group-by :face cards)]
    (when (= 4 (count g))
      (report cards 7))))

(defn high-card [cards]
  (report cards 8))


(defn rank-hand [hand]
  (some identity
        (map
          #(% (split-cards hand))
          [straight-flush?
           four-of-a-kind?
           full-house?
           flush?
           straight?
           three-of-a-kind?
           two-pairs?
           one-pair?
           high-card])))


(defn best-hands [hands]
  [(second (first (sort-by first (map rank-hand hands))))])

