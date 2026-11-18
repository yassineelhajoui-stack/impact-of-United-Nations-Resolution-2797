# Replication package — CGE simulations (PEP-w-t model)

This package contains the GAMS code used to produce the computable general
equilibrium (CGE) results reported in Section 4 of the article ("Simulation
of the impact of Resolution 2797 on intra-AMU trade and Maghreb economic
integration"). It is provided to the reviewers of *Frontiers in Political
Science* for verification and reproducibility purposes.

## 1. Base model

All simulations are built on **PEP-w-t**, the standard multi-region,
recursive-dynamic world CGE model developed by the Partnership for Economic
Policy (PEP):

- Robichaud, V., Lemelin, A., Decaluwé, B., & Maisonnave, H. (2013). *PEP-w-t:
  The PEP Standard Multi-Region, Recursive Dynamic World CGE Model*, version
  4.0.
- Lemelin, A., & Robichaud, V. (2014). *PEP-w-t: Update, with a Reference
  Scenario*, version 4.1.

The base model code (`PEP-w-t_v4.1-25-18.gms`, `INIT.gms`,
`DATA_AGG-2007-25-18.gms`, `BAU_SOLVE-25-18.gms`, `BAU_RESULTS-25-18.gms`,
`SIM_SOLVE-25-18.gms`, `SIM_RESULTS-25-18.GMS`, `XLS_RESULTS-25-18.GMS`) is
distributed by PEP under a **CC BY-NC-SA 3.0** licence (attribution to
Robichaud, Lemelin, Decaluwé and Maisonnave; non-commercial; share-alike).
This package modifies and extends that code for the purposes of this
article; it does **not** claim authorship of the base model.

The model is calibrated on a **25-region, 18-commodity** aggregation of the
GTAP database, following the aggregation procedure documented in Robichaud
(2014), *How to Create Input Files for DATA_AGG*.

> **Note on the GTAP database version.** The file names and in-code
> documentation inherited from the base PEP-w-t model (`DATA_AGG-2007-25-18.gms`,
> comments referring to "GTAP 8.1", Narayanan, Dimaranan & McDougall, 2012)
> all still say **GTAP 8.1**. The database actually used to calibrate the
> simulations reported in this article is **GTAP 11** (Aguiar et al., 2022),
> not GTAP 8.1. This naming has been left unchanged throughout the code,
> file names and documentation on purpose, to avoid discrepancies between
> what reviewers read in the files and what is described here — please read
> every "GTAP 8.1" reference in the code and file names below as GTAP 11.

The underlying GTAP database is proprietary and is **not included** in this
package; it must be obtained separately by any party holding a GTAP
licence, and the aggregation file (`DATA_AGG-2007-25-18.gdx`) regenerated
locally from it before the model can be solved (see Section 4).

## 2. What is specific to this article

The base model is a *generic* world CGE model with no built-in policy
shocks. Everything specific to Resolution 2797 and the four scenarios of
Table 2 of the article is implemented as separate GAMS snippets that are
`$INCLUDE`d into a full copy of `PEP-w-t_v4.1_CAL_B_line-25-18.gms` — the
"CAL_B_line" (calibrating baseline) variant of the model, which endogenously
computes total factor productivity and the household-savings intercept
consistent with the FBQF/MaGE reference growth trajectory (see the model
documentation, Appendix D).

| File (snippet) | Role |
|---|---|
| `referenc.gms` | Improves the **no-shock reference scenario**: makes permanent, from 2021 onward, the Morocco–Algeria tariff rupture described in Table 1 of the methodology (a historical fact, not a hypothetical shock). Must be run first — see Section 4. |
| `A_prime.gms` | **Scenario A′** — institutional/geopolitical shock, with a transitory intensification of bilateral tensions in 2025-2027 before reverting to the 2024 tariff status quo. |
| `A.gms` | **Scenario A** — institutional/geopolitical shock only; tariffs frozen at their 2024 (post-rupture) level. |
| `B.gms` | **Scenario B** — Scenario A + bilateral Morocco–Algeria tariff normalization (return to pre-2021 levels only). |
| `C.gms` | **Scenario C** — Scenario B + full, progressive intra-AMU tariff liberalization by 2040. |

Each snippet contains only the GAMS statements specific to that scenario
(tariff schedules on `ttim`, and the TFP shock on `A_VA` for the Saharan
provinces from 2025 onward); it is not a standalone runnable file. The
`cal_b_line_scenarios/` folder contains the corresponding **full, ready-to-run
copies** (`PEP-w-t_v4.1_CAL_B_line-25-18_{referenc,A_prime,A,B,C}.gms`), i.e.
the base model with the relevant snippet inserted at the correct point
inside the model's time loop (an important technical constraint: GAMS does
not allow new `ALIAS`/`PARAMETER` declarations inside a `LOOP`, so these are
declared once near the top of each full copy rather than inside the
snippet — see the in-file comments, "CORRECTIF 2").

## 3. Sensitivity analysis

`sensitivity_scenarios/` (snippets) and `sensitivity_wrappers/` /
`sensitivity_delivery/` (full ready-to-run copies) implement the ±50 %
one-at-a-time and joint sensitivity analysis reported in Section 4.2
(Figure 10, Tables 11–12), all built on top of Scenario C:

| File | Shock varied |
|---|---|
| `C_PTF_bas.gms` / `C_PTF_haut.gms` | Total factor productivity shock, ±50 % around +0.12 % |
| `C_invest_bas.gms` / `C_invest_haut.gms` | Investment shock, ±50 % around +1.5 % |
| `C_elast_bas.gms` / `C_elast_haut.gms` | CET/CES elasticities, ±50 % around +5 % |
| `C_bas.gms` / `C_haut.gms` | All three shocks varied jointly, ±50 % |

## 4. How to reproduce the results

Requirements: a licensed GAMS installation (with a compatible NLP/MCP
solver) and a personal GTAP licence (for `DATA_AGG-2007-25-18.gdx`) — **GTAP
11** in practice, see the note on database versioning in Section 1; the
file names below still read "GTAP 8.1" by inheritance from the base model.

1. **Data aggregation** — using a licensed copy of the GTAP database (GTAP
   11 — see Section 1) and `DATA_AGG-2007-25-18.gms` (see `How to create
   input files for DATA_AGGRev.pdf` for the step-by-step procedure), produce
   `DATA_AGG-2007-25-18.gdx` for the 25-region, 18-commodity aggregation.
2. **Step 0 — reference scenario**: run
   `PEP-w-t_v4.1_CAL_B_line-25-18_referenc.gms`. This produces
   `B_line-25-18_REF.gdx` (the calibrated no-shock reference path,
   including the corrected 2021-2024 tariff rupture) and
   `Results_reference.xlsx`.
3. **Policy scenarios**: run, in any order,
   `PEP-w-t_v4.1_CAL_B_line-25-18_A_prime.gms`,
   `..._A.gms`, `..._B.gms`, `..._C.gms`. Each reads `B_line-25-18_REF.gdx`
   from Step 0 and produces its own `Results_choc_*.xlsx`.
4. **Sensitivity analysis** (optional, reproduces Figure 10 / Tables 11-12):
   run the eight files in `sensitivity_wrappers/` (equivalently,
   `sensitivity_delivery/`), each of which also depends on
   `B_line-25-18_REF.gdx` from Step 0.

All scenario and sensitivity results used in the article are strictly
post-CORRECTIF 6; any `Results_*.xlsx` file generated before that fix was
applied should be considered superseded.

## 5. Contents of this package

```
GAMS/                                   base model (PEP, CC BY-NC-SA 3.0)
  PEP-w-t_v4.1-25-18.gms
  PEP-w-t_v4.1_CAL_B_line-25-18.gms
  INIT.gms
  DATA_AGG-2007-25-18.gms
  BAU_SOLVE-25-18.gms / BAU_RESULTS-25-18.gms
  SIM_SOLVE-25-18.gms / SIM_RESULTS-25-18.GMS
  XLS_RESULTS-25-18.GMS

gams_scenarios/                         scenario snippets (this article)
  referenc.gms, A_prime.gms, A.gms, B.gms, C.gms

cal_b_line_scenarios/                   full, ready-to-run copies
  PEP-w-t_v4.1_CAL_B_line-25-18_{referenc,A_prime,A,B,C}.gms
  PEP-w-t_v4.1_CAL_B_line-25-18_placebo.gms   (CORRECTIF 5 diagnostic only)

sensitivity_scenarios/                  sensitivity snippets
sensitivity_wrappers/ , sensitivity_delivery/    full, ready-to-run copies
```

## 6. Contact

For any question on the implementation of the scenarios, the correction
history, or reproduction of the results, please contact the corresponding
author.
