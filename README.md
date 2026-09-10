# UK Warehouse-to-Store Transportation Optimisation

**A linear programming project proving that an optimised, capacity-respecting shipment plan barely costs more than an infeasible "nearest warehouse" guess.**

## The Problem

3 UK distribution centres ship to 15 stores. Each warehouse has a fixed **capacity**, each store has a fixed **demand**, and every route has a **cost** (haversine distance × £0.45/km). The goal: find the shipment plan that minimises total cost while respecting every capacity and demand constraint.

| Warehouse | Capacity |
|---|---|
| Basildon DC | 5,000 |
| Birmingham DC | 6,000 |
| Leeds DC | 4,000 |

Total capacity (15,000) exceeds total demand (12,000) — the problem is feasible before solving.

Since haversine gives straight-line distance, not real road distance, cost is bounded two ways: a **lower bound** (raw haversine) and an **upper bound** (inflated for road circuity).

## Linear Program

<table>
<tr>
<th width="50%">Standard Form (Primal)</th>
<th width="50%">Dual Problem</th>
</tr>
<tr>
<td>

**Minimise:**

$$\sum_{i=1}^{3}\sum_{j=1}^{15} c_{ij}x_{ij}$$

**Subject to:**

$$\sum_{j=1}^{15} x_{ij} + s_i = \text{capacity}_i \quad \forall i$$

$$\sum_{i=1}^{3} x_{ij} - e_j = \text{demand}_j \quad \forall j$$

$$x_{ij},\ s_i,\ e_j \geq 0$$

</td>
<td>

**Maximise:**

$\sum_{i=1}^{3} \text{capacity}_i \cdot u_i + \sum_{j=1}^{15} \text{demand}_j \cdot v_j$

**Subject to:**

$$u_i + v_j \leq c_{ij} \quad \forall i,j$$

$$u_i \leq 0 \quad \forall i$$

$$v_j \geq 0 \quad \forall j$$

</td>
</tr>
</table>

$x_{ij}$ = units shipped warehouse $i$ → store $j$. $u_i, v_j$ = shadow prices of capacity/demand. By complementary slackness, only **Leeds DC** has $u_i \neq 0$ — it's the only warehouse fully utilised at optimum.

## Results

| Scenario | Naive (nearest-only) | LP-Optimised |
|---|---|---|
| Lower bound | £360,363 infeasible | £360,689 |
| Upper bound | £587,210 infeasible | £596,198 |

Naive assigns 4,900 units to Leeds DC (capacity: 4,000) — impossible. The LP is the cheapest **achievable** plan, costing only £326–£8,988 more than the invalid naive estimate. Leeds DC runs at 100% capacity (the network bottleneck); Basildon and Birmingham DC have slack. The optimal allocation is identical across both cost scenarios.

## Visualisations

<table>
<tr>
<td width="50%"><img src="scripts/matplot.png"/></td>
<td width="50%"><img src="data/sources_sinks_map.png"/></td>
</tr>
<tr>
<td width="50%"><img src="scripts/naive_vs_optimised.png"/></td>
<td width="50%"><img src="scripts/utilisation_comparison.png"/></td>
</tr>
</table>

## Tech Stack

`pandas`, `numpy`, `geopandas`, `matplotlib`, `PuLP` (CBC solver)
