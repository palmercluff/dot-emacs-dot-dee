(define-abbrev-table
  'global-abbrev-table '(
			 ;; Greek letters
			 ("Alpha"      "Α") ;A
			 ("alpha"      "α") ;a
			 ("Beta"       "Β") ;B
			 ("beta"       "β") ;b
			 ("Gamma"      "Γ") ;G
			 ("gamma"      "γ") ;g
			 ("Delta"      "Δ") ;D
			 ("delta"      "δ") ;d
			 ("Epsilon"    "Ε") ;E
			 ("epsilon"    "ε") ;e
			 ("Zeta"       "Ζ") ;Z
			 ("zeta"       "ζ") ;z
			 ("Eta"        "Η") ;H
			 ("eta"        "η") ;h
			 ("Theta"      "Θ") ;Th
			 ("theta"      "θ") ;th
			 ("Iota"       "Ι") ;I
			 ("iota"       "ι") ;i
			 ("Kappa"      "Κ") ;K
			 ("kappa"      "κ") ;k
			 ("Lambda"     "Λ") ;L
			 ("lambda"     "λ") ;l
			 ("Mu"         "Μ") ;M
			 ("mu"         "μ") ;m
			 ("Nu"         "Ν") ;N
			 ("nu"         "ν") ;n
			 ("Xi"         "Ξ") ;X
			 ("xi"         "ξ") ;x
			 ("Omicron"    "Ο") ;O
			 ("omicron"    "ο") ;o
			 ("Pi"         "Π") ;P
			 ("pi"         "π") ;p
			 ("Rho"        "Ρ") ;R
			 ("rho"        "ρ") ;r
			 ("Sigma"      "Σ") ;S
			 ("sigma"      "σ") ;s
			 ("Tau"        "Τ") ;T
			 ("tau"        "τ") ;t
			 ("Upsilon"    "Υ") ;U
			 ("upsilon"    "υ") ;u
			 ("Phi"        "Φ") ;Ph
			 ("phi"        "φ") ;ph
			 ("Chi"        "Χ") ;Ch
			 ("chi"        "χ") ;ch
			 ("Psi"        "Ψ") ;Ps
			 ("psi"        "ψ") ;ps
			 ("Omega"      "Ω") ;O
			 ("omega"      "ω") ;o

			 ;; Currency
			 ("yen"        "¥")
			 ("euro"       "€")

			 ;; Temperatures
			 ("degrees" "" degrees)
			 ("C"          "Celsius")
			 ("F"          "Fahrenheit")

			 ;; Other
			 ("inf"        "∞") ;Infinity
			 ("nospace"    "no space after expansion" dont-add-space)
			 ))

(defun degrees()
  (backward-char)
  (insert "°"))

(defun dont-add-space()
  t)
(put 'dont-add-space 'no-self-insert t)
