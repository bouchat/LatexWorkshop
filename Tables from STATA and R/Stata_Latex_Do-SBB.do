/*
Using LaTeX and Stata 
Sarah B. Bouchat
24 September 2014
Thanks to Simon Haeder and the internet for basically all of this
*/

cd "/Users/sbouchat/LatexWorkshop"

/* Packages Used
findit outtex
findit outtable
findit sutex
findit graph2tex
findit latab
findit listtab
findit corrtex
findit estatout
*/

ssc install outtex
ssc install outtable
ssc install sutex
/*ssc install graph2tex */
ssc install latab
ssc install listtab
ssc install corrtex
/*ssc install estatout */
ssc install estout

sysuse auto
describe
summarize
encode make, generate (make2)

* OLS Estimation
reg price headroom trunk weight foreign mpg, vce(robust)

* outtex
outtex
outtex, detail
outtex, detail level below 
outtex, detail level below digits (5) legend 
outtex, detail level below digits (5) legend label nopar 
outtex, detail level below digits (5) legend label nopar title(Auto Results)


quietly reg price headroom trunk weight foreign mpg i.make2, vce(robust)
outtex, detail level below digits (5) legend label nopar title(Auto Results) long

* outtable
quietly reg price headroom trunk weight foreign mpg, vce(robust)
matrix var=e(V)
matrix list var
matrix list var, nohalf

outtable using table1, mat(var) 
outtable using table1, mat(var) cap(Variance-Covariance Matrix) nobox append

* sutex
sutex
sutex, minmax nobs par labels

*graph2tex
scatter length weight
graph2tex, epsfile(auto1) number reset
scatter price trunk
graph2tex, epsfile(auto2) number 

graph2tex, epsfile{auto1} caption(Auto) ht(5)

*latab
tab foreign
latab foreign, dec(2)

* latabstat
tabstat length weight, by(foreign)
latabstat length weight, by(foreign) s(mean sd min max n r skewness) cap(Auto)

* listtab
list make weight
 listtab make weight , type delim(&)

* corrtex
 corrtex price foreign mpg if price>5000, file(2)

 *estout
eststo: quietly regress price weight mpg
eststo: quietly regress price weight mpg foreign
esttab using example1.tex, stats(r2 bic N) label nostar title(Regression table\label{tab1})
eststo clear

eststo: quietly regress price weight mpg
estadd vif
esttab using example1.tex, aux(vif 2) wide nopar append













 
 
 
