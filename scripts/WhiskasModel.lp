\* The_Whiskas_Problem *\
Minimize
Total_cost_of_ingredients_per_can: 0.008 BeefPercent + 0.013 ChickenPercent
Subject To
_C1: BeefPercent + ChickenPercent = 100
_C2: 0.2 BeefPercent + 0.1 ChickenPercent >= 8
_C3: 0.1 BeefPercent + 0.08 ChickenPercent >= 6
_C4: 0.005 BeefPercent + 0.001 ChickenPercent <= 2
_C5: 0.005 BeefPercent + 0.002 ChickenPercent <= 0.4
Bounds
 0 <= ChickenPercent
Generals
ChickenPercent
End
