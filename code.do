gen agecat=.
recode agecat .=0 if F2_1<=29
recode agecat .=1 if F2_1>=30&F2_1<=39
recode agecat .=2 if F2_1>=40&F2_1<=49
recode agecat .=3 if F2_1>=50&F2_1<=59
recode agecat .=4 if F2_1>=60&F2_1<=69
recode agecat .=5 if F2_1>=70&F2_1<=79
label define agecat 0 "<=29" 1 "30-39" 2 "40-49" 3 "50-59" 4 "60-69" 5 "70-79"
label value agecat agecat

 
gen agecat2=.
recode agecat2 .=0 if F2_1<=64
recode agecat2 .=1 if F2_1>=65&F2_1<=74
recode agecat2 .=2 if F2_1>=75&F2_1<=79
label define agecat2 0 "<=64" 1 "65-74" 2 "75-79" 
label value agecat2 agecat2

 
gen agecat3=.
recode agecat3 .=0 if F2_1<=49
recode agecat3 .=1 if F2_1>=50&F2_1<=79
label define agecat3 0 "<=49" 1 "50-79"
label value agecat3 agecat3
 
gen educat= Q26
recode educat 1/2=1 3/4=2 5/6=3 7/8=4
tab Q26 educat,m
label define educat 1 "High school or less" 2 "Some college" 3 "College or more" 4 "Others/unknown"
label value educat educat

gen householdincomecat= F6
recode householdincomecat 5/9=5 10=99 .=99
label define householdincomecat 1 "<2 million" 2 "2-4 million" 3 "4-6 million" 4 "6-8 million" 5 "≥8 million" 99 "Unknown/missing"
label value householdincomecat householdincomecat

label define F4 1 "Single, separated, or widowed" 2 "Married"
label value F4 F4

gen area=F3
recode area 2/7=2 8/14=3 15/24=4 25/30=5 31/35=6 36/39=7 40/47=8
label define area 1 "Hokkaido" 2 "Tohoku" 3 "Kanto" 4 "Chubu" 5 "Kinki" 6 "Chugoku" 7 "Shikoku" 8 "Kyushu"
label value area area


label define F5 1 "No Children" 2 "Has Children"
label value F5 F5

gen occupation=F8
recode occupation 1/5=1 9=1 6/7=2 12=3 8=4 10=5  11=6
label define occupation 1 "Employed" 2 "Self-employed" 3 "Not working" 4 "Homemaker" 5 "Student" 6 "Other"
label value occupation occupation

gen politicalcat=Q3
recode politicalcat 1/5=0 6/10=1
label define politicalcat 0 "liberal" 1 "conservative"
label value politicalcat politicalcat


xtile Q3_tertile=Q3S1, nq(3)

label define Q3_tertile 1 "liberal" 2 "moderate" 3"conservative"
label value Q3_tertile Q3_tertile


label define F1 1 "male" 2 "female"
label value F1 F1

label define Q4 1 "voted" 2 "not voted"
label value Q4 Q4


gen infocount= Q5_1+ Q5_2+ Q5_3+ Q5_4+ Q5_5+ Q5_6+ Q5_7+ Q5_8+ Q5_9+ Q5_10

gen primary_info=.
recode primary_info .=0 if Q6==1& infocount>=2
recode primary_info .=0 if Q5_1==1& infocount==1
recode primary_info .=0 if Q6==2& infocount>=2
recode primary_info .=0 if Q5_2==1& infocount==1
recode primary_info .=0 if Q6==5& infocount>=2
recode primary_info .=0 if Q5_5==1& infocount==1

recode primary_info .=1 if Q6==6& infocount>=2
recode primary_info .=1 if Q5_6==1& infocount==1

recode primary_info .=2 if Q6==3& infocount>=2
recode primary_info .=2 if Q5_3==1& infocount==1
recode primary_info .=2 if Q6==4& infocount>=2
recode primary_info .=2 if Q5_4==1& infocount==1

recode primary_info .=3 if Q6==8& infocount>=2
recode primary_info .=3 if Q5_8==1& infocount==1
recode primary_info .=3 if Q6==9& infocount>=2
recode primary_info .=3 if Q5_9==1& infocount==1

recode primary_info .=99 if infocount==0
recode primary_info .=4 if Q6==7& infocount>=2
recode primary_info .=4 if Q6==10& infocount>=2
recode primary_info .=4 if Q5_7==1& infocount==1
recode primary_info .=4 if Q5_10==1& infocount==1


label define primary_info 0 "traditonal media" 1 "SNS" 2"Government or Public Sector Information" 3 "family and friends" 4 "others" 99 "none"
label value primary_info primary_info

gen tokai=1 if F3==13|F3==14|F3==11|F3==12|F3==8|F3==9|F3==10|F3==19|F3==23|F3==21|F3==24|F3==27|F3==26|F3==28|F3==25|F3==29|F3==30
recode tokai .=0

regress Q21S1 ib2.F1 ib2.agecat ib3.educat ib5.householdincomecat i.F4 i.F5 ib3.occupation ib1.tokai  i.primary_info ib3.Q3_tertile

ttest Q21S1, by(F1)
sum Q21S1 if agecat==0
sum Q21S1 if agecat==1
sum Q21S1 if agecat==2
sum Q21S1 if agecat==3
sum Q21S1 if agecat==4
sum Q21S1 if agecat==5

sum Q21S1 if educat==1
sum Q21S1 if educat==2
sum Q21S1 if educat==3
sum Q21S1 if educat==4

tab householdincomecat,m
sum Q21S1 if householdincomecat==1
sum Q21S1 if householdincomecat==2
sum Q21S1 if householdincomecat==3
sum Q21S1 if householdincomecat==4
sum Q21S1 if householdincomecat==5
sum Q21S1 if householdincomecat==99

sum Q21S1 if F4==1
sum Q21S1 if F4==2

sum Q21S1 if F5==1
sum Q21S1 if F5==2

sum Q21S1 if occupation==1
sum Q21S1 if occupation==2
sum Q21S1 if occupation==3
sum Q21S1 if occupation==4
sum Q21S1 if occupation==5
sum Q21S1 if occupation==6

sum Q21S1 if tokai==0
sum Q21S1 if tokai==1

sum Q21S1 if primary_info==0
sum Q21S1 if primary_info==1
sum Q21S1 if primary_info==2
sum Q21S1 if primary_info==3
sum Q21S1 if primary_info==4
sum Q21S1 if primary_info==99

sum Q21S1 if Q3_tertile==1
sum Q21S1 if Q3_tertile==2
sum Q21S1 if Q3_tertile==3



gen lie=1 if Q13S11==1
recode lie .=0 if Q13S11==2

glm lie ib2.F1 ib2.agecat ib3.educat ib5.householdincomecat i.F4 i.F5 ib3.occupation ib1.tokai  i.primary_info ib3.Q3_tertile, family(poisson) link(log) eform vce(robust)

glm lie ib2.F1 i.agecat3 ib3.educat ib5.householdincomecat i.F4 i.F5 ib3.occupation ib1.tokai  i.primary_info ib3.Q3_tertile, family(poisson) link(log) eform vce(robust)


gen occupationv2=1 if occupation==1
recode occupationv2 .=0 if occupation==3

gen rural=1 if tokai==0
recode rural .=0

gen primary_infov2=1 if primary_info==1
recode primary_infov2 .=0 if primary_info==0

gen male=1 if F1==1
recode male .=0

poisson lie ib2.F1 ib3.occupation ib1.tokai  i.primary_info, vce(robust) 
predict yhat99, pr(1)
sum yhat99 if F1==1&occupation==1&tokai==0&primary_info==1

poisson lie ib2.F1 ib3.occupation ib1.tokai  i.primary_info, vce(robust) irr

gen denier=1 if F1==1&occupation==1&tokai==0&primary_info==1
recode denier .=0
poisson lie i.denier, vce(robust) irr

tab lie denier
csi 28 1894 61 10164

gen deniercat=0 if male==0&occupationv2==0&rural==0&primary_infov2==0
recode deniercat .=1 if male==1&occupationv2==0&rural==0&primary_infov2==0
recode deniercat .=2 if male==0&occupationv2==1&rural==0&primary_infov2==0
recode deniercat .=3 if male==0&occupationv2==0&rural==1&primary_infov2==0
recode deniercat .=4 if male==0&occupationv2==0&rural==0&primary_infov2==1
recode deniercat .=5 if male==1&occupationv2==1&rural==0&primary_infov2==0
recode deniercat .=6 if male==1&occupationv2==0&rural==1&primary_infov2==0
recode deniercat .=7 if male==1&occupationv2==0&rural==0&primary_infov2==1

recode deniercat .=8 if male==0&occupationv2==1&rural==1&primary_infov2==0
recode deniercat .=9 if male==0&occupationv2==1&rural==0&primary_infov2==1
recode deniercat .=10 if male==0&occupationv2==0&rural==1&primary_infov2==1
recode deniercat .=11 if male==1&occupationv2==1&rural==1&primary_infov2==0
recode deniercat .=12 if male==1&occupationv2==1&rural==0&primary_infov2==1
recode deniercat .=13 if male==1&occupationv2==0&rural==1&primary_infov2==1
recode deniercat .=14 if male==0&occupationv2==1&rural==1&primary_infov2==1
recode deniercat .=15 if male==1&occupationv2==1&rural==1&primary_infov2==1
tab lie deniercat

poisson lie i.deniercat, vce(robust) irr
predict yhat991, pr(1)

drop if deniercat==.

capture program drop boot_predict
program define boot_predict, rclass
    preserve
   
    poisson lie i.deniercat, vce(robust) irr
    
    predict yhat_boot, pr(1)
    
    summarize yhat_boot if deniercat == 13
    return scalar mean_yhat = r(mean)
    restore
end

bootstrap mean_yhat = r(mean_yhat), reps(500) seed(12345): boot_predict

estat bootstrap, percentile
