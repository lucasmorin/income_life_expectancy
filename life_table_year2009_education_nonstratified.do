
do path.do


use "year2009.dta", clear
	stset dox, fail(death==1) origin(time date_birth) enter(time date_entry) scale(365.25) id(lopnr)

cd "Life expectancy estimates (individual tables)"


ltable _t _d if sex==1 & level_education==1, hazard saving(male_education_1_2009.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_education==2, hazard saving(male_education_2_2009.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_education==3, hazard saving(male_education_3_2009.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==1 & level_education==4, hazard saving(male_education_4_2009.dta, replace) tvid(lopnr) notable

ltable _t _d if sex==2 & level_education==1, hazard saving(female_education_1_2009.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_education==2, hazard saving(female_education_2_2009.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_education==3, hazard saving(female_education_3_2009.dta, replace) tvid(lopnr) notable
ltable _t _d if sex==2 & level_education==4, hazard saving(female_education_4_2009.dta, replace) tvid(lopnr) notable



do path.do


use "Life expectancy estimates (individual tables)/male_education_1_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_education=1


save "Life expectancy estimates (individual tables)/male_education_1_2009_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_education_2_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_education=2


save "Life expectancy estimates (individual tables)/male_education_2_2009_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_education_3_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_education=3


save "Life expectancy estimates (individual tables)/male_education_3_2009_LE.dta", replace
use "Life expectancy estimates (individual tables)/male_education_4_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=1
gen level_education=4


save "Life expectancy estimates (individual tables)/male_education_4_2009_LE.dta", replace


use "Life expectancy estimates (individual tables)/female_education_1_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_education=1


save "Life expectancy estimates (individual tables)/female_education_1_2009_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_education_2_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_education=2


save "Life expectancy estimates (individual tables)/female_education_2_2009_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_education_3_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_education=3


save "Life expectancy estimates (individual tables)/female_education_3_2009_LE.dta", replace
use "Life expectancy estimates (individual tables)/female_education_4_2009.dta", clear
lifetabl, s(t0) death(deaths) pop(lost) keep _ExpYL not
keep t0 lost _Rx _qx _dx _px _lx _Lx _Tx _ExpYL _Surv _SurvVar _HRate
rename t0 age
rename lost population
gen sex=2
gen level_education=4


save "Life expectancy estimates (individual tables)/female_education_4_2009_LE.dta", replace


use "Life expectancy estimates (individual tables)/male_education_1_2009_LE.dta"
append using "Life expectancy estimates (individual tables)/male_education_2_2009_LE.dta"
append using "Life expectancy estimates (individual tables)/male_education_3_2009_LE.dta"
append using "Life expectancy estimates (individual tables)/male_education_4_2009_LE.dta"

append using "Life expectancy estimates (individual tables)/female_education_1_2009_LE.dta"
append using "Life expectancy estimates (individual tables)/female_education_2_2009_LE.dta"
append using "Life expectancy estimates (individual tables)/female_education_3_2009_LE.dta"
append using "Life expectancy estimates (individual tables)/female_education_4_2009_LE.dta"


*** Save appended file on the disk

do path.do

save "Life expectancy estimates (appended tables)/LE_education_2009_nonstratified.dta", replace
