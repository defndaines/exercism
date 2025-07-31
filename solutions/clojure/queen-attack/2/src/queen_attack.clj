(ns queen-attack)

(def ^:private row (vec (repeat 8 \_)))

(def ^:private default-board (vec (repeat 8 row)))

(defn ^:private board-to-str [board]
  (str (clojure.string/join
         \newline
         (map #(clojure.string/join \space %) board))
       \newline))

(defn board-string [{white :w black :b}]
  (board-to-str
    (if (seq white)
      (let [with-w (assoc-in default-board white \W)]
        (assoc-in with-w black \B))
      default-board)))

(defn can-attack
  "Determine if two pieces are vertically, horizontally, or diagonally aligned."
  [{[wx wy] :w [bx by] :b}]
  (or
    (= wx bx)
    (= wy by)
    (= (Math/abs (- wx bx)) (Math/abs (- wy by)))))