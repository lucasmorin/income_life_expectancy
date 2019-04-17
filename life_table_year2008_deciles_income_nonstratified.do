
do path.do

use "year2008.dta", clear
	stset dox, fail(death==1) origin(time date_birth) enter(time date_entry) scale(365.25) id(lopnr)

cd "Life expectancy estimates (individual tables)"


ltable _t _d if sex==1 & level_income==1, hazard saving(male_income_1_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==2, hazard saving(male_income_2_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==3, hazard saving(male_income_3_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==4, hazard saving(male_income_4_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==5, hazard saving(male_income_5_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==6, hazard saving(male_income_6_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==7, hazard saving(male_income_7_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==8, hazard saving(male_income_8_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==9, hazard saving(male_income_9_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_income==10, hazard saving(male_income_10_2008.dta, replace) tvid(lopnr) notable

ltable _t _d if sex==2 & level_income==1, hazard saving(female_income_1_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==2, hazard saving(female_income_2_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==3, hazard saving(female_income_3_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==4, hazard saving(female_income_4_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==5, hazard saving(female_income_5_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==6, hazard saving(female_income_6_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==7, hazard saving(female_income_7_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==8, hazard saving(female_income_8_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==9, hazard saving(female_income_9_2008.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_income==10, hazard saving(female_income_10_2008.dta, replace) tvid(lopnr) notable



do path.do


use "Life expectancy estimates (individual tables)/male_income_1_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=1


save "Life expectancy estimates (individual tables)/male_income_1_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_2_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=2


save "Life expectancy estimates (individual tables)/male_income_2_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_3_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=3


save "Life expectancy estimates (individual tables)/male_income_3_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_4_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=4


save "Life expectancy estimates (individual tables)/male_income_4_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_5_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=5


save "Life expectancy estimates (individual tables)/male_income_5_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_6_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=6


save "Life expectancy estimates (individual tables)/male_income_6_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_7_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=7


save "Life expectancy estimates (individual tables)/male_income_7_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_8_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=8


save "Life expectancy estimates (individual tables)/male_income_8_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_9_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=9


save "Life expectancy estimates (individual tables)/male_income_9_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_income_10_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_income=10


save "Life expectancy estimates (individual tables)/male_income_10_2008_LE.dta", replace

use "Life expectancy estimates (individual tables)/female_income_1_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=1


save "Life expectancy estimates (individual tables)/female_income_1_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_2_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=2


save "Life expectancy estimates (individual tables)/female_income_2_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_3_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=3


save "Life expectancy estimates (individual tables)/female_income_3_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_4_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=4


save "Life expectancy estimates (individual tables)/female_income_4_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_5_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=5


save "Life expectancy estimates (individual tables)/female_income_5_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_6_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=6


save "Life expectancy estimates (individual tables)/female_income_6_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_7_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=7


save "Life expectancy estimates (individual tables)/female_income_7_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_8_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=8


save "Life expectancy estimates (individual tables)/female_income_8_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_9_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=9


save "Life expectancy estimates (individual tables)/female_income_9_2008_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_income_10_2008.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_income=10


save "Life expectancy estimates (individual tables)/female_income_10_2008_LE.dta", replace


do path.do


use "Life expectancy estimates (individual tables)/male_income_1_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_2_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_3_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_4_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_5_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_6_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_7_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_8_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_9_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/male_income_10_2008_LE.dta"

append using "Life expectancy estimates (individual tables)/female_income_1_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_2_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_3_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_4_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_5_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_6_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_7_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_8_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_9_2008_LE.dta"
append using "Life expectancy estimates (individual tables)/female_income_10_2008_LE.dta"

*** Save appended file on the disk

do path.do

save "Life expectancy estimates (appended tables)/LE_deciles_income_2008_nonstratified.dta", replace
