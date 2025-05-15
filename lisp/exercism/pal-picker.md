---
description: Pal Picker Exercism Lisp exercise notes and solutions.
---

# Pal Picker

- [Pal Picker Lisp Exercise](https://exercism.org/tracks/common-lisp/exercises/pal-picker)

## Solution

```lisp
;;;;
;; pal-picker :: Symbol -> String
;;
;; Returns the type of pet based on the personality.
;;
(defun pal-picker (personality)
  (cond
    ((string= personality :lazy) "Cat")
    ((string= personality :energetic) "Dog")
    ((string= personality :quiet) "Fish")
    ((string= personality :hungry) "Rabbit")
    ((string= personality :talkative) "Bird")
    (t "I don't know... A dragon?")))

;;;;
;; habitat-filter :: Integer -> Symbol
;;
;; Returns the habitat size based on the weight of the animal.
;;
(defun habitat-fitter (weight)
  (cond
    ((>= weight 40) :massive)
    ((and (>= weight 20) (<= weight 39)) :large)
    ((and (>= weight 10) (<= weight 19)) :medium)
    ((and (>= weight 1) (<= weight 9)) :small)
    ((<= weight 0) :just-your-imagination)))

;;;;
;; feeding-time-p :: Integer -> String
;;
;; Returns a string indicating whether the bowl needs refilling based on
;; the bowl fullness.
;;
(defun feeding-time-p (fullness)
  (if (> fullness 20)
    "All is well."
    "It's feeding time!"))

;;;;
;; pet :: String -> String | NIL
;;
;; Returns a string informing we should probably not pet this specific
;; pet or nil if this kind of pet can be petted.
;;
(defun pet (pet)
  (cond
    ((string= pet "Fish") "Maybe not with this pet...")
    (t nil)))

;;;;
;; play-fetch :: String -> String | NIL
;;
;; Returns nil if this kind of pet can play fetch, or a string
;; indicating we should probably not try to play fetch with this
;; kind of pet.
;;
(defun play-fetch (pet)
  (cond
    ((string= pet "Dog") nil)
    (t "Maybe not with this pet...")))
```
