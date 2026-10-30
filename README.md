# Housing Affordability in Catalonia (2013--2023)

## Project Overview

This project explores how housing affordability has evolved across
Catalonia between 2013 and 2023, and how this evolution differs between
municipalities.

The analysis focuses on 47 Catalan municipalities with more than 30,000
inhabitants. It brings together housing prices, rental prices, income,
demographic indicators, housing-market activity and territorial context
to identify geographical and temporal patterns.

The project is exploratory and descriptive. It aims to identify
associations and differences across municipalities, not to establish
causal relationships.

## Research Question

**How has housing affordability evolved across Catalan municipalities,
and how does this evolution relate to income, demographic change and
distance from Barcelona?**

The analysis is structured around three complementary dimensions:

* **Economic:** housing purchase prices, rental prices and income.
* **Demographic and territorial:** population trends,
municipality-level differences and distance from Barcelona.
* **Market context:** housing transactions, mortgages and mortgage
interest rates, where data coverage allows.

## Scope

\---

Item                                Definition

\---

Geographic scope                    Catalonia, Spain

Municipal universe                  47 municipalities with more than
30,000 inhabitants

Main analysis period                2013--2023

Unit of analysis                    Municipality and year, where
available

Analytical approach                 Exploratory and descriptive

Main tools                          Python, pandas, SQL/MySQL
Workbench, Tableau
---

Some contextual datasets cover periods outside the main analysis window.
Their coverage is stated separately where relevant.

## Data and Preparation

The project combines municipal-level datasets covering housing, income,
population and market activity.

Data preparation has included:

* Reviewing source tables and their temporal coverage.
* Checking municipal identifiers and consistency across datasets.
* Validating the municipal analysis universe.
* Reviewing missing values and differences in year coverage.
* Standardising units where necessary.
* Preparing analysis-ready tables and CSV files for visualisation.
* Checking relationships between Tableau data sources and avoiding
unsupported joins.

### Database and data validation

The SQL database schema used during the project is named
`housing\_affordability` and contains 11 tables.

Key validation results recorded during the data preparation stage:

* `analysis\_universe` is used to validate the municipal keys included
in the analysis.
* The affordability dataset contains **517 records**, covering **47
municipalities** over **2013--2023**.
* `contracts\_by\_year` covers **2005--2025**; 2026 is incomplete and
should not be treated as a full year.
* `mortgages\_by\_year` covers **2013--2024**. The conversion from
thousands to individual units was checked for consistency across the
12 available years.

These coverage differences matter when comparing indicators: not every
dataset supports the same time period.

## Key Indicators and Methodology

### 1\. Purchase affordability

The purchase affordability analysis compares housing purchase prices
with income.

One of the indicators used is the **Price-to-Income Ratio (PER)**, which
expresses the equivalent number of years of annual income represented by
a property's price.

* A higher PER indicates that purchasing a home requires more years of
income.
* Therefore, a higher PER indicates lower purchase affordability.

### 2\. Rental affordability and housing effort

Rental affordability compares rental costs with income.

The **Housing Effort** indicator measures the share of income required
to cover housing costs.

* A higher housing-effort percentage indicates greater financial
pressure.
* A lower percentage indicates that housing costs represent a smaller
share of income.

The interpretation of this metric depends on the exact housing-cost and
income definitions available in the source data.

### 3\. Affordability indices

To compare changes over time within each municipality, purchase and
rental affordability indicators are normalised to a common base year:

**2013 = 100**

The project uses:

* `purchase\_affordability\_index`
* `rental\_affordability\_index`

A combined indicator is calculated as the arithmetic mean of the two
indices:

``` text
combined\_affordability\_index =
    (purchase\_affordability\_index + rental\_affordability\_index) / 2
```

This gives equal weight to the relative evolution of purchase and rental
affordability.

**Important interpretation:** the combined index is a composite proxy
for changes in affordability over time. It is not a direct measurement
of actual household expenditure, the total cost of living, or the
proportion of household budgets spent on housing. Since both component
indices are normalised to 2013, the combined index describes relative
change against that base year rather than an absolute affordability
level that can be compared directly between municipalities.

### 4\. Income evolution

Income trends are considered alongside housing prices to assess whether
income has evolved at a similar pace.

A municipality-level annual income growth rate can be calculated using
the compound annual growth rate (CAGR), provided that the selected
income measure has comparable observations in both 2013 and 2023:

``` text
CAGR = (Income\_2023 / Income\_2013) ^ (1 / 10) - 1
```

The calculation assumes one comparable income value per municipality for
each endpoint year. It should not be interpreted as evidence that income
growth caused changes in affordability.

### 5\. Demographic and territorial context

Population change and distance from Barcelona are used to explore
whether affordability patterns differ according to municipal context.

The territorial analysis can help distinguish:

* Municipalities close to Barcelona.
* Municipalities in the wider metropolitan area.
* Municipalities farther from Barcelona.

Distance is treated as a descriptive territorial variable, not as proof
that proximity to Barcelona causes higher or lower housing costs.

### 6\. Housing-market activity and mortgage context

Housing-market activity is considered through available indicators such
as contracts and mortgages. Mortgage interest rates provide additional
context for understanding the financing environment during the period.

The available time ranges are not identical:

* Contracts: 2005--2025, with 2026 incomplete.
* Mortgages: 2013--2024.
* Main affordability analysis: 2013--2023.

For this reason, market-activity charts should clearly show their own
date coverage and should not imply that all indicators cover the same
period.

## Main Findings and Analytical Insights

The work completed so far has established the analytical framework and
prepared the indicators needed to compare affordability across
municipalities.

The following observations have been developed for the dashboard
narrative:

* The analysis includes a reported annual housing-price increase of
**4.22%** for the period/series examined. This figure should always
be presented with its precise source, indicator definition and
calculation period.
* Housing prices need to be interpreted alongside income evolution:
price growth alone does not describe the full change in
affordability.
* Mortgage interest rates and housing-market activity provide
additional context for understanding changes in the market.
* Municipal comparisons are important because regional averages can
conceal substantial local differences.
* The comparison of municipalities near Barcelona helps explore the
geographical dimension of housing affordability.

The final conclusions should be based on the validated dashboard
outputs. No causal relationship should be inferred from the observed
associations.

## Dashboard and Visualisation

The project includes a Tableau dashboard built from prepared municipal
and time-series datasets.

The data model has been reviewed, including the relationship between
`analysis\_universe.csv` and `distance\_analysis.csv`.

A relevant structural detail is that neither of these two files contains
a `year` field. Their relationship should therefore be based on the
appropriate shared municipal key, rather than on a time-based
relationship.

The dashboard is intended to bring together:

* The evolution of housing affordability.
* Purchase and rental affordability indicators.
* Income and housing-price trends.
* Differences between municipalities.
* Population and territorial context.
* Housing-market activity and mortgage context.

The final dashboard should make the geographic scope, indicator
definitions and available date ranges clear to the reader.

## Limitations

The results should be interpreted in light of the following limitations:

1. **Partial definition of housing costs.** The analysis does not
include every expense associated with owning or renting a home, nor
all household living expenses. Additional costs such as utilities,
maintenance, taxes, insurance and other recurring expenses may
affect real household affordability.
2. **Composite index.** The combined affordability index gives equal
weight to the purchase and rental indices. This is a methodological
choice, not a measured distribution of households between owners and
renters.
3. **Relative rather than absolute comparison.** Indices normalised to
2013 = 100 show changes relative to the base year. They do not, by
themselves, establish which municipality is absolutely more
affordable.
4. **Different data coverage.** Some datasets cover periods beyond or
shorter than 2013--2023. Comparisons must respect each dataset's
actual coverage.
5. **Municipal universe.** The analysis is limited to 47 municipalities
with more than 30,000 inhabitants. Findings should not automatically
be generalised to every municipality in Catalonia.
6. **Descriptive analysis.** Observed relationships between housing
prices, income, demographics, distance and market activity are
associations. They do not demonstrate causality.
7. **Income and household differences.** Municipal or aggregate income
indicators may not reflect the circumstances of every household,
income group or household composition.

## Project Status

### Completed or established

* Defined the main research question and the 47-municipality
analytical scope.
* Established the 2013--2023 main analysis period.
* Created and validated the `housing\_affordability` database
structure.
* Validated the municipal analysis universe.
* Checked the affordability dataset coverage: 517 records, 47
municipalities and 2013--2023.
* Reviewed the coverage and units of contracts and mortgage datasets.
* Defined purchase and rental affordability indicators.
* Created the methodology for the purchase, rental and combined
indices, normalised to 2013 = 100.
* Prepared municipal and territorial data for dashboard analysis.
* Reviewed Tableau data-source relationships, including
`analysis\_universe.csv` and `distance\_analysis.csv`.

### Remaining work / final checks

* Verify that all index values shown in Tableau match the validated
calculations in the notebooks and exported CSV files.
* Confirm the exact definition, source and period behind the reported
4.22% annual housing-price increase.
* Complete the interpretation of municipal differences, including
municipalities close to Barcelona.
* Finalise the multivariable analysis and ensure that all variables
are defined consistently.
* Complete the answer to the main research question using the final
validated results.
* Add the final dashboard screenshots or public link, if available.
* Review chart titles, units, date ranges, source notes and metric
definitions.
* Include the limitations and housing-cost disclaimer in the final
presentation.

## Conclusion

This project provides a municipality-level, descriptive view of housing
affordability in Catalonia between 2013 and 2023.

By combining purchase and rental indicators with income, demographic
change, territorial context and housing-market activity, it aims to show
how affordability has evolved and why the experience may differ from one
municipality to another.

The final assessment should distinguish between the relative evolution
of affordability and the absolute cost of housing, and should make clear
that the indicators do not capture every expense faced by households.

## Tools and Technologies

* **Python:** data cleaning, preparation and exploratory analysis.
* **pandas / NumPy:** data manipulation and calculations.
* **SQL / MySQL Workbench:** database structure, data validation and
queries.
* **Tableau:** data modelling and dashboard development.
* **Jupyter Notebook:** reproducible analysis and documentation.

## Jeronimo Cagliero

Data Analytics Final Project --- Ironhack

**Topic:** Housing Affordability in Catalonia  
**Period:** 2013--2023  
**Geographic scope:** 47 Catalan municipalities

