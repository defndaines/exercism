(ns dominoes)

(defn- match?
  "Check if either half of a tile has the desired number of dots."
  [dots tile]
  (let [[a b] tile]
    (or (= dots a) (= dots b))))

(defn- separate-matching
  "Separate out the `tiles` which can match the number of `dots` and those that
  cannot."
  [dots tiles]
  (group-by
    (partial match? dots)
    tiles))

(defn- remove-tile
  "Remove the `tile` from `tiles`."
  [tile tiles]
  (let [pos (.indexOf tiles tile)
        len (count tiles)]
    (concat
      (subvec tiles 0 pos)
      (subvec tiles (min (inc pos) len)))))

(defn- connect
  "Connect the `tiles` in a chain, if possible. Otherwise, return `nil`."
  ([tiles]
   (connect [(first tiles)] (rest tiles)))
  ([chain tiles]
   (if (seq tiles)
     (let [[_ dots] (last chain)
           {matches true
            left-over false} (separate-matching dots tiles)]
       (when (seq matches)
         (some
           identity
           (map
             (fn [[a b :as tile]]
               (let [aligned (if (= dots a) tile [b a])]
                 (connect (conj chain aligned)
                          (concat left-over
                                  (remove-tile tile matches)))))
             matches))))
     chain))) ; no tiles left to connect.

(defn loop?
  "Check if the head and tail of a chain can loop back on one another."
  [chain]
  (when chain
    (= (ffirst chain) (last (last chain)))))

(defn can-chain? [tiles]
  (loop? (connect tiles)))
