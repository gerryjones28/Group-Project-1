# College Scorecard - Institution Variables by Category

Generated from `data/CollegeScorecardDataDictionary.xlsx` (sheet `Institution_Data_Dictionary`). The workbook itself is unchanged.

**3308 institution-level variables** across **10 categories**.

How to read each table:

- **API field path** - what you pass to `fields=` in the API and to `sc_select()` in `rscorecard`. `latest.` means "most recent value available"; replace it with a year such as `2019.` to pin a year.
- **Raw column name** - the `VARIABLE NAME` used in the original `MERGED_YYYY_YY_PP.csv` files. THIS IS A DIFFERENT STRING from the API path.
- **Years** - how many of the 30 annual datafiles (1996-97 ... 2025-26) the workbook's `Institution_Cohort_Map` says carry a value for this variable. `30` means all years. A `1` is normal for slow-moving or identifier fields (`LATITUDE`, `ACCREDAGENCY`, `CITY`) that the workbook only documents against the most recent file - it does NOT mean the value is missing from the older datafiles. Check `reference/06_cohort_coverage.csv` before treating any low number as real absence.

### Category index

| # | Category | Variables | What it covers |
|---|----------|-----------|----------------|
| 1 | `root` | 6 | Identifiers for the institution itself (Unit ID, OPE ID, lat/lon, school code). These are the join keys. Not year-specific. |
| 2 | `school` | 50 | Who the school is: name, address, sector/ownership, Carnegie classification, accreditor, minority-serving flags, Title IV status, endowment, faculty. |
| 3 | `admissions` | 32 | How hard it is to get in: admission rate and SAT/ACT score distributions. |
| 4 | `cost` | 85 | What it costs: tuition and fees, average net price overall and by family-income band. |
| 5 | `aid` | 111 | What students get and what they owe: Pell/loan take-up rates, median debt at graduation and for non-completers, PLUS loans. |
| 6 | `student` | 131 | Who is enrolled and how many: total size, race/ethnicity shares, first-generation share, family income, full-time/part-time split. |
| 7 | `academics` | 247 | What is taught: share of degrees by CIP field, programs offered, average months to completion by program. |
| 8 | `completion` | 1367 | Whether students finish: 100%/150%/200% completion and outcome rates, broken down by Pell status, loan status, first-gen status, race and time since entry. The single largest category. |
| 9 | `earnings` | 185 | What graduates earn: median/mean earnings and counts of working vs not working 1-11 years after entry or after completion, plus earnings thresholds. |
| 10 | `repayment` | 1094 | Whether loans get repaid: cohort default rates, repayment rates at 1/3/5/7 years, and balance-based repayment rates (BBRR/DBRR) split by demographics and cohorts. |

---

## 1. `root` - 6 variables

> Identifiers for the institution itself (Unit ID, OPE ID, lat/lon, school code). These are the join keys. Not year-specific.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `id` | `UNITID` | integer | 30 | Unit ID for institution |
| `ope8_id` | `OPEID` | string | 30 | 8-digit OPE ID for institution |
| `ope6_id` | `OPEID6` | string | 30 | 6-digit OPE ID for institution |
| `location.lat` | `LATITUDE` | float | 1 | Latitude |
| `location.lon` | `LONGITUDE` | float | 1 | Longitude |
| `fed_sch_cd` | `FEDSCHCD` | string | 1 | Federal School Code |

---

## 2. `school` - 50 variables

> Who the school is: name, address, sector/ownership, Carnegie classification, accreditor, minority-serving flags, Title IV status, endowment, faculty.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.school.name` | `INSTNM` | autocomplete | 30 | Institution name |
| `latest.school.city` | `CITY` | autocomplete | 30 | City |
| `latest.school.state` | `STABBR` | string | 30 | State postcode |
| `latest.school.zip` | `ZIP` | string | 30 | ZIP code |
| `latest.school.accreditor` | `ACCREDAGENCY` | string | 1 | Accreditor for institution |
| `latest.school.school_url` | `INSTURL` | string | 1 | URL for institution's homepage |
| `latest.school.price_calculator_url` | `NPCURL` | string | 1 | URL for institution's net price calculator |
| `latest.school.degrees_awarded.predominant_recoded` | `SCH_DEG` | integer | 22 | Predominant degree awarded (recoded 0s and 4s) |
| `latest.school.under_investigation` | `HCM2` | integer | 1 | Schools that are on Heightened Cash Monitoring 2 by the Department of Education |
| `latest.school.main_campus` | `MAIN` | integer | 30 | Flag for main campus |
| `latest.school.branches` | `NUMBRANCH` | integer | 30 | Number of branch campuses |
| `latest.school.degrees_awarded.predominant` | `PREDDEG` | integer | 30 | Predominant undergraduate degree awarded
 0 Not classified
 1 Predominantly certificate-degree granting
 2... |
| `latest.school.degrees_awarded.highest` | `HIGHDEG` | integer | 30 | Highest degree awarded
 0 Non-degree-granting
 1 Certificate degree
 2 Associate degree
 3 Bachelor's degre... |
| `latest.school.ownership` | `CONTROL` | integer | 30 | Control of institution (IPEDS) |
| `latest.school.state_fips` | `ST_FIPS` | integer | 30 | FIPS code for state |
| `latest.school.region_id` | `REGION` | integer | 30 | Region (IPEDS) |
| `latest.school.locale` | `LOCALE` | integer | 1 | Locale of institution |
| `latest.school.degree_urbanization` | `LOCALE2` | integer | 0 | Degree of urbanization of institution |
| `latest.school.carnegie_basic` | `CCBASIC` | integer | 1 | Carnegie Classification -- basic |
| `latest.school.carnegie_undergrad` | `CCUGPROF` | integer | 1 | Carnegie Classification -- undergraduate profile |
| `latest.school.carnegie_size_setting` | `CCSIZSET` | integer | 1 | Carnegie Classification -- size and setting |
| `latest.school.minority_serving.historically_black` | `HBCU` | integer | 1 | Flag for Historically Black College and University |
| `latest.school.minority_serving.predominantly_black` | `PBI` | integer | 1 | Flag for predominantly black institution |
| `latest.school.minority_serving.annh` | `ANNHI` | integer | 1 | Flag for Alaska Native Native Hawaiian serving institution |
| `latest.school.minority_serving.tribal` | `TRIBAL` | integer | 1 | Flag for tribal college and university |
| `latest.school.minority_serving.aanipi` | `AANAPII` | integer | 1 | Flag for Asian American Native American Pacific Islander-serving institution |
| `latest.school.minority_serving.hispanic` | `HSI` | integer | 1 | Flag for Hispanic-serving institution |
| `latest.school.minority_serving.nant` | `NANTI` | integer | 1 | Flag for Native American non-tribal institution |
| `latest.school.men_only` | `MENONLY` | integer | 1 | Flag for men-only college |
| `latest.school.women_only` | `WOMENONLY` | integer | 1 | Flag for women-only college |
| `latest.school.religious_affiliation` | `RELAFFIL` | integer | 1 | Religous affiliation of the institution |
| `latest.school.online_only` | `DISTANCEONLY` | integer | 15 | Flag for distance-education-only education |
| `latest.school.operating` | `CURROPER` | integer | 1 | Flag for currently operating institution, 0=closed, 1=operating |
| `latest.school.tuition_revenue_per_fte` | `TUITFTE` | integer | 27 | Net tuition revenue per full-time equivalent student |
| `latest.school.instructional_expenditure_per_fte` | `INEXPFTE` | integer | 27 | Instructional expenditures per full-time equivalent student |
| `latest.school.faculty_salary` | `AVGFACSAL` | integer | 28 | Average faculty salary |
| `latest.school.ft_faculty_rate` | `PFTFAC` | float | 23 | Proportion of faculty that is full-time |
| `latest.school.alias` | `ALIAS` | autocomplete | 20 | Institution name aliases |
| `latest.school.institutional_characteristics.level` | `ICLEVEL` | integer | 30 | Level of institution |
| `latest.school.open_admissions_policy` | `OPENADMP` | integer | 29 | Open admissions policy indicator |
| `latest.school.accreditor_code` | `ACCREDCODE` | string | 1 | Code corresponding to accreditor (as captured from PEPS) |
| `latest.school.title_iv.approval_date` | `T4APPROVALDATE` | string | 1 | Date that institution was first approved to participate in Title IV aid programs |
| `latest.school.ownership_peps` | `SCHTYPE` | integer | 1 | Control of institution, per PEPS |
| `latest.school.title_iv.eligibility_type` | `OPEFLAG` | integer | 30 | Title IV eligibility type |
| `latest.school.endowment.begin` | `ENDOWBEGIN` | long | 22 | Value of school's endowment at the beginning of the fiscal year |
| `latest.school.endowment.end` | `ENDOWEND` | long | 22 | Value of school's endowment at the end of the fiscal year |
| `latest.school.dolflag` | `DOLPROVIDER` | integer | 1 | DOL approved training provider indicator |
| `latest.school.peps_ownership` | `CONTROL_PEPS` | string | 1 | Control of institution (PEPS) |
| `latest.school.address` | `ADDR` | string | 5 | Address of institution |
| `latest.school.sector.scorecard` | `SCORECARD_SECTOR` | integer | 30 | Institutional sector derived from the ownership structure (CONTROL) and the predominant level of award conf... |

### 2.1 Coded variables in `school` (29 of 50 need a value/label lookup)

**`latest.school.main_campus`** (raw `MAIN`) - Flag for main campus

| Value | Meaning |
|---|---|
| `1` | Main campus |

**`latest.school.degrees_awarded.predominant`** (raw `PREDDEG`) - Predominant undergraduate degree awarded
 0 Not classified
 1 Predominantly certificate-degree granting
 2 Predominantly associate's-degree granting
 3 Predominantly bachelor's-degree granting
 4 Entirely graduate-degree granting

| Value | Meaning |
|---|---|
| `1` | Predominantly certificate-degree granting |
| `2` | Predominantly associate's-degree granting |
| `3` | Predominantly bachelor's-degree granting |
| `4` | Entirely graduate-degree granting |

**`latest.school.degrees_awarded.highest`** (raw `HIGHDEG`) - Highest degree awarded
 0 Non-degree-granting
 1 Certificate degree
 2 Associate degree
 3 Bachelor's degree
 4 Graduate degree

| Value | Meaning |
|---|---|
| `1` | Certificate degree |
| `2` | Associate degree |
| `3` | Bachelor's degree |
| `4` | Graduate degree |

**`latest.school.ownership`** (raw `CONTROL`) - Control of institution (IPEDS)

| Value | Meaning |
|---|---|
| `2` | Private nonprofit |
| `3` | Private for-profit |

**`latest.school.state_fips`** (raw `ST_FIPS`) - FIPS code for state

| Value | Meaning |
|---|---|
| `2` | Alaska |
| `4` | Arizona |
| `5` | Arkansas |
| `6` | California |
| `8` | Colorado |
| `9` | Connecticut |
| `10` | Delaware |
| `11` | District of Columbia |
| `12` | Florida |
| `13` | Georgia |
| `15` | Hawaii |
| `16` | Idaho |
| `17` | Illinois |
| `18` | Indiana |
| `19` | Iowa |
| `20` | Kansas |
| `21` | Kentucky |
| `22` | Louisiana |
| `23` | Maine |
| `24` | Maryland |
| `25` | Massachusetts |
| `26` | Michigan |
| `27` | Minnesota |
| `28` | Mississippi |
| `29` | Missouri |
| `30` | Montana |
| `31` | Nebraska |
| `32` | Nevada |
| `33` | New Hampshire |
| `34` | New Jersey |
| `35` | New Mexico |
| `36` | New York |
| `37` | North Carolina |
| `38` | North Dakota |
| `39` | Ohio |
| `40` | Oklahoma |
| `41` | Oregon |
| `42` | Pennsylvania |
| `44` | Rhode Island |
| `45` | South Carolina |
| `46` | South Dakota |
| `47` | Tennessee |
| `48` | Texas |
| `49` | Utah |
| `50` | Vermont |
| `51` | Virginia |
| `53` | Washington |
| `54` | West Virginia |
| `55` | Wisconsin |
| `56` | Wyoming |
| `60` | American Samoa |
| `64` | Federated States of Micronesia |
| `66` | Guam |
| `69` | Northern Mariana Islands |
| `70` | Palau |
| `72` | Puerto Rico |
| `78` | Virgin Islands |

**`latest.school.region_id`** (raw `REGION`) - Region (IPEDS)

| Value | Meaning |
|---|---|
| `1` | New England (CT, ME, MA, NH, RI, VT) |
| `2` | Mid East (DE, DC, MD, NJ, NY, PA) |
| `3` | Great Lakes (IL, IN, MI, OH, WI) |
| `4` | Plains (IA, KS, MN, MO, NE, ND, SD) |
| `5` | Southeast (AL, AR, FL, GA, KY, LA, MS, NC, SC, TN, VA, WV) |
| `6` | Southwest (AZ, NM, OK, TX) |
| `7` | Rocky Mountains (CO, ID, MT, UT, WY) |
| `8` | Far West (AK, CA, HI, NV, OR, WA) |
| `9` | Outlying Areas (AS, FM, GU, MH, MP, PR, PW, VI) |

**`latest.school.locale`** (raw `LOCALE`) - Locale of institution

| Value | Meaning |
|---|---|
| `12` | City: Midsize (population of at least 100,000 but less than 250,000) |
| `13` | City: Small (population less than 100,000) |
| `21` | Suburb: Large (outside principal city, in urbanized area with population of 250,000 or more) |
| `22` | Suburb: Midsize (outside principal city, in urbanized area with population of at least 100,000 but less than 250,000) |
| `23` | Suburb: Small (outside principal city, in urbanized area with population less than 100,000) |
| `31` | Town: Fringe (in urban cluster up to 10 miles from an urbanized area) |
| `32` | Town: Distant (in urban cluster more than 10 miles and up to 35 miles from an urbanized area) |
| `33` | Town: Remote (in urban cluster more than 35 miles from an urbanized area) |
| `41` | Rural: Fringe (rural territory up to 5 miles from an urbanized area or up to 2.5 miles from an urban cluster) |
| `42` | Rural: Distant (rural territory more than 5 miles but up to 25 miles from an urbanized area or more than 2.5 and up to 10 miles from an urban cluster) |
| `43` | Rural: Remote (rural territory more than 25 miles from an urbanized area and more than 10 miles from an urban cluster) |

**`latest.school.degree_urbanization`** (raw `LOCALE2`) - Degree of urbanization of institution

| Value | Meaning |
|---|---|
| `2` | Mid-Size City (a central city of a CMSA or MSA, with the city having a population less than 250,000) |
| `3` | Urban Fringe of a Large City (any territory within a CMSA or MSA of a Large City and defined as urban by the Census Bureau) |
| `4` | Urban Fringe of a Mid-Size City (any territory within a CMSA or MSA of a Mid-Size City and defined as urban by the Census Bureau) |
| `5` | Large Town (an incorporated place or Census-designated place with a population greater than or equal to 25,000 and located outside a CMSA or MSA) |
| `6` | Small Town (an incorporated place or Census-designated place with a population less than 25,000 and greater than or equal to 2,500 and located outside a CMSA or MSA) |
| `7` | Rural, Outside MSA (any territory designated as rural by the Census Bureau that is outside a CMSA or MSA of a Large or Mid-Size City) |
| `8` | Rural, Inside MSA (any territory designated as rural by the Census Bureau that is within a CMSA or MSA of a Large or Mid-Size City) |

**`latest.school.carnegie_basic`** (raw `CCBASIC`) - Carnegie Classification -- basic

| Value | Meaning |
|---|---|
| `0` | (Not classified) |
| `1` | Associate's Colleges: High Transfer-High Traditional |
| `2` | Associate's Colleges: High Transfer-Mixed Traditional/Nontraditional |
| `3` | Associate's Colleges: High Transfer-High Nontraditional |
| `4` | Associate's Colleges: Mixed Transfer/Career & Technical-High Traditional |
| `5` | Associate's Colleges: Mixed Transfer/Career & Technical-Mixed Traditional/Nontraditional |
| `6` | Associate's Colleges: Mixed Transfer/Career & Technical-High Nontraditional |
| `7` | Associate's Colleges: High Career & Technical-High Traditional |
| `8` | Associate's Colleges: High Career & Technical-Mixed Traditional/Nontraditional |
| `9` | Associate's Colleges: High Career & Technical-High Nontraditional |
| `10` | Special Focus Two-Year: Health Professions |
| `11` | Special Focus Two-Year: Technical Professions |
| `12` | Special Focus Two-Year: Arts & Design |
| `13` | Special Focus Two-Year: Other Fields |
| `14` | Baccalaureate/Associate's Colleges: Associate's Dominant |
| `15` | Doctoral Universities: Very High Research Activity |
| `16` | Doctoral Universities: High Research Activity |
| `17` | Doctoral/Professional Universities |
| `18` | Master's Colleges & Universities: Larger Programs |
| `19` | Master's Colleges & Universities: Medium Programs |
| `20` | Master's Colleges & Universities: Small Programs |
| `21` | Baccalaureate Colleges: Arts & Sciences Focus |
| `22` | Baccalaureate Colleges: Diverse Fields |
| `23` | Baccalaureate/Associate's Colleges: Mixed Baccalaureate/Associate's |
| `24` | Special Focus Four-Year: Faith-Related Institutions |
| `25` | Special Focus Four-Year: Medical Schools & Centers |
| `26` | Special Focus Four-Year: Other Health Professions Schools |
| `27` | Special Focus Four-Year: Research Institution |
| `28` | Special Focus Four-Year: Engineering and Other Technology-Related Schools |
| `29` | Special Focus Four-Year: Business & Management Schools |
| `30` | Special Focus Four-Year: Arts, Music & Design Schools |
| `31` | Special Focus Four-Year: Law Schools |
| `32` | Special Focus Four-Year: Other Special Focus Institutions |
| `33` | Tribal Colleges |

**`latest.school.carnegie_undergrad`** (raw `CCUGPROF`) - Carnegie Classification -- undergraduate profile

| Value | Meaning |
|---|---|
| `0` | Not classified (Exclusively Graduate) |
| `1` | Two-year, higher part-time |
| `2` | Two-year, mixed part/full-time |
| `3` | Two-year, medium full-time |
| `4` | Two-year, higher full-time |
| `5` | Four-year, higher part-time |
| `6` | Four-year, medium full-time, inclusive, lower transfer-in |
| `7` | Four-year, medium full-time, inclusive, higher transfer-in |
| `8` | Four-year, medium full-time, selective, lower transfer-in |
| `9` | Four-year, medium full-time , selective, higher transfer-in |
| `10` | Four-year, full-time, inclusive, lower transfer-in |
| `11` | Four-year, full-time, inclusive, higher transfer-in |
| `12` | Four-year, full-time, selective, lower transfer-in |
| `13` | Four-year, full-time, selective, higher transfer-in |
| `14` | Four-year, full-time, more selective, lower transfer-in |
| `15` | Four-year, full-time, more selective, higher transfer-in |

**`latest.school.carnegie_size_setting`** (raw `CCSIZSET`) - Carnegie Classification -- size and setting

| Value | Meaning |
|---|---|
| `0` | (Not classified) |
| `1` | Two-year, very small |
| `2` | Two-year, small |
| `3` | Two-year, medium |
| `4` | Two-year, large |
| `5` | Two-year, very large |
| `6` | Four-year, very small, primarily nonresidential |
| `7` | Four-year, very small, primarily residential |
| `8` | Four-year, very small, highly residential |
| `9` | Four-year, small, primarily nonresidential |
| `10` | Four-year, small, primarily residential |
| `11` | Four-year, small, highly residential |
| `12` | Four-year, medium, primarily nonresidential |
| `13` | Four-year, medium, primarily residential |
| `14` | Four-year, medium, highly residential |
| `15` | Four-year, large, primarily nonresidential |
| `16` | Four-year, large, primarily residential |
| `17` | Four-year, large, highly residential |
| `18` | Exclusively graduate/professional |

**`latest.school.minority_serving.historically_black`** (raw `HBCU`) - Flag for Historically Black College and University

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.minority_serving.predominantly_black`** (raw `PBI`) - Flag for predominantly black institution

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.minority_serving.annh`** (raw `ANNHI`) - Flag for Alaska Native Native Hawaiian serving institution

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.minority_serving.tribal`** (raw `TRIBAL`) - Flag for tribal college and university

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.minority_serving.aanipi`** (raw `AANAPII`) - Flag for Asian American Native American Pacific Islander-serving institution

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.minority_serving.hispanic`** (raw `HSI`) - Flag for Hispanic-serving institution

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.minority_serving.nant`** (raw `NANTI`) - Flag for Native American non-tribal institution

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.men_only`** (raw `MENONLY`) - Flag for men-only college

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.women_only`** (raw `WOMENONLY`) - Flag for women-only college

| Value | Meaning |
|---|---|
| `1` | Yes |

**`latest.school.religious_affiliation`** (raw `RELAFFIL`) - Religous affiliation of the institution

| Value | Meaning |
|---|---|
| `-2` | Not applicable |
| `22` | American Evangelical Lutheran Church |
| `24` | African Methodist Episcopal Zion Church |
| `27` | Assemblies of God Church |
| `28` | Brethren Church |
| `30` | Roman Catholic |
| `33` | Wisconsin Evangelical Lutheran Synod |
| `34` | Christ and Missionary Alliance Church |
| `35` | Christian Reformed Church |
| `36` | Evangelical Congregational Church |
| `37` | Evangelical Covenant Church of America |
| `38` | Evangelical Free Church of America |
| `39` | Evangelical Lutheran Church |
| `40` | International United Pentecostal Church |
| `41` | Free Will Baptist Church |
| `42` | Interdenominational |
| `43` | Mennonite Brethren Church |
| `44` | Moravian Church |
| `45` | North American Baptist |
| `47` | Pentecostal Holiness Church |
| `48` | Christian Churches and Churches of Christ |
| `49` | Reformed Church in America |
| `50` | Episcopal Church, Reformed |
| `51` | African Methodist Episcopal |
| `52` | American Baptist |
| `53` | American Lutheran |
| `54` | Baptist |
| `55` | Christian Methodist Episcopal |
| `57` | Church of God |
| `58` | Church of Brethren |
| `59` | Church of the Nazarene |
| `60` | Cumberland Presbyterian |
| `61` | Christian Church (Disciples of Christ) |
| `64` | Free Methodist |
| `65` | Friends |
| `66` | Presbyterian Church (USA) |
| `67` | Lutheran Church in America |
| `68` | Lutheran Church - Missouri Synod |
| `69` | Mennonite Church |
| `71` | United Methodist |
| `73` | Protestant Episcopal |
| `74` | Churches of Christ |
| `75` | Southern Baptist |
| `76` | United Church of Christ |
| `77` | Protestant, not specified |
| `78` | Multiple Protestant Denomination |
| `79` | Other Protestant |
| `80` | Jewish |
| `81` | Reformed Presbyterian Church |
| `84` | United Brethren Church |
| `87` | Missionary Church Inc |
| `88` | Undenominational |
| `89` | Wesleyan |
| `91` | Greek Orthodox |
| `92` | Russian Orthodox |
| `93` | Unitarian Universalist |
| `94` | Latter Day Saints (Mormon Church) |
| `95` | Seventh Day Adventists |
| `97` | The Presbyterian Church in America |
| `99` | Other (none of the above) |
| `100` | Original Free Will Baptist |
| `101` | Ecumenical Christian |
| `102` | Evangelical Christian |
| `103` | Presbyterian |
| `105` | General Baptist |
| `106` | Muslim |
| `107` | Plymouth Brethren |
| `108` | Non-Denominational |
| `110` | Orthodox Christian |

**`latest.school.online_only`** (raw `DISTANCEONLY`) - Flag for distance-education-only education

| Value | Meaning |
|---|---|
| `1` | Distance-education only |

**`latest.school.operating`** (raw `CURROPER`) - Flag for currently operating institution, 0=closed, 1=operating

| Value | Meaning |
|---|---|
| `1` | Currently certified as operating |

**`latest.school.institutional_characteristics.level`** (raw `ICLEVEL`) - Level of institution

| Value | Meaning |
|---|---|
| `2` | 2-year |
| `3` | Less-than-2-year |

**`latest.school.open_admissions_policy`** (raw `OPENADMP`) - Open admissions policy indicator

| Value | Meaning |
|---|---|
| `2` | No |
| `3` | Does not enroll first-time students |

**`latest.school.ownership_peps`** (raw `SCHTYPE`) - Control of institution, per PEPS

| Value | Meaning |
|---|---|
| `2` | Private, Nonprofit |
| `3` | Proprietary |

**`latest.school.title_iv.eligibility_type`** (raw `OPEFLAG`) - Title IV eligibility type

| Value | Meaning |
|---|---|
| `1` | Participates in Title IV federal financial aid programs |
| `2` | Branch campus of a main campus that participates in Title IV |
| `3` | Deferment only - limited participation |
| `5` | Not currently participating in Title IV, has an OPE ID number |
| `6` | Not currently participating in Title IV, does not have OPE ID number |
| `7` | Stopped participating during the collection year |
| `8` | New participants (became eligible during the collection year) |
| `19` | Not eligible |

**`latest.school.dolflag`** (raw `DOLPROVIDER`) - DOL approved training provider indicator

| Value | Meaning |
|---|---|
| `1` | Matched to the DOL list |

**`latest.school.sector.scorecard`** (raw `SCORECARD_SECTOR`) - Institutional sector derived from the ownership structure (CONTROL) and the predominant level of award conferred (PREDDEG)

| Value | Meaning |
|---|---|
| `2` | Graduate-only Nonprofit institution |
| `3` | Graduate-only For-profit institution |
| `4` | 4-year Public institution |
| `5` | 4-year Nonprofit institution |
| `6` | 4-year For-profit institution |
| `7` | 2-year Public institution |
| `8` | 2-year Nonprofit institution |
| `9` | 2-year For-profit institution |
| `10` | Less-than-2-year Public institution |
| `11` | Less-than-2-year Nonprofit institution |
| `12` | Less-than-2-year For-profit institution |
| `13` | Unknown Public institution |
| `14` | Unknown Nonprofit institution |
| `15` | Unknown For-profit institution |

---

## 3. `admissions` - 32 variables

> How hard it is to get in: admission rate and SAT/ACT score distributions.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.admissions.admission_rate.overall` | `ADM_RATE` | float | 24 | Admission rate |
| `latest.admissions.admission_rate.by_ope_id` | `ADM_RATE_ALL` | float | 24 | Admission rate for all campuses rolled up to the 6-digit OPE ID |
| `latest.admissions.sat_scores.25th_percentile.critical_reading` | `SATVR25` | float | 24 | 25th percentile of SAT scores at the institution (critical reading) |
| `latest.admissions.sat_scores.75th_percentile.critical_reading` | `SATVR75` | float | 24 | 75th percentile of SAT scores at the institution (critical reading) |
| `latest.admissions.sat_scores.25th_percentile.math` | `SATMT25` | float | 24 | 25th percentile of SAT scores at the institution (math) |
| `latest.admissions.sat_scores.75th_percentile.math` | `SATMT75` | float | 24 | 75th percentile of SAT scores at the institution (math) |
| `latest.admissions.sat_scores.25th_percentile.writing` | `SATWR25` | float | 10 | 25th percentile of SAT scores at the institution (writing) |
| `latest.admissions.sat_scores.75th_percentile.writing` | `SATWR75` | float | 10 | 75th percentile of SAT scores at the institution (writing) |
| `latest.admissions.sat_scores.midpoint.critical_reading` | `SATVRMID` | float | 21 | Midpoint of SAT scores at the institution (critical reading) |
| `latest.admissions.sat_scores.midpoint.math` | `SATMTMID` | float | 21 | Midpoint of SAT scores at the institution (math) |
| `latest.admissions.sat_scores.midpoint.writing` | `SATWRMID` | float | 10 | Midpoint of SAT scores at the institution (writing) |
| `latest.admissions.act_scores.25th_percentile.cumulative` | `ACTCM25` | float | 24 | 25th percentile of the ACT cumulative score |
| `latest.admissions.act_scores.75th_percentile.cumulative` | `ACTCM75` | float | 24 | 75th percentile of the ACT cumulative score |
| `latest.admissions.act_scores.25th_percentile.english` | `ACTEN25` | float | 24 | 25th percentile of the ACT English score |
| `latest.admissions.act_scores.75th_percentile.english` | `ACTEN75` | float | 24 | 75th percentile of the ACT English score |
| `latest.admissions.act_scores.25th_percentile.math` | `ACTMT25` | float | 24 | 25th percentile of the ACT math score |
| `latest.admissions.act_scores.75th_percentile.math` | `ACTMT75` | float | 24 | 75th percentile of the ACT math score |
| `latest.admissions.act_scores.25th_percentile.writing` | `ACTWR25` | float | 8 | 25th percentile of the ACT writing score |
| `latest.admissions.act_scores.75th_percentile.writing` | `ACTWR75` | float | 8 | 75th percentile of the ACT writing score |
| `latest.admissions.act_scores.midpoint.cumulative` | `ACTCMMID` | float | 21 | Midpoint of the ACT cumulative score |
| `latest.admissions.act_scores.midpoint.english` | `ACTENMID` | float | 21 | Midpoint of the ACT English score |
| `latest.admissions.act_scores.midpoint.math` | `ACTMTMID` | float | 21 | Midpoint of the ACT math score |
| `latest.admissions.act_scores.midpoint.writing` | `ACTWRMID` | float | 8 | Midpoint of the ACT writing score |
| `latest.admissions.sat_scores.average.overall` | `SAT_AVG` | float | 24 | Average SAT equivalent score of students admitted |
| `latest.admissions.sat_scores.average.by_ope_id` | `SAT_AVG_ALL` | float | 24 | Average SAT equivalent score of students admitted for all campuses rolled up to the 6-digit OPE ID |
| `latest.admissions.test_requirements` | `ADMCON7` | integer | 25 | Test score requirements for admission |
| `latest.admissions.admission_rate_suppressed.overall` | `ADM_RATE_SUPP` | float | 1 | Admission rate, suppressed for n<30 |
| `latest.admissions.sat_scores.50th_percentile.critical_reading` | `SATVR50` | float | 3 | 50th percentile of SAT scores at the institution (critical reading) |
| `latest.admissions.sat_scores.50th_percentile.math` | `SATMT50` | float | 3 | 50th percentile of SAT scores at the institution (math) |
| `latest.admissions.act_scores.50th_percentile.cumulative` | `ACTCM50` | float | 3 | 50th percentile of the ACT cumulative score |
| `latest.admissions.act_scores.50th_percentile.english` | `ACTEN50` | float | 3 | 50th percentile of the ACT English score |
| `latest.admissions.act_scores.50th_percentile.math` | `ACTMT50` | float | 3 | 50th percentile of the ACT math score |

### 3.1 Coded variables in `admissions` (1 of 32 need a value/label lookup)

**`latest.admissions.test_requirements`** (raw `ADMCON7`) - Test score requirements for admission

| Value | Meaning |
|---|---|
| `2` | Recommended |
| `3` | Neither required nor recommended |
| `4` | Do not know |
| `5` | Considered but not required |

---

## 4. `cost` - 85 variables

> What it costs: tuition and fees, average net price overall and by family-income band.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.cost.avg_net_price.public` | `NPT4_PUB` | integer | 16 | Average net price for Title IV institutions (public institutions) |
| `latest.cost.avg_net_price.private` | `NPT4_PRIV` | integer | 16 | Average net price for Title IV institutions (private for-profit and nonprofit institutions) |
| `latest.cost.avg_net_price.program_year` | `NPT4_PROG` | integer | 2 | Average net price for the largest program at the institution for program-year institutions |
| `latest.cost.avg_net_price.other_academic_year` | `NPT4_OTHER` | integer | 2 | Average net price for the largest program at the institution for schools on "other" academic year calendars |
| `latest.cost.net_price.public.by_income_level.0-30000` | `NPT41_PUB` | integer | 16 | Average net price for $0-$30,000 family income (public institutions) |
| `latest.cost.net_price.public.by_income_level.30001-48000` | `NPT42_PUB` | integer | 16 | Average net price for $30,001-$48,000 family income (public institutions) |
| `latest.cost.net_price.public.by_income_level.48001-75000` | `NPT43_PUB` | integer | 16 | Average net price for $48,001-$75,000 family income (public institutions) |
| `latest.cost.net_price.public.by_income_level.75001-110000` | `NPT44_PUB` | integer | 16 | Average net price for $75,001-$110,000 family income (public institutions) |
| `latest.cost.net_price.public.by_income_level.110001-plus` | `NPT45_PUB` | integer | 16 | Average net price for $110,000+ family income (public institutions) |
| `latest.cost.net_price.private.by_income_level.0-30000` | `NPT41_PRIV` | integer | 16 | Average net price for $0-$30,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.private.by_income_level.30001-48000` | `NPT42_PRIV` | integer | 16 | Average net price for $30,001-$48,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.private.by_income_level.48001-75000` | `NPT43_PRIV` | integer | 16 | Average net price for $48,001-$75,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.private.by_income_level.75001-110000` | `NPT44_PRIV` | integer | 16 | Average net price for $75,001-$110,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.private.by_income_level.110001-plus` | `NPT45_PRIV` | integer | 16 | Average net price for $110,000+ family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.0-30000` | `NPT41_PROG` | integer | 2 | Average net price for $0-$30,000 family income (program-year institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.30001-48000` | `NPT42_PROG` | integer | 2 | Average net price for $30,001-$48,000 family income (program-year institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.48001-75000` | `NPT43_PROG` | integer | 2 | Average net price for $48,001-$75,000 family income (program-year institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.75001-110000` | `NPT44_PROG` | integer | 2 | Average net price for $75,001-$110,000 family income (program-year institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.110001-plus` | `NPT45_PROG` | integer | 2 | Average net price for $110,000+ family income (program-year institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.0-30000` | `NPT41_OTHER` | integer | 2 | Average net price for $0-$30,000 family income (other academic calendar institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.30001-48000` | `NPT42_OTHER` | integer | 2 | Average net price for $30,001-$48,000 family income (other academic calendar institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.48001-75000` | `NPT43_OTHER` | integer | 2 | Average net price for $48,001-$75,000 family income (other academic calendar institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.75001-110000` | `NPT44_OTHER` | integer | 2 | Average net price for $75,001-$110,000 family income (other academic calendar institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.110001-plus` | `NPT45_OTHER` | integer | 2 | Average net price for $110,000+ family income (other academic calendar institutions) |
| `latest.cost.net_price.public.by_income_level.0-48000` | `NPT4_048_PUB` | integer | 16 | Average net price for $0-$48,000 family income (public institutions) |
| `latest.cost.net_price.private.by_income_level.0-48000` | `NPT4_048_PRIV` | integer | 16 | Average net price for $0-$48,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.0-48000` | `NPT4_048_PROG` | integer | 2 | Average net price for $0-$48,000 family income (program-year institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.0-48000` | `NPT4_048_OTHER` | integer | 2 | Average net price for $0-$48,000 family income (other academic calendar institutions) |
| `latest.cost.net_price.public.by_income_level.30001-75000` | `NPT4_3075_PUB` | integer | 16 | Average net price for $30,001-$75,000 family income (public institutions) |
| `latest.cost.net_price.private.by_income_level.30001-75000` | `NPT4_3075_PRIV` | integer | 16 | Average net price for $30,001-$75,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.public.by_income_level.75000-plus` | `NPT4_75UP_PUB` | integer | 16 | Average net price for $75,000+ family income (public institutions) |
| `latest.cost.net_price.private.by_income_level.75000-plus` | `NPT4_75UP_PRIV` | integer | 16 | Average net price for $75,000+ family income (private for-profit and nonprofit institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.30001-75000` | `NPT4_3075_PROG` | integer | 2 | Average net price for $30,001-$75,000 family income (program-year institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.30001-75000` | `NPT4_3075_OTHER` | integer | 2 | Average net price for $30,001-$75,000 family income (other academic calendar institutions) |
| `latest.cost.net_price.program_reporter.by_income_level.75000-plus` | `NPT4_75UP_PROG` | integer | 2 | Average net price for $75,000+ family income (program-year institutions) |
| `latest.cost.net_price.other_acad_calendar.by_income_level.75000-plus` | `NPT4_75UP_OTHER` | integer | 2 | Average net price for $75,000+ family income (other academic calendar institutions) |
| `latest.cost.title_iv.public.all` | `NUM4_PUB` | integer | 16 | Number of Title IV students (public institutions) |
| `latest.cost.title_iv.private.all` | `NUM4_PRIV` | integer | 16 | Number of Title IV students (private for-profit and nonprofit institutions) |
| `latest.cost.title_iv.program_year` | `NUM4_PROG` | integer | 2 | Number of Title IV students (program-year institutions) |
| `latest.cost.title_iv.academic_year` | `NUM4_OTHER` | integer | 2 | Number of Title IV students (other academic calendar institutions) |
| `latest.cost.title_iv.public.by_income_level.0-30000` | `NUM41_PUB` | integer | 16 | Number of Title IV students, $0-$30,000 family income (public institutions) |
| `latest.cost.title_iv.public.by_income_level.30001-48000` | `NUM42_PUB` | integer | 16 | Number of Title IV students, $30,001-$48,000 family income (public institutions) |
| `latest.cost.title_iv.public.by_income_level.48001-75000` | `NUM43_PUB` | integer | 16 | Number of Title IV students, $48,001-$75,000 family income (public institutions) |
| `latest.cost.title_iv.public.by_income_level.75001-110000` | `NUM44_PUB` | integer | 16 | Number of Title IV students, $75,001-$110,000 family income (public institutions) |
| `latest.cost.title_iv.public.by_income_level.110001-plus` | `NUM45_PUB` | integer | 16 | Number of Title IV students, $110,000+ family income (public institutions) |
| `latest.cost.title_iv.private.by_income_level.0-30000` | `NUM41_PRIV` | integer | 16 | Number of Title IV students, $0-$30,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.title_iv.private.by_income_level.30001-48000` | `NUM42_PRIV` | integer | 16 | Number of Title IV students, $30,001-$48,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.title_iv.private.by_income_level.48001-75000` | `NUM43_PRIV` | integer | 16 | Number of Title IV students, $48,001-$75,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.title_iv.private.by_income_level.75001-110000` | `NUM44_PRIV` | integer | 16 | Number of Title IV students, $75,001-$110,000 family income (private for-profit and nonprofit institutions) |
| `latest.cost.title_iv.private.by_income_level.110001-plus` | `NUM45_PRIV` | integer | 16 | Number of Title IV students, $110,000+ family income (private for-profit and nonprofit institutions) |
| `latest.cost.title_iv.program_reporter.by_income_level.0-30000` | `NUM41_PROG` | integer | 2 | Number of Title IV students, $0-$30,000 family income (program-year institutions) |
| `latest.cost.title_iv.program_reporter.by_income_level.30001-48000` | `NUM42_PROG` | integer | 2 | Number of Title IV students, $30,001-$48,000 family income (program-year institutions) |
| `latest.cost.title_iv.program_reporter.by_income_level.48001-75000` | `NUM43_PROG` | integer | 2 | Number of Title IV students, $48,001-$75,000 family income (program-year institutions) |
| `latest.cost.title_iv.program_reporter.by_income_level.75001-110000` | `NUM44_PROG` | integer | 2 | Number of Title IV students, $75,001-$110,000 family income (program-year institutions) |
| `latest.cost.title_iv.program_reporter.by_income_level.110001-plus` | `NUM45_PROG` | integer | 2 | Number of Title IV students, $110,000+ family income (program-year institutions) |
| `latest.cost.title_iv.other_acad_calendar.by_income_level.0-30000` | `NUM41_OTHER` | integer | 2 | Number of Title IV students, $0-$30,000 family income (other academic calendar institutions) |
| `latest.cost.title_iv.other_acad_calendar.by_income_level.30001-48000` | `NUM42_OTHER` | integer | 2 | Number of Title IV students, $30,001-$48,000 family income (other academic calendar institutions) |
| `latest.cost.title_iv.other_acad_calendar.by_income_level.48001-75000` | `NUM43_OTHER` | integer | 2 | Number of Title IV students, $48,001-$75,000 family income (other academic calendar institutions) |
| `latest.cost.title_iv.other_acad_calendar.by_income_level.75001-110000` | `NUM44_OTHER` | integer | 2 | Number of Title IV students, $75,001-$110,000 family income (other academic calendar institutions) |
| `latest.cost.title_iv.other_acad_calendar.by_income_level.110001-plus` | `NUM45_OTHER` | integer | 2 | Number of Title IV students, $110,000+ family income (other academic calendar institutions) |
| `latest.cost.attendance.academic_year` | `COSTT4_A` | integer | 16 | Average cost of attendance (academic year institutions) |
| `latest.cost.attendance.program_year` | `COSTT4_P` | integer | 16 | Average cost of attendance (program-year institutions) |
| `latest.cost.tuition.in_state` | `TUITIONFEE_IN` | integer | 25 | In-state tuition and fees |
| `latest.cost.tuition.out_of_state` | `TUITIONFEE_OUT` | integer | 25 | Out-of-state tuition and fees |
| `latest.cost.tuition.program_year` | `TUITIONFEE_PROG` | integer | 25 | Tuition and fees for program-year institutions |
| `latest.cost.program_reporter.program_1.cip_6_digit.full_program` | `CIPTFBS1` | integer | 29 | Tuition, fees, books, and supply charges for largest program (full program) |
| `latest.cost.program_reporter.program_2.cip_6_digit.full_program` | `CIPTFBS2` | integer | 29 | Tuition, fees, books, and supply charges for program #2 (full program) |
| `latest.cost.program_reporter.program_3.cip_6_digit.full_program` | `CIPTFBS3` | integer | 29 | Tuition, fees, books, and supply charges for program #3 (full program) |
| `latest.cost.program_reporter.program_4.cip_6_digit.full_program` | `CIPTFBS4` | integer | 29 | Tuition, fees, books, and supply charges for program #4 (full program) |
| `latest.cost.program_reporter.program_5.cip_6_digit.full_program` | `CIPTFBS5` | integer | 29 | Tuition, fees, books, and supply charges for program #5 (full program) |
| `latest.cost.program_reporter.program_6.cip_6_digit.full_program` | `CIPTFBS6` | integer | 29 | Tuition, fees, books, and supply charges for program #6 (full program) |
| `latest.cost.program_reporter.program_1.cip_6_digit.annualized` | `CIPTFBSANNUAL1` | integer | 14 | Tuition, fees, books, and supply charges for largest program (annualized based on institution's academic year) |
| `latest.cost.program_reporter.program_2.cip_6_digit.annualized` | `CIPTFBSANNUAL2` | integer | 14 | Tuition, fees, books, and supply charges for program #2 (annualized based on institution's academic year) |
| `latest.cost.program_reporter.program_3.cip_6_digit.annualized` | `CIPTFBSANNUAL3` | integer | 14 | Tuition, fees, books, and supply charges for program #3 (annualized based on institution's academic year) |
| `latest.cost.program_reporter.program_4.cip_6_digit.annualized` | `CIPTFBSANNUAL4` | integer | 14 | Tuition, fees, books, and supply charges for program #4 (annualized based on institution's academic year) |
| `latest.cost.program_reporter.program_5.cip_6_digit.annualized` | `CIPTFBSANNUAL5` | integer | 14 | Tuition, fees, books, and supply charges for program #5 (annualized based on institution's academic year) |
| `latest.cost.program_reporter.program_6.cip_6_digit.annualized` | `CIPTFBSANNUAL6` | integer | 14 | Tuition, fees, books, and supply charges for program #6 (annualized based on institution's academic year) |
| `latest.cost.booksupply` | `BOOKSUPPLY` | integer | 26 | Cost of attendance: estimated books and supplies |
| `latest.cost.roomboard.oncampus` | `ROOMBOARD_ON` | integer | 26 | Cost of attendance: on-campus room and board |
| `latest.cost.otherexpense.oncampus` | `OTHEREXPENSE_ON` | integer | 26 | Cost of attendance: on-campus other expenses |
| `latest.cost.roomboard.offcampus` | `ROOMBOARD_OFF` | integer | 26 | Cost of attendance: off-campus room and board |
| `latest.cost.otherexpense.offcampus` | `OTHEREXPENSE_OFF` | integer | 26 | Cost of attendance: off-campus other expenses |
| `latest.cost.otherexpense.withfamily` | `OTHEREXPENSE_FAM` | integer | 26 | Cost of attendance: with-family other expenses |
| `latest.cost.avg_net_price.consumer.median_by_pred_degree` | `MDCOST_PD` | float | 0 | Median average net price amongst insitituions with the same predominant degree category |
| `latest.cost.avg_net_price.consumer.overall_median` | `MDCOST_ALL` | float | 0 | Overall median for average net price |

---

## 5. `aid` - 111 variables

> What students get and what they owe: Pell/loan take-up rates, median debt at graduation and for non-completers, PLUS loans.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.aid.pell_grant_rate` | `PCTPELL` | float | 17 | Percentage of undergraduates who receive a Pell Grant |
| `latest.aid.federal_loan_rate` | `PCTFLOAN` | float | 16 | Percent of all undergraduate students receiving a federal student loan |
| `latest.aid.loan_principal` | `DEBT_MDN` | float | 24 | The median original amount of the loan principal upon entering repayment |
| `latest.aid.median_debt.completers.overall` | `GRAD_DEBT_MDN` | float | 24 | The median debt for students who have completed |
| `latest.aid.median_debt.noncompleters` | `WDRAW_DEBT_MDN` | float | 24 | The median debt for students who have not completed |
| `latest.aid.median_debt.income.0_30000` | `LO_INC_DEBT_MDN` | float | 24 | The median debt for students with family income between $0-$30,000 |
| `latest.aid.median_debt.income.30001_75000` | `MD_INC_DEBT_MDN` | float | 24 | The median debt for students with family income between $30,001-$75,000 |
| `latest.aid.median_debt.income.greater_than_75000` | `HI_INC_DEBT_MDN` | float | 24 | The median debt for students with family income $75,001+ |
| `latest.aid.median_debt.dependent_students` | `DEP_DEBT_MDN` | float | 24 | The median debt for dependent students |
| `latest.aid.median_debt.independent_students` | `IND_DEBT_MDN` | float | 24 | The median debt for independent students |
| `latest.aid.median_debt.pell_grant` | `PELL_DEBT_MDN` | float | 24 | The median debt for Pell students |
| `latest.aid.median_debt.no_pell_grant` | `NOPELL_DEBT_MDN` | float | 24 | The median debt for no-Pell students |
| `latest.aid.median_debt.female_students` | `FEMALE_DEBT_MDN` | float | 24 | The median debt for female students |
| `latest.aid.median_debt.male_students` | `MALE_DEBT_MDN` | float | 24 | The median debt for male students |
| `latest.aid.median_debt.first_generation_students` | `FIRSTGEN_DEBT_MDN` | float | 24 | The median debt for first-generation students |
| `latest.aid.median_debt.non_first_generation_students` | `NOTFIRSTGEN_DEBT_MDN` | float | 24 | The median debt for not-first-generation students |
| `latest.aid.median_debt.number.overall` | `DEBT_N` | integer | 24 | The number of students in the median debt cohort |
| `latest.aid.median_debt.number.completers` | `GRAD_DEBT_N` | integer | 24 | The number of students in the median debt completers cohort |
| `latest.aid.median_debt.number.noncompleters` | `WDRAW_DEBT_N` | integer | 24 | The number of students in the median debt withdrawn cohort |
| `latest.aid.median_debt.number.income.0_30000` | `LO_INC_DEBT_N` | integer | 24 | The number of students in the median debt low-income (less than or equal to $30,000 in nominal family incom... |
| `latest.aid.median_debt.number.income.30001_75000` | `MD_INC_DEBT_N` | integer | 24 | The number of students in the median debt middle-income (between $30,000 and $75,000 in nominal family inco... |
| `latest.aid.median_debt.number.income.greater_than_75000` | `HI_INC_DEBT_N` | integer | 24 | The number of students in the median debt high-income (above $75,000 in nominal family income) students cohort |
| `latest.aid.median_debt.number.dependent_students` | `DEP_DEBT_N` | integer | 24 | The number of students in the median debt dependent students cohort |
| `latest.aid.median_debt.number.independent_students` | `IND_DEBT_N` | integer | 24 | The number of students in the median debt independent students cohort |
| `latest.aid.median_debt.number.pell_grant` | `PELL_DEBT_N` | integer | 24 | The number of students in the median debt Pell students cohort |
| `latest.aid.median_debt.number.no_pell_grant` | `NOPELL_DEBT_N` | integer | 24 | The number of students in the median debt no-Pell students cohort |
| `latest.aid.median_debt.number.female_students` | `FEMALE_DEBT_N` | integer | 24 | The number of students in the median debt female students cohort |
| `latest.aid.median_debt.number.male_students` | `MALE_DEBT_N` | integer | 24 | The number of students in the median debt male students cohort |
| `latest.aid.median_debt.number.first_generation_students` | `FIRSTGEN_DEBT_N` | integer | 24 | The number of students in the median debt first-generation students cohort |
| `latest.aid.median_debt.number.non_first_generation_students` | `NOTFIRSTGEN_DEBT_N` | integer | 24 | The number of students in the median debt not-first-generation students cohort |
| `latest.aid.median_debt.completers.monthly_payments` | `GRAD_DEBT_MDN10YR` | float | 1 | Median loan debt of completers in monthly payments (10-year amortization plan) |
| `latest.aid.cumulative_debt.number` | `CUML_DEBT_N` | integer | 20 | Number of students in the cumulative loan debt cohort |
| `latest.aid.cumulative_debt.90th_percentile` | `CUML_DEBT_P90` | integer | 20 | Cumulative loan debt at the 90th percentile |
| `latest.aid.cumulative_debt.75th_percentile` | `CUML_DEBT_P75` | integer | 20 | Cumulative loan debt at the 75th percentile |
| `latest.aid.cumulative_debt.25th_percentile` | `CUML_DEBT_P25` | integer | 20 | Cumulative loan debt at the 25th percentile |
| `latest.aid.cumulative_debt.10th_percentile` | `CUML_DEBT_P10` | integer | 20 | Cumulative loan debt at the 10th percentile |
| `latest.aid.students_with_any_loan` | `LOAN_EVER` | float | 20 | Share of students who received a federal loan while in school |
| `latest.aid.median_debt_suppressed.overall` | `DEBT_MDN_SUPP` | float | 1 | Median debt, suppressed for n=30 |
| `latest.aid.median_debt_suppressed.completers.overall` | `GRAD_DEBT_MDN_SUPP` | float | 1 | Median debt of completers, suppressed for n=30 |
| `latest.aid.median_debt_suppressed.completers.monthly_payments` | `GRAD_DEBT_MDN10YR_SUPP` | float | 1 | Median debt of completers expressed in 10-year monthly payments, suppressed for n=30 |
| `latest.aid.ftft_pell_grant_rate` | `FTFTPCTPELL` | float | 17 | Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a Pell Grant |
| `latest.aid.ftft_federal_loan_rate` | `FTFTPCTFLOAN` | float | 17 | Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a federal loan |
| `latest.aid.ftft_undergrads_pell_federal_loan_years` | `POOLYRS_FTFTAIDPCT` | integer | 1 | Years used for rolling averages of FTFTPCTPELL_POOLED_SUPP and FTFTPCTFLOAN_POOLED_SUPP |
| `latest.aid.ftft_pell_grant_rate_pooled` | `FTFTPCTPELL_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a Pell Grant,... |
| `latest.aid.ftft_federal_loan_rate_pooled` | `FTFTPCTFLOAN_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a federal loa... |
| `latest.aid.plus_loan_pct_lower` | `PPLUS_PCT_LOW` | integer | 7 | Lower bound of estimated percentage range of students whose parents took out a PLUS loan |
| `latest.aid.plus_loan_pct_upper` | `PPLUS_PCT_HIGH` | integer | 7 | Upper bound of estimated percentage range of students whose parents took out a PLUS loan |
| `latest.aid.plus_loan_pct_lower_pooled` | `PPLUS_PCT_LOW_POOLED_SUPP` | integer | 1 | Lower bound of estimated percentage range of students whose parents took out a PLUS loan, pooled in rolling... |
| `latest.aid.plus_loan_pct_upper_pooled` | `PPLUS_PCT_HIGH_POOLED_SUPP` | integer | 1 | Upper bound of estimated percentage range of students whose parents took out a PLUS loan, pooled in rolling... |
| `latest.aid.plus_loan_pct_years` | `POOLYRS_PLUSPCT` | integer | 1 | Years used for rolling averages of PPLUS_PCT_LOW_POOLED_SUPP and PPLUS_PCT_HIGH_POOLED_SUPP |
| `latest.aid.plus_debt.all.eval_inst.count` | `PLUS_DEBT_INST_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at this institution |
| `latest.aid.plus_debt.all.eval_inst.median` | `PLUS_DEBT_INST_MD` | integer | 7 | Median PLUS loan debt disbursed at this institution |
| `latest.aid.plus_debt.all.all_inst.count` | `PLUS_DEBT_ALL_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at all institutions |
| `latest.aid.plus_debt.all.all_inst.median` | `PLUS_DEBT_ALL_MD` | integer | 7 | Median PLUS loan debt disbursed at all institutions |
| `latest.aid.plus_debt.completers.eval_inst.count` | `PLUS_DEBT_INST_COMP_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to completers at this institution |
| `latest.aid.plus_debt.completers.eval_inst.median` | `PLUS_DEBT_INST_COMP_MD` | integer | 7 | Median PLUS loan debt disbursed to completers at this institution |
| `latest.aid.plus_debt.completers.eval_inst.median_payment` | `PLUS_DEBT_INST_COMP_MDPAY10` | float | 1 | Median estimated monthly payment for PLUS loan debt disbursed to completers at this institution |
| `latest.aid.plus_debt_suppressed.completers.eval_inst.median` | `PLUS_DEBT_INST_COMP_MD_SUPP` | integer | 1 | Median PLUS loan debt disbursed to completers at this institution, suppressed for n=30 |
| `latest.aid.plus_debt_suppressed.completers.eval_inst.median_payment` | `PLUS_DEBT_INST_COMP_MDPAY10_SUPP` | float | 1 | Median estimated monthly payment for PLUS loan debt disbursed to completers at this institution, suppressed... |
| `latest.aid.plus_debt.completers.all_inst.count` | `PLUS_DEBT_ALL_COMP_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to completers at all institutions |
| `latest.aid.plus_debt.completers.all_inst.median` | `PLUS_DEBT_ALL_COMP_MD` | integer | 7 | Median PLUS loan debt disbursed to completers at all institutions |
| `latest.aid.plus_debt.completers.all_inst.median_payment` | `PLUS_DEBT_ALL_COMP_MDPAY10` | float | 1 | Median estimated monthly payment for PLUS loan debt disbursed to completers at all institutions |
| `latest.aid.plus_debt_suppressed.completers.all_inst.median` | `PLUS_DEBT_ALL_COMP_MD_SUPP` | integer | 1 | Median PLUS loan debt disbursed to completers at all institutions, suppressed for n=30 |
| `latest.aid.plus_debt_suppressed.completers.all_inst.median_payment` | `PLUS_DEBT_ALL_COMP_MDPAY10_SUPP` | float | 1 | Median estimated monthly payment for PLUS loan debt disbursed to completers at all institutions, suppressed... |
| `latest.aid.plus_debt.noncompleters.eval_inst.count` | `PLUS_DEBT_INST_NOCOMP_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to non-completers at this institution |
| `latest.aid.plus_debt.noncompleters.eval_inst.median` | `PLUS_DEBT_INST_NOCOMP_MD` | integer | 7 | Median PLUS loan debt disbursed to non-completers at this institution |
| `latest.aid.plus_debt.noncompleters.all_inst.count` | `PLUS_DEBT_ALL_NOCOMP_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to non-completers at all institutions |
| `latest.aid.plus_debt.noncompleters.all_inst.median` | `PLUS_DEBT_ALL_NOCOMP_MD` | integer | 7 | Median PLUS loan debt disbursed to non-completers at all institutions |
| `latest.aid.plus_debt.male.eval_inst.count` | `PLUS_DEBT_INST_MALE_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to males at this institution |
| `latest.aid.plus_debt.male.eval_inst.median` | `PLUS_DEBT_INST_MALE_MD` | integer | 7 | Median PLUS loan debt disbursed to males at this institution |
| `latest.aid.plus_debt.male.all_inst.count` | `PLUS_DEBT_ALL_MALE_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to males at all institutions |
| `latest.aid.plus_debt.male.all_inst.median` | `PLUS_DEBT_ALL_MALE_MD` | integer | 7 | Median PLUS loan debt disbursed to males at all institutions |
| `latest.aid.plus_debt.not_male.eval_inst.count` | `PLUS_DEBT_INST_NOMALE_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to non-males at this institution |
| `latest.aid.plus_debt.not_male.eval_inst.median` | `PLUS_DEBT_INST_NOMALE_MD` | integer | 7 | Median PLUS loan debt disbursed to non-males at this institution |
| `latest.aid.plus_debt.not_male.all_inst.count` | `PLUS_DEBT_ALL_NOMALE_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to non-males at all institutions |
| `latest.aid.plus_debt.not_male.all_inst.median` | `PLUS_DEBT_ALL_NOMALE_MD` | integer | 7 | Median PLUS loan debt disbursed to non-males at all institutions |
| `latest.aid.plus_debt.pell.eval_inst.count` | `PLUS_DEBT_INST_PELL_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to Pell recipients at this institution |
| `latest.aid.plus_debt.pell.eval_inst.median` | `PLUS_DEBT_INST_PELL_MD` | integer | 7 | Median PLUS loan debt disbursed to Pell recipients at this institution |
| `latest.aid.plus_debt.pell.all_inst.count` | `PLUS_DEBT_ALL_PELL_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to Pell recipients at all institutions |
| `latest.aid.plus_debt.pell.all_inst.median` | `PLUS_DEBT_ALL_PELL_MD` | integer | 7 | Median PLUS loan debt disbursed to Pell recipients at all institutions |
| `latest.aid.plus_debt.not_pell.eval_inst.count` | `PLUS_DEBT_INST_NOPELL_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to non-Pell-recipients at this institution |
| `latest.aid.plus_debt.not_pell.eval_inst.median` | `PLUS_DEBT_INST_NOPELL_MD` | integer | 7 | Median PLUS loan debt disbursed to non-Pell-recipients at this institution |
| `latest.aid.plus_debt.not_pell.all_inst.count` | `PLUS_DEBT_ALL_NOPELL_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed to non-Pell-recipients at all institutions |
| `latest.aid.plus_debt.not_pell.all_inst.median` | `PLUS_DEBT_ALL_NOPELL_MD` | integer | 7 | Median PLUS loan debt disbursed to non-Pell-recipients at all institutions |
| `latest.aid.plus_debt.stafford_this_school.eval_inst.count` | `PLUS_DEBT_INST_STAFFTHIS_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at this institution to Stafford loan recipients... |
| `latest.aid.plus_debt.stafford_this_school.eval_inst.median` | `PLUS_DEBT_INST_STAFFTHIS_MD` | integer | 7 | Median PLUS loan debt disbursed at this institution to Stafford loan recipients at this institution |
| `latest.aid.plus_debt.stafford_this_school.all_inst.count` | `PLUS_DEBT_ALL_STAFFTHIS_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at any institution to Stafford loan recipients... |
| `latest.aid.plus_debt.stafford_this_school.all_inst.median` | `PLUS_DEBT_ALL_STAFFTHIS_MD` | integer | 7 | Median PLUS loan debt disbursed at any institution to Stafford loan recipients at this institution |
| `latest.aid.plus_debt.nostafford_this_school.eval_inst.count` | `PLUS_DEBT_INST_NOSTAFFTHIS_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at this institution to students not receiving a... |
| `latest.aid.plus_debt.nostafford_this_school.eval_inst.median` | `PLUS_DEBT_INST_NOSTAFFTHIS_MD` | integer | 7 | Median PLUS loan debt disbursed at this institution to students not receiving a Stafford loan at this insti... |
| `latest.aid.plus_debt.nostafford_this_school.all_inst.count` | `PLUS_DEBT_ALL_NOSTAFFTHIS_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at any institution to students not receiving a... |
| `latest.aid.plus_debt.nostafford_this_school.all_inst.median` | `PLUS_DEBT_ALL_NOSTAFFTHIS_MD` | integer | 7 | Median PLUS loan debt disbursed at any institution to students not receiving a Stafford loan at this instit... |
| `latest.aid.plus_debt.stafford_any_school.eval_inst.count` | `PLUS_DEBT_INST_STAFFANY_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at this institution to Stafford loan recipients... |
| `latest.aid.plus_debt.stafford_any_school.eval_inst.median` | `PLUS_DEBT_INST_STAFFANY_MD` | integer | 7 | Median PLUS loan debt disbursed at this institution to Stafford loan recipients at any institution |
| `latest.aid.plus_debt.stafford_any_school.all_inst.count` | `PLUS_DEBT_ALL_STAFFANY_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at any institution to Stafford loan recipients... |
| `latest.aid.plus_debt.stafford_any_school.all_inst.median` | `PLUS_DEBT_ALL_STAFFANY_MD` | integer | 7 | Median PLUS loan debt disbursed at any institution to Stafford loan recipients at any institution |
| `latest.aid.plus_debt.nostafford_any_school.eval_inst.count` | `PLUS_DEBT_INST_NOSTAFFANY_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at this institution to students not receiving a... |
| `latest.aid.plus_debt.nostafford_any_school.eval_inst.median` | `PLUS_DEBT_INST_NOSTAFFANY_MD` | integer | 7 | Median PLUS loan debt disbursed at this institution to students not receiving a Stafford loan at any instit... |
| `latest.aid.plus_debt.nostafford_any_school.all_inst.count` | `PLUS_DEBT_ALL_NOSTAFFANY_N` | integer | 7 | Student recipient count for median PLUS loan debt disbursed at any institution to students not receiving a... |
| `latest.aid.plus_debt.nostafford_any_school.all_inst.median` | `PLUS_DEBT_ALL_NOSTAFFANY_MD` | integer | 7 | Median PLUS loan debt disbursed at any institution to students not receiving a Stafford loan at any institu... |
| `latest.aid.portfolio.direct_loans.count` | `LPSTAFFORD_CNT` | integer | 3 | Number of borrowers with outstanding federal Direct Loan balances |
| `latest.aid.portfolio.direct_loans.amount` | `LPSTAFFORD_AMT` | long | 3 | Total outstanding federal Direct Loan balance |
| `latest.aid.portfolio.parent_plus.count` | `LPPPLUS_CNT` | integer | 3 | Number of students associated with outstanding Parent PLUS Loan balances |
| `latest.aid.portfolio.parent_plus.amount` | `LPPPLUS_AMT` | long | 3 | Total outstanding Parent PLUS Loan balance |
| `latest.aid.portfolio.grad_plus.count` | `LPGPLUS_CNT` | integer | 3 | Number of students associated with outstanding Grad PLUS Loan balances |
| `latest.aid.portfolio.grad_plus.amount` | `LPGPLUS_AMT` | long | 3 | Total outstanding Grad PLUS Loan balance |
| `latest.aid.dcs_pell_grant_rate` | `PCTPELL_DCS` | float | 3 | Percentage of degree/certificate-seeking undergraduate students awarded a Pell Grant |
| `latest.aid.dcs_federal_loan_rate` | `PCTFLOAN_DCS` | float | 3 | Percentage of degree/certificate-seeking undergraduate students awarded a federal loan |
| `latest.aid.dcs_pell_grant_rate_pooled` | `PCTPELL_DCS_POOLED_SUPP` | float | 1 | Percentage of degree/certificate-seeking undergraduate students awarded a Pell Grant, pooled in rolling ave... |
| `latest.aid.dcs_federal_loan_rate_pooled` | `PCTFLOAN_DCS_POOLED_SUPP` | float | 1 | Percentage of degree/certificate-seeking undergraduate students awarded a federal loan, pooled in rolling a... |
| `latest.aid.dcs_undergrads_pell_federal_loan_years` | `POOLYRS_DCS` | integer | 1 | Years used for rolling averages of PCTPELL_DCS_POOLED_SUPP and PCTFLOAN_DCS_POOLED_SUPP |

---

## 6. `student` - 131 variables

> Who is enrolled and how many: total size, race/ethnicity shares, first-generation share, family income, full-time/part-time split.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.student.size` | `UGDS` | integer | 28 | Enrollment of undergraduate certificate/degree-seeking students |
| `latest.student.enrollment.all` | `UG` | integer | 1 | Enrollment of all undergraduate students |
| `latest.student.demographics.race_ethnicity.white` | `UGDS_WHITE` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are white |
| `latest.student.demographics.race_ethnicity.black` | `UGDS_BLACK` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are black |
| `latest.student.demographics.race_ethnicity.hispanic` | `UGDS_HISP` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are Hispanic |
| `latest.student.demographics.race_ethnicity.asian` | `UGDS_ASIAN` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are Asian |
| `latest.student.demographics.race_ethnicity.aian` | `UGDS_AIAN` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are American Indian/Alaska Native |
| `latest.student.demographics.race_ethnicity.nhpi` | `UGDS_NHPI` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are Native Hawaiian/Pacific Islander |
| `latest.student.demographics.race_ethnicity.two_or_more` | `UGDS_2MOR` | float | 17 | Total share of enrollment of undergraduate degree-seeking students who are two or more races |
| `latest.student.demographics.race_ethnicity.non_resident_alien` | `UGDS_NRA` | float | 28 | Total share of enrollment of undergraduate degree-seeking students who are non-resident aliens |
| `latest.student.demographics.race_ethnicity.unknown` | `UGDS_UNKN` | float | 28 | Total share of enrollment of undergraduate degree-seeking students whose race is unknown |
| `latest.student.demographics.race_ethnicity.white_non_hispanic` | `UGDS_WHITENH` | float | 13 | Total share of enrollment of undergraduate degree-seeking students who are white non-Hispanic |
| `latest.student.demographics.race_ethnicity.black_non_hispanic` | `UGDS_BLACKNH` | float | 13 | Total share of enrollment of undergraduate degree-seeking students who are black non-Hispanic |
| `latest.student.demographics.race_ethnicity.asian_pacific_islander` | `UGDS_API` | float | 13 | Total share of enrollment of undergraduate degree-seeking students who are Asian/Pacific Islander |
| `latest.student.demographics.race_ethnicity.aian_prior_2009` | `UGDS_AIANOLD` | float | 13 | Total share of enrollment of undergraduate degree-seeking students who are American Indian/Alaska Native |
| `latest.student.demographics.race_ethnicity.hispanic_prior_2009` | `UGDS_HISPOLD` | float | 13 | Total share of enrollment of undergraduate degree-seeking students who are Hispanic |
| `latest.student.demographics.non_resident_aliens_2000` | `UG_NRA` | float | 1 | Total share of enrollment of undergraduate students who are non-resident aliens |
| `latest.student.demographics.race_ethnicity.unknown_2000` | `UG_UNKN` | float | 1 | Total share of enrollment of undergraduate students whose race is unknown |
| `latest.student.demographics.race_ethnicity.white_2000` | `UG_WHITENH` | float | 1 | Total share of enrollment of undergraduate students who are white non-Hispanic |
| `latest.student.demographics.race_ethnicity.black_2000` | `UG_BLACKNH` | float | 1 | Total share of enrollment of undergraduate students who are black non-Hispanic |
| `latest.student.demographics.race_ethnicity.api_2000` | `UG_API` | float | 1 | Total share of enrollment of undergraduate students who are Asian/Pacific Islander |
| `latest.student.demographics.race_ethnicity.aian_2000` | `UG_AIANOLD` | float | 1 | Total share of enrollment of undergraduate students who are American Indian/Alaska Native |
| `latest.student.demographics.race_ethnicity.hispanic_2000` | `UG_HISPOLD` | float | 1 | Total share of enrollment of undergraduate students who are Hispanic |
| `latest.student.part_time_share` | `PPTUG_EF` | float | 28 | Share of undergraduate, degree-/certificate-seeking students who are part-time |
| `latest.student.part_time_share_2000` | `PPTUG_EF2` | float | 1 | Share of undergraduate, degree-/certificate-seeking students who are part-time |
| `latest.student.share_first.time_full.time` | `PFTFTUG1_EF` | float | 19 | Share of entering undergraduate students who are first-time, full-time degree-/certificate-seeking undergra... |
| `latest.student.retention_rate.four_year.full_time` | `RET_FT4` | float | 21 | First-time, full-time student retention rate at four-year institutions |
| `latest.student.retention_rate.lt_four_year.full_time` | `RET_FTL4` | float | 21 | First-time, full-time student retention rate at less-than-four-year institutions |
| `latest.student.retention_rate.four_year.part_time` | `RET_PT4` | float | 21 | First-time, part-time student retention rate at four-year institutions |
| `latest.student.retention_rate.lt_four_year.part_time` | `RET_PTL4` | float | 21 | First-time, part-time student retention rate at less-than-four-year institutions |
| `latest.student.share_25_older` | `UG25ABV` | float | 14 | Percentage of undergraduates aged 25 and above |
| `latest.student.share_lowincome.0_30000` | `INC_PCT_LO` | float | 20 | Percentage of aided students whose family income is between $0-$30,000 |
| `latest.student.share_independent_students` | `DEP_STAT_PCT_IND` | float | 20 | Percentage of students who are financially independent |
| `latest.student.share_independent_lowincome.0_30000` | `IND_INC_PCT_LO` | float | 20 | Percentage of students who are financially independent and have family incomes between $0-30,000 |
| `latest.student.share_dependent_lowincome.0_300000` | `DEP_INC_PCT_LO` | float | 20 | Percentage of students who are financially dependent and have family incomes between $0-30,000 |
| `latest.student.share_firstgeneration` | `PAR_ED_PCT_1STGEN` | float | 20 | Percentage first-generation students |
| `latest.student.share_middleincome.30001_48000` | `INC_PCT_M1` | float | 20 | Aided students with family incomes between $30,001-$48,000 in nominal dollars |
| `latest.student.share_middleincome.48001_75000` | `INC_PCT_M2` | float | 20 | Aided students with family incomes between $48,001-$75,000 in nominal dollars |
| `latest.student.share_highincome.75001_110000` | `INC_PCT_H1` | float | 20 | Aided students with family incomes between $75,001-$110,000 in nominal dollars |
| `latest.student.share_highincome.110001plus` | `INC_PCT_H2` | float | 20 | Aided students with family incomes between $110,001+ in nominal dollars |
| `latest.student.share_dependent_middleincome.300001_48000` | `DEP_INC_PCT_M1` | float | 20 | Dependent students with family incomes between $30,001-$48,000 in nominal dollars |
| `latest.student.share_dependent_middleincome.48001_75000` | `DEP_INC_PCT_M2` | float | 20 | Dependent students with family incomes between $48,001-$75,000 in nominal dollars |
| `latest.student.share_dependent_highincome.75001_110000` | `DEP_INC_PCT_H1` | float | 20 | Dependent students with family incomes between $75,001-$110,000 in nominal dollars |
| `latest.student.share_dependent_highincome.110001plus` | `DEP_INC_PCT_H2` | float | 20 | Dependent students with family incomes between $110,001+ in nominal dollars |
| `latest.student.share_independent_middleincome.30001_48000` | `IND_INC_PCT_M1` | float | 20 | Independent students with family incomes between $30,001-$48,000 in nominal dollars |
| `latest.student.share_independent_middleincome.48001_75000` | `IND_INC_PCT_M2` | float | 20 | Independent students with family incomes between $48,001-$75,000 in nominal dollars |
| `latest.student.share_independent_highincome.75001_110000` | `IND_INC_PCT_H1` | float | 20 | Independent students with family incomes between $75,001-$110,000 in nominal dollars |
| `latest.student.share_independent_highincome.110001plus` | `IND_INC_PCT_H2` | float | 20 | Independent students with family incomes between $110,001+ in nominal dollars |
| `latest.student.share_firstgeneration_parents.middleschool` | `PAR_ED_PCT_MS` | float | 20 | Percent of students whose parents' highest educational level is middle school |
| `latest.student.share_firstgeneration_parents.highschool` | `PAR_ED_PCT_HS` | float | 20 | Percent of students whose parents' highest educational level is high school |
| `latest.student.share_firstgeneration_parents.somecollege` | `PAR_ED_PCT_PS` | float | 20 | Percent of students whose parents' highest educational level was is some form of postsecondary education |
| `latest.student.fafsa_sent.2_college_allyrs` | `APPL_SCH_PCT_GE2` | float | 20 | Number of applications is greater than or equal to 2 |
| `latest.student.fafsa_sent.3_college_allyrs` | `APPL_SCH_PCT_GE3` | float | 20 | Number of applications is greater than or equal to 3 |
| `latest.student.fafsa_sent.4_college_allyrs` | `APPL_SCH_PCT_GE4` | float | 20 | Number of applications is greater than or equal to 4 |
| `latest.student.fafsa_sent.5plus_college_allyrs` | `APPL_SCH_PCT_GE5` | float | 20 | Number of applications is greater than or equal to 5 |
| `latest.student.avg_dependent_income.2014dollars` | `DEP_INC_AVG` | integer | 20 | Average family income of dependent students in real 2015 dollars. |
| `latest.student.avg_independent_income.2014dollars` | `IND_INC_AVG` | integer | 20 | Average family income of independent students in real 2015 dollars. |
| `latest.student.family_income.overall` | `INC_N` | integer | 20 | Number of students in the family income cohort |
| `latest.student.family_income.dependent_students` | `DEP_INC_N` | integer | 20 | Number of students in the family income dependent students cohort |
| `latest.student.family_income.independent_students` | `IND_INC_N` | integer | 20 | Number of students in the family income independent students cohort |
| `latest.student.valid_dependency_status` | `DEP_STAT_N` | integer | 20 | Number of students in the disaggregation with valid dependency status |
| `latest.student.parents_education_level` | `PAR_ED_N` | integer | 20 | Number of students in the parents' education level cohort |
| `latest.student.FAFSA_applications` | `APPL_SCH_N` | integer | 20 | Number of students in the FAFSA applications cohort |
| `latest.student.students_with_pell_grant` | `PELL_EVER` | float | 20 | Share of students who received a Pell Grant while in school |
| `latest.student.demographics.age_entry` | `AGE_ENTRY` | integer | 20 | Average age of entry |
| `latest.student.demographics.age_entry_squared` | `AGE_ENTRY_SQ` | integer | 0 | Average of the age of entry squared |
| `latest.student.demographics.over_23_at_entry` | `AGEGE24` | float | 5 | Percent of students over 23 at entry |
| `latest.student.demographics.female_share` | `FEMALE` | float | 20 | Share of female students |
| `latest.student.demographics.married` | `MARRIED` | float | 20 | Share of married students |
| `latest.student.demographics.dependent` | `DEPENDENT` | float | 20 | Share of dependent students |
| `latest.student.demographics.veteran` | `VETERAN` | float | 20 | Share of veteran students |
| `latest.student.demographics.first_generation` | `FIRST_GEN` | float | 20 | Share of first-generation students |
| `latest.student.demographics.avg_family_income` | `FAMINC` | integer | 20 | Average family income |
| `latest.student.demographics.median_family_income` | `MD_FAMINC` | integer | 20 | Median family income |
| `latest.student.demographics.avg_family_income_independents` | `FAMINC_IND` | integer | 20 | Average family income for independent students |
| `latest.student.demographics.avg_family_income_log` | `LNFAMINC` | integer | 0 | Average of the log of family income |
| `latest.student.demographics.avg_family_income_independents_log` | `LNFAMINC_IND` | integer | 0 | Average of the log of family income for independent students |
| `latest.student.demographics.share_white.home_ZIP` | `PCT_WHITE` | float | 5 | Percent of the population from students' zip codes that is White, via Census data |
| `latest.student.demographics.share_black.home_ZIP` | `PCT_BLACK` | float | 5 | Percent of the population from students' zip codes that is Black, via Census data |
| `latest.student.demographics.share_asian.home_ZIP` | `PCT_ASIAN` | float | 5 | Percent of the population from students' zip codes that is Asian, via Census data |
| `latest.student.demographics.share_hispanic.home_ZIP` | `PCT_HISPANIC` | float | 5 | Percent of the population from students' zip codes that is Hispanic, via Census data |
| `latest.student.demographics.share_bachelors_degree_age25.home_ZIP` | `PCT_BA` | float | 5 | Percent of the population from students' zip codes with a bachelor's degree over the age 25, via Census data |
| `latest.student.demographics.share_professional_degree_age25.home_ZIP` | `PCT_GRAD_PROF` | float | 5 | Percent of the population from students' zip codes over 25 with a professional degree, via Census data |
| `latest.student.demographics.share_born_US.home_ZIP` | `PCT_BORN_US` | float | 5 | Percent of the population from students' zip codes that was born in the US, via Census data |
| `latest.student.demographics.median_hh_income` | `MEDIAN_HH_INC` | integer | 5 | Median household income |
| `latest.student.demographics.poverty_rate` | `POVERTY_RATE` | float | 5 | Poverty rate, via Census data |
| `latest.student.demographics.unemployment` | `UNEMP_RATE` | float | 5 | Unemployment rate, via Census data |
| `latest.student.demographics.median_hh_income_log` | `LN_MEDIAN_HH_INC` | integer | 5 | Log of the median household income |
| `latest.student.fafsa_sent.overall` | `FSEND_COUNT` | integer | 0 | Average number of students who sent their FAFSA reports to at least one college |
| `latest.student.fafsa_sent.1_college` | `FSEND_1` | float | 0 | Share of students who submitted FAFSAs to only one college |
| `latest.student.fafsa_sent.2_colleges` | `FSEND_2` | float | 0 | Share of students who submitted FAFSAs to two colleges |
| `latest.student.fafsa_sent.3_college` | `FSEND_3` | float | 0 | Share of students who submitted FAFSAs to three colleges |
| `latest.student.fafsa_sent.4_colleges` | `FSEND_4` | float | 0 | Share of students who submitted FAFSAs to four colleges |
| `latest.student.fafsa_sent.5_or_more_colleges` | `FSEND_5` | float | 0 | Share of students who submitted FAFSAs to at least five colleges |
| `latest.student.demographics.men` | `UGDS_MEN` | float | 28 | Total share of enrollment of undergraduate degree-seeking students who are men |
| `latest.student.demographics.women` | `UGDS_WOMEN` | float | 28 | Total share of enrollment of undergraduate degree-seeking students who are women |
| `latest.student.undergrads_with_pell_grant_or_federal_student_loan` | `D_PCTPELL_PCTFLOAN` | integer | 17 | Number of undergraduate students (denominator percent receiving a pell grant or federal student loan) |
| `latest.student.undergrads_non_degree_seeking` | `UGNONDS` | integer | 27 | Number of non-degree-seeking undergraduate students |
| `latest.student.grad_students` | `GRADS` | integer | 28 | Number of graduate students |
| `latest.student.retention_rate.four_year.full_time_pooled` | `RET_FT4_POOLED` | float | 1 | First-time, full-time student retention rate at four-year institutions |
| `latest.student.retention_rate.lt_four_year.full_time_pooled` | `RET_FTL4_POOLED` | float | 1 | First-time, full-time student retention rate at less-than-four-year institutions |
| `latest.student.retention_rate.four_year.part_time_pooled` | `RET_PT4_POOLED` | float | 1 | First-time, part-time student retention rate at four-year institutions |
| `latest.student.retention_rate.lt_four_year.part_time_pooled` | `RET_PTL4_POOLED` | float | 1 | First-time, part-time student retention rate at less-than-four-year institutions |
| `latest.student.retention_rate.cohort.four_year.full_time_pooled` | `RET_FT_DEN4_POOLED` | float | 1 | Adjusted cohort count for the first-time, full-time student retention rate at four-year institutions (denom... |
| `latest.student.retention_rate.cohort.lt_four_year.full_time_pooled` | `RET_FT_DENL4_POOLED` | float | 1 | Adjusted cohort count for the first-time, full-time student retention rate at less-than-four-year instituti... |
| `latest.student.retention_rate.cohort.four_year.part_time_pooled` | `RET_PT_DEN4_POOLED` | float | 1 | Adjusted cohort count for the first-time, part-time student retention rate at four-year institutions (denom... |
| `latest.student.retention_rate.cohort.lt_four_year.part_time_pooled` | `RET_PT_DENL4_POOLED` | float | 1 | Adjusted cohort count for the first-time, part-time student retention rate at less-than-four-year instituti... |
| `latest.student.retention_rate.pooled_yrs_used.full_time` | `POOLYRSRET_FT` | integer | 1 | Years used for rolling averages of full-time retention rate RET_FT[4/L4]_POOLED |
| `latest.student.retention_rate.pooled_yrs_used.part_time` | `POOLYRSRET_PT` | integer | 1 | Years used for rolling averages of part-time retention rate RET_PT[4/L4]_POOLED |
| `latest.student.retention_rate_suppressed.four_year.full_time_pooled` | `RET_FT4_POOLED_SUPP` | float | 1 | First-time, full-time student retention rate at four-year institutions |
| `latest.student.retention_rate_suppressed.lt_four_year.full_time_pooled` | `RET_FTL4_POOLED_SUPP` | float | 1 | First-time, full-time student retention rate at less-than-four-year institutions |
| `latest.student.retention_rate_suppressed.four_year.part_time_pooled` | `RET_PT4_POOLED_SUPP` | float | 1 | First-time, part-time student retention rate at four-year institutions |
| `latest.student.retention_rate_suppressed.lt_four_year.part_time_pooled` | `RET_PTL4_POOLED_SUPP` | float | 1 | First-time, part-time student retention rate at less-than-four-year institutions |
| `latest.student.enrollment.undergrad_12_month` | `UG12MN` | integer | 30 | Unduplicated count of undergraduate students enrolled during a 12 month period |
| `latest.student.enrollment.grad_12_month` | `G12MN` | integer | 30 | Unduplicated count of graduate students enrolled during a 12 month period |
| `latest.student.ftft_undergrads_with_pell_grant_or_federal_student_loan` | `SCUGFFN` | integer | 17 | Number of full-time, first-time degree/certificate-seeking undergraduate students (denominator for percent... |
| `latest.student.ftft_undergrads_with_pell_grant_or_federal_student_loan_pooled` | `SCUGFFN_POOLED` | integer | 1 | Number of full-time, first-time degree/certificate-seeking undergraduate students (denominator for percent... |
| `latest.student.demographics.student_faculty_ratio` | `STUFACR` | float | 17 | Undergraduate student to instructional faculty ratio |
| `latest.student.demographics.faculty.race_ethnicity.two_or_more` | `IRPS_2MOR` | float | 13 | Share of full time faculty that are Two or More Races |
| `latest.student.demographics.faculty.race_ethnicity.aian` | `IRPS_AIAN` | float | 18 | Share of full time faculty that are American Indian or Alaskan Native |
| `latest.student.demographics.faculty.race_ethnicity.asian` | `IRPS_ASIAN` | float | 18 | Share of full time faculty that are Asian |
| `latest.student.demographics.faculty.race_ethnicity.black` | `IRPS_BLACK` | float | 18 | Share of full time faculty that are Black or African American |
| `latest.student.demographics.faculty.race_ethnicity.hispanic` | `IRPS_HISP` | float | 18 | Share of full time faculty that are Hispanic |
| `latest.student.demographics.faculty.race_ethnicity.nhpi` | `IRPS_NHPI` | float | 13 | Share of full time faculty that are Native Hawaiian or Other Pacific Islander |
| `latest.student.demographics.faculty.race_ethnicity.non_resident_alien` | `IRPS_NRA` | float | 18 | Share of full time faculty that are U.S. Nonresidents |
| `latest.student.demographics.faculty.race_ethnicity.unknown` | `IRPS_UNKN` | float | 18 | Share of full time faculty that are of unknown race/ethnicity |
| `latest.student.demographics.faculty.race_ethnicity.white` | `IRPS_WHITE` | float | 18 | Share of full time faculty that are White |
| `latest.student.demographics.faculty.men` | `IRPS_WOMEN` | float | 18 | Share of full time faculty that are men |
| `latest.student.demographics.faculty.women` | `IRPS_MEN` | float | 18 | Share of full time faculty that are women |
| `latest.student.dcs_undergrads_with_pell_grant_or_federal_student_loan` | `DCS_PELL_LOAN` | integer | 3 | Number of degree/certificate-seeking undergraduate students (denominator for percent degree/certificate-see... |
| `latest.student.dcs_undergrads_with_pell_grant_or_federal_student_loan_pooled` | `DCS_PELL_LOAN_POOLED` | integer | 1 | Number of degree/certificate-seeking undergraduate students (denominator for percent degree/certificate-see... |

---

## 7. `academics` - 247 variables

> What is taught: share of degrees by CIP field, programs offered, average months to completion by program.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.academics.program_percentage.agriculture` | `PCIP01` | float | 30 | Percentage of degrees awarded in Agriculture, Agriculture Operations, And Related Sciences. |
| `latest.academics.program_percentage.resources` | `PCIP03` | float | 30 | Percentage of degrees awarded in Natural Resources And Conservation. |
| `latest.academics.program_percentage.architecture` | `PCIP04` | float | 30 | Percentage of degrees awarded in Architecture And Related Services. |
| `latest.academics.program_percentage.ethnic_cultural_gender` | `PCIP05` | float | 30 | Percentage of degrees awarded in Area, Ethnic, Cultural, Gender, And Group Studies. |
| `latest.academics.program_percentage.communication` | `PCIP09` | float | 30 | Percentage of degrees awarded in Communication, Journalism, And Related Programs. |
| `latest.academics.program_percentage.communications_technology` | `PCIP10` | float | 30 | Percentage of degrees awarded in Communications Technologies/Technicians And Support Services. |
| `latest.academics.program_percentage.computer` | `PCIP11` | float | 30 | Percentage of degrees awarded in Computer And Information Sciences And Support Services. |
| `latest.academics.program_percentage.personal_culinary` | `PCIP12` | float | 30 | Percentage of degrees awarded in Personal And Culinary Services. |
| `latest.academics.program_percentage.education` | `PCIP13` | float | 30 | Percentage of degrees awarded in Education. |
| `latest.academics.program_percentage.engineering` | `PCIP14` | float | 30 | Percentage of degrees awarded in Engineering. |
| `latest.academics.program_percentage.engineering_technology` | `PCIP15` | float | 30 | Percentage of degrees awarded in Engineering Technologies And Engineering-Related Fields. |
| `latest.academics.program_percentage.language` | `PCIP16` | float | 30 | Percentage of degrees awarded in Foreign Languages, Literatures, And Linguistics. |
| `latest.academics.program_percentage.family_consumer_science` | `PCIP19` | float | 30 | Percentage of degrees awarded in Family And Consumer Sciences/Human Sciences. |
| `latest.academics.program_percentage.legal` | `PCIP22` | float | 30 | Percentage of degrees awarded in Legal Professions And Studies. |
| `latest.academics.program_percentage.english` | `PCIP23` | float | 30 | Percentage of degrees awarded in English Language And Literature/Letters. |
| `latest.academics.program_percentage.humanities` | `PCIP24` | float | 30 | Percentage of degrees awarded in Liberal Arts And Sciences, General Studies And Humanities. |
| `latest.academics.program_percentage.library` | `PCIP25` | float | 30 | Percentage of degrees awarded in Library Science. |
| `latest.academics.program_percentage.biological` | `PCIP26` | float | 30 | Percentage of degrees awarded in Biological And Biomedical Sciences. |
| `latest.academics.program_percentage.mathematics` | `PCIP27` | float | 30 | Percentage of degrees awarded in Mathematics And Statistics. |
| `latest.academics.program_percentage.military` | `PCIP29` | float | 30 | Percentage of degrees awarded in Military Technologies And Applied Sciences. |
| `latest.academics.program_percentage.multidiscipline` | `PCIP30` | float | 30 | Percentage of degrees awarded in Multi/Interdisciplinary Studies. |
| `latest.academics.program_percentage.parks_recreation_fitness` | `PCIP31` | float | 30 | Percentage of degrees awarded in Parks, Recreation, Leisure, And Fitness Studies. |
| `latest.academics.program_percentage.philosophy_religious` | `PCIP38` | float | 30 | Percentage of degrees awarded in Philosophy And Religious Studies. |
| `latest.academics.program_percentage.theology_religious_vocation` | `PCIP39` | float | 30 | Percentage of degrees awarded in Theology And Religious Vocations. |
| `latest.academics.program_percentage.physical_science` | `PCIP40` | float | 30 | Percentage of degrees awarded in Physical Sciences. |
| `latest.academics.program_percentage.science_technology` | `PCIP41` | float | 30 | Percentage of degrees awarded in Science Technologies/Technicians. |
| `latest.academics.program_percentage.psychology` | `PCIP42` | float | 30 | Percentage of degrees awarded in Psychology. |
| `latest.academics.program_percentage.security_law_enforcement` | `PCIP43` | float | 30 | Percentage of degrees awarded in Homeland Security, Law Enforcement, Firefighting And Related Protective Se... |
| `latest.academics.program_percentage.public_administration_social_service` | `PCIP44` | float | 30 | Percentage of degrees awarded in Public Administration And Social Service Professions. |
| `latest.academics.program_percentage.social_science` | `PCIP45` | float | 30 | Percentage of degrees awarded in Social Sciences. |
| `latest.academics.program_percentage.construction` | `PCIP46` | float | 30 | Percentage of degrees awarded in Construction Trades. |
| `latest.academics.program_percentage.mechanic_repair_technology` | `PCIP47` | float | 30 | Percentage of degrees awarded in Mechanic And Repair Technologies/Technicians. |
| `latest.academics.program_percentage.precision_production` | `PCIP48` | float | 30 | Percentage of degrees awarded in Precision Production. |
| `latest.academics.program_percentage.transportation` | `PCIP49` | float | 30 | Percentage of degrees awarded in Transportation And Materials Moving. |
| `latest.academics.program_percentage.visual_performing` | `PCIP50` | float | 30 | Percentage of degrees awarded in Visual And Performing Arts. |
| `latest.academics.program_percentage.health` | `PCIP51` | float | 30 | Percentage of degrees awarded in Health Professions And Related Programs. |
| `latest.academics.program_percentage.business_marketing` | `PCIP52` | float | 30 | Percentage of degrees awarded in Business, Management, Marketing, And Related Support Services. |
| `latest.academics.program_percentage.history` | `PCIP54` | float | 30 | Percentage of degrees awarded in History. |
| `latest.academics.program.certificate_lt_1_yr.agriculture` | `CIP01CERT1` | integer | 30 | Certificate of less than one academic year in Agriculture, Agriculture Operations, And Related Sciences. |
| `latest.academics.program.certificate_lt_2_yr.agriculture` | `CIP01CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Agriculture, Agriculture Operations, And Re... |
| `latest.academics.program.assoc.agriculture` | `CIP01ASSOC` | integer | 30 | Associate degree in Agriculture, Agriculture Operations, And Related Sciences. |
| `latest.academics.program.certificate_lt_4_yr.agriculture` | `CIP01CERT4` | integer | 30 | Award of at least two but less than four academic years in Agriculture, Agriculture Operations, And Related... |
| `latest.academics.program.bachelors.agriculture` | `CIP01BACHL` | integer | 30 | Bachelor's degree in Agriculture, Agriculture Operations, And Related Sciences. |
| `latest.academics.program.certificate_lt_1_yr.resources` | `CIP03CERT1` | integer | 30 | Certificate of less than one academic year in Natural Resources And Conservation. |
| `latest.academics.program.certificate_lt_2_yr.resources` | `CIP03CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Natural Resources And Conservation. |
| `latest.academics.program.assoc.resources` | `CIP03ASSOC` | integer | 30 | Associate degree in Natural Resources And Conservation. |
| `latest.academics.program.certificate_lt_4_yr.resources` | `CIP03CERT4` | integer | 30 | Award of at least two but less than four academic years in Natural Resources And Conservation. |
| `latest.academics.program.bachelors.resources` | `CIP03BACHL` | integer | 30 | Bachelor's degree in Natural Resources And Conservation. |
| `latest.academics.program.certificate_lt_1_yr.architecture` | `CIP04CERT1` | integer | 30 | Certificate of less than one academic year in Architecture And Related Services. |
| `latest.academics.program.certificate_lt_2_yr.architecture` | `CIP04CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Architecture And Related Services. |
| `latest.academics.program.assoc.architecture` | `CIP04ASSOC` | integer | 30 | Associate degree in Architecture And Related Services. |
| `latest.academics.program.certificate_lt_4_yr.architecture` | `CIP04CERT4` | integer | 30 | Award of at least two but less than four academic years in Architecture And Related Services. |
| `latest.academics.program.bachelors.architecture` | `CIP04BACHL` | integer | 30 | Bachelor's degree in Architecture And Related Services. |
| `latest.academics.program.certificate_lt_1_yr.ethnic_cultural_gender` | `CIP05CERT1` | integer | 30 | Certificate of less than one academic year in Area, Ethnic, Cultural, Gender, And Group Studies. |
| `latest.academics.program.certificate_lt_2_yr.ethnic_cultural_gender` | `CIP05CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Area, Ethnic, Cultural, Gender, And Group S... |
| `latest.academics.program.assoc.ethnic_cultural_gender` | `CIP05ASSOC` | integer | 30 | Associate degree in Area, Ethnic, Cultural, Gender, And Group Studies. |
| `latest.academics.program.certificate_lt_4_yr.ethnic_cultural_gender` | `CIP05CERT4` | integer | 30 | Award of at least two but less than four academic years in Area, Ethnic, Cultural, Gender, And Group Studies. |
| `latest.academics.program.bachelors.ethnic_cultural_gender` | `CIP05BACHL` | integer | 30 | Bachelor's degree in Area, Ethnic, Cultural, Gender, And Group Studies. |
| `latest.academics.program.certificate_lt_1_yr.communication` | `CIP09CERT1` | integer | 30 | Certificate of less than one academic year in Communication, Journalism, And Related Programs. |
| `latest.academics.program.certificate_lt_2_yr.communication` | `CIP09CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Communication, Journalism, And Related Prog... |
| `latest.academics.program.assoc.communication` | `CIP09ASSOC` | integer | 30 | Associate degree in Communication, Journalism, And Related Programs. |
| `latest.academics.program.certificate_lt_4_yr.communication` | `CIP09CERT4` | integer | 30 | Award of at least two but less than four academic years in Communication, Journalism, And Related Programs. |
| `latest.academics.program.bachelors.communication` | `CIP09BACHL` | integer | 30 | Bachelor's degree in Communication, Journalism, And Related Programs. |
| `latest.academics.program.certificate_lt_1_yr.communications_technology` | `CIP10CERT1` | integer | 30 | Certificate of less than one academic year in Communications Technologies/Technicians And Support Services. |
| `latest.academics.program.certificate_lt_2_yr.communications_technology` | `CIP10CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Communications Technologies/Technicians And... |
| `latest.academics.program.assoc.communications_technology` | `CIP10ASSOC` | integer | 30 | Associate degree in Communications Technologies/Technicians And Support Services. |
| `latest.academics.program.certificate_lt_4_yr.communications_technology` | `CIP10CERT4` | integer | 30 | Award of at least two but less than four academic years in Communications Technologies/Technicians And Supp... |
| `latest.academics.program.bachelors.communications_technology` | `CIP10BACHL` | integer | 30 | Bachelor's degree in Communications Technologies/Technicians And Support Services. |
| `latest.academics.program.certificate_lt_1_yr.computer` | `CIP11CERT1` | integer | 30 | Certificate of less than one academic year in Computer And Information Sciences And Support Services. |
| `latest.academics.program.certificate_lt_2_yr.computer` | `CIP11CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Computer And Information Sciences And Suppo... |
| `latest.academics.program.assoc.computer` | `CIP11ASSOC` | integer | 30 | Associate degree in Computer And Information Sciences And Support Services. |
| `latest.academics.program.certificate_lt_4_yr.computer` | `CIP11CERT4` | integer | 30 | Award of at least two but less than four academic years in Computer And Information Sciences And Support Se... |
| `latest.academics.program.bachelors.computer` | `CIP11BACHL` | integer | 30 | Bachelor's degree in Computer And Information Sciences And Support Services. |
| `latest.academics.program.certificate_lt_1_yr.personal_culinary` | `CIP12CERT1` | integer | 30 | Certificate of less than one academic year in Personal And Culinary Services. |
| `latest.academics.program.certificate_lt_2_yr.personal_culinary` | `CIP12CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Personal And Culinary Services. |
| `latest.academics.program.assoc.personal_culinary` | `CIP12ASSOC` | integer | 30 | Associate degree in Personal And Culinary Services. |
| `latest.academics.program.certificate_lt_4_yr.personal_culinary` | `CIP12CERT4` | integer | 30 | Award of at least two but less than four academic years in Personal And Culinary Services. |
| `latest.academics.program.bachelors.personal_culinary` | `CIP12BACHL` | integer | 30 | Bachelor's degree in Personal And Culinary Services. |
| `latest.academics.program.certificate_lt_1_yr.education` | `CIP13CERT1` | integer | 30 | Certificate of less than one academic year in Education. |
| `latest.academics.program.certificate_lt_2_yr.education` | `CIP13CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Education. |
| `latest.academics.program.assoc.education` | `CIP13ASSOC` | integer | 30 | Associate degree in Education. |
| `latest.academics.program.certificate_lt_4_yr.education` | `CIP13CERT4` | integer | 30 | Award of at least two but less than four academic years in Education. |
| `latest.academics.program.bachelors.education` | `CIP13BACHL` | integer | 30 | Bachelor's degree in Education. |
| `latest.academics.program.certificate_lt_1_yr.engineering` | `CIP14CERT1` | integer | 30 | Certificate of less than one academic year in Engineering. |
| `latest.academics.program.certificate_lt_2_yr.engineering` | `CIP14CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Engineering. |
| `latest.academics.program.assoc.engineering` | `CIP14ASSOC` | integer | 30 | Associate degree in Engineering. |
| `latest.academics.program.certificate_lt_4_yr.engineering` | `CIP14CERT4` | integer | 30 | Award of at least two but less than four academic years in Engineering. |
| `latest.academics.program.bachelors.engineering` | `CIP14BACHL` | integer | 30 | Bachelor's degree in Engineering. |
| `latest.academics.program.certificate_lt_1_yr.engineering_technology` | `CIP15CERT1` | integer | 30 | Certificate of less than one academic year in Engineering Technologies And Engineering-Related Fields. |
| `latest.academics.program.certificate_lt_2_yr.engineering_technology` | `CIP15CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Engineering Technologies And Engineering-Re... |
| `latest.academics.program.assoc.engineering_technology` | `CIP15ASSOC` | integer | 30 | Associate degree in Engineering Technologies And Engineering-Related Fields. |
| `latest.academics.program.certificate_lt_4_yr.engineering_technology` | `CIP15CERT4` | integer | 30 | Award of at least two but less than four academic years in Engineering Technologies And Engineering-Related... |
| `latest.academics.program.bachelors.engineering_technology` | `CIP15BACHL` | integer | 30 | Bachelor's degree in Engineering Technologies And Engineering-Related Fields. |
| `latest.academics.program.certificate_lt_1_yr.language` | `CIP16CERT1` | integer | 30 | Certificate of less than one academic year in Foreign Languages, Literatures, And Linguistics. |
| `latest.academics.program.certificate_lt_2_yr.language` | `CIP16CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Foreign Languages, Literatures, And Linguis... |
| `latest.academics.program.assoc.language` | `CIP16ASSOC` | integer | 30 | Associate degree in Foreign Languages, Literatures, And Linguistics. |
| `latest.academics.program.certificate_lt_4_yr.language` | `CIP16CERT4` | integer | 30 | Award of at least two but less than four academic years in Foreign Languages, Literatures, And Linguistics. |
| `latest.academics.program.bachelors.language` | `CIP16BACHL` | integer | 30 | Bachelor's degree in Foreign Languages, Literatures, And Linguistics. |
| `latest.academics.program.certificate_lt_1_yr.family_consumer_science` | `CIP19CERT1` | integer | 30 | Certificate of less than one academic year in Family And Consumer Sciences/Human Sciences. |
| `latest.academics.program.certificate_lt_2_yr.family_consumer_science` | `CIP19CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Family And Consumer Sciences/Human Sciences. |
| `latest.academics.program.assoc.family_consumer_science` | `CIP19ASSOC` | integer | 30 | Associate degree in Family And Consumer Sciences/Human Sciences. |
| `latest.academics.program.certificate_lt_4_yr.family_consumer_science` | `CIP19CERT4` | integer | 30 | Award of at least two but less than four academic years in Family And Consumer Sciences/Human Sciences. |
| `latest.academics.program.bachelors.family_consumer_science` | `CIP19BACHL` | integer | 30 | Bachelor's degree in Family And Consumer Sciences/Human Sciences. |
| `latest.academics.program.certificate_lt_1_yr.legal` | `CIP22CERT1` | integer | 30 | Certificate of less than one academic year in Legal Professions And Studies. |
| `latest.academics.program.certificate_lt_2_yr.legal` | `CIP22CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Legal Professions And Studies. |
| `latest.academics.program.assoc.legal` | `CIP22ASSOC` | integer | 30 | Associate degree in Legal Professions And Studies. |
| `latest.academics.program.certificate_lt_4_yr.legal` | `CIP22CERT4` | integer | 30 | Award of at least two but less than four academic years in Legal Professions And Studies. |
| `latest.academics.program.bachelors.legal` | `CIP22BACHL` | integer | 30 | Bachelor's degree in Legal Professions And Studies. |
| `latest.academics.program.certificate_lt_1_yr.english` | `CIP23CERT1` | integer | 30 | Certificate of less than one academic year in English Language And Literature/Letters. |
| `latest.academics.program.certificate_lt_2_yr.english` | `CIP23CERT2` | integer | 30 | Certificate of at least one but less than two academic years in English Language And Literature/Letters. |
| `latest.academics.program.assoc.english` | `CIP23ASSOC` | integer | 30 | Associate degree in English Language And Literature/Letters. |
| `latest.academics.program.certificate_lt_4_yr.english` | `CIP23CERT4` | integer | 30 | Award of at least two but less than four academic years in English Language And Literature/Letters. |
| `latest.academics.program.bachelors.english` | `CIP23BACHL` | integer | 30 | Bachelor's degree in English Language And Literature/Letters. |
| `latest.academics.program.certificate_lt_1_yr.humanities` | `CIP24CERT1` | integer | 30 | Certificate of less than one academic year in Liberal Arts And Sciences, General Studies And Humanities. |
| `latest.academics.program.certificate_lt_2_yr.humanities` | `CIP24CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Liberal Arts And Sciences, General Studies... |
| `latest.academics.program.assoc.humanities` | `CIP24ASSOC` | integer | 30 | Associate degree in Liberal Arts And Sciences, General Studies And Humanities. |
| `latest.academics.program.certificate_lt_4_yr.humanities` | `CIP24CERT4` | integer | 30 | Award of at least two but less than four academic years in Liberal Arts And Sciences, General Studies And H... |
| `latest.academics.program.bachelors.humanities` | `CIP24BACHL` | integer | 30 | Bachelor's degree in Liberal Arts And Sciences, General Studies And Humanities. |
| `latest.academics.program.certificate_lt_1_yr.library` | `CIP25CERT1` | integer | 30 | Certificate of less than one academic year in Library Science. |
| `latest.academics.program.certificate_lt_2_yr.library` | `CIP25CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Library Science. |
| `latest.academics.program.assoc.library` | `CIP25ASSOC` | integer | 30 | Associate degree in Library Science. |
| `latest.academics.program.certificate_lt_4_yr.library` | `CIP25CERT4` | integer | 30 | Award of at least two but less than four academic years in Library Science. |
| `latest.academics.program.bachelors.library` | `CIP25BACHL` | integer | 30 | Bachelor's degree in Library Science. |
| `latest.academics.program.certificate_lt_1_yr.biological` | `CIP26CERT1` | integer | 30 | Certificate of less than one academic year in Biological And Biomedical Sciences. |
| `latest.academics.program.certificate_lt_2_yr.biological` | `CIP26CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Biological And Biomedical Sciences. |
| `latest.academics.program.assoc.biological` | `CIP26ASSOC` | integer | 30 | Associate degree in Biological And Biomedical Sciences. |
| `latest.academics.program.certificate_lt_4_yr.biological` | `CIP26CERT4` | integer | 30 | Award of at least two but less than four academic years in Biological And Biomedical Sciences. |
| `latest.academics.program.bachelors.biological` | `CIP26BACHL` | integer | 30 | Bachelor's degree in Biological And Biomedical Sciences. |
| `latest.academics.program.certificate_lt_1_yr.mathematics` | `CIP27CERT1` | integer | 30 | Certificate of less than one academic year in Mathematics And Statistics. |
| `latest.academics.program.certificate_lt_2_yr.mathematics` | `CIP27CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Mathematics And Statistics. |
| `latest.academics.program.assoc.mathematics` | `CIP27ASSOC` | integer | 30 | Associate degree in Mathematics And Statistics. |
| `latest.academics.program.certificate_lt_4_yr.mathematics` | `CIP27CERT4` | integer | 30 | Award of at least two but less than four academic years in Mathematics And Statistics. |
| `latest.academics.program.bachelors.mathematics` | `CIP27BACHL` | integer | 30 | Bachelor's degree in Mathematics And Statistics. |
| `latest.academics.program.certificate_lt_1_yr.military` | `CIP29CERT1` | integer | 30 | Certificate of less than one academic year in Military Technologies And Applied Sciences. |
| `latest.academics.program.certificate_lt_2_yr.military` | `CIP29CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Military Technologies And Applied Sciences. |
| `latest.academics.program.assoc.military` | `CIP29ASSOC` | integer | 30 | Associate degree in Military Technologies And Applied Sciences. |
| `latest.academics.program.certificate_lt_4_yr.military` | `CIP29CERT4` | integer | 30 | Award of at least two but less than four academic years in Military Technologies And Applied Sciences. |
| `latest.academics.program.bachelors.military` | `CIP29BACHL` | integer | 30 | Bachelor's degree in Military Technologies And Applied Sciences. |
| `latest.academics.program.certificate_lt_1_yr.multidiscipline` | `CIP30CERT1` | integer | 30 | Certificate of less than one academic year in Multi/Interdisciplinary Studies. |
| `latest.academics.program.certificate_lt_2_yr.multidiscipline` | `CIP30CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Multi/Interdisciplinary Studies. |
| `latest.academics.program.assoc.multidiscipline` | `CIP30ASSOC` | integer | 30 | Associate degree in Multi/Interdisciplinary Studies. |
| `latest.academics.program.certificate_lt_4_yr.multidiscipline` | `CIP30CERT4` | integer | 30 | Award of at least two but less than four academic years in Multi/Interdisciplinary Studies. |
| `latest.academics.program.bachelors.multidiscipline` | `CIP30BACHL` | integer | 30 | Bachelor's degree in Multi/Interdisciplinary Studies. |
| `latest.academics.program.certificate_lt_1_yr.parks_recreation_fitness` | `CIP31CERT1` | integer | 30 | Certificate of less than one academic year in Parks, Recreation, Leisure, And Fitness Studies. |
| `latest.academics.program.certificate_lt_2_yr.parks_recreation_fitness` | `CIP31CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Parks, Recreation, Leisure, And Fitness Stu... |
| `latest.academics.program.assoc.parks_recreation_fitness` | `CIP31ASSOC` | integer | 30 | Associate degree in Parks, Recreation, Leisure, And Fitness Studies. |
| `latest.academics.program.certificate_lt_4_yr.parks_recreation_fitness` | `CIP31CERT4` | integer | 30 | Award of at least two but less than four academic years in Parks, Recreation, Leisure, And Fitness Studies. |
| `latest.academics.program.bachelors.parks_recreation_fitness` | `CIP31BACHL` | integer | 30 | Bachelor's degree in Parks, Recreation, Leisure, And Fitness Studies. |
| `latest.academics.program.certificate_lt_1_yr.philosophy_religious` | `CIP38CERT1` | integer | 30 | Certificate of less than one academic year in Philosophy And Religious Studies. |
| `latest.academics.program.certificate_lt_2_yr.philosophy_religious` | `CIP38CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Philosophy And Religious Studies. |
| `latest.academics.program.assoc.philosophy_religious` | `CIP38ASSOC` | integer | 30 | Associate degree in Philosophy And Religious Studies. |
| `latest.academics.program.certificate_lt_4_yr.philosophy_religious` | `CIP38CERT4` | integer | 30 | Award of at least two but less than four academic years in Philosophy And Religious Studies. |
| `latest.academics.program.bachelors.philosophy_religious` | `CIP38BACHL` | integer | 30 | Bachelor's degree in Philosophy And Religious Studies. |
| `latest.academics.program.certificate_lt_1_yr.theology_religious_vocation` | `CIP39CERT1` | integer | 30 | Certificate of less than one academic year in Theology And Religious Vocations. |
| `latest.academics.program.certificate_lt_2_yr.theology_religious_vocation` | `CIP39CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Theology And Religious Vocations. |
| `latest.academics.program.assoc.theology_religious_vocation` | `CIP39ASSOC` | integer | 30 | Associate degree in Theology And Religious Vocations. |
| `latest.academics.program.certificate_lt_4_yr.theology_religious_vocation` | `CIP39CERT4` | integer | 30 | Award of at least two but less than four academic years in Theology And Religious Vocations. |
| `latest.academics.program.bachelors.theology_religious_vocation` | `CIP39BACHL` | integer | 30 | Bachelor's degree in Theology And Religious Vocations. |
| `latest.academics.program.certificate_lt_1_yr.physical_science` | `CIP40CERT1` | integer | 30 | Certificate of less than one academic year in Physical Sciences. |
| `latest.academics.program.certificate_lt_2_yr.physical_science` | `CIP40CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Physical Sciences. |
| `latest.academics.program.assoc.physical_science` | `CIP40ASSOC` | integer | 30 | Associate degree in Physical Sciences. |
| `latest.academics.program.certificate_lt_4_yr.physical_science` | `CIP40CERT4` | integer | 30 | Award of at least two but less than four academic years in Physical Sciences. |
| `latest.academics.program.bachelors.physical_science` | `CIP40BACHL` | integer | 30 | Bachelor's degree in Physical Sciences. |
| `latest.academics.program.certificate_lt_1_yr.science_technology` | `CIP41CERT1` | integer | 30 | Certificate of less than one academic year in Science Technologies/Technicians. |
| `latest.academics.program.certificate_lt_2_yr.science_technology` | `CIP41CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Science Technologies/Technicians. |
| `latest.academics.program.assoc.science_technology` | `CIP41ASSOC` | integer | 30 | Associate degree in Science Technologies/Technicians. |
| `latest.academics.program.certificate_lt_4_yr.science_technology` | `CIP41CERT4` | integer | 30 | Award of at least two but less than four academic years in Science Technologies/Technicians. |
| `latest.academics.program.bachelors.science_technology` | `CIP41BACHL` | integer | 30 | Bachelor's degree in Science Technologies/Technicians. |
| `latest.academics.program.certificate_lt_1_yr.psychology` | `CIP42CERT1` | integer | 30 | Certificate of less than one academic year in Psychology. |
| `latest.academics.program.certificate_lt_2_yr.psychology` | `CIP42CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Psychology. |
| `latest.academics.program.assoc.psychology` | `CIP42ASSOC` | integer | 30 | Associate degree in Psychology. |
| `latest.academics.program.certificate_lt_4_yr.psychology` | `CIP42CERT4` | integer | 30 | Award of at least two but less than four academic years in Psychology. |
| `latest.academics.program.bachelors.psychology` | `CIP42BACHL` | integer | 30 | Bachelor's degree in Psychology. |
| `latest.academics.program.certificate_lt_1_yr.security_law_enforcement` | `CIP43CERT1` | integer | 30 | Certificate of less than one academic year in Homeland Security, Law Enforcement, Firefighting And Related... |
| `latest.academics.program.certificate_lt_2_yr.security_law_enforcement` | `CIP43CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Homeland Security, Law Enforcement, Firefig... |
| `latest.academics.program.assoc.security_law_enforcement` | `CIP43ASSOC` | integer | 30 | Associate degree in Homeland Security, Law Enforcement, Firefighting And Related Protective Services. |
| `latest.academics.program.certificate_lt_4_yr.security_law_enforcement` | `CIP43CERT4` | integer | 30 | Award of at least two but less than four academic years in Homeland Security, Law Enforcement, Firefighting... |
| `latest.academics.program.bachelors.security_law_enforcement` | `CIP43BACHL` | integer | 30 | Bachelor's degree in Homeland Security, Law Enforcement, Firefighting And Related Protective Services. |
| `latest.academics.program.certificate_lt_1_yr.public_administration_social_service` | `CIP44CERT1` | integer | 30 | Certificate of less than one academic year in Public Administration And Social Service Professions. |
| `latest.academics.program.certificate_lt_2_yr.public_administration_social_service` | `CIP44CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Public Administration And Social Service Pr... |
| `latest.academics.program.assoc.public_administration_social_service` | `CIP44ASSOC` | integer | 30 | Associate degree in Public Administration And Social Service Professions. |
| `latest.academics.program.certificate_lt_4_yr.public_administration_social_service` | `CIP44CERT4` | integer | 30 | Award of at least two but less than four academic years in Public Administration And Social Service Profess... |
| `latest.academics.program.bachelors.public_administration_social_service` | `CIP44BACHL` | integer | 30 | Bachelor's degree in Public Administration And Social Service Professions. |
| `latest.academics.program.certificate_lt_1_yr.social_science` | `CIP45CERT1` | integer | 30 | Certificate of less than one academic year in Social Sciences. |
| `latest.academics.program.certificate_lt_2_yr.social_science` | `CIP45CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Social Sciences. |
| `latest.academics.program.assoc.social_science` | `CIP45ASSOC` | integer | 30 | Associate degree in Social Sciences. |
| `latest.academics.program.certificate_lt_4_yr.social_science` | `CIP45CERT4` | integer | 30 | Award of at least two but less than four academic years in Social Sciences. |
| `latest.academics.program.bachelors.social_science` | `CIP45BACHL` | integer | 30 | Bachelor's degree in Social Sciences. |
| `latest.academics.program.certificate_lt_1_yr.construction` | `CIP46CERT1` | integer | 30 | Certificate of less than one academic year in Construction Trades. |
| `latest.academics.program.certificate_lt_2_yr.construction` | `CIP46CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Construction Trades. |
| `latest.academics.program.assoc.construction` | `CIP46ASSOC` | integer | 30 | Associate degree in Construction Trades. |
| `latest.academics.program.certificate_lt_4_yr.construction` | `CIP46CERT4` | integer | 30 | Award of at least two but less than four academic years in Construction Trades. |
| `latest.academics.program.bachelors.construction` | `CIP46BACHL` | integer | 30 | Bachelor's degree in Construction Trades. |
| `latest.academics.program.certificate_lt_1_yr.mechanic_repair_technology` | `CIP47CERT1` | integer | 30 | Certificate of less than one academic year in Mechanic And Repair Technologies/Technicians. |
| `latest.academics.program.certificate_lt_2_yr.mechanic_repair_technology` | `CIP47CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Mechanic And Repair Technologies/Technicians. |
| `latest.academics.program.assoc.mechanic_repair_technology` | `CIP47ASSOC` | integer | 30 | Associate degree in Mechanic And Repair Technologies/Technicians. |
| `latest.academics.program.certificate_lt_4_yr.mechanic_repair_technology` | `CIP47CERT4` | integer | 30 | Award of at least two but less than four academic years in Mechanic And Repair Technologies/Technicians. |
| `latest.academics.program.bachelors.mechanic_repair_technology` | `CIP47BACHL` | integer | 30 | Bachelor's degree in Mechanic And Repair Technologies/Technicians. |
| `latest.academics.program.certificate_lt_1_yr.precision_production` | `CIP48CERT1` | integer | 30 | Certificate of less than one academic year in Precision Production. |
| `latest.academics.program.certificate_lt_2_yr.precision_production` | `CIP48CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Precision Production. |
| `latest.academics.program.assoc.precision_production` | `CIP48ASSOC` | integer | 30 | Associate degree in Precision Production. |
| `latest.academics.program.certificate_lt_4_yr.precision_production` | `CIP48CERT4` | integer | 30 | Award of at least two but less than four academic years in Precision Production. |
| `latest.academics.program.bachelors.precision_production` | `CIP48BACHL` | integer | 30 | Bachelor's degree in Precision Production. |
| `latest.academics.program.certificate_lt_1_yr.transportation` | `CIP49CERT1` | integer | 30 | Certificate of less than one academic year in Transportation And Materials Moving. |
| `latest.academics.program.certificate_lt_2_yr.transportation` | `CIP49CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Transportation And Materials Moving. |
| `latest.academics.program.assoc.transportation` | `CIP49ASSOC` | integer | 30 | Associate degree in Transportation And Materials Moving. |
| `latest.academics.program.certificate_lt_4_yr.transportation` | `CIP49CERT4` | integer | 30 | Award of at least two but less than four academic years in Transportation And Materials Moving. |
| `latest.academics.program.bachelors.transportation` | `CIP49BACHL` | integer | 30 | Bachelor's degree in Transportation And Materials Moving. |
| `latest.academics.program.certificate_lt_1_yr.visual_performing` | `CIP50CERT1` | integer | 30 | Certificate of less than one academic year in Visual And Performing Arts. |
| `latest.academics.program.certificate_lt_2_yr.visual_performing` | `CIP50CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Visual And Performing Arts. |
| `latest.academics.program.assoc.visual_performing` | `CIP50ASSOC` | integer | 30 | Associate degree in Visual And Performing Arts. |
| `latest.academics.program.certificate_lt_4_yr.visual_performing` | `CIP50CERT4` | integer | 30 | Award of at least two but less than four academic years in Visual And Performing Arts. |
| `latest.academics.program.bachelors.visual_performing` | `CIP50BACHL` | integer | 30 | Bachelor's degree in Visual And Performing Arts. |
| `latest.academics.program.certificate_lt_1_yr.health` | `CIP51CERT1` | integer | 30 | Certificate of less than one academic year in Health Professions And Related Programs. |
| `latest.academics.program.certificate_lt_2_yr.health` | `CIP51CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Health Professions And Related Programs. |
| `latest.academics.program.assoc.health` | `CIP51ASSOC` | integer | 30 | Associate degree in Health Professions And Related Programs. |
| `latest.academics.program.certificate_lt_4_yr.health` | `CIP51CERT4` | integer | 30 | Award of at least two but less than four academic years in Health Professions And Related Programs. |
| `latest.academics.program.bachelors.health` | `CIP51BACHL` | integer | 30 | Bachelor's degree in Health Professions And Related Programs. |
| `latest.academics.program.certificate_lt_1_yr.business_marketing` | `CIP52CERT1` | integer | 30 | Certificate of less than one academic year in Business, Management, Marketing, And Related Support Services. |
| `latest.academics.program.certificate_lt_2_yr.business_marketing` | `CIP52CERT2` | integer | 30 | Certificate of at least one but less than two academic years in Business, Management, Marketing, And Relate... |
| `latest.academics.program.assoc.business_marketing` | `CIP52ASSOC` | integer | 30 | Associate degree in Business, Management, Marketing, And Related Support Services. |
| `latest.academics.program.certificate_lt_4_yr.business_marketing` | `CIP52CERT4` | integer | 30 | Award of at least two but less than four academic years in Business, Management, Marketing, And Related Sup... |
| `latest.academics.program.bachelors.business_marketing` | `CIP52BACHL` | integer | 30 | Bachelor's degree in Business, Management, Marketing, And Related Support Services. |
| `latest.academics.program.certificate_lt_1_yr.history` | `CIP54CERT1` | integer | 30 | Certificate of less than one academic year in History. |
| `latest.academics.program.certificate_lt_2_yr.history` | `CIP54CERT2` | integer | 30 | Certificate of at least one but less than two academic years in History. |
| `latest.academics.program.assoc.history` | `CIP54ASSOC` | integer | 30 | Associate degree in History. |
| `latest.academics.program.certificate_lt_4_yr.history` | `CIP54CERT4` | integer | 30 | Award of at least two but less than four academic years in History. |
| `latest.academics.program.bachelors.history` | `CIP54BACHL` | integer | 30 | Bachelor's degree in History. |
| `latest.academics.program_reporter.programs_offered` | `PRGMOFR` | integer | 27 | Number of programs offered |
| `latest.academics.program_reporter.program_1.cip_6_digit.code` | `CIPCODE1` | string | 29 | CIP code of largest program |
| `latest.academics.program_reporter.program_2.cip_6_digit.code` | `CIPCODE2` | string | 29 | CIP code of program #2 |
| `latest.academics.program_reporter.program_3.cip_6_digit.code` | `CIPCODE3` | string | 29 | CIP code of program #3 |
| `latest.academics.program_reporter.program_4.cip_6_digit.code` | `CIPCODE4` | string | 29 | CIP code of program #4 |
| `latest.academics.program_reporter.program_5.cip_6_digit.code` | `CIPCODE5` | string | 29 | CIP code of program #5 |
| `latest.academics.program_reporter.program_6.cip_6_digit.code` | `CIPCODE6` | string | 29 | CIP code of program #6 |
| `latest.academics.program_reporter.program_1.cip_6_digit.title` | `CIPTITLE1` | string | 29 | CIP text description of largest program |
| `latest.academics.program_reporter.program_2.cip_6_digit.title` | `CIPTITLE2` | string | 29 | CIP text description of program #2 |
| `latest.academics.program_reporter.program_3.cip_6_digit.title` | `CIPTITLE3` | string | 29 | CIP text description of program #3 |
| `latest.academics.program_reporter.program_4.cip_6_digit.title` | `CIPTITLE4` | string | 29 | CIP text description of program #4 |
| `latest.academics.program_reporter.program_5.cip_6_digit.title` | `CIPTITLE5` | string | 29 | CIP text description of program #5 |
| `latest.academics.program_reporter.program_6.cip_6_digit.title` | `CIPTITLE6` | string | 29 | CIP text description of program #6 |
| `latest.academics.program_reporter.program_1.cip_6_digit.avg_month_completion` | `MTHCMP1` | integer | 19 | Average number of months needed to complete largest program |
| `latest.academics.program_reporter.program_2.cip_6_digit.avg_month_completion` | `MTHCMP2` | integer | 19 | Average number of months needed to complete program #2 |
| `latest.academics.program_reporter.program_3.cip_6_digit.avg_month_completion` | `MTHCMP3` | integer | 19 | Average number of months needed to complete program #3 |
| `latest.academics.program_reporter.program_4.cip_6_digit.avg_month_completion` | `MTHCMP4` | integer | 19 | Average number of months needed to complete program #4 |
| `latest.academics.program_reporter.program_5.cip_6_digit.avg_month_completion` | `MTHCMP5` | integer | 19 | Average number of months needed to complete program #5 |
| `latest.academics.program_reporter.program_6.cip_6_digit.avg_month_completion` | `MTHCMP6` | integer | 19 | Average number of months needed to complete program #6 |

---

## 8. `completion` - 1367 variables

> Whether students finish: 100%/150%/200% completion and outcome rates, broken down by Pell status, loan status, first-gen status, race and time since entry. The single largest category.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.completion.completion_rate_4yr_150nt` | `C150_4` | float | 28 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_less_than_4yr_150nt` | `C150_L4` | float | 28 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_4yr_150nt_pooled` | `C150_4_POOLED` | float | 1 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_less_than_4yr_150nt_pooled` | `C150_L4_POOLED` | float | 1 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.pooled_yrs_used` | `POOLYRS` | integer | 1 | Years used for rolling averages of completion rate C150_[4/L4]_POOLED and transfer rate TRANS_[4/L4]_POOLED |
| `latest.completion.completion_cohort_4yr_150nt` | `D150_4` | integer | 28 | Adjusted cohort count for completion rate at four-year institutions (denominator of 150% completion rate) |
| `latest.completion.completion_cohort_less_than_4yr_150nt` | `D150_L4` | integer | 28 | Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 150% completi... |
| `latest.completion.completion_cohort_4yr_150nt_pooled` | `D150_4_POOLED` | integer | 1 | Adjusted cohort count for completion rate at four-year institutions (denominator of 150% completion rate),... |
| `latest.completion.completion_cohort_less_than_4yr_150nt_pooled` | `D150_L4_POOLED` | integer | 1 | Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 150% completi... |
| `latest.completion.completion_rate_4yr_150_white` | `C150_4_WHITE` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_black` | `C150_4_BLACK` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_hispanic` | `C150_4_HISP` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_asian` | `C150_4_ASIAN` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_aian` | `C150_4_AIAN` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_nhpi` | `C150_4_NHPI` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_2ormore` | `C150_4_2MOR` | float | 17 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_nonresident.alien` | `C150_4_NRA` | float | 28 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_race.unknown` | `C150_4_UNKN` | float | 28 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_white_pre2010` | `C150_4_WHITENH` | float | 14 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_black_pre2010` | `C150_4_BLACKNH` | float | 14 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_api_pre2010` | `C150_4_API` | float | 14 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_aian_pre2010` | `C150_4_AIANOLD` | float | 14 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_4yr_150_hispanic_pre2010` | `C150_4_HISPOLD` | float | 14 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.completion_rate_l4yr_150_white` | `C150_L4_WHITE` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_black` | `C150_L4_BLACK` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_hispanic` | `C150_L4_HISP` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_asian` | `C150_L4_ASIAN` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_aian` | `C150_L4_AIAN` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_nhpi` | `C150_L4_NHPI` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_2ormore` | `C150_L4_2MOR` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_nonresident.alien` | `C150_L4_NRA` | float | 28 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_race.unknown` | `C150_L4_UNKN` | float | 28 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_white_pre2010` | `C150_L4_WHITENH` | float | 14 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_black_pre2010` | `C150_L4_BLACKNH` | float | 14 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_api_pre2010` | `C150_L4_API` | float | 14 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_aian_pre2010` | `C150_L4_AIANOLD` | float | 14 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_l4yr_150_hispanic_pre2010` | `C150_L4_HISPOLD` | float | 14 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.completion_rate_4yr_200nt` | `C200_4` | float | 17 | Completion rate for first-time, full-time bachelor's-degree-seeking students at four-year institutions (200... |
| `latest.completion.completion_rate_less_than_4yr_200nt` | `C200_L4` | float | 17 | Completion rate for first-time, full-time students at less-than-four-year institutions (200% of expected ti... |
| `latest.completion.completion_cohort_4yr_200nt` | `D200_4` | float | 17 | Adjusted cohort count for completion rate at four-year institutions (denominator of 200% completion rate) |
| `latest.completion.completion_cohort_less_than_4yr_200nt` | `D200_L4` | float | 17 | Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 200% completi... |
| `latest.completion.completion_rate_4yr_200nt_pooled` | `C200_4_POOLED` | float | 1 | Completion rate for first-time, full-time bachelor's-degree-seeking students at four-year institutions (200... |
| `latest.completion.completion_rate_less_than_4yr_200nt_pooled` | `C200_L4_POOLED` | float | 1 | Completion rate for first-time, full-time students at less-than-four-year institutions (200% of expected ti... |
| `latest.completion.pooled_yrs_used_200` | `POOLYRS200` | integer | 1 | Years used for rolling averages of completion rate C200_[4/L4]_POOLED |
| `latest.completion.completion_cohort_4yr_200nt_pooled` | `D200_4_POOLED` | float | 1 | Adjusted cohort count for completion rate at four-year institutions (denominator of 200% completion rate),... |
| `latest.completion.completion_cohort_less_than_4yr_200nt_pooled` | `D200_L4_POOLED` | float | 1 | Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 200% completi... |
| `latest.completion.title_iv.died_by.2yrs` | `DEATH_YR2_RT` | float | 22 | Percent died within 2 years at original institution |
| `latest.completion.title_iv.completed_by.2yrs` | `COMP_ORIG_YR2_RT` | float | 22 | Percent completed within 2 years at original institution |
| `latest.completion.title_iv.transf_completed_4yr_by.2yrs` | `COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.transf_completed_2yr_by.2yrs` | `COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.withdrawn_by.2yrs` | `WDRAW_ORIG_YR2_RT` | float | 22 | Percent withdrawn from original institution within 2 years |
| `latest.completion.title_iv.transf_withdrawn_4yr_by.2yrs` | `WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.transf_withdrawn_2yr_by.2yrs` | `WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.still_enrolled_by.2yrs` | `ENRL_ORIG_YR2_RT` | float | 22 | Percent still enrolled at original institution within 2 years |
| `latest.completion.title_iv.transf_still_enrolled_4yr_by.2yrs` | `ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 4-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.transf_still_enrolled_2yr_by.2yrs` | `ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 2-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.unknown_by.2yrs` | `UNKN_ORIG_YR2_RT` | float | 22 | Percent with status unknown within 2 years at original institution |
| `latest.completion.title_iv.transf_unknown_4yr_by.2yrs` | `UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 4-year institution and whose status is unknown within 2 years |
| `latest.completion.title_iv.transf_unknown_2yr_by.2yrs` | `UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent who transferred to a 2-year institution and whose status is unknown within 2 years |
| `latest.completion.title_iv.low_inc.died_by.2yrs` | `LO_INC_DEATH_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who died within 2 years at orig... |
| `latest.completion.title_iv.low_inc.completed_by.2yrs` | `LO_INC_COMP_ORIG_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who completed within 2 years at... |
| `latest.completion.title_iv.low_inc.transf_completed_4yr_by.2yrs` | `LO_INC_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_completed_2yr_by.2yrs` | `LO_INC_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.withdrawn_by.2yrs` | `LO_INC_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institu... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_4yr_by.2yrs` | `LO_INC_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_2yr_by.2yrs` | `LO_INC_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.still_enrolled_by.2yrs` | `LO_INC_ENRL_ORIG_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at orig... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_4yr_by.2yrs` | `LO_INC_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_2yr_by.2yrs` | `LO_INC_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.unknown_by.2yrs` | `LO_INC_UNKN_ORIG_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 2 ye... |
| `latest.completion.title_iv.low_inc.transf_unknown_4yr_by.2yrs` | `LO_INC_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_unknown_2yr_by.2yrs` | `LO_INC_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.mid_inc.died_by.2yrs` | `MD_INC_DEATH_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 2... |
| `latest.completion.title_iv.mid_inc.completed_by.2yrs` | `MD_INC_COMP_ORIG_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed with... |
| `latest.completion.title_iv.mid_inc.transf_completed_4yr_by.2yrs` | `MD_INC_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_completed_2yr_by.2yrs` | `MD_INC_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.withdrawn_by.2yrs` | `MD_INC_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from ori... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_4yr_by.2yrs` | `MD_INC_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_2yr_by.2yrs` | `MD_INC_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.still_enrolled_by.2yrs` | `MD_INC_ENRL_ORIG_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enr... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_4yr_by.2yrs` | `MD_INC_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_2yr_by.2yrs` | `MD_INC_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.unknown_by.2yrs` | `MD_INC_UNKN_ORIG_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknow... |
| `latest.completion.title_iv.mid_inc.transf_unknown_4yr_by.2yrs` | `MD_INC_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_unknown_2yr_by.2yrs` | `MD_INC_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.high_inc.died_by.2yrs` | `HI_INC_DEATH_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who died within 2 years at origina... |
| `latest.completion.title_iv.high_inc.completed_by.2yrs` | `HI_INC_COMP_ORIG_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who completed within 2 years at or... |
| `latest.completion.title_iv.high_inc.transf_completed_4yr_by.2yrs` | `HI_INC_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_completed_2yr_by.2yrs` | `HI_INC_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.withdrawn_by.2yrs` | `HI_INC_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institutio... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_4yr_by.2yrs` | `HI_INC_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_2yr_by.2yrs` | `HI_INC_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.still_enrolled_by.2yrs` | `HI_INC_ENRL_ORIG_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at origina... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_4yr_by.2yrs` | `HI_INC_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_2yr_by.2yrs` | `HI_INC_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.unknown_by.2yrs` | `HI_INC_UNKN_ORIG_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students with status unknown within 2 years... |
| `latest.completion.title_iv.high_inc.transf_unknown_4yr_by.2yrs` | `HI_INC_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_unknown_2yr_by.2yrs` | `HI_INC_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.depend.died_by.2yrs` | `DEP_DEATH_YR2_RT` | float | 22 | Percent of dependent students who died within 2 years at original institution |
| `latest.completion.title_iv.depend.completed_by.2yrs` | `DEP_COMP_ORIG_YR2_RT` | float | 22 | Percent of dependent students who completed within 2 years at original institution |
| `latest.completion.title_iv.depend.transf_completed_4yr_by.2yrs` | `DEP_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.depend.transf_completed_2yr_by.2yrs` | `DEP_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.depend.withdrawn_by.2yrs` | `DEP_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of dependent students withdrawn from original institution within 2 years |
| `latest.completion.title_iv.depend.transf_withdrawn_4yr_by.2yrs` | `DEP_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.depend.transf_withdrawn_2yr_by.2yrs` | `DEP_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.depend.still_enrolled_by.2yrs` | `DEP_ENRL_ORIG_YR2_RT` | float | 22 | Percent of dependent students who were still enrolled at original institution within 2 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_4yr_by.2yrs` | `DEP_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 4-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_2yr_by.2yrs` | `DEP_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 2-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.depend.unknown_by.2yrs` | `DEP_UNKN_ORIG_YR2_RT` | float | 22 | Percent of dependent students with status unknown within 2 years at original institution |
| `latest.completion.title_iv.depend.transf_unknown_4yr_by.2yrs` | `DEP_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 2... |
| `latest.completion.title_iv.depend.transf_unknown_2yr_by.2yrs` | `DEP_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 2... |
| `latest.completion.title_iv.independ.died_by.2yrs` | `IND_DEATH_YR2_RT` | float | 22 | Percent of independent students who died within 2 years at original institution |
| `latest.completion.title_iv.independ.completed_by.2yrs` | `IND_COMP_ORIG_YR2_RT` | float | 22 | Percent of independent students who completed within 2 years at original institution |
| `latest.completion.title_iv.independ.transf_completed_4yr_by.2yrs` | `IND_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.independ.transf_completed_2yr_by.2yrs` | `IND_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.independ.withdrawn_by.2yrs` | `IND_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of independent students withdrawn from original institution within 2 years |
| `latest.completion.title_iv.independ.transf_withdrawn_4yr_by.2yrs` | `IND_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.independ.transf_withdrawn_2yr_by.2yrs` | `IND_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.independ.still_enrolled_by.2yrs` | `IND_ENRL_ORIG_YR2_RT` | float | 22 | Percent of independent students who were still enrolled at original institution within 2 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_4yr_by.2yrs` | `IND_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 4-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_2yr_by.2yrs` | `IND_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 2-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.independ.unknown_by.2yrs` | `IND_UNKN_ORIG_YR2_RT` | float | 22 | Percent of independent students with status unknown within 2 years at original institution |
| `latest.completion.title_iv.independ.transf_unknown_4yr_by.2yrs` | `IND_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 4-year institution and whose status is unknown within... |
| `latest.completion.title_iv.independ.transf_unknown_2yr_by.2yrs` | `IND_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of independent students who transferred to a 2-year institution and whose status is unknown within... |
| `latest.completion.title_iv.female.died_by.2yrs` | `FEMALE_DEATH_YR2_RT` | float | 22 | Percent of female students who died within 2 years at original institution |
| `latest.completion.title_iv.female.completed_by.2yrs` | `FEMALE_COMP_ORIG_YR2_RT` | float | 22 | Percent of female students who completed within 2 years at original institution |
| `latest.completion.title_iv.female.transf_completed_4yr_by.2yrs` | `FEMALE_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.female.transf_completed_2yr_by.2yrs` | `FEMALE_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.female.withdrawn_by.2yrs` | `FEMALE_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of female students withdrawn from original institution within 2 years |
| `latest.completion.title_iv.female.transf_withdrawn_4yr_by.2yrs` | `FEMALE_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.female.transf_withdrawn_2yr_by.2yrs` | `FEMALE_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.female.still_enrolled_by.2yrs` | `FEMALE_ENRL_ORIG_YR2_RT` | float | 22 | Percent of female students who were still enrolled at original institution within 2 years |
| `latest.completion.title_iv.female.transf_still_enrolled_4yr_by.2yrs` | `FEMALE_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 4-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.female.transf_still_enrolled_2yr_by.2yrs` | `FEMALE_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 2-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.female.unknown_by.2yrs` | `FEMALE_UNKN_ORIG_YR2_RT` | float | 22 | Percent of female students with status unknown within 2 years at original institution |
| `latest.completion.title_iv.female.transf_unknown_4yr_by.2yrs` | `FEMALE_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 4-year institution and whose status is unknown within 2 years |
| `latest.completion.title_iv.female.transf_unknown_2yr_by.2yrs` | `FEMALE_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of female students who transferred to a 2-year institution and whose status is unknown within 2 years |
| `latest.completion.title_iv.male.died_by.2yrs` | `MALE_DEATH_YR2_RT` | float | 22 | Percent of male students who died within 2 years at original institution |
| `latest.completion.title_iv.male.completed_by.2yrs` | `MALE_COMP_ORIG_YR2_RT` | float | 22 | Percent of male students who completed within 2 years at original institution |
| `latest.completion.title_iv.male.transf_completed_4yr_by.2yrs` | `MALE_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.male.transf_completed_2yr_by.2yrs` | `MALE_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.male.withdrawn_by.2yrs` | `MALE_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of male students withdrawn from original institution within 2 years |
| `latest.completion.title_iv.male.transf_withdrawn_4yr_by.2yrs` | `MALE_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.male.transf_withdrawn_2yr_by.2yrs` | `MALE_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.male.still_enrolled_by.2yrs` | `MALE_ENRL_ORIG_YR2_RT` | float | 22 | Percent of male students who were still enrolled at original institution within 2 years |
| `latest.completion.title_iv.male.transf_still_enrolled_4yr_by.2yrs` | `MALE_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 4-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.male.transf_still_enrolled_2yr_by.2yrs` | `MALE_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 2-year institution and were still enrolled within 2 years |
| `latest.completion.title_iv.male.unknown_by.2yrs` | `MALE_UNKN_ORIG_YR2_RT` | float | 22 | Percent of male students with status unknown within 2 years at original institution |
| `latest.completion.title_iv.male.transf_unknown_4yr_by.2yrs` | `MALE_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 4-year institution and whose status is unknown within 2 years |
| `latest.completion.title_iv.male.transf_unknown_2yr_by.2yrs` | `MALE_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of male students who transferred to a 2-year institution and whose status is unknown within 2 years |
| `latest.completion.title_iv.pell_recip.died_by.2yrs` | `PELL_DEATH_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who died within 2 years at original in... |
| `latest.completion.title_iv.pell_recip.completed_by.2yrs` | `PELL_COMP_ORIG_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who completed in 2 years at original i... |
| `latest.completion.title_iv.pell_recip.transf_completed_4yr_by.2yrs` | `PELL_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_completed_2yr_by.2yrs` | `PELL_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.withdrawn_by.2yrs` | `PELL_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and withdrew from original institution wit... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_4yr_by.2yrs` | `PELL_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_2yr_by.2yrs` | `PELL_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.still_enrolled_by.2yrs` | `PELL_ENRL_ORIG_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who were still enrolled at original in... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_4yr_by.2yrs` | `PELL_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_2yr_by.2yrs` | `PELL_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.unknown_by.2yrs` | `PELL_UNKN_ORIG_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and with status unknown within 2 years at... |
| `latest.completion.title_iv.pell_recip.transf_unknown_4yr_by.2yrs` | `PELL_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_unknown_2yr_by.2yrs` | `PELL_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.no_pell.died_by.2yrs` | `NOPELL_DEATH_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who died within 2 years at origi... |
| `latest.completion.title_iv.no_pell.completed_by.2yrs` | `NOPELL_COMP_ORIG_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who completed in 2 years at orig... |
| `latest.completion.title_iv.no_pell.transf_completed_4yr_by.2yrs` | `NOPELL_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_completed_2yr_by.2yrs` | `NOPELL_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.withdrawn_by.2yrs` | `NOPELL_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and withdrew from original instituti... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_4yr_by.2yrs` | `NOPELL_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_2yr_by.2yrs` | `NOPELL_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.still_enrolled_by.2yrs` | `NOPELL_ENRL_ORIG_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who were still enrolled at origi... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_4yr_by.2yrs` | `NOPELL_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_2yr_by.2yrs` | `NOPELL_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.unknown_by.2yrs` | `NOPELL_UNKN_ORIG_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and with status unknown within 2 yea... |
| `latest.completion.title_iv.no_pell.transf_unknown_4yr_by.2yrs` | `NOPELL_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_unknown_2yr_by.2yrs` | `NOPELL_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.loan_recip.died_by.2yrs` | `LOAN_DEATH_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who died within 2 years at original... |
| `latest.completion.title_iv.loan_recip.completed_by.2yrs` | `LOAN_COMP_ORIG_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who completed in 2 years at original... |
| `latest.completion.title_iv.loan_recip.transf_completed_4yr_by.2yrs` | `LOAN_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federel loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_completed_2yr_by.2yrs` | `LOAN_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.withdrawn_by.2yrs` | `LOAN_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and withdrew from original institution w... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_4yr_by.2yrs` | `LOAN_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_2yr_by.2yrs` | `LOAN_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.still_enrolled_by.2yrs` | `LOAN_ENRL_ORIG_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who were still enrolled at original... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_4yr_by.2yrs` | `LOAN_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_2yr_by.2yrs` | `LOAN_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.unknown_by.2yrs` | `LOAN_UNKN_ORIG_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and with status unknown within 2 years a... |
| `latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs` | `LOAN_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_unknown_2yr_by.2yrs` | `LOAN_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.no_loan.died_by.2yrs` | `NOLOAN_DEATH_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who died within 2 years at ori... |
| `latest.completion.title_iv.no_loan.completed_by.2yrs` | `NOLOAN_COMP_ORIG_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who completed in 2 years at or... |
| `latest.completion.title_iv.no_loan.transf_completed_4yr_by.2yrs` | `NOLOAN_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_completed_2yr_by.2yrs` | `NOLOAN_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.withdrawn_by.2yrs` | `NOLOAN_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and withdrew from original institu... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_4yr_by.2yrs` | `NOLOAN_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_2yr_by.2yrs` | `NOLOAN_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.still_enrolled_by.2yrs` | `NOLOAN_ENRL_ORIG_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who were still enrolled at ori... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_4yr_by.2yrs` | `NOLOAN_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_2yr_by.2yrs` | `NOLOAN_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.unknown_by.2yrs` | `NOLOAN_UNKN_ORIG_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and with status unknown within 2 y... |
| `latest.completion.title_iv.no_loan.transf_unknown_4yr_by.2yrs` | `NOLOAN_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_unknown_2yr_by.2yrs` | `NOLOAN_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.first_gen.died_by.2yrs` | `FIRSTGEN_DEATH_YR2_RT` | float | 22 | Percent of first-generation students who died within 2 years at original institution |
| `latest.completion.title_iv.first_gen.completed_by.2yrs` | `FIRSTGEN_COMP_ORIG_YR2_RT` | float | 22 | Percent of first-generation students who completed within 2 years at original institution |
| `latest.completion.title_iv.first_gen.transf_completed_4yr_by.2yrs` | `FIRSTGEN_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.first_gen.transf_completed_2yr_by.2yrs` | `FIRSTGEN_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.first_gen.withdrawn_by.2yrs` | `FIRSTGEN_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of first-generation students withdrawn from original institution within 2 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_4yr_by.2yrs` | `FIRSTGEN_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_2yr_by.2yrs` | `FIRSTGEN_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.first_gen.still_enrolled_by.2yrs` | `FIRSTGEN_ENRL_ORIG_YR2_RT` | float | 22 | Percent of first-generation students who were still enrolled at original institution within 2 years |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_4yr_by.2yrs` | `FIRSTGEN_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 4-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_2yr_by.2yrs` | `FIRSTGEN_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 2-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.unknown_by.2yrs` | `FIRSTGEN_UNKN_ORIG_YR2_RT` | float | 22 | Percent of first-generation students with status unknown within 2 years at original institution |
| `latest.completion.title_iv.first_gen.transf_unknown_4yr_by.2yrs` | `FIRSTGEN_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 4-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.first_gen.transf_unknown_2yr_by.2yrs` | `FIRSTGEN_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of first-generation students who transferred to a 2-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.not_first_gen.died_by.2yrs` | `NOT1STGEN_DEATH_YR2_RT` | float | 22 | Percent of not-first-generation students who died within 2 years at original institution |
| `latest.completion.title_iv.not_first_gen.completed_by.2yrs` | `NOT1STGEN_COMP_ORIG_YR2_RT` | float | 22 | Percent of not-first-generation students who completed within 2 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_completed_4yr_by.2yrs` | `NOT1STGEN_COMP_4YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 4-year institution and completed within 2 years |
| `latest.completion.title_iv.not_first_gen.transf_completed_2yr_by.2yrs` | `NOT1STGEN_COMP_2YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 2-year institution and completed within 2 years |
| `latest.completion.title_iv.not_first_gen.withdrawn_by.2yrs` | `NOT1STGEN_WDRAW_ORIG_YR2_RT` | float | 22 | Percent of not-first-generation students withdrawn from original institution within 2 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_4yr_by.2yrs` | `NOT1STGEN_WDRAW_4YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 2 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_2yr_by.2yrs` | `NOT1STGEN_WDRAW_2YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 2 years |
| `latest.completion.title_iv.not_first_gen.still_enrolled_by.2yrs` | `NOT1STGEN_ENRL_ORIG_YR2_RT` | float | 22 | Percent of not-first-generation students who were still enrolled at original institution within 2 years |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_4yr_by.2yrs` | `NOT1STGEN_ENRL_4YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_2yr_by.2yrs` | `NOT1STGEN_ENRL_2YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.unknown_by.2yrs` | `NOT1STGEN_UNKN_ORIG_YR2_RT` | float | 22 | Percent of not-first-generation students with status unknown within 2 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_unknown_4yr_by.2yrs` | `NOT1STGEN_UNKN_4YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknow... |
| `latest.completion.title_iv.not_first_gen.transf_unknown_2yr_by.2yrs` | `NOT1STGEN_UNKN_2YR_TRANS_YR2_RT` | float | 22 | Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknow... |
| `latest.completion.title_iv.died_by.3yrs` | `DEATH_YR3_RT` | float | 21 | Percent died within 3 years at original institution |
| `latest.completion.title_iv.completed_by.3yrs` | `COMP_ORIG_YR3_RT` | float | 21 | Percent completed within 3 years at original institution |
| `latest.completion.title_iv.transf_completed_4yr_by.3yrs` | `COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.transf_completed_2yr_by.3yrs` | `COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.withdrawn_by.3yrs` | `WDRAW_ORIG_YR3_RT` | float | 21 | Percent withdrawn from original institution within 3 years |
| `latest.completion.title_iv.transf_withdrawn_4yr_by.3yrs` | `WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.transf_withdrawn_2yr_by.3yrs` | `WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.still_enrolled_by.3yrs` | `ENRL_ORIG_YR3_RT` | float | 21 | Percent still enrolled at original institution within 3 years |
| `latest.completion.title_iv.transf_still_enrolled_4yr_by.3yrs` | `ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 4-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.transf_still_enrolled_2yr_by.3yrs` | `ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 2-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.unknown_by.3yrs` | `UNKN_ORIG_YR3_RT` | float | 21 | Percent with status unknown within 3 years at original institution |
| `latest.completion.title_iv.transf_unknown_4yr_by.3yrs` | `UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 4-year institution and whose status is unknown within 3 years |
| `latest.completion.title_iv.transf_unknown_2yr_by.3yrs` | `UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent who transferred to a 2-year institution and whose status is unknown within 3 years |
| `latest.completion.title_iv.low_inc.died_by.3yrs` | `LO_INC_DEATH_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who died within 3 years at orig... |
| `latest.completion.title_iv.low_inc.completed_by.3yrs` | `LO_INC_COMP_ORIG_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who completed within 3 years at... |
| `latest.completion.title_iv.low_inc.transf_completed_4yr_by.3yrs` | `LO_INC_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_completed_2yr_by.3yrs` | `LO_INC_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.withdrawn_by.3yrs` | `LO_INC_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institu... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_4yr_by.3yrs` | `LO_INC_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_2yr_by.3yrs` | `LO_INC_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.still_enrolled_by.3yrs` | `LO_INC_ENRL_ORIG_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at orig... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_4yr_by.3yrs` | `LO_INC_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_2yr_by.3yrs` | `LO_INC_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.unknown_by.3yrs` | `LO_INC_UNKN_ORIG_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 3 ye... |
| `latest.completion.title_iv.low_inc.transf_unknown_4yr_by.3yrs` | `LO_INC_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_unknown_2yr_by.3yrs` | `LO_INC_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.mid_inc.died_by.3yrs` | `MD_INC_DEATH_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 3... |
| `latest.completion.title_iv.mid_inc.completed_by.3yrs` | `MD_INC_COMP_ORIG_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed with... |
| `latest.completion.title_iv.mid_inc.transf_completed_4yr_by.3yrs` | `MD_INC_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_completed_2yr_by.3yrs` | `MD_INC_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.withdrawn_by.3yrs` | `MD_INC_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from ori... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_4yr_by.3yrs` | `MD_INC_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_2yr_by.3yrs` | `MD_INC_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.still_enrolled_by.3yrs` | `MD_INC_ENRL_ORIG_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enr... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_4yr_by.3yrs` | `MD_INC_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_2yr_by.3yrs` | `MD_INC_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.unknown_by.3yrs` | `MD_INC_UNKN_ORIG_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknow... |
| `latest.completion.title_iv.mid_inc.transf_unknown_4yr_by.3yrs` | `MD_INC_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_unknown_2yr_by.3yrs` | `MD_INC_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.high_inc.died_by.3yrs` | `HI_INC_DEATH_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who died within 3 years at origina... |
| `latest.completion.title_iv.high_inc.completed_by.3yrs` | `HI_INC_COMP_ORIG_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who completed within 3 years at or... |
| `latest.completion.title_iv.high_inc.transf_completed_4yr_by.3yrs` | `HI_INC_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_completed_2yr_by.3yrs` | `HI_INC_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.withdrawn_by.3yrs` | `HI_INC_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institutio... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_4yr_by.3yrs` | `HI_INC_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_2yr_by.3yrs` | `HI_INC_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.still_enrolled_by.3yrs` | `HI_INC_ENRL_ORIG_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at origina... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_4yr_by.3yrs` | `HI_INC_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_2yr_by.3yrs` | `HI_INC_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.unknown_by.3yrs` | `HI_INC_UNKN_ORIG_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students with status unknown within 3 years... |
| `latest.completion.title_iv.high_inc.transf_unknown_4yr_by.3yrs` | `HI_INC_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_unknown_2yr_by.3yrs` | `HI_INC_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.depend.died_by.3yrs` | `DEP_DEATH_YR3_RT` | float | 21 | Percent of dependent students who died within 3 years at original institution |
| `latest.completion.title_iv.depend.completed_by.3yrs` | `DEP_COMP_ORIG_YR3_RT` | float | 21 | Percent of dependent students who completed within 3 years at original institution |
| `latest.completion.title_iv.depend.transf_completed_4yr_by.3yrs` | `DEP_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.depend.transf_completed_2yr_by.3yrs` | `DEP_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.depend.withdrawn_by.3yrs` | `DEP_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of dependent students withdrawn from original institution within 3 years |
| `latest.completion.title_iv.depend.transf_withdrawn_4yr_by.3yrs` | `DEP_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.depend.transf_withdrawn_2yr_by.3yrs` | `DEP_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.depend.still_enrolled_by.3yrs` | `DEP_ENRL_ORIG_YR3_RT` | float | 21 | Percent of dependent students who were still enrolled at original institution within 3 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_4yr_by.3yrs` | `DEP_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 4-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_2yr_by.3yrs` | `DEP_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 2-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.depend.unknown_by.3yrs` | `DEP_UNKN_ORIG_YR3_RT` | float | 21 | Percent of dependent students with status unknown within 3 years at original institution |
| `latest.completion.title_iv.depend.transf_unknown_4yr_by.3yrs` | `DEP_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 3... |
| `latest.completion.title_iv.depend.transf_unknown_2yr_by.3yrs` | `DEP_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 3... |
| `latest.completion.title_iv.independ.died_by.3yrs` | `IND_DEATH_YR3_RT` | float | 21 | Percent of independent students who died within 3 years at original institution |
| `latest.completion.title_iv.independ.completed_by.3yrs` | `IND_COMP_ORIG_YR3_RT` | float | 21 | Percent of independent students who completed within 3 years at original institution |
| `latest.completion.title_iv.independ.transf_completed_4yr_by.3yrs` | `IND_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.independ.transf_completed_2yr_by.3yrs` | `IND_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.independ.withdrawn_by.3yrs` | `IND_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of independent students withdrawn from original institution within 3 years |
| `latest.completion.title_iv.independ.transf_withdrawn_4yr_by.3yrs` | `IND_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.independ.transf_withdrawn_2yr_by.3yrs` | `IND_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.independ.still_enrolled_by.3yrs` | `IND_ENRL_ORIG_YR3_RT` | float | 21 | Percent of independent students who were still enrolled at original institution within 3 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_4yr_by.3yrs` | `IND_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 4-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_2yr_by.3yrs` | `IND_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 2-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.independ.unknown_by.3yrs` | `IND_UNKN_ORIG_YR3_RT` | float | 21 | Percent of independent students with status unknown within 3 years at original institution |
| `latest.completion.title_iv.independ.transf_unknown_4yr_by.3yrs` | `IND_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 4-year institution and whose status is unknown within... |
| `latest.completion.title_iv.independ.transf_unknown_2yr_by.3yrs` | `IND_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of independent students who transferred to a 2-year institution and whose status is unknown within... |
| `latest.completion.title_iv.female.died_by.3yrs` | `FEMALE_DEATH_YR3_RT` | float | 21 | Percent of female students who died within 3 years at original institution |
| `latest.completion.title_iv.female.completed_by.3yrs` | `FEMALE_COMP_ORIG_YR3_RT` | float | 21 | Percent of female students who completed within 3 years at original institution |
| `latest.completion.title_iv.female.transf_completed_4yr_by.3yrs` | `FEMALE_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.female.transf_completed_2yr_by.3yrs` | `FEMALE_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.female.withdrawn_by.3yrs` | `FEMALE_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of female students withdrawn from original institution within 3 years |
| `latest.completion.title_iv.female.transf_withdrawn_4yr_by.3yrs` | `FEMALE_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.female.transf_withdrawn_2yr_by.3yrs` | `FEMALE_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.female.still_enrolled_by.3yrs` | `FEMALE_ENRL_ORIG_YR3_RT` | float | 21 | Percent of female students who were still enrolled at original institution within 3 years |
| `latest.completion.title_iv.female.transf_still_enrolled_4yr_by.3yrs` | `FEMALE_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 4-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.female.transf_still_enrolled_2yr_by.3yrs` | `FEMALE_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 2-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.female.unknown_by.3yrs` | `FEMALE_UNKN_ORIG_YR3_RT` | float | 21 | Percent of female students with status unknown within 3 years at original institution |
| `latest.completion.title_iv.female.transf_unknown_4yr_by.3yrs` | `FEMALE_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 4-year institution and whose status is unknown within 3 years |
| `latest.completion.title_iv.female.transf_unknown_2yr_by.3yrs` | `FEMALE_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of female students who transferred to a 2-year institution and whose status is unknown within 3 years |
| `latest.completion.title_iv.male.died_by.3yrs` | `MALE_DEATH_YR3_RT` | float | 21 | Percent of male students who died within 3 years at original institution |
| `latest.completion.title_iv.male.completed_by.3yrs` | `MALE_COMP_ORIG_YR3_RT` | float | 21 | Percent of male students who completed within 3 years at original institution |
| `latest.completion.title_iv.male.transf_completed_4yr_by.3yrs` | `MALE_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.male.transf_completed_2yr_by.3yrs` | `MALE_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.male.withdrawn_by.3yrs` | `MALE_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of male students withdrawn from original institution within 3 years |
| `latest.completion.title_iv.male.transf_withdrawn_4yr_by.3yrs` | `MALE_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.male.transf_withdrawn_2yr_by.3yrs` | `MALE_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.male.still_enrolled_by.3yrs` | `MALE_ENRL_ORIG_YR3_RT` | float | 21 | Percent of male students who were still enrolled at original institution within 3 years |
| `latest.completion.title_iv.male.transf_still_enrolled_4yr_by.3yrs` | `MALE_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 4-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.male.transf_still_enrolled_2yr_by.3yrs` | `MALE_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 2-year institution and were still enrolled within 3 years |
| `latest.completion.title_iv.male.unknown_by.3yrs` | `MALE_UNKN_ORIG_YR3_RT` | float | 21 | Percent of male students with status unknown within 3 years at original institution |
| `latest.completion.title_iv.male.transf_unknown_4yr_by.3yrs` | `MALE_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 4-year institution and whose status is unknown within 3 years |
| `latest.completion.title_iv.male.transf_unknown_2yr_by.3yrs` | `MALE_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of male students who transferred to a 2-year institution and whose status is unknown within 3 years |
| `latest.completion.title_iv.pell_recip.died_by.3yrs` | `PELL_DEATH_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who died within 3 years at original in... |
| `latest.completion.title_iv.pell_recip.completed_by.3yrs` | `PELL_COMP_ORIG_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who completed in 3 years at original i... |
| `latest.completion.title_iv.pell_recip.transf_completed_4yr_by.3yrs` | `PELL_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_completed_2yr_by.3yrs` | `PELL_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.withdrawn_by.3yrs` | `PELL_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and withdrew from original institution wit... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_4yr_by.3yrs` | `PELL_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_2yr_by.3yrs` | `PELL_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.still_enrolled_by.3yrs` | `PELL_ENRL_ORIG_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who were still enrolled at original in... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_4yr_by.3yrs` | `PELL_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_2yr_by.3yrs` | `PELL_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.unknown_by.3yrs` | `PELL_UNKN_ORIG_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and with status unknown within 3 years at... |
| `latest.completion.title_iv.pell_recip.transf_unknown_4yr_by.3yrs` | `PELL_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_unknown_2yr_by.3yrs` | `PELL_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.no_pell.died_by.3yrs` | `NOPELL_DEATH_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who died within 3 years at origi... |
| `latest.completion.title_iv.no_pell.completed_by.3yrs` | `NOPELL_COMP_ORIG_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who completed in 3 years at orig... |
| `latest.completion.title_iv.no_pell.transf_completed_4yr_by.3yrs` | `NOPELL_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_completed_2yr_by.3yrs` | `NOPELL_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.withdrawn_by.3yrs` | `NOPELL_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and withdrew from original instituti... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_4yr_by.3yrs` | `NOPELL_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_2yr_by.3yrs` | `NOPELL_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.still_enrolled_by.3yrs` | `NOPELL_ENRL_ORIG_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who were still enrolled at origi... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_4yr_by.3yrs` | `NOPELL_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_2yr_by.3yrs` | `NOPELL_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.unknown_by.3yrs` | `NOPELL_UNKN_ORIG_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and with status unknown within 3 yea... |
| `latest.completion.title_iv.no_pell.transf_unknown_4yr_by.3yrs` | `NOPELL_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_unknown_2yr_by.3yrs` | `NOPELL_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.loan_recip.died_by.3yrs` | `LOAN_DEATH_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who died within 3 years at original... |
| `latest.completion.title_iv.loan_recip.completed_by.3yrs` | `LOAN_COMP_ORIG_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who completed in 3 years at original... |
| `latest.completion.title_iv.loan_recip.transf_completed_4yr_by.3yrs` | `LOAN_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_completed_2yr_by.3yrs` | `LOAN_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.withdrawn_by.3yrs` | `LOAN_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and withdrew from original institution w... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_4yr_by.3yrs` | `LOAN_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_2yr_by.3yrs` | `LOAN_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.still_enrolled_by.3yrs` | `LOAN_ENRL_ORIG_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who were still enrolled at original... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_4yr_by.3yrs` | `LOAN_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_2yr_by.3yrs` | `LOAN_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.unknown_by.3yrs` | `LOAN_UNKN_ORIG_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and with status unknown within 3 years a... |
| `latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.3yrs` | `LOAN_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_unknown_2yr_by.3yrs` | `LOAN_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.no_loan.died_by.3yrs` | `NOLOAN_DEATH_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who died within 3 years at ori... |
| `latest.completion.title_iv.no_loan.completed_by.3yrs` | `NOLOAN_COMP_ORIG_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who completed in 3 years at or... |
| `latest.completion.title_iv.no_loan.transf_completed_4yr_by.3yrs` | `NOLOAN_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_completed_2yr_by.3yrs` | `NOLOAN_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.withdrawn_by.3yrs` | `NOLOAN_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and withdrew from original institu... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_4yr_by.3yrs` | `NOLOAN_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_2yr_by.3yrs` | `NOLOAN_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.still_enrolled_by.3yrs` | `NOLOAN_ENRL_ORIG_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who were still enrolled at ori... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_4yr_by.3yrs` | `NOLOAN_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_2yr_by.3yrs` | `NOLOAN_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.unknown_by.3yrs` | `NOLOAN_UNKN_ORIG_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and with status unknown within 3 y... |
| `latest.completion.title_iv.no_loan.transf_unknown_4yr_by.3yrs` | `NOLOAN_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_unknown_2yr_by.3yrs` | `NOLOAN_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.first_gen.died_by.3yrs` | `FIRSTGEN_DEATH_YR3_RT` | float | 21 | Percent of first-generation students who died within 3 years at original institution |
| `latest.completion.title_iv.first_gen.completed_by.3yrs` | `FIRSTGEN_COMP_ORIG_YR3_RT` | float | 21 | Percent of first-generation students who completed within 3 years at original institution |
| `latest.completion.title_iv.first_gen.transf_completed_4yr_by.3yrs` | `FIRSTGEN_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.first_gen.transf_completed_2yr_by.3yrs` | `FIRSTGEN_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.first_gen.withdrawn_by.3yrs` | `FIRSTGEN_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of first-generation students withdrawn from original institution within 3 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_4yr_by.3yrs` | `FIRSTGEN_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_2yr_by.3yrs` | `FIRSTGEN_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.first_gen.still_enrolled_by.3yrs` | `FIRSTGEN_ENRL_ORIG_YR3_RT` | float | 21 | Percent of first-generation students who were still enrolled at original institution within 3 years |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_4yr_by.3yrs` | `FIRSTGEN_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 4-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_2yr_by.3yrs` | `FIRSTGEN_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 2-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.unknown_by.3yrs` | `FIRSTGEN_UNKN_ORIG_YR3_RT` | float | 21 | Percent of first-generation students with status unknown within 3 years at original institution |
| `latest.completion.title_iv.first_gen.transf_unknown_4yr_by.3yrs` | `FIRSTGEN_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 4-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.first_gen.transf_unknown_2yr_by.3yrs` | `FIRSTGEN_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of first-generation students who transferred to a 2-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.not_first_gen.died_by.3yrs` | `NOT1STGEN_DEATH_YR3_RT` | float | 21 | Percent of not-first-generation students who died within 3 years at original institution |
| `latest.completion.title_iv.not_first_gen.completed_by.3yrs` | `NOT1STGEN_COMP_ORIG_YR3_RT` | float | 21 | Percent of not-first-generation students who completed within 3 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_completed_4yr_by.3yrs` | `NOT1STGEN_COMP_4YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 4-year institution and completed within 3 years |
| `latest.completion.title_iv.not_first_gen.transf_completed_2yr_by.3yrs` | `NOT1STGEN_COMP_2YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 2-year institution and completed within 3 years |
| `latest.completion.title_iv.not_first_gen.withdrawn_by.3yrs` | `NOT1STGEN_WDRAW_ORIG_YR3_RT` | float | 21 | Percent of not-first-generation students withdrawn from original institution within 3 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_4yr_by.3yrs` | `NOT1STGEN_WDRAW_4YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 3 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_2yr_by.3yrs` | `NOT1STGEN_WDRAW_2YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 3 years |
| `latest.completion.title_iv.not_first_gen.still_enrolled_by.3yrs` | `NOT1STGEN_ENRL_ORIG_YR3_RT` | float | 21 | Percent of not-first-generation students who were still enrolled at original institution within 3 years |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_4yr_by.3yrs` | `NOT1STGEN_ENRL_4YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_2yr_by.3yrs` | `NOT1STGEN_ENRL_2YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.unknown_by.3yrs` | `NOT1STGEN_UNKN_ORIG_YR3_RT` | float | 21 | Percent of not-first-generation students with status unknown within 3 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_unknown_4yr_by.3yrs` | `NOT1STGEN_UNKN_4YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknow... |
| `latest.completion.title_iv.not_first_gen.transf_unknown_2yr_by.3yrs` | `NOT1STGEN_UNKN_2YR_TRANS_YR3_RT` | float | 21 | Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknow... |
| `latest.completion.title_iv.died_by.4yrs` | `DEATH_YR4_RT` | float | 20 | Percent died within 4 years at original institution |
| `latest.completion.title_iv.completed_by.4yrs` | `COMP_ORIG_YR4_RT` | float | 20 | Percent completed within 4 years at original institution |
| `latest.completion.title_iv.transf_completed_4yr_by.4yrs` | `COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.transf_completed_2yr_by.4yrs` | `COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.withdrawn_by.4yrs` | `WDRAW_ORIG_YR4_RT` | float | 20 | Percent withdrawn from original institution within 4 years |
| `latest.completion.title_iv.transf_withdrawn_4yr_by.4yrs` | `WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.transf_withdrawn_2yr_by.4yrs` | `WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.still_enrolled_by.4yrs` | `ENRL_ORIG_YR4_RT` | float | 20 | Percent still enrolled at original institution within 4 years |
| `latest.completion.title_iv.transf_still_enrolled_4yr_by.4yrs` | `ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 4-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.transf_still_enrolled_2yr_by.4yrs` | `ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 2-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.unknown_by.4yrs` | `UNKN_ORIG_YR4_RT` | float | 20 | Percent with status unknown within 4 years at original institution |
| `latest.completion.title_iv.transf_unknown_4yr_by.4yrs` | `UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 4-year institution and whose status is unknown within 4 years |
| `latest.completion.title_iv.transf_unknown_2yr_by.4yrs` | `UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent who transferred to a 2-year institution and whose status is unknown within 4 years |
| `latest.completion.title_iv.low_inc.died_by.4yrs` | `LO_INC_DEATH_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who died within 4 years at orig... |
| `latest.completion.title_iv.low_inc.completed_by.4yrs` | `LO_INC_COMP_ORIG_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who completed within 4 years at... |
| `latest.completion.title_iv.low_inc.transf_completed_4yr_by.4yrs` | `LO_INC_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_completed_2yr_by.4yrs` | `LO_INC_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.withdrawn_by.4yrs` | `LO_INC_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institu... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_4yr_by.4yrs` | `LO_INC_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_2yr_by.4yrs` | `LO_INC_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.still_enrolled_by.4yrs` | `LO_INC_ENRL_ORIG_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at orig... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_4yr_by.4yrs` | `LO_INC_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_2yr_by.4yrs` | `LO_INC_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.unknown_by.4yrs` | `LO_INC_UNKN_ORIG_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 4 ye... |
| `latest.completion.title_iv.low_inc.transf_unknown_4yr_by.4yrs` | `LO_INC_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_unknown_2yr_by.4yrs` | `LO_INC_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.mid_inc.died_by.4yrs` | `MD_INC_DEATH_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 4... |
| `latest.completion.title_iv.mid_inc.completed_by.4yrs` | `MD_INC_COMP_ORIG_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed with... |
| `latest.completion.title_iv.mid_inc.transf_completed_4yr_by.4yrs` | `MD_INC_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_completed_2yr_by.4yrs` | `MD_INC_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.withdrawn_by.4yrs` | `MD_INC_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from ori... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_4yr_by.4yrs` | `MD_INC_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_2yr_by.4yrs` | `MD_INC_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.still_enrolled_by.4yrs` | `MD_INC_ENRL_ORIG_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enr... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_4yr_by.4yrs` | `MD_INC_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_2yr_by.4yrs` | `MD_INC_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.unknown_by.4yrs` | `MD_INC_UNKN_ORIG_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknow... |
| `latest.completion.title_iv.mid_inc.transf_unknown_4yr_by.4yrs` | `MD_INC_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_unknown_2yr_by.4yrs` | `MD_INC_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.high_inc.died_by.4yrs` | `HI_INC_DEATH_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who died within 4 years at origina... |
| `latest.completion.title_iv.high_inc.completed_by.4yrs` | `HI_INC_COMP_ORIG_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who completed within 4 years at or... |
| `latest.completion.title_iv.high_inc.transf_completed_4yr_by.4yrs` | `HI_INC_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_completed_2yr_by.4yrs` | `HI_INC_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.withdrawn_by.4yrs` | `HI_INC_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institutio... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_4yr_by.4yrs` | `HI_INC_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_2yr_by.4yrs` | `HI_INC_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.still_enrolled_by.4yrs` | `HI_INC_ENRL_ORIG_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at origina... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_4yr_by.4yrs` | `HI_INC_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_2yr_by.4yrs` | `HI_INC_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.unknown_by.4yrs` | `HI_INC_UNKN_ORIG_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students with status unknown within 4 years... |
| `latest.completion.title_iv.high_inc.transf_unknown_4yr_by.4yrs` | `HI_INC_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_unknown_2yr_by.4yrs` | `HI_INC_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.depend.died_by.4yrs` | `DEP_DEATH_YR4_RT` | float | 20 | Percent of dependent students who died within 4 years at original institution |
| `latest.completion.title_iv.depend.completed_by.4yrs` | `DEP_COMP_ORIG_YR4_RT` | float | 20 | Percent of dependent students who completed within 4 years at original institution |
| `latest.completion.title_iv.depend.transf_completed_4yr_by.4yrs` | `DEP_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.depend.transf_completed_2yr_by.4yrs` | `DEP_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.depend.withdrawn_by.4yrs` | `DEP_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of dependent students withdrawn from original institution within 4 years |
| `latest.completion.title_iv.depend.transf_withdrawn_4yr_by.4yrs` | `DEP_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.depend.transf_withdrawn_2yr_by.4yrs` | `DEP_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.depend.still_enrolled_by.4yrs` | `DEP_ENRL_ORIG_YR4_RT` | float | 20 | Percent of dependent students who were still enrolled at original institution within 4 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_4yr_by.4yrs` | `DEP_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 4-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_2yr_by.4yrs` | `DEP_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 2-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.depend.unknown_by.4yrs` | `DEP_UNKN_ORIG_YR4_RT` | float | 20 | Percent of dependent students with status unknown within 4 years at original institution |
| `latest.completion.title_iv.depend.transf_unknown_4yr_by.4yrs` | `DEP_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 4... |
| `latest.completion.title_iv.depend.transf_unknown_2yr_by.4yrs` | `DEP_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 4... |
| `latest.completion.title_iv.independ.died_by.4yrs` | `IND_DEATH_YR4_RT` | float | 20 | Percent of independent students who died within 4 years at original institution |
| `latest.completion.title_iv.independ.completed_by.4yrs` | `IND_COMP_ORIG_YR4_RT` | float | 20 | Percent of independent students who completed within 4 years at original institution |
| `latest.completion.title_iv.independ.transf_completed_4yr_by.4yrs` | `IND_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.independ.transf_completed_2yr_by.4yrs` | `IND_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.independ.withdrawn_by.4yrs` | `IND_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of independent students withdrawn from original institution within 4 years |
| `latest.completion.title_iv.independ.transf_withdrawn_4yr_by.4yrs` | `IND_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.independ.transf_withdrawn_2yr_by.4yrs` | `IND_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.independ.still_enrolled_by.4yrs` | `IND_ENRL_ORIG_YR4_RT` | float | 20 | Percent of independent students who were still enrolled at original institution within 4 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_4yr_by.4yrs` | `IND_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 4-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_2yr_by.4yrs` | `IND_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 2-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.independ.unknown_by.4yrs` | `IND_UNKN_ORIG_YR4_RT` | float | 20 | Percent of independent students with status unknown within 4 years at original institution |
| `latest.completion.title_iv.independ.transf_unknown_4yr_by.4yrs` | `IND_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 4-year institution and whose status is unknown within... |
| `latest.completion.title_iv.independ.transf_unknown_2yr_by.4yrs` | `IND_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of independent students who transferred to a 2-year institution and whose status is unknown within... |
| `latest.completion.title_iv.female.died_by.4yrs` | `FEMALE_DEATH_YR4_RT` | float | 20 | Percent of female students who died within 4 years at original institution |
| `latest.completion.title_iv.female.completed_by.4yrs` | `FEMALE_COMP_ORIG_YR4_RT` | float | 20 | Percent of female students who completed within 4 years at original institution |
| `latest.completion.title_iv.female.transf_completed_4yr_by.4yrs` | `FEMALE_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.female.transf_completed_2yr_by.4yrs` | `FEMALE_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.female.withdrawn_by.4yrs` | `FEMALE_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of female students withdrawn from original institution within 4 years |
| `latest.completion.title_iv.female.transf_withdrawn_4yr_by.4yrs` | `FEMALE_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.female.transf_withdrawn_2yr_by.4yrs` | `FEMALE_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.female.still_enrolled_by.4yrs` | `FEMALE_ENRL_ORIG_YR4_RT` | float | 20 | Percent of female students who were still enrolled at original institution within 4 years |
| `latest.completion.title_iv.female.transf_still_enrolled_4yr_by.4yrs` | `FEMALE_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 4-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.female.transf_still_enrolled_2yr_by.4yrs` | `FEMALE_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 2-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.female.unknown_by.4yrs` | `FEMALE_UNKN_ORIG_YR4_RT` | float | 20 | Percent of female students with status unknown within 4 years at original institution |
| `latest.completion.title_iv.female.transf_unknown_4yr_by.4yrs` | `FEMALE_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 4-year institution and whose status is unknown within 4 years |
| `latest.completion.title_iv.female.transf_unknown_2yr_by.4yrs` | `FEMALE_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of female students who transferred to a 2-year institution and whose status is unknown within 4 years |
| `latest.completion.title_iv.male.died_by.4yrs` | `MALE_DEATH_YR4_RT` | float | 20 | Percent of male students who died within 4 years at original institution |
| `latest.completion.title_iv.male.completed_by.4yrs` | `MALE_COMP_ORIG_YR4_RT` | float | 20 | Percent of male students who completed within 4 years at original institution |
| `latest.completion.title_iv.male.transf_completed_4yr_by.4yrs` | `MALE_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.male.transf_completed_2yr_by.4yrs` | `MALE_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.male.withdrawn_by.4yrs` | `MALE_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of male students withdrawn from original institution within 4 years |
| `latest.completion.title_iv.male.transf_withdrawn_4yr_by.4yrs` | `MALE_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.male.transf_withdrawn_2yr_by.4yrs` | `MALE_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.male.still_enrolled_by.4yrs` | `MALE_ENRL_ORIG_YR4_RT` | float | 20 | Percent of male students who were still enrolled at original institution within 4 years |
| `latest.completion.title_iv.male.transf_still_enrolled_4yr_by.4yrs` | `MALE_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 4-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.male.transf_still_enrolled_2yr_by.4yrs` | `MALE_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 2-year institution and were still enrolled within 4 years |
| `latest.completion.title_iv.male.unknown_by.4yrs` | `MALE_UNKN_ORIG_YR4_RT` | float | 20 | Percent of male students with status unknown within 4 years at original institution |
| `latest.completion.title_iv.male.transf_unknown_4yr_by.4yrs` | `MALE_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 4-year institution and whose status is unknown within 4 years |
| `latest.completion.title_iv.male.transf_unknown_2yr_by.4yrs` | `MALE_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of male students who transferred to a 2-year institution and whose status is unknown within 4 years |
| `latest.completion.title_iv.pell_recip.died_by.4yrs` | `PELL_DEATH_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who died within 4 years at original in... |
| `latest.completion.title_iv.pell_recip.completed_by.4yrs` | `PELL_COMP_ORIG_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who completed in 4 years at original i... |
| `latest.completion.title_iv.pell_recip.transf_completed_4yr_by.4yrs` | `PELL_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_completed_2yr_by.4yrs` | `PELL_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.withdrawn_by.4yrs` | `PELL_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and withdrew from original institution wit... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_4yr_by.4yrs` | `PELL_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_2yr_by.4yrs` | `PELL_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.still_enrolled_by.4yrs` | `PELL_ENRL_ORIG_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who were still enrolled at original in... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_4yr_by.4yrs` | `PELL_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_2yr_by.4yrs` | `PELL_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.unknown_by.4yrs` | `PELL_UNKN_ORIG_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and with status unknown within 4 years at... |
| `latest.completion.title_iv.pell_recip.transf_unknown_4yr_by.4yrs` | `PELL_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_unknown_2yr_by.4yrs` | `PELL_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.no_pell.died_by.4yrs` | `NOPELL_DEATH_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who died within 4 years at origi... |
| `latest.completion.title_iv.no_pell.completed_by.4yrs` | `NOPELL_COMP_ORIG_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who completed in 4 years at orig... |
| `latest.completion.title_iv.no_pell.transf_completed_4yr_by.4yrs` | `NOPELL_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_completed_2yr_by.4yrs` | `NOPELL_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.withdrawn_by.4yrs` | `NOPELL_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and withdrew from original instituti... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_4yr_by.4yrs` | `NOPELL_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_2yr_by.4yrs` | `NOPELL_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.still_enrolled_by.4yrs` | `NOPELL_ENRL_ORIG_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who were still enrolled at origi... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_4yr_by.4yrs` | `NOPELL_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_2yr_by.4yrs` | `NOPELL_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.unknown_by.4yrs` | `NOPELL_UNKN_ORIG_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and with status unknown within 4 yea... |
| `latest.completion.title_iv.no_pell.transf_unknown_4yr_by.4yrs` | `NOPELL_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_unknown_2yr_by.4yrs` | `NOPELL_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.loan_recip.died_by.4yrs` | `LOAN_DEATH_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who died within 4 years at original... |
| `latest.completion.title_iv.loan_recip.completed_by.4yrs` | `LOAN_COMP_ORIG_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who completed in 4 years at original... |
| `latest.completion.title_iv.loan_recip.transf_completed_4yr_by.4yrs` | `LOAN_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_completed_2yr_by.4yrs` | `LOAN_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.withdrawn_by.4yrs` | `LOAN_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and withdrew from original institution w... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_4yr_by.4yrs` | `LOAN_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_2yr_by.4yrs` | `LOAN_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.still_enrolled_by.4yrs` | `LOAN_ENRL_ORIG_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who were still enrolled at original... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_4yr_by.4yrs` | `LOAN_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_2yr_by.4yrs` | `LOAN_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.unknown_by.4yrs` | `LOAN_UNKN_ORIG_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and with status unknown within 4 years a... |
| `latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.4yrs` | `LOAN_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_unknown_2yr_by.4yrs` | `LOAN_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.no_loan.died_by.4yrs` | `NOLOAN_DEATH_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who died within 4 years at ori... |
| `latest.completion.title_iv.no_loan.completed_by.4yrs` | `NOLOAN_COMP_ORIG_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who completed in 4 years at or... |
| `latest.completion.title_iv.no_loan.transf_completed_4yr_by.4yrs` | `NOLOAN_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_completed_2yr_by.4yrs` | `NOLOAN_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.withdrawn_by.4yrs` | `NOLOAN_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and withdrew from original institu... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_4yr_by.4yrs` | `NOLOAN_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_2yr_by.4yrs` | `NOLOAN_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.still_enrolled_by.4yrs` | `NOLOAN_ENRL_ORIG_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who were still enrolled at ori... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_4yr_by.4yrs` | `NOLOAN_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_2yr_by.4yrs` | `NOLOAN_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.unknown_by.4yrs` | `NOLOAN_UNKN_ORIG_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and with status unknown within 4 y... |
| `latest.completion.title_iv.no_loan.transf_unknown_4yr_by.4yrs` | `NOLOAN_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_unknown_2yr_by.4yrs` | `NOLOAN_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.first_gen.died_by.4yrs` | `FIRSTGEN_DEATH_YR4_RT` | float | 20 | Percent of first-generation students who died within 4 years at original institution |
| `latest.completion.title_iv.first_gen.completed_by.4yrs` | `FIRSTGEN_COMP_ORIG_YR4_RT` | float | 20 | Percent of first-generation students who completed within 4 years at original institution |
| `latest.completion.title_iv.first_gen.transf_completed_4yr_by.4yrs` | `FIRSTGEN_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.first_gen.transf_completed_2yr_by.4yrs` | `FIRSTGEN_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.first_gen.withdrawn_by.4yrs` | `FIRSTGEN_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of first-generation students withdrawn from original institution within 4 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_4yr_by.4yrs` | `FIRSTGEN_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_2yr_by.4yrs` | `FIRSTGEN_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.first_gen.still_enrolled_by.4yrs` | `FIRSTGEN_ENRL_ORIG_YR4_RT` | float | 20 | Percent of first-generation students who were still enrolled at original institution within 4 years |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_4yr_by.4yrs` | `FIRSTGEN_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 4-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_2yr_by.4yrs` | `FIRSTGEN_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 2-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.unknown_by.4yrs` | `FIRSTGEN_UNKN_ORIG_YR4_RT` | float | 20 | Percent of first-generation students with status unknown within 4 years at original institution |
| `latest.completion.title_iv.first_gen.transf_unknown_4yr_by.4yrs` | `FIRSTGEN_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 4-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.first_gen.transf_unknown_2yr_by.4yrs` | `FIRSTGEN_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of first-generation students who transferred to a 2-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.not_first_gen.died_by.4yrs` | `NOT1STGEN_DEATH_YR4_RT` | float | 20 | Percent of not-first-generation students who died within 4 years at original institution |
| `latest.completion.title_iv.not_first_gen.completed_by.4yrs` | `NOT1STGEN_COMP_ORIG_YR4_RT` | float | 20 | Percent of not-first-generation students who completed within 4 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_completed_4yr_by.4yrs` | `NOT1STGEN_COMP_4YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 4-year institution and completed within 4 years |
| `latest.completion.title_iv.not_first_gen.transf_completed_2yr_by.4yrs` | `NOT1STGEN_COMP_2YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 2-year institution and completed within 4 years |
| `latest.completion.title_iv.not_first_gen.withdrawn_by.4yrs` | `NOT1STGEN_WDRAW_ORIG_YR4_RT` | float | 20 | Percent of not-first-generation students withdrawn from original institution within 4 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_4yr_by.4yrs` | `NOT1STGEN_WDRAW_4YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 4 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_2yr_by.4yrs` | `NOT1STGEN_WDRAW_2YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 4 years |
| `latest.completion.title_iv.not_first_gen.still_enrolled_by.4yrs` | `NOT1STGEN_ENRL_ORIG_YR4_RT` | float | 20 | Percent of not-first-generation students who were still enrolled at original institution within 4 years |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_4yr_by.4yrs` | `NOT1STGEN_ENRL_4YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_2yr_by.4yrs` | `NOT1STGEN_ENRL_2YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.unknown_by.4yrs` | `NOT1STGEN_UNKN_ORIG_YR4_RT` | float | 20 | Percent of not-first-generation students with status unknown within 4 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_unknown_4yr_by.4yrs` | `NOT1STGEN_UNKN_4YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknow... |
| `latest.completion.title_iv.not_first_gen.transf_unknown_2yr_by.4yrs` | `NOT1STGEN_UNKN_2YR_TRANS_YR4_RT` | float | 20 | Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknow... |
| `latest.completion.title_iv.died_by.6yrs` | `DEATH_YR6_RT` | float | 18 | Percent died within 6 years at original institution |
| `latest.completion.title_iv.completed_by.6yrs` | `COMP_ORIG_YR6_RT` | float | 18 | Percent completed within 6 years at original institution |
| `latest.completion.title_iv.transf_completed_4yr_by.6yrs` | `COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.transf_completed_2yr_by.6yrs` | `COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.withdrawn_by.6yrs` | `WDRAW_ORIG_YR6_RT` | float | 18 | Percent withdrawn from original institution within 6 years |
| `latest.completion.title_iv.transf_withdrawn_4yr_by.6yrs` | `WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.transf_withdrawn_2yr_by.6yrs` | `WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.still_enrolled_by.6yrs` | `ENRL_ORIG_YR6_RT` | float | 18 | Percent still enrolled at original institution within 6 years |
| `latest.completion.title_iv.transf_still_enrolled_4yr_by.6yrs` | `ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 4-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.transf_still_enrolled_2yr_by.6yrs` | `ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 2-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.unknown_by.6yrs` | `UNKN_ORIG_YR6_RT` | float | 18 | Percent with status unknown within 6 years at original institution |
| `latest.completion.title_iv.transf_unknown_4yr_by.6yrs` | `UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 4-year institution and whose status is unknown within 6 years |
| `latest.completion.title_iv.transf_unknown_2yr_by.6yrs` | `UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent who transferred to a 2-year institution and whose status is unknown within 6 years |
| `latest.completion.title_iv.low_inc.died_by.6yrs` | `LO_INC_DEATH_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who died within 6 years at orig... |
| `latest.completion.title_iv.low_inc.completed_by.6yrs` | `LO_INC_COMP_ORIG_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who completed within 6 years at... |
| `latest.completion.title_iv.low_inc.transf_completed_4yr_by.6yrs` | `LO_INC_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_completed_2yr_by.6yrs` | `LO_INC_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.withdrawn_by.6yrs` | `LO_INC_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institu... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_4yr_by.6yrs` | `LO_INC_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_2yr_by.6yrs` | `LO_INC_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.still_enrolled_by.6yrs` | `LO_INC_ENRL_ORIG_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at orig... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_4yr_by.6yrs` | `LO_INC_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_2yr_by.6yrs` | `LO_INC_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.unknown_by.6yrs` | `LO_INC_UNKN_ORIG_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 6 ye... |
| `latest.completion.title_iv.low_inc.transf_unknown_4yr_by.6yrs` | `LO_INC_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_unknown_2yr_by.6yrs` | `LO_INC_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.mid_inc.died_by.6yrs` | `MD_INC_DEATH_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 6... |
| `latest.completion.title_iv.mid_inc.completed_by.6yrs` | `MD_INC_COMP_ORIG_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed with... |
| `latest.completion.title_iv.mid_inc.transf_completed_4yr_by.6yrs` | `MD_INC_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_completed_2yr_by.6yrs` | `MD_INC_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.withdrawn_by.6yrs` | `MD_INC_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from ori... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_4yr_by.6yrs` | `MD_INC_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_2yr_by.6yrs` | `MD_INC_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.still_enrolled_by.6yrs` | `MD_INC_ENRL_ORIG_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enr... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_4yr_by.6yrs` | `MD_INC_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_2yr_by.6yrs` | `MD_INC_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.unknown_by.6yrs` | `MD_INC_UNKN_ORIG_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknow... |
| `latest.completion.title_iv.mid_inc.transf_unknown_4yr_by.6yrs` | `MD_INC_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_unknown_2yr_by.6yrs` | `MD_INC_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.high_inc.died_by.6yrs` | `HI_INC_DEATH_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who died within 6 years at origina... |
| `latest.completion.title_iv.high_inc.completed_by.6yrs` | `HI_INC_COMP_ORIG_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who completed within 6 years at or... |
| `latest.completion.title_iv.high_inc.transf_completed_4yr_by.6yrs` | `HI_INC_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_completed_2yr_by.6yrs` | `HI_INC_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.withdrawn_by.6yrs` | `HI_INC_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institutio... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_4yr_by.6yrs` | `HI_INC_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_2yr_by.6yrs` | `HI_INC_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.still_enrolled_by.6yrs` | `HI_INC_ENRL_ORIG_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at origina... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_4yr_by.6yrs` | `HI_INC_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_2yr_by.6yrs` | `HI_INC_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.unknown_by.6yrs` | `HI_INC_UNKN_ORIG_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students with status unknown within 6 years... |
| `latest.completion.title_iv.high_inc.transf_unknown_4yr_by.6yrs` | `HI_INC_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_unknown_2yr_by.6yrs` | `HI_INC_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.depend.died_by.6yrs` | `DEP_DEATH_YR6_RT` | float | 18 | Percent of dependent students who died within 6 years at original institution |
| `latest.completion.title_iv.depend.completed_by.6yrs` | `DEP_COMP_ORIG_YR6_RT` | float | 18 | Percent of dependent students who completed within 6 years at original institution |
| `latest.completion.title_iv.depend.transf_completed_4yr_by.6yrs` | `DEP_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.depend.transf_completed_2yr_by.6yrs` | `DEP_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.depend.withdrawn_by.6yrs` | `DEP_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of dependent students withdrawn from original institution within 6 years |
| `latest.completion.title_iv.depend.transf_withdrawn_4yr_by.6yrs` | `DEP_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.depend.transf_withdrawn_2yr_by.6yrs` | `DEP_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.depend.still_enrolled_by.6yrs` | `DEP_ENRL_ORIG_YR6_RT` | float | 18 | Percent of dependent students who were still enrolled at original institution within 6 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_4yr_by.6yrs` | `DEP_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 4-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_2yr_by.6yrs` | `DEP_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 2-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.depend.unknown_by.6yrs` | `DEP_UNKN_ORIG_YR6_RT` | float | 18 | Percent of dependent students with status unknown within 6 years at original institution |
| `latest.completion.title_iv.depend.transf_unknown_4yr_by.6yrs` | `DEP_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 6... |
| `latest.completion.title_iv.depend.transf_unknown_2yr_by.6yrs` | `DEP_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 6... |
| `latest.completion.title_iv.independ.died_by.6yrs` | `IND_DEATH_YR6_RT` | float | 18 | Percent of independent students who died within 6 years at original institution |
| `latest.completion.title_iv.independ.completed_by.6yrs` | `IND_COMP_ORIG_YR6_RT` | float | 18 | Percent of independent students who completed within 6 years at original institution |
| `latest.completion.title_iv.independ.transf_completed_4yr_by.6yrs` | `IND_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.independ.transf_completed_2yr_by.6yrs` | `IND_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.independ.withdrawn_by.6yrs` | `IND_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of independent students withdrawn from original institution within 6 years |
| `latest.completion.title_iv.independ.transf_withdrawn_4yr_by.6yrs` | `IND_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.independ.transf_withdrawn_2yr_by.6yrs` | `IND_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.independ.still_enrolled_by.6yrs` | `IND_ENRL_ORIG_YR6_RT` | float | 18 | Percent of independent students who were still enrolled at original institution within 6 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_4yr_by.6yrs` | `IND_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 4-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_2yr_by.6yrs` | `IND_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 2-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.independ.unknown_by.6yrs` | `IND_UNKN_ORIG_YR6_RT` | float | 18 | Percent of independent students with status unknown within 6 years at original institution |
| `latest.completion.title_iv.independ.transf_unknown_4yr_by.6yrs` | `IND_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 4-year institution and whose status is unknown within... |
| `latest.completion.title_iv.independ.transf_unknown_2yr_by.6yrs` | `IND_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of independent students who transferred to a 2-year institution and whose status is unknown within... |
| `latest.completion.title_iv.female.died_by.6yrs` | `FEMALE_DEATH_YR6_RT` | float | 18 | Percent of female students who died within 6 years at original institution |
| `latest.completion.title_iv.female.completed_by.6yrs` | `FEMALE_COMP_ORIG_YR6_RT` | float | 18 | Percent of female students who completed within 6 years at original institution |
| `latest.completion.title_iv.female.transf_completed_4yr_by.6yrs` | `FEMALE_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.female.transf_completed_2yr_by.6yrs` | `FEMALE_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.female.withdrawn_by.6yrs` | `FEMALE_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of female students withdrawn from original institution within 6 years |
| `latest.completion.title_iv.female.transf_withdrawn_4yr_by.6yrs` | `FEMALE_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.female.transf_withdrawn_2yr_by.6yrs` | `FEMALE_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.female.still_enrolled_by.6yrs` | `FEMALE_ENRL_ORIG_YR6_RT` | float | 18 | Percent of female students who were still enrolled at original institution within 6 years |
| `latest.completion.title_iv.female.transf_still_enrolled_4yr_by.6yrs` | `FEMALE_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 4-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.female.transf_still_enrolled_2yr_by.6yrs` | `FEMALE_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 2-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.female.unknown_by.6yrs` | `FEMALE_UNKN_ORIG_YR6_RT` | float | 18 | Percent of female students with status unknown within 6 years at original institution |
| `latest.completion.title_iv.female.transf_unknown_4yr_by.6yrs` | `FEMALE_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 4-year institution and whose status is unknown within 6 years |
| `latest.completion.title_iv.female.transf_unknown_2yr_by.6yrs` | `FEMALE_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of female students who transferred to a 2-year institution and whose status is unknown within 6 years |
| `latest.completion.title_iv.male.died_by.6yrs` | `MALE_DEATH_YR6_RT` | float | 18 | Percent of male students who died within 6 years at original institution |
| `latest.completion.title_iv.male.completed_by.6yrs` | `MALE_COMP_ORIG_YR6_RT` | float | 18 | Percent of male students who completed within 6 years at original institution |
| `latest.completion.title_iv.male.transf_completed_4yr_by.6yrs` | `MALE_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.male.transf_completed_2yr_by.6yrs` | `MALE_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.male.withdrawn_by.6yrs` | `MALE_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of male students withdrawn from original institution within 6 years |
| `latest.completion.title_iv.male.transf_withdrawn_4yr_by.6yrs` | `MALE_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.male.transf_withdrawn_2yr_by.6yrs` | `MALE_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.male.still_enrolled_by.6yrs` | `MALE_ENRL_ORIG_YR6_RT` | float | 18 | Percent of male students who were still enrolled at original institution within 6 years |
| `latest.completion.title_iv.male.transf_still_enrolled_4yr_by.6yrs` | `MALE_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 4-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.male.transf_still_enrolled_2yr_by.6yrs` | `MALE_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 2-year institution and were still enrolled within 6 years |
| `latest.completion.title_iv.male.unknown_by.6yrs` | `MALE_UNKN_ORIG_YR6_RT` | float | 18 | Percent of male students with status unknown within 6 years at original institution |
| `latest.completion.title_iv.male.transf_unknown_4yr_by.6yrs` | `MALE_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 4-year institution and whose status is unknown within 6 years |
| `latest.completion.title_iv.male.transf_unknown_2yr_by.6yrs` | `MALE_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of male students who transferred to a 2-year institution and whose status is unknown within 6 years |
| `latest.completion.title_iv.pell_recip.died_by.6yrs` | `PELL_DEATH_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who died within 6 years at original in... |
| `latest.completion.title_iv.pell_recip.completed_by.6yrs` | `PELL_COMP_ORIG_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who completed in 6 years at original i... |
| `latest.completion.title_iv.pell_recip.transf_completed_4yr_by.6yrs` | `PELL_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_completed_2yr_by.6yrs` | `PELL_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.withdrawn_by.6yrs` | `PELL_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and withdrew from original institution wit... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_4yr_by.6yrs` | `PELL_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_2yr_by.6yrs` | `PELL_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.still_enrolled_by.6yrs` | `PELL_ENRL_ORIG_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who were still enrolled at original in... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_4yr_by.6yrs` | `PELL_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_2yr_by.6yrs` | `PELL_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.unknown_by.6yrs` | `PELL_UNKN_ORIG_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and with status unknown within 6 years at... |
| `latest.completion.title_iv.pell_recip.transf_unknown_4yr_by.6yrs` | `PELL_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_unknown_2yr_by.6yrs` | `PELL_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.no_pell.died_by.6yrs` | `NOPELL_DEATH_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who died within 6 years at origi... |
| `latest.completion.title_iv.no_pell.completed_by.6yrs` | `NOPELL_COMP_ORIG_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who completed in 6 years at orig... |
| `latest.completion.title_iv.no_pell.transf_completed_4yr_by.6yrs` | `NOPELL_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_completed_2yr_by.6yrs` | `NOPELL_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.withdrawn_by.6yrs` | `NOPELL_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and withdrew from original instituti... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_4yr_by.6yrs` | `NOPELL_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_2yr_by.6yrs` | `NOPELL_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.still_enrolled_by.6yrs` | `NOPELL_ENRL_ORIG_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who were still enrolled at origi... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_4yr_by.6yrs` | `NOPELL_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_2yr_by.6yrs` | `NOPELL_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.unknown_by.6yrs` | `NOPELL_UNKN_ORIG_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and with status unknown within 6 yea... |
| `latest.completion.title_iv.no_pell.transf_unknown_4yr_by.6yrs` | `NOPELL_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_unknown_2yr_by.6yrs` | `NOPELL_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.loan_recip.died_by.6yrs` | `LOAN_DEATH_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who died within 6 years at original... |
| `latest.completion.title_iv.loan_recip.completed_by.6yrs` | `LOAN_COMP_ORIG_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who completed in 6 years at original... |
| `latest.completion.title_iv.loan_recip.transf_completed_4yr_by.6yrs` | `LOAN_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_completed_2yr_by.6yrs` | `LOAN_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.withdrawn_by.6yrs` | `LOAN_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and withdrew from original institution w... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_4yr_by.6yrs` | `LOAN_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_2yr_by.6yrs` | `LOAN_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.still_enrolled_by.6yrs` | `LOAN_ENRL_ORIG_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who were still enrolled at original... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_4yr_by.6yrs` | `LOAN_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_2yr_by.6yrs` | `LOAN_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.unknown_by.6yrs` | `LOAN_UNKN_ORIG_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and with status unknown within 6 years a... |
| `latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.6yrs` | `LOAN_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_unknown_2yr_by.6yrs` | `LOAN_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.no_loan.died_by.6yrs` | `NOLOAN_DEATH_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who died within 6 years at ori... |
| `latest.completion.title_iv.no_loan.completed_by.6yrs` | `NOLOAN_COMP_ORIG_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who completed in 6 years at or... |
| `latest.completion.title_iv.no_loan.transf_completed_4yr_by.6yrs` | `NOLOAN_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_completed_2yr_by.6yrs` | `NOLOAN_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.withdrawn_by.6yrs` | `NOLOAN_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and withdrew from original institu... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_4yr_by.6yrs` | `NOLOAN_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_2yr_by.6yrs` | `NOLOAN_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.still_enrolled_by.6yrs` | `NOLOAN_ENRL_ORIG_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who were still enrolled at ori... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_4yr_by.6yrs` | `NOLOAN_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_2yr_by.6yrs` | `NOLOAN_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.unknown_by.6yrs` | `NOLOAN_UNKN_ORIG_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and with status unknown within 6 y... |
| `latest.completion.title_iv.no_loan.transf_unknown_4yr_by.6yrs` | `NOLOAN_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_unknown_2yr_by.6yrs` | `NOLOAN_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.first_gen.died_by.6yrs` | `FIRSTGEN_DEATH_YR6_RT` | float | 18 | Percent of first-generation students who died within 6 years at original institution |
| `latest.completion.title_iv.first_gen.completed_by.6yrs` | `FIRSTGEN_COMP_ORIG_YR6_RT` | float | 18 | Percent of first-generation students who completed within 6 years at original institution |
| `latest.completion.title_iv.first_gen.transf_completed_4yr_by.6yrs` | `FIRSTGEN_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.first_gen.transf_completed_2yr_by.6yrs` | `FIRSTGEN_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.first_gen.withdrawn_by.6yrs` | `FIRSTGEN_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of first-generation students withdrawn from original institution within 6 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_4yr_by.6yrs` | `FIRSTGEN_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_2yr_by.6yrs` | `FIRSTGEN_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.first_gen.still_enrolled_by.6yrs` | `FIRSTGEN_ENRL_ORIG_YR6_RT` | float | 18 | Percent of first-generation students who were still enrolled at original institution within 6 years |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_4yr_by.6yrs` | `FIRSTGEN_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 4-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_2yr_by.6yrs` | `FIRSTGEN_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 2-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.unknown_by.6yrs` | `FIRSTGEN_UNKN_ORIG_YR6_RT` | float | 18 | Percent of first-generation students with status unknown within 6 years at original institution |
| `latest.completion.title_iv.first_gen.transf_unknown_4yr_by.6yrs` | `FIRSTGEN_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 4-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.first_gen.transf_unknown_2yr_by.6yrs` | `FIRSTGEN_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of first-generation students who transferred to a 2-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.not_first_gen.died_by.6yrs` | `NOT1STGEN_DEATH_YR6_RT` | float | 18 | Percent of not-first-generation students who died within 6 years at original institution |
| `latest.completion.title_iv.not_first_gen.completed_by.6yrs` | `NOT1STGEN_COMP_ORIG_YR6_RT` | float | 18 | Percent of not-first-generation students who completed within 6 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_completed_4yr_by.6yrs` | `NOT1STGEN_COMP_4YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 4-year institution and completed within 6 years |
| `latest.completion.title_iv.not_first_gen.transf_completed_2yr_by.6yrs` | `NOT1STGEN_COMP_2YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 2-year institution and completed within 6 years |
| `latest.completion.title_iv.not_first_gen.withdrawn_by.6yrs` | `NOT1STGEN_WDRAW_ORIG_YR6_RT` | float | 18 | Percent of not-first-generation students withdrawn from original institution within 6 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_4yr_by.6yrs` | `NOT1STGEN_WDRAW_4YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 6 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_2yr_by.6yrs` | `NOT1STGEN_WDRAW_2YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 6 years |
| `latest.completion.title_iv.not_first_gen.still_enrolled_by.6yrs` | `NOT1STGEN_ENRL_ORIG_YR6_RT` | float | 18 | Percent of not-first-generation students who were still enrolled at original institution within 6 years |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_4yr_by.6yrs` | `NOT1STGEN_ENRL_4YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_2yr_by.6yrs` | `NOT1STGEN_ENRL_2YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.unknown_by.6yrs` | `NOT1STGEN_UNKN_ORIG_YR6_RT` | float | 18 | Percent of not-first-generation students with status unknown within 6 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_unknown_4yr_by.6yrs` | `NOT1STGEN_UNKN_4YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknow... |
| `latest.completion.title_iv.not_first_gen.transf_unknown_2yr_by.6yrs` | `NOT1STGEN_UNKN_2YR_TRANS_YR6_RT` | float | 18 | Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknow... |
| `latest.completion.title_iv.died_by.8yrs` | `DEATH_YR8_RT` | float | 16 | Percent died within 8 years at original institution |
| `latest.completion.title_iv.completed_by.8yrs` | `COMP_ORIG_YR8_RT` | float | 16 | Percent completed within 8 years at original institution |
| `latest.completion.title_iv.transf_completed_4yr_by.8yrs` | `COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.transf_completed_2yr_by.8yrs` | `COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.withdrawn_by.8yrs` | `WDRAW_ORIG_YR8_RT` | float | 16 | Percent withdrawn from original institution within 8 years |
| `latest.completion.title_iv.transf_withdrawn_4yr_by.8yrs` | `WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.transf_withdrawn_2yr_by.8yrs` | `WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.still_enrolled_by.8yrs` | `ENRL_ORIG_YR8_RT` | float | 16 | Percent still enrolled at original institution within 8 years |
| `latest.completion.title_iv.transf_still_enrolled_4yr_by.8yrs` | `ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 4-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.transf_still_enrolled_2yr_by.8yrs` | `ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 2-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.unknown_by.8yrs` | `UNKN_ORIG_YR8_RT` | float | 16 | Percent with status unknown within 8 years at original institution |
| `latest.completion.title_iv.transf_unknown_4yr_by.8yrs` | `UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 4-year institution and whose status is unknown within 8 years |
| `latest.completion.title_iv.transf_unknown_2yr_by.8yrs` | `UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent who transferred to a 2-year institution and whose status is unknown within 8 years |
| `latest.completion.title_iv.low_inc.died_by.8yrs` | `LO_INC_DEATH_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who died within 8 years at orig... |
| `latest.completion.title_iv.low_inc.completed_by.8yrs` | `LO_INC_COMP_ORIG_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who completed within 8 years at... |
| `latest.completion.title_iv.low_inc.transf_completed_4yr_by.8yrs` | `LO_INC_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_completed_2yr_by.8yrs` | `LO_INC_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.withdrawn_by.8yrs` | `LO_INC_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institu... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_4yr_by.8yrs` | `LO_INC_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_withdrawn_2yr_by.8yrs` | `LO_INC_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.still_enrolled_by.8yrs` | `LO_INC_ENRL_ORIG_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at orig... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_4yr_by.8yrs` | `LO_INC_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_still_enrolled_2yr_by.8yrs` | `LO_INC_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.low_inc.unknown_by.8yrs` | `LO_INC_UNKN_ORIG_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 8 ye... |
| `latest.completion.title_iv.low_inc.transf_unknown_4yr_by.8yrs` | `LO_INC_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year ins... |
| `latest.completion.title_iv.low_inc.transf_unknown_2yr_by.8yrs` | `LO_INC_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year ins... |
| `latest.completion.title_iv.mid_inc.died_by.8yrs` | `MD_INC_DEATH_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 8... |
| `latest.completion.title_iv.mid_inc.completed_by.8yrs` | `MD_INC_COMP_ORIG_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed with... |
| `latest.completion.title_iv.mid_inc.transf_completed_4yr_by.8yrs` | `MD_INC_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_completed_2yr_by.8yrs` | `MD_INC_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.withdrawn_by.8yrs` | `MD_INC_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from ori... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_4yr_by.8yrs` | `MD_INC_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_withdrawn_2yr_by.8yrs` | `MD_INC_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.still_enrolled_by.8yrs` | `MD_INC_ENRL_ORIG_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enr... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_4yr_by.8yrs` | `MD_INC_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_still_enrolled_2yr_by.8yrs` | `MD_INC_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.unknown_by.8yrs` | `MD_INC_UNKN_ORIG_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknow... |
| `latest.completion.title_iv.mid_inc.transf_unknown_4yr_by.8yrs` | `MD_INC_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.mid_inc.transf_unknown_2yr_by.8yrs` | `MD_INC_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to... |
| `latest.completion.title_iv.high_inc.died_by.8yrs` | `HI_INC_DEATH_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who died within 8 years at origina... |
| `latest.completion.title_iv.high_inc.completed_by.8yrs` | `HI_INC_COMP_ORIG_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who completed within 8 years at or... |
| `latest.completion.title_iv.high_inc.transf_completed_4yr_by.8yrs` | `HI_INC_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_completed_2yr_by.8yrs` | `HI_INC_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.withdrawn_by.8yrs` | `HI_INC_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institutio... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_4yr_by.8yrs` | `HI_INC_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_withdrawn_2yr_by.8yrs` | `HI_INC_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.still_enrolled_by.8yrs` | `HI_INC_ENRL_ORIG_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at origina... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_4yr_by.8yrs` | `HI_INC_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_still_enrolled_2yr_by.8yrs` | `HI_INC_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.high_inc.unknown_by.8yrs` | `HI_INC_UNKN_ORIG_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students with status unknown within 8 years... |
| `latest.completion.title_iv.high_inc.transf_unknown_4yr_by.8yrs` | `HI_INC_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year instit... |
| `latest.completion.title_iv.high_inc.transf_unknown_2yr_by.8yrs` | `HI_INC_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year instit... |
| `latest.completion.title_iv.depend.died_by.8yrs` | `DEP_DEATH_YR8_RT` | float | 16 | Percent of dependent students who died within 8 years at original institution |
| `latest.completion.title_iv.depend.completed_by.8yrs` | `DEP_COMP_ORIG_YR8_RT` | float | 16 | Percent of dependent students who completed within 8 years at original institution |
| `latest.completion.title_iv.depend.transf_completed_4yr_by.8yrs` | `DEP_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.depend.transf_completed_2yr_by.8yrs` | `DEP_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.depend.withdrawn_by.8yrs` | `DEP_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of dependent students withdrawn from original institution within 8 years |
| `latest.completion.title_iv.depend.transf_withdrawn_4yr_by.8yrs` | `DEP_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.depend.transf_withdrawn_2yr_by.8yrs` | `DEP_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.depend.still_enrolled_by.8yrs` | `DEP_ENRL_ORIG_YR8_RT` | float | 16 | Percent of dependent students who were still enrolled at original institution within 8 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_4yr_by.8yrs` | `DEP_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 4-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.depend.transf_still_enrolled_2yr_by.8yrs` | `DEP_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 2-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.depend.unknown_by.8yrs` | `DEP_UNKN_ORIG_YR8_RT` | float | 16 | Percent of dependent students with status unknown within 8 years at original institution |
| `latest.completion.title_iv.depend.transf_unknown_4yr_by.8yrs` | `DEP_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 8... |
| `latest.completion.title_iv.depend.transf_unknown_2yr_by.8yrs` | `DEP_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 8... |
| `latest.completion.title_iv.independ.died_by.8yrs` | `IND_DEATH_YR8_RT` | float | 16 | Percent of independent students who died within 8 years at original institution |
| `latest.completion.title_iv.independ.completed_by.8yrs` | `IND_COMP_ORIG_YR8_RT` | float | 16 | Percent of independent students who completed within 8 years at original institution |
| `latest.completion.title_iv.independ.transf_completed_4yr_by.8yrs` | `IND_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.independ.transf_completed_2yr_by.8yrs` | `IND_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.independ.withdrawn_by.8yrs` | `IND_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of independent students withdrawn from original institution within 8 years |
| `latest.completion.title_iv.independ.transf_withdrawn_4yr_by.8yrs` | `IND_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.independ.transf_withdrawn_2yr_by.8yrs` | `IND_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.independ.still_enrolled_by.8yrs` | `IND_ENRL_ORIG_YR8_RT` | float | 16 | Percent of independent students who were still enrolled at original institution within 8 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_4yr_by.8yrs` | `IND_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 4-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.independ.transf_still_enrolled_2yr_by.8yrs` | `IND_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 2-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.independ.unknown_by.8yrs` | `IND_UNKN_ORIG_YR8_RT` | float | 16 | Percent of independent students with status unknown within 8 years at original institution |
| `latest.completion.title_iv.independ.transf_unknown_4yr_by.8yrs` | `IND_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 4-year institution and whose status is unknown within... |
| `latest.completion.title_iv.independ.transf_unknown_2yr_by.8yrs` | `IND_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of independent students who transferred to a 2-year institution and whose status is unknown within... |
| `latest.completion.title_iv.female.died_by.8yrs` | `FEMALE_DEATH_YR8_RT` | float | 16 | Percent of female students who died within 8 years at original institution |
| `latest.completion.title_iv.female.completed_by.8yrs` | `FEMALE_COMP_ORIG_YR8_RT` | float | 16 | Percent of female students who completed within 8 years at original institution |
| `latest.completion.title_iv.female.transf_completed_4yr_by.8yrs` | `FEMALE_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.female.transf_completed_2yr_by.8yrs` | `FEMALE_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.female.withdrawn_by.8yrs` | `FEMALE_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of female students withdrawn from original institution within 8 years |
| `latest.completion.title_iv.female.transf_withdrawn_4yr_by.8yrs` | `FEMALE_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.female.transf_withdrawn_2yr_by.8yrs` | `FEMALE_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.female.still_enrolled_by.8yrs` | `FEMALE_ENRL_ORIG_YR8_RT` | float | 16 | Percent of female students who were still enrolled at original institution within 8 years |
| `latest.completion.title_iv.female.transf_still_enrolled_4yr_by.8yrs` | `FEMALE_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 4-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.female.transf_still_enrolled_2yr_by.8yrs` | `FEMALE_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 2-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.female.unknown_by.8yrs` | `FEMALE_UNKN_ORIG_YR8_RT` | float | 16 | Percent of female students with status unknown within 8 years at original institution |
| `latest.completion.title_iv.female.transf_unknown_4yr_by.8yrs` | `FEMALE_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 4-year institution and whose status is unknown within 8 years |
| `latest.completion.title_iv.female.transf_unknown_2yr_by.8yrs` | `FEMALE_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of female students who transferred to a 2-year institution and whose status is unknown within 8 years |
| `latest.completion.title_iv.male.died_by.8yrs` | `MALE_DEATH_YR8_RT` | float | 16 | Percent of male students who died within 8 years at original institution |
| `latest.completion.title_iv.male.completed_by.8yrs` | `MALE_COMP_ORIG_YR8_RT` | float | 16 | Percent of male students who completed within 8 years at original institution |
| `latest.completion.title_iv.male.transf_completed_4yr_by.8yrs` | `MALE_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.male.transf_completed_2yr_by.8yrs` | `MALE_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.male.withdrawn_by.8yrs` | `MALE_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of male students withdrawn from original institution within 8 years |
| `latest.completion.title_iv.male.transf_withdrawn_4yr_by.8yrs` | `MALE_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.male.transf_withdrawn_2yr_by.8yrs` | `MALE_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.male.still_enrolled_by.8yrs` | `MALE_ENRL_ORIG_YR8_RT` | float | 16 | Percent of male students who were still enrolled at original institution within 8 years |
| `latest.completion.title_iv.male.transf_still_enrolled_4yr_by.8yrs` | `MALE_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 4-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.male.transf_still_enrolled_2yr_by.8yrs` | `MALE_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 2-year institution and were still enrolled within 8 years |
| `latest.completion.title_iv.male.unknown_by.8yrs` | `MALE_UNKN_ORIG_YR8_RT` | float | 16 | Percent of male students with status unknown within 8 years at original institution |
| `latest.completion.title_iv.male.transf_unknown_4yr_by.8yrs` | `MALE_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 4-year institution and whose status is unknown within 8 years |
| `latest.completion.title_iv.male.transf_unknown_2yr_by.8yrs` | `MALE_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of male students who transferred to a 2-year institution and whose status is unknown within 8 years |
| `latest.completion.title_iv.pell_recip.died_by.8yrs` | `PELL_DEATH_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who died within 8 years at original in... |
| `latest.completion.title_iv.pell_recip.completed_by.8yrs` | `PELL_COMP_ORIG_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who completed in 8 years at original i... |
| `latest.completion.title_iv.pell_recip.transf_completed_4yr_by.8yrs` | `PELL_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_completed_2yr_by.8yrs` | `PELL_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.withdrawn_by.8yrs` | `PELL_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and withdrew from original institution wit... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_4yr_by.8yrs` | `PELL_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_withdrawn_2yr_by.8yrs` | `PELL_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.still_enrolled_by.8yrs` | `PELL_ENRL_ORIG_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who were still enrolled at original in... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_4yr_by.8yrs` | `PELL_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_still_enrolled_2yr_by.8yrs` | `PELL_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.pell_recip.unknown_by.8yrs` | `PELL_UNKN_ORIG_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and with status unknown within 8 years at... |
| `latest.completion.title_iv.pell_recip.transf_unknown_4yr_by.8yrs` | `PELL_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institutio... |
| `latest.completion.title_iv.pell_recip.transf_unknown_2yr_by.8yrs` | `PELL_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institutio... |
| `latest.completion.title_iv.no_pell.died_by.8yrs` | `NOPELL_DEATH_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who died within 8 years at origi... |
| `latest.completion.title_iv.no_pell.completed_by.8yrs` | `NOPELL_COMP_ORIG_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who completed in 8 years at orig... |
| `latest.completion.title_iv.no_pell.transf_completed_4yr_by.8yrs` | `NOPELL_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_completed_2yr_by.8yrs` | `NOPELL_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.withdrawn_by.8yrs` | `NOPELL_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and withdrew from original instituti... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_4yr_by.8yrs` | `NOPELL_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_withdrawn_2yr_by.8yrs` | `NOPELL_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.still_enrolled_by.8yrs` | `NOPELL_ENRL_ORIG_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who were still enrolled at origi... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_4yr_by.8yrs` | `NOPELL_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_still_enrolled_2yr_by.8yrs` | `NOPELL_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.no_pell.unknown_by.8yrs` | `NOPELL_UNKN_ORIG_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and with status unknown within 8 yea... |
| `latest.completion.title_iv.no_pell.transf_unknown_4yr_by.8yrs` | `NOPELL_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year inst... |
| `latest.completion.title_iv.no_pell.transf_unknown_2yr_by.8yrs` | `NOPELL_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year inst... |
| `latest.completion.title_iv.loan_recip.died_by.8yrs` | `LOAN_DEATH_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who died within 8 years at original... |
| `latest.completion.title_iv.loan_recip.completed_by.8yrs` | `LOAN_COMP_ORIG_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who completed in 8 years at original... |
| `latest.completion.title_iv.loan_recip.transf_completed_4yr_by.8yrs` | `LOAN_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_completed_2yr_by.8yrs` | `LOAN_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.withdrawn_by.8yrs` | `LOAN_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and withdrew from original institution w... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_4yr_by.8yrs` | `LOAN_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_withdrawn_2yr_by.8yrs` | `LOAN_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.still_enrolled_by.8yrs` | `LOAN_ENRL_ORIG_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who were still enrolled at original... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_4yr_by.8yrs` | `LOAN_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_still_enrolled_2yr_by.8yrs` | `LOAN_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.loan_recip.unknown_by.8yrs` | `LOAN_UNKN_ORIG_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and with status unknown within 8 years a... |
| `latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.8yrs` | `LOAN_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 4-year institut... |
| `latest.completion.title_iv.loan_recip.transf_unknown_2yr_by.8yrs` | `LOAN_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who received a federal loan at the institution and who transferred to a 2-year institut... |
| `latest.completion.title_iv.no_loan.died_by.8yrs` | `NOLOAN_DEATH_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who died within 8 years at ori... |
| `latest.completion.title_iv.no_loan.completed_by.8yrs` | `NOLOAN_COMP_ORIG_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who completed in 8 years at or... |
| `latest.completion.title_iv.no_loan.transf_completed_4yr_by.8yrs` | `NOLOAN_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_completed_2yr_by.8yrs` | `NOLOAN_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.withdrawn_by.8yrs` | `NOLOAN_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and withdrew from original institu... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_4yr_by.8yrs` | `NOLOAN_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_withdrawn_2yr_by.8yrs` | `NOLOAN_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.still_enrolled_by.8yrs` | `NOLOAN_ENRL_ORIG_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who were still enrolled at ori... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_4yr_by.8yrs` | `NOLOAN_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_still_enrolled_2yr_by.8yrs` | `NOLOAN_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.no_loan.unknown_by.8yrs` | `NOLOAN_UNKN_ORIG_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and with status unknown within 8 y... |
| `latest.completion.title_iv.no_loan.transf_unknown_4yr_by.8yrs` | `NOLOAN_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 4-year in... |
| `latest.completion.title_iv.no_loan.transf_unknown_2yr_by.8yrs` | `NOLOAN_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of students who never received a federal loan at the institution and who transferred to a 2-year in... |
| `latest.completion.title_iv.first_gen.died_by.8yrs` | `FIRSTGEN_DEATH_YR8_RT` | float | 16 | Percent of first-generation students who died within 8 years at original institution |
| `latest.completion.title_iv.first_gen.completed_by.8yrs` | `FIRSTGEN_COMP_ORIG_YR8_RT` | float | 16 | Percent of first-generation students who completed within 8 years at original institution |
| `latest.completion.title_iv.first_gen.transf_completed_4yr_by.8yrs` | `FIRSTGEN_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.first_gen.transf_completed_2yr_by.8yrs` | `FIRSTGEN_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.first_gen.withdrawn_by.8yrs` | `FIRSTGEN_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of first-generation students withdrawn from original institution within 8 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_4yr_by.8yrs` | `FIRSTGEN_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.first_gen.transf_withdrawn_2yr_by.8yrs` | `FIRSTGEN_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.first_gen.still_enrolled_by.8yrs` | `FIRSTGEN_ENRL_ORIG_YR8_RT` | float | 16 | Percent of first-generation students who were still enrolled at original institution within 8 years |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_4yr_by.8yrs` | `FIRSTGEN_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 4-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.transf_still_enrolled_2yr_by.8yrs` | `FIRSTGEN_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 2-year institution and were still enrolled within... |
| `latest.completion.title_iv.first_gen.unknown_by.8yrs` | `FIRSTGEN_UNKN_ORIG_YR8_RT` | float | 16 | Percent of first-generation students with status unknown within 8 years at original institution |
| `latest.completion.title_iv.first_gen.transf_unknown_4yr_by.8yrs` | `FIRSTGEN_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 4-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.first_gen.transf_unknown_2yr_by.8yrs` | `FIRSTGEN_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of first-generation students who transferred to a 2-year institution and whose status is unknown wi... |
| `latest.completion.title_iv.not_first_gen.died_by.8yrs` | `NOT1STGEN_DEATH_YR8_RT` | float | 16 | Percent of not-first-generation students who died within 8 years at original institution |
| `latest.completion.title_iv.not_first_gen.completed_by.8yrs` | `NOT1STGEN_COMP_ORIG_YR8_RT` | float | 16 | Percent of not-first-generation students who completed within 8 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_completed_4yr_by.8yrs` | `NOT1STGEN_COMP_4YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 4-year institution and completed within 8 years |
| `latest.completion.title_iv.not_first_gen.transf_completed_2yr_by.8yrs` | `NOT1STGEN_COMP_2YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 2-year institution and completed within 8 years |
| `latest.completion.title_iv.not_first_gen.withdrawn_by.8yrs` | `NOT1STGEN_WDRAW_ORIG_YR8_RT` | float | 16 | Percent of not-first-generation students withdrawn from original institution within 8 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_4yr_by.8yrs` | `NOT1STGEN_WDRAW_4YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 8 years |
| `latest.completion.title_iv.not_first_gen.transf_withdrawn_2yr_by.8yrs` | `NOT1STGEN_WDRAW_2YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 8 years |
| `latest.completion.title_iv.not_first_gen.still_enrolled_by.8yrs` | `NOT1STGEN_ENRL_ORIG_YR8_RT` | float | 16 | Percent of not-first-generation students who were still enrolled at original institution within 8 years |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_4yr_by.8yrs` | `NOT1STGEN_ENRL_4YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.transf_still_enrolled_2yr_by.8yrs` | `NOT1STGEN_ENRL_2YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled wi... |
| `latest.completion.title_iv.not_first_gen.unknown_by.8yrs` | `NOT1STGEN_UNKN_ORIG_YR8_RT` | float | 16 | Percent of not-first-generation students with status unknown within 8 years at original institution |
| `latest.completion.title_iv.not_first_gen.transf_unknown_4yr_by.8yrs` | `NOT1STGEN_UNKN_4YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknow... |
| `latest.completion.title_iv.not_first_gen.transf_unknown_2yr_by.8yrs` | `NOT1STGEN_UNKN_2YR_TRANS_YR8_RT` | float | 16 | Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknow... |
| `latest.completion.2_yr_completion.overall` | `OVERALL_YR2_N` | integer | 22 | Number of students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.low_income` | `LO_INC_YR2_N` | integer | 22 | Number of low-income (less than $30,000 in nominal family income) students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.middle_income` | `MD_INC_YR2_N` | integer | 22 | Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 2-year c... |
| `latest.completion.2_yr_completion.high_income` | `HI_INC_YR2_N` | integer | 22 | Number of high-income (above $75,000 in nominal family income) students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.dependent_students` | `DEP_YR2_N` | integer | 22 | Number of dependent students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.independent_students` | `IND_YR2_N` | integer | 22 | Number of independent students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.female_students` | `FEMALE_YR2_N` | integer | 22 | Number of female students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.male_students` | `MALE_YR2_N` | integer | 22 | Number of male students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.pell_grant` | `PELL_YR2_N` | integer | 22 | Number of Pell students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.no_pell_grant` | `NOPELL_YR2_N` | integer | 22 | Number of no-Pell students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.loan_students` | `LOAN_YR2_N` | integer | 22 | Number of loan students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.no_loan_students` | `NOLOAN_YR2_N` | integer | 22 | Number of no-loan students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.first_generation_students` | `FIRSTGEN_YR2_N` | integer | 22 | Number of first-generation students in overall 2-year completion cohort |
| `latest.completion.2_yr_completion.no_first_generation_students` | `NOT1STGEN_YR2_N` | integer | 22 | Number of not-first-generation students in overall 2-year completion cohort |
| `latest.completion.3_yr_completion.overall` | `OVERALL_YR3_N` | integer | 21 | Number of students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.low_income` | `LO_INC_YR3_N` | integer | 21 | Number of low-income (less than $30,000 in nominal family income) students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.middle_income` | `MD_INC_YR3_N` | integer | 21 | Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 3-year c... |
| `latest.completion.3_yr_completion.high_income` | `HI_INC_YR3_N` | integer | 21 | Number of high-income (above $75,000 in nominal family income) students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.dependent_students` | `DEP_YR3_N` | integer | 21 | Number of dependent students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.independent_students` | `IND_YR3_N` | integer | 21 | Number of independent students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.female_students` | `FEMALE_YR3_N` | integer | 21 | Number of female students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.male_students` | `MALE_YR3_N` | integer | 21 | Number of male students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.pell_grant` | `PELL_YR3_N` | integer | 21 | Number of Pell students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.no_pell_grant` | `NOPELL_YR3_N` | integer | 21 | Number of no-Pell students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.loan_students` | `LOAN_YR3_N` | integer | 21 | Number of loan students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.no_loan_students` | `NOLOAN_YR3_N` | integer | 21 | Number of no-loan students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.first_generation_students` | `FIRSTGEN_YR3_N` | integer | 21 | Number of first-generation students in overall 3-year completion cohort |
| `latest.completion.3_yr_completion.no_first_generation_students` | `NOT1STGEN_YR3_N` | integer | 21 | Number of not-first-generation students in overall 3-year completion cohort |
| `latest.completion.4_yr_completion.overall` | `OVERALL_YR4_N` | integer | 20 | Number of students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.low_income` | `LO_INC_YR4_N` | integer | 20 | Number of low-income (less than $30,000 in nominal family income) students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.middle_income` | `MD_INC_YR4_N` | integer | 20 | Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 4-year c... |
| `latest.completion.4_yr_completion.high_income` | `HI_INC_YR4_N` | integer | 20 | Number of high-income (above $75,000 in nominal family income) students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.dependent_students` | `DEP_YR4_N` | integer | 20 | Number of dependent students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.independent_students` | `IND_YR4_N` | integer | 20 | Number of independent students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.female_students` | `FEMALE_YR4_N` | integer | 20 | Number of female students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.male_students` | `MALE_YR4_N` | integer | 20 | Number of male students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.pell_grant` | `PELL_YR4_N` | integer | 20 | Number of Pell students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.no_pell_grant` | `NOPELL_YR4_N` | integer | 20 | Number of no-Pell students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.loan_students` | `LOAN_YR4_N` | integer | 20 | Number of loan students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.no_loan_students` | `NOLOAN_YR4_N` | integer | 20 | Number of no-loan students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.first_generation_students` | `FIRSTGEN_YR4_N` | integer | 20 | Number of first-generation students in overall 4-year completion cohort |
| `latest.completion.4_yr_completion.no_first_generation_students` | `NOT1STGEN_YR4_N` | integer | 20 | Number of not-first-generation students in overall 4-year completion cohort |
| `latest.completion.6_yr_completion.overall` | `OVERALL_YR6_N` | integer | 18 | Number of students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.low_income` | `LO_INC_YR6_N` | integer | 18 | Number of low-income (less than $30,000 in nominal family income) students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.middle_income` | `MD_INC_YR6_N` | integer | 18 | Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 6-year c... |
| `latest.completion.6_yr_completion.high_income` | `HI_INC_YR6_N` | integer | 18 | Number of high-income (above $75,000 in nominal family income) students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.dependent_students` | `DEP_YR6_N` | integer | 18 | Number of dependent students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.independent_students` | `IND_YR6_N` | integer | 18 | Number of independent students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.female_students` | `FEMALE_YR6_N` | integer | 18 | Number of female students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.male_students` | `MALE_YR6_N` | integer | 18 | Number of male students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.pell_grant` | `PELL_YR6_N` | integer | 18 | Number of Pell students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.no_pell_grant` | `NOPELL_YR6_N` | integer | 18 | Number of no-Pell students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.loan_students` | `LOAN_YR6_N` | integer | 18 | Number of loan students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.no_loan_students` | `NOLOAN_YR6_N` | integer | 18 | Number of no-loan students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.first_generation_students` | `FIRSTGEN_YR6_N` | integer | 18 | Number of first-generation students in overall 6-year completion cohort |
| `latest.completion.6_yr_completion.no_first_generation_students` | `NOT1STGEN_YR6_N` | integer | 18 | Number of not-first-generation students in overall 6-year completion cohort |
| `latest.completion.8_yr_completion.overall` | `OVERALL_YR8_N` | integer | 16 | Number of students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.low_income` | `LO_INC_YR8_N` | integer | 16 | Number of low-income (less than $30,000 in nominal family income) students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.middle_income` | `MD_INC_YR8_N` | integer | 16 | Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 8-year c... |
| `latest.completion.8_yr_completion.high_income` | `HI_INC_YR8_N` | integer | 16 | Number of high-income (above $75,000 in nominal family income) students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.dependent_students` | `DEP_YR8_N` | integer | 16 | Number of dependent students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.independent_students` | `IND_YR8_N` | integer | 16 | Number of independent students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.female_students` | `FEMALE_YR8_N` | integer | 16 | Number of female students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.male_students` | `MALE_YR8_N` | integer | 16 | Number of male students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.pell_grant` | `PELL_YR8_N` | integer | 16 | Number of Pell students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.no_pell_grant` | `NOPELL_YR8_N` | integer | 16 | Number of no-Pell students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.loan_students` | `LOAN_YR8_N` | integer | 16 | Number of loan students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.no_loan_students` | `NOLOAN_YR8_N` | integer | 16 | Number of no-loan students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.first_generation_students` | `FIRSTGEN_YR8_N` | integer | 16 | Number of first-generation students in overall 8-year completion cohort |
| `latest.completion.8_yr_completion.no_first_generation_students` | `NOT1STGEN_YR8_N` | integer | 16 | Number of not-first-generation students in overall 8-year completion cohort |
| `latest.completion.separation_date.median` | `SEPAR_DT_MDN` | string | 19 | Median Date Student Separated |
| `latest.completion.separation_date.number` | `SEPAR_DT_N` | integer | 19 | Number of students in the cohort for date students separated from the school |
| `latest.completion.rate_suppressed.lt_four_year_150percent` | `C150_L4_POOLED_SUPP` | float | 1 | Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected ti... |
| `latest.completion.rate_suppressed.four_year` | `C150_4_POOLED_SUPP` | float | 1 | Completion rate for first-time, full-time students at four-year institutions (150% of expected time to comp... |
| `latest.completion.rate_suppressed.lt_four_year` | `C200_L4_POOLED_SUPP` | float | 1 | Completion rate for first-time, full-time students at less-than-four-year institutions (200% of expected ti... |
| `latest.completion.rate_suppressed.four_year_200percent` | `C200_4_POOLED_SUPP` | float | 1 | Completion rate for first-time, full-time students at four-year institutions (200% of expected time to comp... |
| `latest.completion.completion_rate_4yr_100nt` | `C100_4` | float | 27 | Completion rate for first-time, full-time students at four-year institutions (100% of expected time to comp... |
| `latest.completion.completion_cohort_4yr_100nt` | `D100_4` | integer | 27 | Adjusted cohort count for completion rate at four-year institutions (denominator of 100% completion rate) |
| `latest.completion.completion_rate_less_than_4yr_100nt` | `C100_L4` | float | 16 | Completion rate for first-time, full-time students at less-than-four-year institutions (100% of expected ti... |
| `latest.completion.completion_cohort_less_than_4yr_100nt` | `D100_L4` | integer | 16 | Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 100% completi... |
| `latest.completion.transfer_rate.4yr.full_time` | `TRANS_4` | float | 28 | Transfer rate for first-time, full-time students at four-year institutions (within 150% of expected time to... |
| `latest.completion.transfer_rate.cohort_4yr.full_time` | `DTRANS_4` | integer | 28 | Adjusted cohort count for transfer rate at four-year institutions (denominator of 150% transfer rate) |
| `latest.completion.transfer_rate.less_than_4yr.full_time` | `TRANS_L4` | float | 28 | Transfer rate for first-time, full-time students at less-than-four-year institutions (150% of expected time... |
| `latest.completion.transfer_rate.cohort_less_than_4yr.full_time` | `DTRANS_L4` | integer | 28 | Adjusted cohort count for transfer rate at less-than-four-year institutions (denominator of 150% transfer r... |
| `latest.completion.completion_cohort_4yr_150_white` | `D150_4_WHITE` | integer | 17 | Adjusted cohort count for completion rate of White students at four-year institutions (denominator of 150%... |
| `latest.completion.completion_cohort_4yr_150_black` | `D150_4_BLACK` | integer | 17 | Adjusted cohort count for completion rate of Black/African American students at four-year institutions (den... |
| `latest.completion.completion_cohort_4yr_150_hispanic` | `D150_4_HISP` | integer | 17 | Adjusted cohort count for completion rate of Hispanic students at four-year institutions (denominator of 15... |
| `latest.completion.completion_cohort_4yr_150_asian` | `D150_4_ASIAN` | integer | 17 | Adjusted cohort count for completion rate of Asian students at four-year institutions (denominator of 150%... |
| `latest.completion.completion_cohort_4yr_150_aian` | `D150_4_AIAN` | integer | 17 | Adjusted cohort count for completion rate of American Indian/Alaska Native students at four-year institutio... |
| `latest.completion.completion_cohort_4yr_150_nhpi` | `D150_4_NHPI` | integer | 17 | Adjusted cohort count for completion rate of Native Hawaiian/Pacific Islander students at four-year institu... |
| `latest.completion.completion_cohort_4yr_150_2ormore` | `D150_4_2MOR` | integer | 17 | Adjusted cohort count for completion rate of students of Two or More Races at four-year institutions (denom... |
| `latest.completion.completion_cohort_4yr_150_nonresident.alien` | `D150_4_NRA` | integer | 28 | Adjusted cohort count for completion rate of U.S. Nonresident students at four-year institutions (denominat... |
| `latest.completion.completion_cohort_4yr_150_race.unknown` | `D150_4_UNKN` | integer | 28 | Adjusted cohort count for completion rate of students of Unknown race at four-year institutions (denominato... |
| `latest.completion.completion_cohort_less_than_4yr_150_white` | `D150_L4_WHITE` | integer | 17 | Adjusted cohort count for completion rate of White students at less-than-four-year institutions (denominato... |
| `latest.completion.completion_cohort_less_than_4yr_150_black` | `D150_L4_BLACK` | integer | 17 | Adjusted cohort count for completion rate of Black/African American students at less-than-four-year institu... |
| `latest.completion.completion_cohort_less_than_4yr_150_hispanic` | `D150_L4_HISP` | integer | 17 | Adjusted cohort count for completion rate of Hispanic students at less-than-four-year institutions (denomin... |
| `latest.completion.completion_cohort_less_than_4yr_150_asian` | `D150_L4_ASIAN` | integer | 17 | Adjusted cohort count for completion rate of Asian students at less-than-four-year institutions (denominato... |
| `latest.completion.completion_cohort_less_than_4yr_150_aian` | `D150_L4_AIAN` | integer | 17 | Adjusted cohort count for completion rate of American Indian/Alaska Native students at less-than-four-year... |
| `latest.completion.completion_cohort_less_than_4yr_150_nhpi` | `D150_L4_NHPI` | integer | 17 | Adjusted cohort count for completion rate of Native Hawaiian/Pacific Islander students at less-than-four-ye... |
| `latest.completion.completion_cohort_less_than_4yr_150_2ormore` | `D150_L4_2MOR` | integer | 17 | Adjusted cohort count for completion rate of students of Two or More Races at less-than-four-year instituti... |
| `latest.completion.completion_cohort_less_than_4yr_150_nonresident.alien` | `D150_L4_NRA` | integer | 28 | Adjusted cohort count for completion rate of U.S. Nonresident students at less-than-four-year institutions... |
| `latest.completion.completion_cohort_less_than_4yr_150_race.unknown` | `D150_L4_UNKN` | integer | 28 | Adjusted cohort count for completion rate of students of Unknown race at less-than-four-year institutions (... |
| `latest.completion.completion_cohort_4yr_150_white_pre2010` | `D150_4_WHITENH` | integer | 14 | Adjusted cohort count for completion rate of White, non-Hispanic students at four-year institutions (denomi... |
| `latest.completion.completion_cohort_4yr_150_black_pre2010` | `D150_4_BLACKNH` | integer | 14 | Adjusted cohort count for completion rate of Black, non-Hispanic students at four-year institutions (denomi... |
| `latest.completion.completion_cohort_4yr_150_api_pre2010` | `D150_4_API` | integer | 14 | Adjusted cohort count for completion rate of Asian/Pacific Islander students at four-year institutions (den... |
| `latest.completion.completion_cohort_4yr_150_aian_pre2010` | `D150_4_AIANOld` | integer | - | Adjusted cohort count for completion rate of American Indian/Alaska Native students at four-year institutio... |
| `latest.completion.completion_cohort_4yr_150_hispanic_pre2010` | `D150_4_HISPOld` | integer | - | Adjusted cohort count for completion rate of Hispanic students at four-year institutions (denominator of 15... |
| `latest.completion.completion_cohort_less_than_4yr_150_white_pre2010` | `D150_L4_WHITENH` | integer | 14 | Adjusted cohort count for completion rate of White, non-Hispanic students at less-than-four-year institutio... |
| `latest.completion.completion_cohort_less_than_4yr_150_black_pre2010` | `D150_L4_BLACKNH` | integer | 14 | Adjusted cohort count for completion rate of Black, non-Hispanic students at less-than-four-year institutio... |
| `latest.completion.completion_cohort_less_than_4yr_150_api_pre2010` | `D150_L4_API` | integer | 14 | Adjusted cohort count for completion rate of Asian/Pacific Islander students at less-than-four-year institu... |
| `latest.completion.completion_cohort_less_than_4yr_150_aian_pre2010` | `D150_L4_AIANOld` | integer | - | Adjusted cohort count for completion rate of American Indian/Alaska Native students at less-than-four-year... |
| `latest.completion.completion_cohort_less_than_4yr_150_hispanic_pre2010` | `D150_L4_HISPOld` | integer | - | Adjusted cohort count for completion rate of Hispanic students at less-than-four-year institutions (denomin... |
| `latest.completion.outcome_cohort.full_time.first_time.6yr` | `OMACHT6_FTFT` | integer | 10 | Adjusted cohort count of full-time, first-time students (denominator for the percentage receiving an award... |
| `latest.completion.outcome_percentage.full_time.first_time.6yr.award` | `OMAWDP6_FTFT` | float | 10 | Percentage of full-time, first-time student receiving an award within 6 years of entry |
| `latest.completion.outcome_cohort.full_time.first_time.8yr` | `OMACHT8_FTFT` | integer | 10 | Adjusted cohort count of full-time, first-time students (denominator for the 8-year outcomes percentages) |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.award` | `OMAWDP8_FTFT` | float | 10 | Percentage of full-time, first-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.still_enrolled` | `OMENRYP8_FTFT` | float | 10 | Percentage of full-time, first-time students that did not receive an award and are still enrolled at this i... |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.transfer` | `OMENRAP8_FTFT` | float | 10 | Percentage of full-time, first-time students that did not receive an award and enrolled at another institut... |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.unknown` | `OMENRUP8_FTFT` | float | 10 | Percentage of full-time, first-time students that did not receive an award and whose enrollment status is u... |
| `latest.completion.outcome_cohort.part_time.first_time.6yr` | `OMACHT6_PTFT` | integer | 10 | Adjusted cohort count of part-time, first-time students (denominator for the percentage receiving an award... |
| `latest.completion.outcome_percentage.part_time.first_time.6yr.award` | `OMAWDP6_PTFT` | float | 10 | Percentage of part-time, first-time student receiving an award within 6 years of entry |
| `latest.completion.outcome_cohort.part_time.first_time.8yr` | `OMACHT8_PTFT` | integer | 10 | Adjusted cohort count of part-time, first-time students (denominator for the 8-year outcomes percentages) |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.award` | `OMAWDP8_PTFT` | float | 10 | Percentage of part-time, first-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.still_enrolled` | `OMENRYP8_PTFT` | float | 10 | Percentage of part-time, first-time students that did not receive an award and are still enrolled at this i... |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.transfer` | `OMENRAP8_PTFT` | float | 10 | Percentage of part-time, first-time students that did not receive an award and enrolled at another institut... |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.unknown` | `OMENRUP8_PTFT` | float | 10 | Percentage of part-time, first-time students that did not receive an award and whose enrollment status is u... |
| `latest.completion.outcome_cohort.full_time.not_first_time.6yr` | `OMACHT6_FTNFT` | integer | 10 | Adjusted cohort count of full-time, not first-time students (denominator for the percentage receiving an aw... |
| `latest.completion.outcome_percentage.full_time.not_first_time.6yr.award` | `OMAWDP6_FTNFT` | float | 10 | Percentage of full-time, not first-time student receiving an award within 6 years of entry |
| `latest.completion.outcome_cohort.full_time.not_first_time.8yr` | `OMACHT8_FTNFT` | integer | 10 | Adjusted cohort count of full-time, not first-time students (denominator for the 8-year outcomes percentages) |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.award` | `OMAWDP8_FTNFT` | float | 10 | Percentage of full-time, not first-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.still_enrolled` | `OMENRYP8_FTNFT` | float | 10 | Percentage of full-time, not first-time students that did not receive an award and are still enrolled at th... |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.transfer` | `OMENRAP8_FTNFT` | float | 10 | Percentage of full-time, not first-time students that did not receive an award and enrolled at another inst... |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.unknown` | `OMENRUP8_FTNFT` | float | 10 | Percentage of full-time, not first-time students that did not receive an award and whose enrollment status... |
| `latest.completion.outcome_cohort.part_time.not_first_time.6yr` | `OMACHT6_PTNFT` | integer | 10 | Adjusted cohort count of part-time, not first-time students (denominator for the percentage receiving an aw... |
| `latest.completion.outcome_percentage.part_time.not_first_time.6yr.award` | `OMAWDP6_PTNFT` | float | 10 | Percentage of part-time, not first-time student receiving an award within 6 years of entry |
| `latest.completion.outcome_cohort.part_time.not_first_time.8yr` | `OMACHT8_PTNFT` | integer | 10 | Adjusted cohort count of part-time, not first-time students (denominator for the 8-year outcomes percentages) |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.award` | `OMAWDP8_PTNFT` | float | 10 | Percentage of part-time, not first-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.still_enrolled` | `OMENRYP8_PTNFT` | float | 10 | Percentage of part-time, not first-time students that did not receive an award and are still enrolled at th... |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.transfer` | `OMENRAP8_PTNFT` | float | 10 | Percentage of part-time, not first-time students that did not receive an award and enrolled at another inst... |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.unknown` | `OMENRUP8_PTNFT` | float | 10 | Percentage of part-time, not first-time students that did not receive an award and whose enrollment status... |
| `latest.completion.transfer_rate.4yr.full_time_pooled` | `TRANS_4_POOLED` | float | 1 | Transfer rate for first-time, full-time students at four-year institutions (within 150% of expected time to... |
| `latest.completion.transfer_rate.less_than_4yr.full_time_pooled` | `TRANS_L4_POOLED` | float | 1 | Transfer rate for first-time, full-time students at less-than-four-year institutions (150% of expected time... |
| `latest.completion.transfer_rate.cohort_4yr.full_time_pooled` | `DTRANS_4_POOLED` | integer | 1 | Adjusted cohort count for transfer rate at four-year institutions (denominator of 150% transfer rate) |
| `latest.completion.transfer_rate.cohort_less_than_4yr.full_time_pooled` | `DTRANS_L4_POOLED` | integer | 1 | Adjusted cohort count for transfer rate at less-than-four-year institutions (denominator of 150% transfer r... |
| `latest.completion.transfer_rate_suppressed.4yr.full_time_pooled` | `TRANS_4_POOLED_SUPP` | float | 1 | Transfer rate for first-time, full-time students at four-year institutions (within 150% of expected time to... |
| `latest.completion.transfer_rate_suppressed.less_than_4yr.full_time_pooled` | `TRANS_L4_POOLED_SUPP` | float | 1 | Transfer rate for first-time, full-time students at less-than-four-year institutions (150% of expected time... |
| `latest.completion.completion_rate_four_year_100_pooled` | `C100_4_POOLED` | float | 1 | Completion rate for first-time, full-time students at four-year institutions (100% of expected time to comp... |
| `latest.completion.completion_rate_lt_four_year_100_pooled` | `C100_L4_POOLED` | float | 1 | Completion rate for first-time, full-time students at less-than-four-year institutions (100% of expected ti... |
| `latest.completion.completion_cohort_four_year_100_pooled` | `D100_4_POOLED` | integer | 1 | Adjusted cohort count for completion rate at four-year institutions (denominator of 100% completion rate),... |
| `latest.completion.completion_cohort_lt_four_year_100_pooled` | `D100_L4_POOLED` | integer | 1 | Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 100% completi... |
| `latest.completion.pooled_yrs_used_100` | `POOLYRS100` | integer | 1 | Years used for rolling averages of completion rate C100_[4/L4]_POOLED |
| `latest.completion.rate_suppressed.four_year_100_pooled` | `C100_4_POOLED_SUPP` | float | 1 | Completion rate for first-time, full-time students at four-year institutions (100% of expected time to comp... |
| `latest.completion.rate_suppressed.lt_four_year_100_pooled` | `C100_L4_POOLED_SUPP` | float | 1 | Completion rate for first-time, full-time students at less-than-four-year institutions (100% of expected ti... |
| `latest.completion.completion_rate_four_year_150_pell` | `C150_4_PELL` | float | 9 | Completion rate for first-time, full-time students receiving a Pell Grant during their first year of colleg... |
| `latest.completion.completion_cohort_four_year_150_pell` | `D150_4_PELL` | integer | 9 | Adjusted cohort count for Pell Grant recipient completion rate at four-year institutions (denominator of 15... |
| `latest.completion.completion_rate_lt_four_year_150_pell` | `C150_L4_PELL` | float | 9 | Completion rate for first-time, full-time students receiving a Pell Grant during their first year of colleg... |
| `latest.completion.completion_cohort_lt_four_year_150_pell` | `D150_L4_PELL` | integer | 9 | Adjusted cohort count for Pell Grant recipient completion rate at less-than-four-year institutions (denomin... |
| `latest.completion.completion_rate_four_year_150_loan_nopell` | `C150_4_LOANNOPELL` | float | 9 | Completion rate for first-time, full-time students receiving a Direct Subsidized Loan but not a Pell Grant... |
| `latest.completion.completion_cohort_four_year_150_loan_nopell` | `D150_4_LOANNOPELL` | integer | 9 | Adjusted cohort count for Direct Subsidized Loan recipients who did not receive a Pell Grant completion rat... |
| `latest.completion.completion_rate_lt_four_year_150_loan_nopell` | `C150_L4_LOANNOPELL` | float | 9 | Completion rate for first-time, full-time students receiving a Direct Subsidized Loan but not a Pell Grant... |
| `latest.completion.completion_cohort_lt_four_year_150_loan_nopell` | `D150_L4_LOANNOPELL` | integer | 9 | Adjusted cohort count for Direct Subsidized Loan recipients who did not receive a Pell Grant completion rat... |
| `latest.completion.completion_rate_four_year_150_noloan_nopell` | `C150_4_NOLOANNOPELL` | float | 9 | Completion rate for first-time, full-time students receiving neither a Direct Subsidized Loan or a Pell Gra... |
| `latest.completion.completion_cohort_four_year_150_noloan_nopell` | `D150_4_NOLOANNOPELL` | integer | 9 | Adjusted cohort count for those who did not receive a Direct Subsidized Loan or a Pell Grant completion rat... |
| `latest.completion.completion_rate_lt_four_year_150_noloan_nopell` | `C150_L4_NOLOANNOPELL` | float | 9 | Completion rate for first-time, full-time students receiving neither a Direct Subsidized Loan or a Pell Gra... |
| `latest.completion.completion_cohort_lt_four_year_150_noloan_nopell` | `D150_L4_NOLOANNOPELL` | integer | 9 | Adjusted cohort count for those who did not receive a Direct Subsidized Loan or a Pell Grant completion rat... |
| `latest.completion.outcome_cohort.full_time.first_time.6yr_pooled` | `OMACHT6_FTFT_POOLED` | integer | 1 | Adjusted cohort count of full-time, first-time students (denominator for the percentage receiving an award... |
| `latest.completion.outcome_percentage.full_time.first_time.6yr.award_pooled` | `OMAWDP6_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time student receiving an award within 6 years of entry, pooled in rolling a... |
| `latest.completion.outcome_cohort.full_time.first_time.8yr_pooled` | `OMACHT8_FTFT_POOLED` | integer | 1 | Adjusted cohort count of full-time, first-time students (denominator for the 8-year outcomes percentages),... |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.award_pooled` | `OMAWDP8_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time student receiving an award within 8 years of entry, pooled in rolling a... |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time students that did not receive an award and are still enrolled at this i... |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.transfer_pooled` | `OMENRAP8_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time students that did not receive an award and enrolled at another institut... |
| `latest.completion.outcome_percentage.full_time.first_time.8yr.unknown_pooled` | `OMENRUP8_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time students that did not receive an award and whose enrollment status is u... |
| `latest.completion.outcome_cohort.part_time.first_time.6yr_pooled` | `OMACHT6_PTFT_POOLED` | integer | 1 | Adjusted cohort count of part-time, first-time students (denominator for the percentage receiving an award... |
| `latest.completion.outcome_percentage.part_time.first_time.6yr.award_pooled` | `OMAWDP6_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time student receiving an award within 6 years of entry, pooled in rolling a... |
| `latest.completion.outcome_cohort.part_time.first_time.8yr_pooled` | `OMACHT8_PTFT_POOLED` | integer | 1 | Adjusted cohort count of part-time, first-time students (denominator for the 8-year outcomes percentages),... |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.award_pooled` | `OMAWDP8_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time student receiving an award within 8 years of entry, pooled in rolling a... |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time students that did not receive an award and are still enrolled at this i... |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.transfer_pooled` | `OMENRAP8_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time students that did not receive an award and enrolled at another institut... |
| `latest.completion.outcome_percentage.part_time.first_time.8yr.unknown_pooled` | `OMENRUP8_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time students that did not receive an award and whose enrollment status is u... |
| `latest.completion.outcome_cohort.full_time.not_first_time.6yr_pooled` | `OMACHT6_FTNFT_POOLED` | integer | 1 | Adjusted cohort count of full-time, not first-time students (denominator for the percentage receiving an aw... |
| `latest.completion.outcome_percentage.full_time.not_first_time.6yr.award_pooled` | `OMAWDP6_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time student receiving an award within 6 years of entry, pooled in rolli... |
| `latest.completion.outcome_cohort.full_time.not_first_time.8yr_pooled` | `OMACHT8_FTNFT_POOLED` | integer | 1 | Adjusted cohort count of full-time, not first-time students (denominator for the 8-year outcomes percentage... |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.award_pooled` | `OMAWDP8_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time student receiving an award within 8 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time students that did not receive an award and are still enrolled at th... |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time students that did not receive an award and enrolled at another inst... |
| `latest.completion.outcome_percentage.full_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time students that did not receive an award and whose enrollment status... |
| `latest.completion.outcome_cohort.part_time.not_first_time.6yr_pooled` | `OMACHT6_PTNFT_POOLED` | integer | 1 | Adjusted cohort count of part-time, not first-time students (denominator for the percentage receiving an aw... |
| `latest.completion.outcome_percentage.part_time.not_first_time.6yr.award_pooled` | `OMAWDP6_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time student receiving an award within 6 years of entry, pooled in rolli... |
| `latest.completion.outcome_cohort.part_time.not_first_time.8yr_pooled` | `OMACHT8_PTNFT_POOLED` | integer | 1 | Adjusted cohort count of part-time, not first-time students (denominator for the 8-year outcomes percentage... |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.award_pooled` | `OMAWDP8_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time student receiving an award within 8 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time students that did not receive an award and are still enrolled at th... |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time students that did not receive an award and enrolled at another inst... |
| `latest.completion.outcome_percentage.part_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time students that did not receive an award and whose enrollment status... |
| `latest.completion.outcome_years.full_time.first_time` | `POOLYRSOM_FTFT` | integer | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_FTFT_PO... |
| `latest.completion.outcome_years.part_time.first_time` | `POOLYRSOM_PTFT` | integer | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PTFT_PO... |
| `latest.completion.outcome_years.full_time.not_first_time` | `POOLYRSOM_FTNFT` | integer | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_FTNFT_P... |
| `latest.completion.outcome_years.part_time.not_first_time` | `POOLYRSOM_PTNFT` | integer | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PTNFT_P... |
| `latest.completion.outcome_percentage_suppressed.full_time.first_time.6yr.award_pooled` | `OMAWDP6_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time student receiving an award within 6 years of entry, pooled in rolling a... |
| `latest.completion.outcome_percentage_suppressed.full_time.first_time.8yr.award_pooled` | `OMAWDP8_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time student receiving an award within 8 years of entry, pooled in rolling a... |
| `latest.completion.outcome_percentage_suppressed.full_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time students that did not receive an award and are still enrolled at this i... |
| `latest.completion.outcome_percentage_suppressed.full_time.first_time.8yr.transfer_pooled` | `OMENRAP8_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time students that did not receive an award and enrolled at another institut... |
| `latest.completion.outcome_percentage_suppressed.full_time.first_time.8yr.unknown_pooled` | `OMENRUP8_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time students that did not receive an award and whose enrollment status is u... |
| `latest.completion.outcome_percentage_suppressed.part_time.first_time.6yr.award_pooled` | `OMAWDP6_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time student receiving an award within 6 years of entry, pooled in rolling a... |
| `latest.completion.outcome_percentage_suppressed.part_time.first_time.8yr.award_pooled` | `OMAWDP8_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time student receiving an award within 8 years of entry, pooled in rolling a... |
| `latest.completion.outcome_percentage_suppressed.part_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time students that did not receive an award and are still enrolled at this i... |
| `latest.completion.outcome_percentage_suppressed.part_time.first_time.8yr.transfer_pooled` | `OMENRAP8_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time students that did not receive an award and enrolled at another institut... |
| `latest.completion.outcome_percentage_suppressed.part_time.first_time.8yr.unknown_pooled` | `OMENRUP8_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time students that did not receive an award and whose enrollment status is u... |
| `latest.completion.outcome_percentage_suppressed.full_time.not_first_time.6yr.award_pooled` | `OMAWDP6_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time student receiving an award within 6 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage_suppressed.full_time.not_first_time.8yr.award_pooled` | `OMAWDP8_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time student receiving an award within 8 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage_suppressed.full_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time students that did not receive an award and are still enrolled at th... |
| `latest.completion.outcome_percentage_suppressed.full_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time students that did not receive an award and enrolled at another inst... |
| `latest.completion.outcome_percentage_suppressed.full_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time students that did not receive an award and whose enrollment status... |
| `latest.completion.outcome_percentage_suppressed.part_time.not_first_time.6yr.award_pooled` | `OMAWDP6_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time student receiving an award within 6 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage_suppressed.part_time.not_first_time.8yr.award_pooled` | `OMAWDP8_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time student receiving an award within 8 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage_suppressed.part_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time students that did not receive an award and are still enrolled at th... |
| `latest.completion.outcome_percentage_suppressed.part_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time students that did not receive an award and enrolled at another inst... |
| `latest.completion.outcome_percentage_suppressed.part_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time students that did not receive an award and whose enrollment status... |
| `latest.completion.outcome_years.om_all_students` | `POOLYRSOM_ALL` | integer | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_ALL_POOLED |
| `latest.completion.outcome_years.om_first_time` | `POOLYRSOM_FIRSTTIME` | integer | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_FIRSTTIME_POOLED |
| `latest.completion.outcome_years.om_not_first_time` | `POOLYRSOM_NOTFIRSTTIME` | integer | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_NOTFIRSTTIME_POOLED |
| `latest.completion.outcome_years.om_full_time` | `POOLYRSOM_FULLTIME` | integer | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_FULLTIME_POOLED |
| `latest.completion.outcome_years.om_part_time` | `POOLYRSOM_PARTTIME` | integer | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PARTTIME_POOLED |
| `latest.completion.outcome_percentage.all_students.8yr.still_enrolled` | `OMENRYP_ALL` | float | 10 | Percentage of all students that did not receive an award and are still enrolled at this institution 8 years... |
| `latest.completion.outcome_percentage.all_students.8yr.transfer` | `OMENRAP_ALL` | float | 10 | Percentage of all students that did not receive an award and enrolled at another institution after leaving... |
| `latest.completion.outcome_percentage.all_students.8yr.award` | `OMAWDP8_ALL` | float | 10 | Percentage of all student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.all_students.8yr.unknown` | `OMENRUP_ALL` | float | 10 | Percentage of all students that did not receive an award and whose enrollment status is unknown after leavi... |
| `latest.completion.outcome_percentage.first_time.8yr.still_enrolled` | `OMENRYP_FIRSTTIME` | float | 10 | Percentage of first-time students that did not receive an award and are still enrolled at this institution... |
| `latest.completion.outcome_percentage.first_time.8yr.transfer` | `OMENRAP_FIRSTTIME` | float | 10 | Percentage of first-time students that did not receive an award and enrolled at another institution after l... |
| `latest.completion.outcome_percentage.first_time.8yr.award` | `OMAWDP8_FIRSTTIME` | float | 10 | Percentage of first-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.first_time.8yr.unknown` | `OMENRUP_FIRSTTIME` | float | 10 | Percentage of first-time students that did not receive an award and whose enrollment status is unknown afte... |
| `latest.completion.outcome_percentage.not_first_time.8yr.still_enrolled` | `OMENRYP_NOTFIRSTTIME` | float | 10 | Percentage of not first-time students that did not receive an award and are still enrolled at this institut... |
| `latest.completion.outcome_percentage.not_first_time.8yr.transfer` | `OMENRAP_NOTFIRSTTIME` | float | 10 | Percentage of not first-time students that did not receive an award and enrolled at another institution aft... |
| `latest.completion.outcome_percentage.not_first_time.8yr.award` | `OMAWDP8_NOTFIRSTTIME` | float | 10 | Percentage of not first-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.not_first_time.8yr.unknown` | `OMENRUP_NOTFIRSTTIME` | float | 10 | Percentage of not first-time students that did not receive an award and whose enrollment status is unknown... |
| `latest.completion.outcome_percentage.full_time.8yr.still_enrolled` | `OMENRYP_FULLTIME` | float | 10 | Percentage of full-time students that did not receive an award and are still enrolled at this institution 8... |
| `latest.completion.outcome_percentage.full_time.8yr.transfer` | `OMENRAP_FULLTIME` | float | 10 | Percentage of full-time students that did not receive an award and enrolled at another institution after le... |
| `latest.completion.outcome_percentage.full_time.8yr.award` | `OMAWDP8_FULLTIME` | float | 10 | Percentage of full-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.full_time.8yr.unknown` | `OMENRUP_FULLTIME` | float | 10 | Percentage of full-time students that did not receive an award and whose enrollment status is unknown after... |
| `latest.completion.outcome_percentage.part_time.8yr.still_enrolled` | `OMENRYP_PARTTIME` | float | 10 | Percentage of part-time students that did not receive an award and are still enrolled at this institution 8... |
| `latest.completion.outcome_percentage.part_time.8yr.transfer` | `OMENRAP_PARTTIME` | float | 10 | Percentage of part-time students that did not receive an award and enrolled at another institution after le... |
| `latest.completion.outcome_percentage.part_time.8yr.award` | `OMAWDP8_PARTTIME` | float | 10 | Percentage of part-time student receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage.part_time.8yr.unknown` | `OMENRUP_PARTTIME` | float | 10 | Percentage of part-time students that did not receive an award and whose enrollment status is unknown after... |
| `latest.completion.outcome_percentage_suppressed.all_students.8yr.still_enrolled_pooled` | `OMENRYP_ALL_POOLED_SUPP` | float | 1 | Percentage of all students that did not receive an award and are still enrolled at this institution 8 years... |
| `latest.completion.outcome_percentage_suppressed.all_students.8yr.transfer_pooled` | `OMENRAP_ALL_POOLED_SUPP` | float | 1 | Percentage of all students that did not receive an award and enrolled at another institution after leaving... |
| `latest.completion.outcome_percentage_suppressed.all_students.8yr.award_pooled` | `OMAWDP8_ALL_POOLED_SUPP` | float | 1 | Percentage of all student receiving an award within 8 years of entry, pooled in rolling averages and suppre... |
| `latest.completion.outcome_percentage_suppressed.all_students.8yr.unknown_pooled` | `OMENRUP_ALL_POOLED_SUPP` | float | 1 | Percentage of all students that did not receive an award and whose enrollment status is unknown after leavi... |
| `latest.completion.outcome_percentage_suppressed.first_time.8yr.still_enrolled_pooled` | `OMENRYP_FIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of first-time students that did not receive an award and are still enrolled at this institution... |
| `latest.completion.outcome_percentage_suppressed.first_time.8yr.transfer_pooled` | `OMENRAP_FIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of first-time students that did not receive an award and enrolled at another institution after l... |
| `latest.completion.outcome_percentage_suppressed.first_time.8yr.award_pooled` | `OMAWDP8_FIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of first-time student receiving an award within 8 years of entry, pooled in rolling averages and... |
| `latest.completion.outcome_percentage_suppressed.first_time.8yr.unknown_pooled` | `OMENRUP_FIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of first-time students that did not receive an award and whose enrollment status is unknown afte... |
| `latest.completion.outcome_percentage_suppressed.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP_NOTFIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of not first-time students that did not receive an award and are still enrolled at this institut... |
| `latest.completion.outcome_percentage_suppressed.not_first_time.8yr.transfer_pooled` | `OMENRAP_NOTFIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of not first-time students that did not receive an award and enrolled at another institution aft... |
| `latest.completion.outcome_percentage_suppressed.not_first_time.8yr.award_pooled` | `OMAWDP8_NOTFIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of not first-time student receiving an award within 8 years of entry, pooled in rolling averages... |
| `latest.completion.outcome_percentage_suppressed.not_first_time.8yr.unknown_pooled` | `OMENRUP_NOTFIRSTTIME_POOLED_SUPP` | float | 1 | Percentage of not first-time students that did not receive an award and whose enrollment status is unknown... |
| `latest.completion.outcome_percentage_suppressed.full_time.8yr.still_enrolled_pooled` | `OMENRYP_FULLTIME_POOLED_SUPP` | float | 1 | Percentage of full-time students that did not receive an award and are still enrolled at this institution 8... |
| `latest.completion.outcome_percentage_suppressed.full_time.8yr.transfer_pooled` | `OMENRAP_FULLTIME_POOLED_SUPP` | float | 1 | Percentage of full-time students that did not receive an award and enrolled at another institution after le... |
| `latest.completion.outcome_percentage_suppressed.full_time.8yr.award_pooled` | `OMAWDP8_FULLTIME_POOLED_SUPP` | float | 1 | Percentage of full-time student receiving an award within 8 years of entry, pooled in rolling averages and... |
| `latest.completion.outcome_percentage_suppressed.full_time.8yr.unknown_pooled` | `OMENRUP_FULLTIME_POOLED_SUPP` | float | 1 | Percentage of full-time students that did not receive an award and whose enrollment status is unknown after... |
| `latest.completion.outcome_percentage_suppressed.part_time.8yr.still_enrolled_pooled` | `OMENRYP_PARTTIME_POOLED_SUPP` | float | 1 | Percentage of part-time students that did not receive an award and are still enrolled at this institution 8... |
| `latest.completion.outcome_percentage_suppressed.part_time.8yr.transfer_pooled` | `OMENRAP_PARTTIME_POOLED_SUPP` | float | 1 | Percentage of part-time students that did not receive an award and enrolled at another institution after le... |
| `latest.completion.outcome_percentage_suppressed.part_time.8yr.award_pooled` | `OMAWDP8_PARTTIME_POOLED_SUPP` | float | 1 | Percentage of part-time student receiving an award within 8 years of entry, pooled in rolling averages and... |
| `latest.completion.outcome_percentage_suppressed.part_time.8yr.unknown_pooled` | `OMENRUP_PARTTIME_POOLED_SUPP` | float | 1 | Percentage of part-time students that did not receive an award and whose enrollment status is unknown after... |
| `latest.completion.rate_suppressed.consumer.median_by_pred_degree` | `MDCOMP_PD` | float | 0 | Median completion rate amongst insitutions with the same predominant degree category |
| `latest.completion.rate_suppressed.consumer.overall_median` | `MDCOMP_ALL` | float | 0 | Overall median of completion rate |
| `latest.completion.completion_cohort_lt_four_year_150_pell_pooled` | `D150_L4_PELL_POOLED` | integer | 1 | Adjusted cohort count for Pell Grant recipient completion rate at less-than-four-year institutions (denomin... |
| `latest.completion.completion_rate_lt_four_year_150_pell_pooled` | `C150_L4_PELL_POOLED` | float | 1 | Pell Grant recipient completion rate at less-than-four-year institutions, pooled for two-year rolling averages |
| `latest.completion.completion_cohort_four_year_150_pell_pooled` | `D150_4_PELL_POOLED` | integer | 1 | Adjusted cohort count for Pell Grant recipient completion rate at four-year institutions (denominator of 15... |
| `latest.completion.completion_rate_four_year_150_pell_pooled` | `C150_4_PELL_POOLED` | float | 1 | First-time, full-time Pell Grant recipient completion rate at four-year institutions, pooled for two-year r... |
| `latest.completion.rate_suppressed_pell.lt_four_year_150_pooled` | `C150_L4_PELL_POOLED_SUPP` | float | 1 | First-time, full-time Pell Grant recipient completion rate at less-than-four-year institutions, pooled for... |
| `latest.completion.rate_suppressed_pell.four_year_150_pooled` | `C150_4_PELL_POOLED_SUPP` | float | 1 | First-time, full-time Pell Grant recipient completion rate at four-year institutions, pooled for two-year r... |
| `latest.completion.pooled_yrs_used_pell_150` | `POOLYRS150_PELL` | integer | 1 | Years used for rolling averages of Pell Grant recipient completion rate C150_PELL_[4/L4]_POOLED |
| `latest.completion.outcome_percentage_pell.all_students.8yr.still_enrolled` | `OMENRYP_PELL_ALL` | float | 8 | Percentage of all Pell Grant recipient students that did not receive an award and are still enrolled at thi... |
| `latest.completion.outcome_percentage_pell.all_students.8yr.transfer` | `OMENRAP_PELL_ALL` | float | 8 | Percentage of all Pell Grant recipient students that did not receive an award and enrolled at another insti... |
| `latest.completion.outcome_percentage_pell.all_students.8yr.award` | `OMAWDP8_PELL_ALL` | float | 8 | Percentage of all Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.all_students.8yr.unknown` | `OMENRUP_PELL_ALL` | float | 8 | Percentage of all Pell Grant recipient students that did not receive an award and whose enrollment status i... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.still_enrolled` | `OMENRYP_PELL_FIRSTTIME` | float | 8 | Percentage of first-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.transfer` | `OMENRAP_PELL_FIRSTTIME` | float | 8 | Percentage of first-time Pell Grant recipient students that did not receive an award and enrolled at anothe... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.award` | `OMAWDP8_PELL_FIRSTTIME` | float | 8 | Percentage of first-time Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.first_time.8yr.unknown` | `OMENRUP_PELL_FIRSTTIME` | float | 8 | Percentage of first-time Pell Grant recipient students that did not receive an award and whose enrollment s... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.still_enrolled` | `OMENRYP_PELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time Pell Grant recipient students that did not receive an award and are still enro... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.transfer` | `OMENRAP_PELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time Pell Grant recipient students that did not receive an award and enrolled at an... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.award` | `OMAWDP8_PELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.unknown` | `OMENRUP_PELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time Pell Grant recipient students that did not receive an award and whose enrollme... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.still_enrolled` | `OMENRYP_PELL_FULLTIME` | float | 8 | Percentage of full-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.transfer` | `OMENRAP_PELL_FULLTIME` | float | 8 | Percentage of full-time Pell Grant recipient students that did not receive an award and enrolled at another... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.award` | `OMAWDP8_PELL_FULLTIME` | float | 8 | Percentage of full-time Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.full_time.8yr.unknown` | `OMENRUP_PELL_FULLTIME` | float | 8 | Percentage of full-time Pell Grant recipient students that did not receive an award and whose enrollment st... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.still_enrolled` | `OMENRYP_PELL_PARTTIME` | float | 8 | Percentage of part-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.transfer` | `OMENRAP_PELL_PARTTIME` | float | 8 | Percentage of part-time Pell Grant recipient students that did not receive an award and enrolled at another... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.award` | `OMAWDP8_PELL_PARTTIME` | float | 8 | Percentage of part-time Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.part_time.8yr.unknown` | `OMENRUP_PELL_PARTTIME` | float | 8 | Percentage of part-time Pell Grant recipient students that did not receive an award and whose enrollment st... |
| `latest.completion.outcome_cohort_pell.full_time.first_time.8yr` | `OMACHT8_PELL_FTFT` | integer | 8 | Adjusted cohort count of full-time, first-time Pell Grant recipient students (denominator for the 8-year ou... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.award` | `OMAWDP8_PELL_FTFT` | float | 8 | Percentage of full-time, first-time Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.still_enrolled` | `OMENRYP8_PELL_FTFT` | float | 8 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and are sti... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.transfer` | `OMENRAP8_PELL_FTFT` | float | 8 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and enrolle... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.unknown` | `OMENRUP8_PELL_FTFT` | float | 8 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and whose e... |
| `latest.completion.outcome_cohort_pell.part_time.first_time.8yr` | `OMACHT8_PELL_PTFT` | integer | 8 | Adjusted cohort count of part-time, first-time Pell Grant recipient students (denominator for the 8-year ou... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.award` | `OMAWDP8_PELL_PTFT` | float | 8 | Percentage of part-time, first-time Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.still_enrolled` | `OMENRYP8_PELL_PTFT` | float | 8 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and are sti... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.transfer` | `OMENRAP8_PELL_PTFT` | float | 8 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and enrolle... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.unknown` | `OMENRUP8_PELL_PTFT` | float | 8 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and whose e... |
| `latest.completion.outcome_cohort_pell.full_time.not_first_time.8yr` | `OMACHT8_PELL_FTNFT` | integer | 8 | Adjusted cohort count of full-time, not first-time Pell Grant recipient students (denominator for the 8-yea... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.award` | `OMAWDP8_PELL_FTNFT` | float | 8 | Percentage of full-time, not first-time Pell Grant recipient students receiving an award within 8 years of... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.still_enrolled` | `OMENRYP8_PELL_FTNFT` | float | 8 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and are... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.transfer` | `OMENRAP8_PELL_FTNFT` | float | 8 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and enr... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.unknown` | `OMENRUP8_PELL_FTNFT` | float | 8 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and who... |
| `latest.completion.outcome_cohort_pell.part_time.not_first_time.8yr` | `OMACHT8_PELL_PTNFT` | integer | 8 | Adjusted cohort count of part-time, not first-time Pell Grant recipient students (denominator for the 8-yea... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.award` | `OMAWDP8_PELL_PTNFT` | float | 8 | Percentage of part-time, not first-time Pell Grant recipient students receiving an award within 8 years of... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.still_enrolled` | `OMENRYP8_PELL_PTNFT` | float | 8 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and are... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.transfer` | `OMENRAP8_PELL_PTNFT` | float | 8 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and enr... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.unknown` | `OMENRUP8_PELL_PTNFT` | float | 8 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and who... |
| `latest.completion.outcome_cohort_pell.full_time.first_time.8yr_pooled` | `OMACHT8_PELL_FTFT_POOLED` | integer | 1 | Adjusted cohort count of full-time, first-time Pell Grant recipient students (denominator for the 8-year ou... |
| `latest.completion.outcome_cohort_pell.part_time.first_time.8yr_pooled` | `OMACHT8_PELL_PTFT_POOLED` | integer | 1 | Adjusted cohort count of part-time, first-time Pell Grant recipient students (denominator for the 8-year ou... |
| `latest.completion.outcome_cohort_pell.full_time.not_first_time.8yr_pooled` | `OMACHT8_PELL_FTNFT_POOLED` | integer | 1 | Adjusted cohort count of full-time, not first-time Pell Grant recipient students (denominator for the 8-yea... |
| `latest.completion.outcome_cohort_pell.part_time.not_first_time.8yr_pooled` | `OMACHT8_PELL_PTNFT_POOLED` | integer | 1 | Adjusted cohort count of part-time, not first-time Pell Grant recipient students (denominator for the 8-yea... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.award_pooled` | `OMAWDP8_PELL_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students receiving an award within 8 years of entr... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and are sti... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and enrolle... |
| `latest.completion.outcome_percentage_pell.full_time.first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_FTFT_POOLED` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and whose e... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.award_pooled` | `OMAWDP8_PELL_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students receiving an award within 8 years of entr... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and are sti... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and enrolle... |
| `latest.completion.outcome_percentage_pell.part_time.first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_PTFT_POOLED` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and whose e... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.award_pooled` | `OMAWDP8_PELL_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students receiving an award within 8 years of... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and are... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and enr... |
| `latest.completion.outcome_percentage_pell.full_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_FTNFT_POOLED` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and who... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.award_pooled` | `OMAWDP8_PELL_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students receiving an award within 8 years of... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and are... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and enr... |
| `latest.completion.outcome_percentage_pell.part_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_PTNFT_POOLED` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and who... |
| `latest.completion.outcome_percentage_pell.all_students.8yr.still_enrolled_pooled` | `OMENRYP_PELL_ALL_POOLED` | float | 1 | Percentage of all Pell Grant recipient students that did not receive an award and are still enrolled at thi... |
| `latest.completion.outcome_percentage_pell.all_students.8yr.transfer_pooled` | `OMENRAP_PELL_ALL_POOLED` | float | 1 | Percentage of all Pell Grant recipient students that did not receive an award and enrolled at another insti... |
| `latest.completion.outcome_percentage_pell.all_students.8yr.award_pooled` | `OMAWDP8_PELL_ALL_POOLED` | float | 1 | Percentage of all Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage_pell.all_students.8yr.unknown_pooled` | `OMENRUP_PELL_ALL_POOLED` | float | 1 | Percentage of all Pell Grant recipient students that did not receive an award and whose enrollment status i... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_FTT_POOLED` | float | 1 | Percentage of first-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.transfer_pooled` | `OMENRAP_PELL_FTT_POOLED` | float | 1 | Percentage of first-time Pell Grant recipient students that did not receive an award and enrolled at anothe... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.award_pooled` | `OMAWDP8_PELL_FTT_POOLED` | float | 1 | Percentage of first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled i... |
| `latest.completion.outcome_percentage_pell.first_time.8yr.unknown_pooled` | `OMENRUP_PELL_FTT_POOLED` | float | 1 | Percentage of first-time Pell Grant recipient students that did not receive an award and whose enrollment s... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_NFT_POOLED` | float | 1 | Percentage of not first-time Pell Grant recipient students that did not receive an award and are still enro... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.transfer_pooled` | `OMENRAP_PELL_NFT_POOLED` | float | 1 | Percentage of not first-time Pell Grant recipient students that did not receive an award and enrolled at an... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.award_pooled` | `OMAWDP8_PELL_NFT_POOLED` | float | 1 | Percentage of not first-time Pell Grant recipient students receiving an award within 8 years of entry, pool... |
| `latest.completion.outcome_percentage_pell.not_first_time.8yr.unknown_pooled` | `OMENRUP_PELL_NFT_POOLED` | float | 1 | Percentage of not first-time Pell Grant recipient students that did not receive an award and whose enrollme... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_FT_POOLED` | float | 1 | Percentage of full-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.transfer_pooled` | `OMENRAP_PELL_FT_POOLED` | float | 1 | Percentage of full-time Pell Grant recipient students that did not receive an award and enrolled at another... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.award_pooled` | `OMAWDP8_PELL_FT_POOLED` | float | 1 | Percentage of full-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in... |
| `latest.completion.outcome_percentage_pell.full_time.8yr.unknown_pooled` | `OMENRUP_PELL_FT_POOLED` | float | 1 | Percentage of full-time Pell Grant recipient students that did not receive an award and whose enrollment st... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_PT_POOLED` | float | 1 | Percentage of part-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.transfer_pooled` | `OMENRAP_PELL_PT_POOLED` | float | 1 | Percentage of part-time Pell Grant recipient students that did not receive an award and enrolled at another... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.award_pooled` | `OMAWDP8_PELL_PT_POOLED` | float | 1 | Percentage of part-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in... |
| `latest.completion.outcome_percentage_pell.part_time.8yr.unknown_pooled` | `OMENRUP_PELL_PT_POOLED` | float | 1 | Percentage of part-time Pell Grant recipient students that did not receive an award and whose enrollment st... |
| `latest.completion.outcome_years_pell.full_time.first_time` | `POOLYRSOM_PELL_FTFT` | float | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FT... |
| `latest.completion.outcome_years_pell.part_time.first_time` | `POOLYRSOM_PELL_PTFT` | float | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_PT... |
| `latest.completion.outcome_years_pell.full_time.not_first_time` | `POOLYRSOM_PELL_FTNFT` | float | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FT... |
| `latest.completion.outcome_years_pell.part_time.not_first_time` | `POOLYRSOM_PELL_PTNFT` | float | 1 | Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_PT... |
| `latest.completion.outcome_years_pell.om_all_students` | `POOLYRSOM_PELL_ALL` | float | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_ALL_POOLED |
| `latest.completion.outcome_years_pell.om_first_time` | `POOLYRSOM_PELL_FIRSTTIME` | float | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FTT_POOLED |
| `latest.completion.outcome_years_pell.om_not_first_time` | `POOLYRSOM_PELL_NOTFIRSTTIME` | float | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_NFT_POOLED |
| `latest.completion.outcome_years_pell.om_full_time` | `POOLYRSOM_PELL_FULLTIME` | float | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FT_POOLED |
| `latest.completion.outcome_years_pell.om_part_time` | `POOLYRSOM_PELL_PARTTIME` | float | 1 | Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_PT_POOLED |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.first_time.8yr.award_pooled` | `OMAWDP8_PELL_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students receiving an award within 8 years of entr... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and are sti... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and enrolle... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_FTFT_POOLED_SUPP` | float | 1 | Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and whose e... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.first_time.8yr.award_pooled` | `OMAWDP8_PELL_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students receiving an award within 8 years of entr... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and are sti... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and enrolle... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_PTFT_POOLED_SUPP` | float | 1 | Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and whose e... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.not_first_time.8yr.award_pooled` | `OMAWDP8_PELL_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students receiving an award within 8 years of... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and are... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and enr... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_FTNFT_POOLED_SUPP` | float | 1 | Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and who... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.not_first_time.8yr.award_pooled` | `OMAWDP8_PELL_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students receiving an award within 8 years of... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP8_PELL_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and are... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.not_first_time.8yr.transfer_pooled` | `OMENRAP8_PELL_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and enr... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.not_first_time.8yr.unknown_pooled` | `OMENRUP8_PELL_PTNFT_POOLED_SUPP` | float | 1 | Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and who... |
| `latest.completion.outcome_percentage_pell_suppressed.all_students.8yr.still_enrolled_pooled` | `OMENRYP_PELL_ALL_POOLED_SUPP` | float | 1 | Percentage of all Pell Grant recipient students that did not receive an award and are still enrolled at thi... |
| `latest.completion.outcome_percentage_pell_suppressed.all_students.8yr.transfer_pooled` | `OMENRAP_PELL_ALL_POOLED_SUPP` | float | 1 | Percentage of all Pell Grant recipient students that did not receive an award and enrolled at another insti... |
| `latest.completion.outcome_percentage_pell_suppressed.all_students.8yr.award_pooled` | `OMAWDP8_PELL_ALL_POOLED_SUPP` | float | 1 | Percentage of all Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolli... |
| `latest.completion.outcome_percentage_pell_suppressed.all_students.8yr.unknown_pooled` | `OMENRUP_PELL_ALL_POOLED_SUPP` | float | 1 | Percentage of all Pell Grant recipient students that did not receive an award and whose enrollment status i... |
| `latest.completion.outcome_percentage_pell_suppressed.first_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_FTT_POOLED_SUPP` | float | 1 | Percentage of first-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell_suppressed.first_time.8yr.transfer_pooled` | `OMENRAP_PELL_FTT_POOLED_SUPP` | float | 1 | Percentage of first-time Pell Grant recipient students that did not receive an award and enrolled at anothe... |
| `latest.completion.outcome_percentage_pell_suppressed.first_time.8yr.award_pooled` | `OMAWDP8_PELL_FTT_POOLED_SUPP` | float | 1 | Percentage of first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled i... |
| `latest.completion.outcome_percentage_pell_suppressed.first_time.8yr.unknown_pooled` | `OMENRUP_PELL_FTT_POOLED_SUPP` | float | 1 | Percentage of first-time Pell Grant recipient students that did not receive an award and whose enrollment s... |
| `latest.completion.outcome_percentage_pell_suppressed.not_first_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_NFT_POOLED_SUPP` | float | 1 | Percentage of not first-time Pell Grant recipient students that did not receive an award and are still enro... |
| `latest.completion.outcome_percentage_pell_suppressed.not_first_time.8yr.transfer_pooled` | `OMENRAP_PELL_NFT_POOLED_SUPP` | float | 1 | Percentage of not first-time Pell Grant recipient students that did not receive an award and enrolled at an... |
| `latest.completion.outcome_percentage_pell_suppressed.not_first_time.8yr.award_pooled` | `OMAWDP8_PELL_NFT_POOLED_SUPP` | float | 1 | Percentage of not first-time Pell Grant recipient students receiving an award within 8 years of entry, pool... |
| `latest.completion.outcome_percentage_pell_suppressed.not_first_time.8yr.unknown_pooled` | `OMENRUP_PELL_NFT_POOLED_SUPP` | float | 1 | Percentage of not first-time Pell Grant recipient students that did not receive an award and whose enrollme... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_FT_POOLED_SUPP` | float | 1 | Percentage of full-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.8yr.transfer_pooled` | `OMENRAP_PELL_FT_POOLED_SUPP` | float | 1 | Percentage of full-time Pell Grant recipient students that did not receive an award and enrolled at another... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.8yr.award_pooled` | `OMAWDP8_PELL_FT_POOLED_SUPP` | float | 1 | Percentage of full-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in... |
| `latest.completion.outcome_percentage_pell_suppressed.full_time.8yr.unknown_pooled` | `OMENRUP_PELL_FT_POOLED_SUPP` | float | 1 | Percentage of full-time Pell Grant recipient students that did not receive an award and whose enrollment st... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.8yr.still_enrolled_pooled` | `OMENRYP_PELL_PT_POOLED_SUPP` | float | 1 | Percentage of part-time Pell Grant recipient students that did not receive an award and are still enrolled... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.8yr.transfer_pooled` | `OMENRAP_PELL_PT_POOLED_SUPP` | float | 1 | Percentage of part-time Pell Grant recipient students that did not receive an award and enrolled at another... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.8yr.award_pooled` | `OMAWDP8_PELL_PT_POOLED_SUPP` | float | 1 | Percentage of part-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in... |
| `latest.completion.outcome_percentage_pell_suppressed.part_time.8yr.unknown_pooled` | `OMENRUP_PELL_PT_POOLED_SUPP` | float | 1 | Percentage of part-time Pell Grant recipient students that did not receive an award and whose enrollment st... |
| `latest.completion.outcome_percentage_nopell.all_students.8yr.still_enrolled` | `OMENRYP_NOPELL_ALL` | float | 8 | Percentage of all non-Pell Grant recipient students that did not receive an award and are still enrolled at... |
| `latest.completion.outcome_percentage_nopell.all_students.8yr.transfer` | `OMENRAP_NOPELL_ALL` | float | 8 | Percentage of all non-Pell Grant recipient students that did not receive an award and enrolled at another i... |
| `latest.completion.outcome_percentage_nopell.all_students.8yr.award` | `OMAWDP8_NOPELL_ALL` | float | 8 | Percentage of all non-Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_nopell.all_students.8yr.unknown` | `OMENRUP_NOPELL_ALL` | float | 8 | Percentage of all non-Pell Grant recipient students that did not receive an award and whose enrollment stat... |
| `latest.completion.outcome_percentage_nopell.first_time.8yr.still_enrolled` | `OMENRYP_NOPELL_FIRSTTIME` | float | 8 | Percentage of first-time non-Pell Grant recipient students that did not receive an award and are still enro... |
| `latest.completion.outcome_percentage_nopell.first_time.8yr.transfer` | `OMENRAP_NOPELL_FIRSTTIME` | float | 8 | Percentage of first-time non-Pell Grant recipient students that did not receive an award and enrolled at an... |
| `latest.completion.outcome_percentage_nopell.first_time.8yr.award` | `OMAWDP8_NOPELL_FIRSTTIME` | float | 8 | Percentage of first-time non-Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_nopell.first_time.8yr.unknown` | `OMENRUP_NOPELL_FIRSTTIME` | float | 8 | Percentage of first-time non-Pell Grant recipient students that did not receive an award and whose enrollme... |
| `latest.completion.outcome_percentage_nopell.not_first_time.8yr.still_enrolled` | `OMENRYP_NOPELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time non-Pell Grant recipient students that did not receive an award and are still... |
| `latest.completion.outcome_percentage_nopell.not_first_time.8yr.transfer` | `OMENRAP_NOPELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time non-Pell Grant recipient students that did not receive an award and enrolled a... |
| `latest.completion.outcome_percentage_nopell.not_first_time.8yr.award` | `OMAWDP8_NOPELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time non-Pell Grant recipient students receiving an award within 8 years of entry |
| `latest.completion.outcome_percentage_nopell.not_first_time.8yr.unknown` | `OMENRUP_NOPELL_NOTFIRSTTIME` | float | 8 | Percentage of not first-time non-Pell Grant recipient students that did not receive an award and whose enro... |
| `latest.completion.outcome_cohort_nopell.all.8yr` | `OMACHT8_NOPELL_ALL` | integer | 8 | Adjusted cohort count of non-Pell Grant recipeint students (denominator for the 8-year outcomes percentages) |
| `latest.completion.outcome_cohort_nopell.first_time.8yr` | `OMACHT8_NOPELL_FIRSTTIME` | integer | 8 | Adjusted cohort count of first-time non-Pell Grant recipient students (denominator for the 8-year outcomes... |
| `latest.completion.outcome_cohort_nopell.not_first_time.8yr` | `OMACHT8_NOPELL_NOTFIRSTTIME` | integer | 8 | Adjusted cohort count of non-first-time non-Pell Grant recipient students (denominator for the 8-year outco... |

---

## 9. `earnings` - 185 variables

> What graduates earn: median/mean earnings and counts of working vs not working 1-11 years after entry or after completion, plus earnings thresholds.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.earnings.student_count` | `COUNT_ED` | integer | 0 | Count of students in the earnings cohort |
| `latest.earnings.10_yrs_after_entry.not_working_not_enrolled.overall` | `COUNT_NWNE_P10` | integer | 7 | Number of students not working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.overall` | `COUNT_WNE_P10` | integer | 7 | Number of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.mean_earnings` | `MN_EARN_WNE_P10` | integer | 6 | Mean earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.median` | `MD_EARN_WNE_P10` | integer | 7 | Median earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10` | `PCT10_EARN_WNE_P10` | integer | 3 | 10th percentile of earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.25` | `PCT25_EARN_WNE_P10` | integer | 7 | 25th percentile of earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.75` | `PCT75_EARN_WNE_P10` | integer | 7 | 75th percentile of earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.90` | `PCT90_EARN_WNE_P10` | integer | 3 | 90th percentile of earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.std_dev` | `SD_EARN_WNE_P10` | integer | 7 | Standard deviation of earnings of students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.income.lowest_tercile` | `COUNT_WNE_INC1_P10` | integer | 7 | Number of students working and not enrolled 10 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.income.middle_tercile` | `COUNT_WNE_INC2_P10` | integer | 7 | Number of students working and not enrolled 10 years after entry in the middle income tercile $30,001-$75,000 |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.income.highest_tercile` | `COUNT_WNE_INC3_P10` | integer | 7 | Number of students working and not enrolled 10 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.dependent_students_lowest_tercile` | `COUNT_WNE_INDEP0_INC1_P10` | integer | 3 | Number of dependent students working and not enrolled 10 years after entry in the lowest income tercile $0-... |
| `latest.earnings.10_yrs_after_entry.working_not_enrolled.dependent_students` | `COUNT_WNE_INDEP0_P10` | integer | 7 | Number of dependent students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.independent_students` | `COUNT_WNE_INDEP1_P10` | integer | 7 | Number of independent students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.female_students` | `COUNT_WNE_MALE0_P10` | integer | 7 | Number of female students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.male_students` | `COUNT_WNE_MALE1_P10` | integer | 7 | Number of male students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.percent_greater_than_25000` | `GT_25K_P10` | float | 5 | Share of students earning over $25,000/year (threshold earnings) 10 years after entry |
| `latest.earnings.10_yrs_after_entry.percent_greater_than_28000` | `GT_28K_P10` | float | 1 | Share of students earning over $28,000/year (threshold earnings) 10 years after entry |
| `latest.earnings.10_yrs_after_entry.mean_earnings.lowest_tercile` | `MN_EARN_WNE_INC1_P10` | integer | 6 | Mean earnings of students working and not enrolled 10 years after entry in the lowest income tercile $0-$30... |
| `latest.earnings.10_yrs_after_entry.mean_earnings.middle_tercile` | `MN_EARN_WNE_INC2_P10` | integer | 6 | Mean earnings of students working and not enrolled 10 years after entry in the middle income tercile $30,00... |
| `latest.earnings.10_yrs_after_entry.mean_earnings.highest_tercile` | `MN_EARN_WNE_INC3_P10` | integer | 6 | Mean earnings of students working and not enrolled 10 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.10_yrs_after_entry.mean_earnings.dependent_students_lowest_tercile` | `MN_EARN_WNE_INDEP0_INC1_P10` | integer | 3 | Mean earnings of dependent students working and not enrolled 10 years after entry in the lowest income terc... |
| `latest.earnings.10_yrs_after_entry.mean_earnings.dependent_students` | `MN_EARN_WNE_INDEP0_P10` | integer | 6 | Mean earnings of dependent students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.mean_earnings.independent_students` | `MN_EARN_WNE_INDEP1_P10` | integer | 6 | Mean earnings of independent students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.mean_earnings.female_students` | `MN_EARN_WNE_MALE0_P10` | integer | 6 | Mean earnings of female students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.mean_earnings.male_students` | `MN_EARN_WNE_MALE1_P10` | integer | 6 | Mean earnings of male students working and not enrolled 10 years after entry |
| `latest.earnings.6_yrs_after_entry.not_working_not_enrolled.overall` | `COUNT_NWNE_P6` | integer | 9 | Number of students not working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.overall` | `COUNT_WNE_P6` | integer | 9 | Number of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.mean_earnings` | `MN_EARN_WNE_P6` | integer | 8 | Mean earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.median` | `MD_EARN_WNE_P6` | integer | 9 | Median earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.earnings_percentile.10` | `PCT10_EARN_WNE_P6` | integer | 5 | 10th percentile of earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.earnings_percentile.25` | `PCT25_EARN_WNE_P6` | integer | 9 | 25th percentile of earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.earnings_percentile.75` | `PCT75_EARN_WNE_P6` | integer | 9 | 75th percentile of earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.earnings_percentile.90` | `PCT90_EARN_WNE_P6` | integer | 5 | 90th percentile of earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.std_dev` | `SD_EARN_WNE_P6` | integer | 9 | Standard deviation of earnings of students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.income.lowest_tercile` | `COUNT_WNE_INC1_P6` | integer | 9 | Number of students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.income.middle_tercile` | `COUNT_WNE_INC2_P6` | integer | 9 | Number of students working and not enrolled 6 years after entry in the middle income tercile $30,001-$75,000 |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.income.highest_tercile` | `COUNT_WNE_INC3_P6` | integer | 9 | Number of students working and not enrolled 6 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.dependent_students_lowest_tercile` | `COUNT_WNE_INDEP0_INC1_P6` | integer | 5 | Number of dependent students working and not enrolled 6 years after entry in the lowest income tercile $0-$... |
| `latest.earnings.6_yrs_after_entry.working_not_enrolled.dependent_students` | `COUNT_WNE_INDEP0_P6` | integer | 9 | Number of dependent students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.independent_students` | `COUNT_WNE_INDEP1_P6` | integer | 9 | Number of independent students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.female_students` | `COUNT_WNE_MALE0_P6` | integer | 9 | Number of female students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.male_students` | `COUNT_WNE_MALE1_P6` | integer | 9 | Number of male students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.percent_greater_than_25000` | `GT_25K_P6` | float | 7 | Share of students earning over $25,000/year (threshold earnings) 6 years after entry |
| `latest.earnings.6_yrs_after_entry.percent_greater_than_28000` | `GT_28K_P6` | float | 1 | Share of students earning over $28,000/year (threshold earnings) 6 years after entry |
| `latest.earnings.6_yrs_after_entry.mean_earnings.lowest_tercile` | `MN_EARN_WNE_INC1_P6` | float | 8 | Mean earnings of students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.6_yrs_after_entry.mean_earnings.middle_tercile` | `MN_EARN_WNE_INC2_P6` | float | 8 | Mean earnings of students working and not enrolled 6 years after entry in the middle income tercile $30,001... |
| `latest.earnings.6_yrs_after_entry.mean_earnings.highest_tercile` | `MN_EARN_WNE_INC3_P6` | float | 8 | Mean earnings of students working and not enrolled 6 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.6_yrs_after_entry.mean_earnings.dependent_students_lowest_tercile` | `MN_EARN_WNE_INDEP0_INC1_P6` | float | 5 | Mean earnings of dependent students working and not enrolled 6 years after entry in the lowest income terci... |
| `latest.earnings.6_yrs_after_entry.mean_earnings.dependent_students` | `MN_EARN_WNE_INDEP0_P6` | float | 8 | Mean earnings of dependent students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.mean_earnings.independent_students` | `MN_EARN_WNE_INDEP1_P6` | float | 8 | Mean earnings of independent students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.mean_earnings.female_students` | `MN_EARN_WNE_MALE0_P6` | float | 8 | Mean earnings of female students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.mean_earnings.male_students` | `MN_EARN_WNE_MALE1_P6` | float | 8 | Mean earnings of male students working and not enrolled 6 years after entry |
| `latest.earnings.7_yrs_after_entry.not_working_not_enrolled` | `COUNT_NWNE_P7` | float | 5 | Number of students not working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.overall` | `COUNT_WNE_P7` | integer | 6 | Number of students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.mean_earnings` | `MN_EARN_WNE_P7` | float | 4 | Mean earnings of students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.std_dev` | `SD_EARN_WNE_P7` | float | 5 | Standard deviation of earnings of students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.percent_greater_than_25000` | `GT_25K_P7` | float | 4 | Share of students earning over $25,000/year (threshold earnings) 7 years after entry |
| `latest.earnings.8_yrs_after_entry.not_working_not_enrolled` | `COUNT_NWNE_P8` | integer | 8 | Number of students not working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled` | `COUNT_WNE_P8` | integer | 8 | Number of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.mean_earnings` | `MN_EARN_WNE_P8` | float | 7 | Mean earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.median_earnings` | `MD_EARN_WNE_P8` | float | 8 | Median earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.10th_percentile_earnings` | `PCT10_EARN_WNE_P8` | integer | 4 | 10th percentile of earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.25th_percentile_earnings` | `PCT25_EARN_WNE_P8` | integer | 8 | 25th percentile of earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.75th_percentile_earnings` | `PCT75_EARN_WNE_P8` | integer | 8 | 75th percentile of earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.90th_percentile_earnings` | `PCT90_EARN_WNE_P8` | integer | 4 | 90th percentile of earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.std_deviation` | `SD_EARN_WNE_P8` | float | 8 | Standard deviation of earnings of students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.percent_greater_than_25000` | `GT_25K_P8` | float | 6 | Share of students earning over $25,000/year (threshold earnings) 8 years after entry |
| `latest.earnings.8_yrs_after_entry.percent_greater_than_28000` | `GT_28K_P8` | float | 1 | Share of students earning over $28,000/year (threshold earnings) 8 years after entry |
| `latest.earnings.9_yrs_after_entry.not_working_not_enrolled` | `COUNT_NWNE_P9` | integer | 4 | Number of students not working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled` | `COUNT_WNE_P9` | integer | 5 | Number of students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.mean_earnings` | `MN_EARN_WNE_P9` | float | 3 | Mean earnings of students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.std_deviation` | `SD_EARN_WNE_P9` | float | 4 | Standard deviation of earnings of students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.percent_greater_than_25000` | `GT_25K_P9` | float | 3 | Share of students earning over $25,000/year (threshold earnings) 9 years after entry |
| `latest.earnings.3_yrs_after_completion.not_working_not_enrolled.overall_count` | `COUNT_NWNE_3YR` | integer | 2 | Number of graduates not working and not enrolled 3 years after completing |
| `latest.earnings.3_yrs_after_completion.working_not_enrolled.overall_count` | `COUNT_WNE_3YR` | integer | 2 | Number of graduates working and not enrolled 3 years after completing |
| `latest.earnings.3_yrs_after_completion.overall_count_over_poverty_line` | `CNTOVER150_3YR` | integer | 2 | Number of graduates working and not enrolled who earned more than 150% of the single-person household pover... |
| `latest.earnings.consumer.median_by_pred_degree` | `MDEARN_PD` | float | 0 | Median earnings of students working and not enrolled 4 years after completion |
| `latest.earnings.consumer.overall_median` | `MDEARN_ALL` | float | 0 | Overall median earnings of students working and not enrolled 4 years after completion |
| `latest.earnings.1_yr_after_completion.not_working_not_enrolled.overall_count` | `COUNT_NWNE_1YR` | integer | 3 | Number of graduates working and not enrolled 1 year after completing |
| `latest.earnings.1_yr_after_completion.working_not_enrolled.overall_count` | `COUNT_WNE_1YR` | integer | 3 | Number of graduates not working and not enrolled 1 year after completing |
| `latest.earnings.1_yr_after_completion.overall_count_over_poverty_line` | `CNTOVER150_1YR` | integer | 1 | Number of graduates working and not enrolled who earned more than 150% of the single-person household pover... |
| `latest.earnings.6_yrs_after_entry.gt_threshold` | `GT_THRESHOLD_P6` | float | 1 | Share of students earning more than a high school graduate (threshold earnings) 6 years after entry |
| `latest.earnings.6_yrs_after_entry.gt_threshold_suppressed` | `GT_THRESHOLD_P6_SUPP` | float | 1 | Share of students earning more than a high school graduate (threshold earnings) 6 years after entry, suppre... |
| `latest.earnings.6_yrs_after_entry.median_earnings_lowest_tercile` | `MD_EARN_WNE_INC1_P6` | integer | 1 | Median earnings of students working and not enrolled 6 years after entry in the lowest income tercile $0-$3... |
| `latest.earnings.6_yrs_after_entry.median_earnings_middle_tercile` | `MD_EARN_WNE_INC2_P6` | integer | 1 | Median earnings of students working and not enrolled 6 years after entry in the middle income tercile $30,0... |
| `latest.earnings.6_yrs_after_entry.median_earnings_highest_tercile` | `MD_EARN_WNE_INC3_P6` | integer | 1 | Median earnings of students working and not enrolled 6 years after entry in the highest income tercile $75,... |
| `latest.earnings.6_yrs_after_entry.median_earnings_independent` | `MD_EARN_WNE_INDEP1_P6` | integer | 1 | Median earnings of independent students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.median_earnings_dependent` | `MD_EARN_WNE_INDEP0_P6` | integer | 1 | Median earnings of dependent students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.median_earnings_non_male` | `MD_EARN_WNE_MALE0_P6` | integer | 1 | Median earnings of non-male students working and not enrolled 6 years after entry |
| `latest.earnings.6_yrs_after_entry.median_earnings_male` | `MD_EARN_WNE_MALE1_P6` | integer | 1 | Median earnings of male students working and not enrolled 6 years after entry |
| `latest.earnings.8_yrs_after_entry.gt_threshold` | `GT_THRESHOLD_P8` | float | 1 | Share of students earning more than a high school graduate (threshold earnings) 8 years after entry |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_lowest_tercile` | `COUNT_WNE_INC1_P8` | integer | 3 | Number of students working and not enrolled 8 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.8_yrs_after_entry.median_earnings_lowest_tercile` | `MD_EARN_WNE_INC1_P8` | integer | 1 | Median earnings of students working and not enrolled 8 years after entry in the lowest income tercile $0-$3... |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_middle_tercile` | `COUNT_WNE_INC2_P8` | integer | 3 | Number of students working and not enrolled 8 years after entry in the middle income tercile $30,001-$75,000 |
| `latest.earnings.8_yrs_after_entry.median_earnings_middle_tercile` | `MD_EARN_WNE_INC2_P8` | integer | 1 | Median earnings of students working and not enrolled 8 years after entry in the middle income tercile $30,0... |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_highest_tercile` | `COUNT_WNE_INC3_P8` | integer | 3 | Number of students working and not enrolled 8 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.8_yrs_after_entry.median_earnings_highest_tercile` | `MD_EARN_WNE_INC3_P8` | integer | 1 | Median earnings of students working and not enrolled 8 years after entry in the highest income tercile $75,... |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_independent` | `COUNT_WNE_INDEP1_P8` | integer | 3 | Number of independent students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.median_earnings_independent` | `MD_EARN_WNE_INDEP1_P8` | integer | 1 | Median earnings of independent students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_dependent` | `COUNT_WNE_INDEP0_P8` | integer | 3 | Number of dependent students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.median_earnings_dependent` | `MD_EARN_WNE_INDEP0_P8` | integer | 1 | Median earnings of dependent students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_non_male` | `COUNT_WNE_MALE0_P8` | integer | 3 | Number of non-male students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.median_earnings_non_male` | `MD_EARN_WNE_MALE0_P8` | integer | 1 | Median earnings of non-male students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.working_not_enrolled_male` | `COUNT_WNE_MALE1_P8` | integer | 3 | Number of male students working and not enrolled 8 years after entry |
| `latest.earnings.8_yrs_after_entry.median_earnings_male` | `MD_EARN_WNE_MALE1_P8` | integer | 1 | Median earnings of male students working and not enrolled 8 years after entry |
| `latest.earnings.10_yrs_after_entry.gt_threshold` | `GT_THRESHOLD_P10` | float | 1 | Share of students earning more than a high school graduate (threshold earnings) 10 years after entry |
| `latest.earnings.10_yrs_after_entry.median_earnings.lowest_tercile` | `MD_EARN_WNE_INC1_P10` | integer | 1 | Median earnings of students working and not enrolled 10 years after entry in the lowest income tercile $0-$... |
| `latest.earnings.10_yrs_after_entry.median_earnings.middle_tercile` | `MD_EARN_WNE_INC2_P10` | integer | 1 | Median earnings of students working and not enrolled 10 years after entry in the middle income tercile $30,... |
| `latest.earnings.10_yrs_after_entry.median_earnings.highest_tercile` | `MD_EARN_WNE_INC3_P10` | integer | 1 | Median earnings of students working and not enrolled 10 years after entry in the highest income tercile $75... |
| `latest.earnings.10_yrs_after_entry.median_earnings.independent_students` | `MD_EARN_WNE_INDEP1_P10` | integer | 1 | Median earnings of independent students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.median_earnings.dependent_students` | `MD_EARN_WNE_INDEP0_P10` | integer | 1 | Median earnings of dependent students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.median_earnings.non_male_students` | `MD_EARN_WNE_MALE0_P10` | integer | 1 | Median earnings of non-male students working and not enrolled 10 years after entry |
| `latest.earnings.10_yrs_after_entry.median_earnings.male_students` | `MD_EARN_WNE_MALE1_P10` | integer | 1 | Median earnings of male students working and not enrolled 10 years after entry |
| `latest.earnings.1_yr_after_completion.median` | `MD_EARN_WNE_1YR` | integer | 2 | Median earnings of graduates working and not enrolled 1 year after completing |
| `latest.earnings.1_yr_after_completion.overall_count_gt_hs_grad` | `GT_THRESHOLD_1YR` | integer | 2 | Number of graduates working and not enrolled who earned more than a high school graduate 1 year after compl... |
| `latest.earnings.4_yrs_after_completion.not_working_not_enrolled.overall_count` | `COUNT_NWNE_4YR` | integer | 1 | Number of graduates not working and not enrolled 4 years after completing |
| `latest.earnings.4_yrs_after_completion.working_not_enrolled.overall_count` | `COUNT_WNE_4YR` | integer | 2 | Number of graduates working and not enrolled 4 years after completing |
| `latest.earnings.4_yrs_after_completion.median` | `MD_EARN_WNE_4YR` | integer | 2 | Median earnings of graduates working and not enrolled 4 years after completing |
| `latest.earnings.4_yrs_after_completion.overall_count_gt_hs_grad` | `GT_THRESHOLD_4YR` | integer | 1 | Number of graduates working and not enrolled who earned more than a high school graduate 4 years after comp... |
| `latest.earnings.5_yrs_after_completion.not_working_not_enrolled.overall_count` | `COUNT_NWNE_5YR` | integer | 1 | Number of graduates not working and not enrolled 5 years after completing |
| `latest.earnings.5_yrs_after_completion.working_not_enrolled.overall_count` | `COUNT_WNE_5YR` | integer | 1 | Number of graduates working and not enrolled 5 years after completing |
| `latest.earnings.5_yrs_after_completion.median` | `MD_EARN_WNE_5YR` | integer | 1 | Median earnings of graduates working and not enrolled 5 years after completing |
| `latest.earnings.5_yrs_after_completion.overall_count_gt_hs_grad` | `GT_THRESHOLD_5YR` | integer | 1 | Number of graduates working and not enrolled who earned more than a high school graduate 5 years after comp... |
| `latest.earnings.7_yrs_after_entry.median` | `MD_EARN_WNE_P7` | integer | 2 | Median earnings of students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.earnings_percentile.25` | `PCT25_EARN_WNE_P7` | integer | 2 | 25th percentile of earnings of students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.earnings_percentile.75` | `PCT75_EARN_WNE_P7` | integer | 2 | 75th percentile of earnings of students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.income.lowest_tercile` | `COUNT_WNE_INC1_P7` | integer | 2 | Number of students working and not enrolled 7 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.income.middle_tercile` | `COUNT_WNE_INC2_P7` | integer | 2 | Number of students working and not enrolled 7 years after entry in the middle income tercile $30,001-$75,000 |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.income.highest_tercile` | `COUNT_WNE_INC3_P7` | integer | 2 | Number of students working and not enrolled 7 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.7_yrs_after_entry.working_not_enrolled.dependent_students` | `COUNT_WNE_INDEP0_P7` | integer | 2 | Number of dependent students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.independent_students` | `COUNT_WNE_INDEP1_P7` | integer | 2 | Number of independent students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.female_students` | `COUNT_WNE_MALE0_P7` | integer | 2 | Number of female students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.male_students` | `COUNT_WNE_MALE1_P7` | integer | 2 | Number of male students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.gt_threshold` | `GT_THRESHOLD_P7` | float | 2 | Share of students earning more than a high school graduate (threshold earnings) 7 years after entry |
| `latest.earnings.7_yrs_after_entry.median_earnings_lowest_tercile` | `MD_EARN_WNE_INC1_P7` | integer | 2 | Median earnings of students working and not enrolled 7 years after entry in the lowest income tercile $0-$3... |
| `latest.earnings.7_yrs_after_entry.median_earnings_middle_tercile` | `MD_EARN_WNE_INC2_P7` | integer | 2 | Median earnings of students working and not enrolled 7 years after entry in the middle income tercile $30,0... |
| `latest.earnings.7_yrs_after_entry.median_earnings_highest_tercile` | `MD_EARN_WNE_INC3_P7` | integer | 2 | Median earnings of students working and not enrolled 7 years after entry in the highest income tercile $75,... |
| `latest.earnings.7_yrs_after_entry.median_earnings_independent` | `MD_EARN_WNE_INDEP1_P7` | integer | 2 | Median earnings of independent students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.median_earnings_dependent` | `MD_EARN_WNE_INDEP0_P7` | integer | 2 | Median earnings of dependent students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.median_earnings_non_male` | `MD_EARN_WNE_MALE0_P7` | integer | 2 | Median earnings of non-male students working and not enrolled 7 years after entry |
| `latest.earnings.7_yrs_after_entry.median_earnings_male` | `MD_EARN_WNE_MALE1_P7` | integer | 2 | Median earnings of male students working and not enrolled 7 years after entry |
| `latest.earnings.9_yrs_after_entry.median_earnings` | `MD_EARN_WNE_P9` | float | 2 | Median earnings of students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.25th_percentile_earnings` | `PCT25_EARN_WNE_P9` | integer | 2 | 25th percentile of earnings of students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.75th_percentile_earnings` | `PCT75_EARN_WNE_P9` | integer | 2 | 75th percentile of earnings of students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_lowest_tercile` | `COUNT_WNE_INC1_P9` | integer | 2 | Number of students working and not enrolled 9 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_middle_tercile` | `COUNT_WNE_INC2_P9` | integer | 2 | Number of students working and not enrolled 9 years after entry in the middle income tercile $30,001-$75,000 |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_highest_tercile` | `COUNT_WNE_INC3_P9` | integer | 2 | Number of students working and not enrolled 9 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_dependent` | `COUNT_WNE_INDEP0_P9` | integer | 2 | Number of dependent students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_independent` | `COUNT_WNE_INDEP1_P9` | integer | 2 | Number of independent students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_non_male` | `COUNT_WNE_MALE0_P9` | integer | 2 | Number of non-male students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.working_not_enrolled_male` | `COUNT_WNE_MALE1_P9` | integer | 2 | Number of male students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.gt_threshold` | `GT_THRESHOLD_P9` | float | 2 | Share of students earning more than a high school graduate (threshold earnings) 9 years after entry |
| `latest.earnings.9_yrs_after_entry.median_earnings_lowest_tercile` | `MD_EARN_WNE_INC1_P9` | integer | 2 | Median earnings of students working and not enrolled 9 years after entry in the lowest income tercile $0-$3... |
| `latest.earnings.9_yrs_after_entry.median_earnings_middle_tercile` | `MD_EARN_WNE_INC2_P9` | integer | 2 | Median earnings of students working and not enrolled 9 years after entry in the middle income tercile $30,0... |
| `latest.earnings.9_yrs_after_entry.median_earnings_highest_tercile` | `MD_EARN_WNE_INC3_P9` | integer | 2 | Median earnings of students working and not enrolled 9 years after entry in the highest income tercile $75,... |
| `latest.earnings.9_yrs_after_entry.median_earnings_dependent` | `MD_EARN_WNE_INDEP0_P9` | integer | 2 | Median earnings of dependent students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.median_earnings_independent` | `MD_EARN_WNE_INDEP1_P9` | integer | 2 | Median earnings of independent students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.median_earnings_non_male` | `MD_EARN_WNE_MALE0_P9` | integer | 2 | Median earnings of non-male students working and not enrolled 9 years after entry |
| `latest.earnings.9_yrs_after_entry.median_earnings_male` | `MD_EARN_WNE_MALE1_P9` | integer | 2 | Median earnings of male students working and not enrolled 9 years after entry |
| `latest.earnings.11_yrs_after_entry.not_working_not_enrolled.overall` | `COUNT_NWNE_P11` | integer | 1 | Number of students not working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.overall` | `COUNT_WNE_P11` | integer | 2 | Number of students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.median` | `MD_EARN_WNE_P11` | integer | 2 | Median earnings of students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.earnings_percentile.25` | `PCT25_EARN_WNE_P11` | integer | 2 | 25th percentile of earnings of students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.earnings_percentile.75` | `PCT75_EARN_WNE_P11` | integer | 2 | 75th percentile of earnings of students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.std_dev` | `SD_EARN_WNE_P11` | integer | 1 | Standard deviation of earnings of students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.income.lowest_tercile` | `COUNT_WNE_INC1_P11` | integer | 2 | Number of students working and not enrolled 11 years after entry in the lowest income tercile $0-$30,000 |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.income.middle_tercile` | `COUNT_WNE_INC2_P11` | integer | 2 | Number of students working and not enrolled 11 years after entry in the middle income tercile $30,001-$75,000 |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.income.highest_tercile` | `COUNT_WNE_INC3_P11` | integer | 2 | Number of students working and not enrolled 11 years after entry in the highest income tercile $75,001+ |
| `latest.earnings.11_yrs_after_entry.working_not_enrolled.dependent_students` | `COUNT_WNE_INDEP0_P11` | integer | 2 | Number of dependent students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.independent_students` | `COUNT_WNE_INDEP1_P11` | integer | 2 | Number of independent students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.female_students` | `COUNT_WNE_MALE0_P11` | integer | 2 | Number of female students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.male_students` | `COUNT_WNE_MALE1_P11` | integer | 2 | Number of male students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.gt_threshold` | `GT_THRESHOLD_P11` | float | 2 | Share of students earning more than a high school graduate (threshold earnings) 11 years after entry |
| `latest.earnings.11_yrs_after_entry.median_earnings.lowest_tercile` | `MD_EARN_WNE_INC1_P11` | integer | 2 | Median earnings of students working and not enrolled 11 years after entry in the lowest income tercile $0-$... |
| `latest.earnings.11_yrs_after_entry.median_earnings.middle_tercile` | `MD_EARN_WNE_INC2_P11` | integer | 2 | Median earnings of students working and not enrolled 11 years after entry in the middle income tercile $30,... |
| `latest.earnings.11_yrs_after_entry.median_earnings.highest_tercile` | `MD_EARN_WNE_INC3_P11` | integer | 2 | Median earnings of students working and not enrolled 11 years after entry in the highest income tercile $75... |
| `latest.earnings.11_yrs_after_entry.median_earnings.dependent_students` | `MD_EARN_WNE_INDEP0_P11` | integer | 2 | Median earnings of dependent students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.median_earnings.independent_students` | `MD_EARN_WNE_INDEP1_P11` | integer | 2 | Median earnings of independent students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.median_earnings.non_male_students` | `MD_EARN_WNE_MALE0_P11` | integer | 2 | Median earnings of non-male students working and not enrolled 11 years after entry |
| `latest.earnings.11_yrs_after_entry.median_earnings.male_students` | `MD_EARN_WNE_MALE1_P11` | integer | 2 | Median earnings of male students working and not enrolled 11 years after entry |
| `latest.earnings.hsearn.threshold.state` | `EARN_THR_STATE` | integer | 1 | Median earnings of high school graduates aged 25 to 34 in the institution state |
| `latest.earnings.hsearn.threshold.national` | `EARN_THR_NAT` | integer | 1 | Median earnings of high school graduates aged 25 to 24 in the United States |

---

## 10. `repayment` - 1094 variables

> Whether loans get repaid: cohort default rates, repayment rates at 1/3/5/7 years, and balance-based repayment rates (BBRR/DBRR) split by demographics and cohorts.

| API field path | Raw column name | Type | Years | Variable meaning |
|---|---|---|---|---|
| `latest.repayment.2_yr_default_rate` | `CDR2` | float | 17 | Two-year cohort default rate |
| `latest.repayment.3_yr_default_rate` | `CDR3` | float | 14 | Three-year cohort default rate |
| `latest.repayment.repayment_cohort.1_year_declining_balance` | `RPY_1YR_RT` | float | 8 | Fraction of repayment cohort who are not in default, and with loan balances that have declined one year sin... |
| `latest.repayment.1_yr_repayment.completers_rate` | `COMPL_RPY_1YR_RT` | float | 8 | One-year repayment rate for completers |
| `latest.repayment.1_yr_repayment.noncompleters_rate` | `NONCOM_RPY_1YR_RT` | float | 8 | One-year repayment rate for non-completers |
| `latest.repayment.1_yr_repayment.income.0_30000` | `LO_INC_RPY_1YR_RT` | float | 8 | One-year repayment rate by family income ($0-30,000) |
| `latest.repayment.1_yr_repayment.income.30000_75000` | `MD_INC_RPY_1YR_RT` | float | 8 | One-year repayment rate by family income ($30,000-75,000) |
| `latest.repayment.1_yr_repayment.income.greater_than_75000` | `HI_INC_RPY_1YR_RT` | float | 8 | One-year repayment rate by family income ($75,000+) |
| `latest.repayment.1_yr_repayment.dependent_students_rate` | `DEP_RPY_1YR_RT` | float | 8 | One-year repayment rate for dependent students |
| `latest.repayment.1_yr_repayment.independent_students_rate` | `IND_RPY_1YR_RT` | float | 8 | One-year repayment rate for independent students |
| `latest.repayment.1_yr_repayment.pell_grant_rate` | `PELL_RPY_1YR_RT` | float | 8 | One-year repayment rate for students who received a Pell grant while at the school |
| `latest.repayment.1_yr_repayment.no_pell_grant_rate` | `NOPELL_RPY_1YR_RT` | float | 8 | One-year repayment rate for students who never received a Pell grant while at school |
| `latest.repayment.1_yr_repayment.female_students_rate` | `FEMALE_RPY_1YR_RT` | float | 8 | One-year repayment rate for females |
| `latest.repayment.1_yr_repayment.male_students_rate` | `MALE_RPY_1YR_RT` | float | 8 | One-year repayment rate for males |
| `latest.repayment.1_yr_repayment.first_generation_students_rate` | `FIRSTGEN_RPY_1YR_RT` | float | 8 | One-year repayment rate for first-generation students |
| `latest.repayment.1_yr_repayment.non_first_generation_students_rate` | `NOTFIRSTGEN_RPY_1YR_RT` | float | 8 | One-year repayment rate for students who are not first-generation |
| `latest.repayment.repayment_cohort.3_year_declining_balance` | `RPY_3YR_RT` | float | 8 | Fraction of repayment cohort who are not in default, and with loan balances that have declined three years... |
| `latest.repayment.3_yr_repayment.completers_rate` | `COMPL_RPY_3YR_RT` | float | 8 | Three-year repayment rate for completers |
| `latest.repayment.3_yr_repayment.noncompleters_rate` | `NONCOM_RPY_3YR_RT` | float | 8 | Three-year repayment rate for non-completers |
| `latest.repayment.3_yr_repayment.income.0_30000` | `LO_INC_RPY_3YR_RT` | float | 8 | Three-year repayment rate by family income ($0-30,000) |
| `latest.repayment.3_yr_repayment.income.30000_75000` | `MD_INC_RPY_3YR_RT` | float | 8 | Three-year repayment rate by family income ($30,000-75,000) |
| `latest.repayment.3_yr_repayment.income.greater_than_75000` | `HI_INC_RPY_3YR_RT` | float | 8 | Three-year repayment rate by family income ($75,000+) |
| `latest.repayment.3_yr_repayment.dependent_students_rate` | `DEP_RPY_3YR_RT` | float | 8 | Three-year repayment rate for dependent students |
| `latest.repayment.3_yr_repayment.independent_students_rate` | `IND_RPY_3YR_RT` | float | 8 | Three-year repayment rate for independent students |
| `latest.repayment.3_yr_repayment.pell_grant_rate` | `PELL_RPY_3YR_RT` | float | 8 | Three-year repayment rate for students who received a Pell grant while at the school |
| `latest.repayment.3_yr_repayment.no_pell_grant_rate` | `NOPELL_RPY_3YR_RT` | float | 8 | Three-year repayment rate for students who never received a Pell grant while at school |
| `latest.repayment.3_yr_repayment.female_students_rate` | `FEMALE_RPY_3YR_RT` | float | 8 | Three-year repayment rate for females |
| `latest.repayment.3_yr_repayment.male_students_rate` | `MALE_RPY_3YR_RT` | float | 8 | Three-year repayment rate for males |
| `latest.repayment.3_yr_repayment.first_generation_students_rate` | `FIRSTGEN_RPY_3YR_RT` | float | 8 | Three-year repayment rate for first-generation students |
| `latest.repayment.3_yr_repayment.non_first_generation_students_rate` | `NOTFIRSTGEN_RPY_3YR_RT` | float | 8 | Three-year repayment rate for students who are not first-generation |
| `latest.repayment.repayment_cohort.5_year_declining_balance` | `RPY_5YR_RT` | float | 6 | Fraction of repayment cohort who are not in default, and with loan balances that have declined five years s... |
| `latest.repayment.5_yr_repayment.completers_rate` | `COMPL_RPY_5YR_RT` | float | 6 | Five-year repayment rate for completers |
| `latest.repayment.5_yr_repayment.noncompleters_rate` | `NONCOM_RPY_5YR_RT` | float | 6 | Five-year repayment rate for non-completers |
| `latest.repayment.5_yr_repayment.income.0_30000` | `LO_INC_RPY_5YR_RT` | float | 6 | Five-year repayment rate by family income ($0-30,000) |
| `latest.repayment.5_yr_repayment.income.30000_75000` | `MD_INC_RPY_5YR_RT` | float | 6 | Five-year repayment rate by family income ($30,000-75,000) |
| `latest.repayment.5_yr_repayment.income.greater_than_75000` | `HI_INC_RPY_5YR_RT` | float | 6 | Five-year repayment rate by family income ($75,000+) |
| `latest.repayment.5_yr_repayment.dependent_students_rate` | `DEP_RPY_5YR_RT` | float | 6 | Five-year repayment rate for dependent students |
| `latest.repayment.5_yr_repayment.independent_students_rate` | `IND_RPY_5YR_RT` | float | 6 | Five-year repayment rate for independent students |
| `latest.repayment.5_yr_repayment.pell_grant_rate` | `PELL_RPY_5YR_RT` | float | 6 | Five-year repayment rate for students who received a Pell grant while at the school |
| `latest.repayment.5_yr_repayment.no_pell_grant_rate` | `NOPELL_RPY_5YR_RT` | float | 6 | Five-year repayment rate for students who never received a Pell grant while at school |
| `latest.repayment.5_yr_repayment.female_students_rate` | `FEMALE_RPY_5YR_RT` | float | 6 | Five-year repayment rate for females |
| `latest.repayment.5_yr_repayment.male_students_rate` | `MALE_RPY_5YR_RT` | float | 6 | Five-year repayment rate for males |
| `latest.repayment.5_yr_repayment.first_generation_students_rate` | `FIRSTGEN_RPY_5YR_RT` | float | 6 | Five-year repayment rate for first-generation students |
| `latest.repayment.5_yr_repayment.non_first_generation_students_rate` | `NOTFIRSTGEN_RPY_5YR_RT` | float | 6 | Five-year repayment rate for students who are not first-generation |
| `latest.repayment.repayment_cohort.7_year_declining_balance` | `RPY_7YR_RT` | float | 4 | Fraction of repayment cohort who are not in default, and with loan balances that have declined seven years... |
| `latest.repayment.7_yr_repayment.completers_rate` | `COMPL_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for completers |
| `latest.repayment.7_yr_repayment.noncompleters_rate` | `NONCOM_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for non-completers |
| `latest.repayment.7_yr_repayment.income.0_30000` | `LO_INC_RPY_7YR_RT` | float | 4 | Seven-year repayment rate by family income ($0-30,000) |
| `latest.repayment.7_yr_repayment.income.30000_75000` | `MD_INC_RPY_7YR_RT` | float | 4 | Seven-year repayment rate by family income ($30,000-75,000) |
| `latest.repayment.7_yr_repayment.income.greater_than_75000` | `HI_INC_RPY_7YR_RT` | float | 4 | Seven-year repayment rate by family income ($75,000+) |
| `latest.repayment.7_yr_repayment.dependent_students_rate` | `DEP_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for dependent students |
| `latest.repayment.7_yr_repayment.independent_students_rate` | `IND_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for independent students |
| `latest.repayment.7_yr_repayment.pell_grant_rate` | `PELL_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for students who received a Pell grant while at the school |
| `latest.repayment.7_yr_repayment.no_pell_grant_rate` | `NOPELL_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for students who never received a Pell grant while at school |
| `latest.repayment.7_yr_repayment.female_students_rate` | `FEMALE_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for females |
| `latest.repayment.7_yr_repayment.male_students_rate` | `MALE_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for males |
| `latest.repayment.7_yr_repayment.first_generation_students_rate` | `FIRSTGEN_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for first-generation students |
| `latest.repayment.7_yr_repayment.non_first_generation_students_rate` | `NOTFIRSTGEN_RPY_7YR_RT` | float | 4 | Seven-year repayment rate for students who are not first-generation |
| `latest.repayment.repayment_date.median` | `REPAY_DT_MDN` | string | 19 | Median Date Student Enters Repayment |
| `latest.repayment.repayment_date.number` | `REPAY_DT_N` | integer | 19 | Number of students in the cohort for date students enter repayment |
| `latest.repayment.1_yr_repayment.overall` | `RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate cohort |
| `latest.repayment.1_yr_repayment.completers` | `COMPL_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of completers cohort |
| `latest.repayment.1_yr_repayment.noncompleters` | `NONCOM_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of non-completers cohort |
| `latest.repayment.1_yr_repayment.low_income` | `LO_INC_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of low-income (less than $30,000 in nominal family income)... |
| `latest.repayment.1_yr_repayment.middle_income` | `MD_INC_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of middle-income (between $30,000 and $75,000 in nominal fa... |
| `latest.repayment.1_yr_repayment.high_income` | `HI_INC_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of high-income (above $75,000 in nominal family income) stu... |
| `latest.repayment.1_yr_repayment.dependent_students` | `DEP_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of dependent students cohort |
| `latest.repayment.1_yr_repayment.independent_students` | `IND_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of independent students cohort |
| `latest.repayment.1_yr_repayment.pell_grant` | `PELL_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of Pell students cohort |
| `latest.repayment.1_yr_repayment.no_pell_grant` | `NOPELL_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of no-Pell students cohort |
| `latest.repayment.1_yr_repayment.female_students` | `FEMALE_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of female students cohort |
| `latest.repayment.1_yr_repayment.male_students` | `MALE_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of male students cohort |
| `latest.repayment.1_yr_repayment.first_generation_students` | `FIRSTGEN_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of first-generation students cohort |
| `latest.repayment.1_yr_repayment.non_first_generation_students` | `NOTFIRSTGEN_RPY_1YR_N` | integer | 8 | Number of students in the 1-year repayment rate of not-first-generation students cohort |
| `latest.repayment.3_yr_repayment.overall` | `RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate cohort |
| `latest.repayment.3_yr_repayment.completers` | `COMPL_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of completers cohort |
| `latest.repayment.3_yr_repayment.noncompleters` | `NONCOM_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of non-completers cohort |
| `latest.repayment.3_yr_repayment.low_income` | `LO_INC_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of low-income (less than $30,000 in nominal family income)... |
| `latest.repayment.3_yr_repayment.middle_income` | `MD_INC_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of middle-income (between $30,000 and $75,000 in nominal fa... |
| `latest.repayment.3_yr_repayment.high_income` | `HI_INC_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of high-income (above $75,000 in nominal family income) stu... |
| `latest.repayment.3_yr_repayment.dependent_students` | `DEP_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of dependent students cohort |
| `latest.repayment.3_yr_repayment.independent_students` | `IND_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of independent students cohort |
| `latest.repayment.3_yr_repayment.pell_grant` | `PELL_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of Pell students cohort |
| `latest.repayment.3_yr_repayment.no_pell_grant` | `NOPELL_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of no-Pell students cohort |
| `latest.repayment.3_yr_repayment.female_students` | `FEMALE_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of female students cohort |
| `latest.repayment.3_yr_repayment.male_students` | `MALE_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of male students cohort |
| `latest.repayment.3_yr_repayment.first_generation_students` | `FIRSTGEN_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of first-generation students cohort |
| `latest.repayment.3_yr_repayment.non_first_generation_students` | `NOTFIRSTGEN_RPY_3YR_N` | integer | 8 | Number of students in the 3-year repayment rate of not-first-generation students cohort |
| `latest.repayment.5_yr_repayment.overall` | `RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate cohort |
| `latest.repayment.5_yr_repayment.completers` | `COMPL_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of completers cohort |
| `latest.repayment.5_yr_repayment.noncompleters` | `NONCOM_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of non-completers cohort |
| `latest.repayment.5_yr_repayment.low_income` | `LO_INC_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of low-income (less than $30,000 in nominal family income)... |
| `latest.repayment.5_yr_repayment.middle_income` | `MD_INC_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of middle-income (between $30,000 and $75,000 in nominal fa... |
| `latest.repayment.5_yr_repayment.high_income` | `HI_INC_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of high-income (above $75,000 in nominal family income) stu... |
| `latest.repayment.5_yr_repayment.dependent_students` | `DEP_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of dependent students cohort |
| `latest.repayment.5_yr_repayment.independent_students` | `IND_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of independent students cohort |
| `latest.repayment.5_yr_repayment.pell_grant` | `PELL_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of Pell students cohort |
| `latest.repayment.5_yr_repayment.no_pell_grant` | `NOPELL_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of no-Pell students cohort |
| `latest.repayment.5_yr_repayment.female_students` | `FEMALE_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of female students cohort |
| `latest.repayment.5_yr_repayment.male_students` | `MALE_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of male students cohort |
| `latest.repayment.5_yr_repayment.first_generation_students` | `FIRSTGEN_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of first-generation students cohort |
| `latest.repayment.5_yr_repayment.non_first_generation_students` | `NOTFIRSTGEN_RPY_5YR_N` | integer | 6 | Number of students in the 5-year repayment rate of not-first-generation students cohort |
| `latest.repayment.7_yr_repayment.overall` | `RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate cohort |
| `latest.repayment.7_yr_repayment.completers` | `COMPL_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of completers cohort |
| `latest.repayment.7_yr_repayment.noncompleters` | `NONCOM_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of non-completers cohort |
| `latest.repayment.7_yr_repayment.low_income` | `LO_INC_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of low-income (less than $30,000 in nominal family income)... |
| `latest.repayment.7_yr_repayment.middle_income` | `MD_INC_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of middle-income (between $30,000 and $75,000 in nominal fa... |
| `latest.repayment.7_yr_repayment.high_income` | `HI_INC_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of high-income (above $75,000 in nominal family income) stu... |
| `latest.repayment.7_yr_repayment.dependent_students` | `DEP_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of dependent students cohort |
| `latest.repayment.7_yr_repayment.independent_students` | `IND_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of independent students cohort |
| `latest.repayment.7_yr_repayment.pell_grant` | `PELL_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of Pell students cohort |
| `latest.repayment.7_yr_repayment.no_pell_grant` | `NOPELL_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of no-Pell students cohort |
| `latest.repayment.7_yr_repayment.female_students` | `FEMALE_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of female students cohort |
| `latest.repayment.7_yr_repayment.male_students` | `MALE_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of male students cohort |
| `latest.repayment.7_yr_repayment.first_generation_students` | `FIRSTGEN_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of first-generation students cohort |
| `latest.repayment.7_yr_repayment.non_first_generation_students` | `NOTFIRSTGEN_RPY_7YR_N` | integer | 4 | Number of students in the 7-year repayment rate of not-first-generation students cohort |
| `latest.repayment.3_yr_repayment_suppressed.overall` | `RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.income.low_income` | `LO_INC_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for low-income (less than $30,000 in nominal family income) students, suppressed for... |
| `latest.repayment.3_yr_repayment_suppressed.income.middle_income` | `MD_INC_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for middle-income (between $30,000 and $75,000 in nominal family income) students, su... |
| `latest.repayment.3_yr_repayment_suppressed.income.high_income` | `HI_INC_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for high-income (above $75,000 in nominal family income) students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.completers` | `COMPL_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for completers, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.non_completers` | `NONCOM_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for non-completers, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.dependent_students` | `DEP_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for dependent students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.independent_students` | `IND_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for independent students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.pell_grant` | `PELL_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for Pell students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.no_pell_grant` | `NOPELL_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for no-Pell students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.female_students` | `FEMALE_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for female students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.male_students` | `MALE_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for male students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.first_generation_students` | `FIRSTGEN_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for first-generation students, suppressed for n=30 |
| `latest.repayment.3_yr_repayment_suppressed.non_first_generation_students` | `NOTFIRSTGEN_RPY_3YR_RT_SUPP` | float | 0 | 3-year repayment rate for non-first-generation students, suppressed for n=30 |
| `latest.repayment.2_yr_default_rate_denom` | `CDR2_DENOM` | integer | 17 | Number of students in the cohort for the two-year cohort default rate |
| `latest.repayment.3_yr_default_rate_denom` | `CDR3_DENOM` | integer | 14 | Number of students in the cohort for the three-year cohort default rate |
| `latest.repayment.1_yr_db_fed_repayment.ug.count` | `DBRR1_FED_UG_N` | integer | 3 | Undergraduate federal student loan dollar-based 1-year repayment rate borrower count |
| `latest.repayment.1_yr_db_fed_repayment.ug.numerator` | `DBRR1_FED_UG_NUM` | long | 3 | Undergraduate federal student loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_fed_repayment.ug.denominator` | `DBRR1_FED_UG_DEN` | long | 3 | Undergraduate federal student loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_fed_repayment.ug.rate` | `DBRR1_FED_UG_RT` | float | 3 | Undergraduate federal student loan dollar-based 1-year repayment rate |
| `latest.repayment.1_yr_db_fed_repayment.gr.count` | `DBRR1_FED_GR_N` | integer | 3 | Graduate federal student loan dollar-based 1-year repayment rate borrower count |
| `latest.repayment.1_yr_db_fed_repayment.gr.numerator` | `DBRR1_FED_GR_NUM` | long | 3 | Graduate federal student loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_fed_repayment.gr.denominator` | `DBRR1_FED_GR_DEN` | long | 3 | Graduate federal student loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_fed_repayment.gr.rate` | `DBRR1_FED_GR_RT` | float | 3 | Graduate federal student loan dollar-based 1-year repayment rate |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer.count` | `DBRR1_FED_UGCOMP_N` | integer | 3 | Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate bor... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer.numerator` | `DBRR1_FED_UGCOMP_NUM` | long | 3 | Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate num... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer.denominator` | `DBRR1_FED_UGCOMP_DEN` | long | 3 | Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate den... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer.rate` | `DBRR1_FED_UGCOMP_RT` | float | 3 | Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate |
| `latest.repayment.1_yr_db_fed_repayment.ug_noncompleter.count` | `DBRR1_FED_UGNOCOMP_N` | integer | 3 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate... |
| `latest.repayment.1_yr_db_fed_repayment.ug_noncompleter.numerator` | `DBRR1_FED_UGNOCOMP_NUM` | long | 3 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate... |
| `latest.repayment.1_yr_db_fed_repayment.ug_noncompleter.denominator` | `DBRR1_FED_UGNOCOMP_DEN` | long | 3 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate... |
| `latest.repayment.1_yr_db_fed_repayment.ug_noncompleter.rate` | `DBRR1_FED_UGNOCOMP_RT` | float | 3 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer_unknown.count` | `DBRR1_FED_UGUNK_N` | integer | 3 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-ye... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer_unknown.numerator` | `DBRR1_FED_UGUNK_NUM` | long | 3 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-ye... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer_unknown.denominator` | `DBRR1_FED_UGUNK_DEN` | long | 3 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-ye... |
| `latest.repayment.1_yr_db_fed_repayment.ug_completer_unknown.rate` | `DBRR1_FED_UGUNK_RT` | float | 3 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-ye... |
| `latest.repayment.1_yr_db_fed_repayment.gr_completer.count` | `DBRR1_FED_GRCOMP_N` | integer | 3 | Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate borrower count |
| `latest.repayment.1_yr_db_fed_repayment.gr_completer.numerator` | `DBRR1_FED_GRCOMP_NUM` | long | 3 | Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_fed_repayment.gr_completer.denominator` | `DBRR1_FED_GRCOMP_DEN` | long | 3 | Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_fed_repayment.gr_completer.rate` | `DBRR1_FED_GRCOMP_RT` | float | 3 | Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate |
| `latest.repayment.1_yr_db_fed_repayment.gr_noncompleter.count` | `DBRR1_FED_GRNOCOMP_N` | integer | 3 | Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate borrower... |
| `latest.repayment.1_yr_db_fed_repayment.gr_noncompleter.numerator` | `DBRR1_FED_GRNOCOMP_NUM` | long | 3 | Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_fed_repayment.gr_noncompleter.denominator` | `DBRR1_FED_GRNOCOMP_DEN` | long | 3 | Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_fed_repayment.gr_noncompleter.rate` | `DBRR1_FED_GRNOCOMP_RT` | float | 3 | Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate repayment... |
| `latest.repayment.4_yr_db_fed_repayment.ug.count` | `DBRR4_FED_UG_N` | integer | 1 | Undergraduate federal student loan dollar-based 4-year repayment rate borrower count |
| `latest.repayment.4_yr_db_fed_repayment.ug.numerator` | `DBRR4_FED_UG_NUM` | long | 1 | Undergraduate federal student loan dollar-based 4-year repayment rate numerator |
| `latest.repayment.4_yr_db_fed_repayment.ug.denominator` | `DBRR4_FED_UG_DEN` | long | 1 | Undergraduate federal student loan dollar-based 4-year repayment rate denominator |
| `latest.repayment.4_yr_db_fed_repayment.ug.rate` | `DBRR4_FED_UG_RT` | float | 1 | Undergraduate federal student loan dollar-based 4-year repayment rate |
| `latest.repayment.4_yr_db_fed_repayment.gr.count` | `DBRR4_FED_GR_N` | integer | 1 | Graduate federal student loan dollar-based 4-year repayment rate borrower count |
| `latest.repayment.4_yr_db_fed_repayment.gr.numerator` | `DBRR4_FED_GR_NUM` | long | 1 | Graduate federal student loan dollar-based 4-year repayment rate numerator |
| `latest.repayment.4_yr_db_fed_repayment.gr.denominator` | `DBRR4_FED_GR_DEN` | long | 1 | Graduate federal student loan dollar-based 4-year repayment rate denominator |
| `latest.repayment.4_yr_db_fed_repayment.gr.rate` | `DBRR4_FED_GR_RT` | float | 1 | Graduate federal student loan dollar-based 4-year repayment rate |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer.count` | `DBRR4_FED_UGCOMP_N` | integer | 1 | Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate bor... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer.numerator` | `DBRR4_FED_UGCOMP_NUM` | long | 1 | Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate num... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer.denominator` | `DBRR4_FED_UGCOMP_DEN` | long | 1 | Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate den... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer.rate` | `DBRR4_FED_UGCOMP_RT` | float | 1 | Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate |
| `latest.repayment.4_yr_db_fed_repayment.ug_noncompleter.count` | `DBRR4_FED_UGNOCOMP_N` | integer | 1 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate... |
| `latest.repayment.4_yr_db_fed_repayment.ug_noncompleter.numerator` | `DBRR4_FED_UGNOCOMP_NUM` | long | 1 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate... |
| `latest.repayment.4_yr_db_fed_repayment.ug_noncompleter.denominator` | `DBRR4_FED_UGNOCOMP_DEN` | long | 1 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate... |
| `latest.repayment.4_yr_db_fed_repayment.ug_noncompleter.rate` | `DBRR4_FED_UGNOCOMP_RT` | float | 1 | Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer_unknown.count` | `DBRR4_FED_UGUNK_N` | integer | 1 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-ye... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer_unknown.numerator` | `DBRR4_FED_UGUNK_NUM` | long | 1 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-ye... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer_unknown.denominator` | `DBRR4_FED_UGUNK_DEN` | long | 1 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-ye... |
| `latest.repayment.4_yr_db_fed_repayment.ug_completer_unknown.rate` | `DBRR4_FED_UGUNK_RT` | float | 1 | Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-ye... |
| `latest.repayment.5_yr_db_fed_repayment.ug.count` | `DBRR5_FED_UG_N` | integer | 3 | Undergraduate federal student loan dollar-based 5-year repayment rate borrower count |
| `latest.repayment.5_yr_db_fed_repayment.ug.numerator` | `DBRR5_FED_UG_NUM` | long | 3 | Undergraduate federal student loan dollar-based 5-year repayment rate numerator |
| `latest.repayment.5_yr_db_fed_repayment.ug.denominator` | `DBRR5_FED_UG_DEN` | long | 3 | Undergraduate federal student loan dollar-based 5-year repayment rate denominator |
| `latest.repayment.5_yr_db_fed_repayment.ug.rate` | `DBRR5_FED_UG_RT` | float | 3 | Undergraduate federal student loan dollar-based 5-year repayment rate |
| `latest.repayment.5_yr_db_fed_repayment.gr.count` | `DBRR5_FED_GR_N` | integer | 3 | Graduate federal student loan dollar-based 5-year repayment rate borrower count |
| `latest.repayment.5_yr_db_fed_repayment.gr.numerator` | `DBRR5_FED_GR_NUM` | long | 3 | Graduate federal student loan dollar-based 5-year repayment rate numerator |
| `latest.repayment.5_yr_db_fed_repayment.gr.denominator` | `DBRR5_FED_GR_DEN` | long | 3 | Graduate federal student loan dollar-based 5-year repayment rate denominator |
| `latest.repayment.5_yr_db_fed_repayment.gr.rate` | `DBRR5_FED_GR_RT` | float | 3 | Graduate federal student loan dollar-based 5-year repayment rate |
| `latest.repayment.10_yr_db_fed_repayment.ug.count` | `DBRR10_FED_UG_N` | integer | 3 | Undergraduate federal student loan dollar-based 10-year repayment rate borrower count |
| `latest.repayment.10_yr_db_fed_repayment.ug.numerator` | `DBRR10_FED_UG_NUM` | long | 3 | Undergraduate federal student loan dollar-based 10-year repayment rate numerator |
| `latest.repayment.10_yr_db_fed_repayment.ug.denominator` | `DBRR10_FED_UG_DEN` | long | 3 | Undergraduate federal student loan dollar-based 10-year repayment rate denominator |
| `latest.repayment.10_yr_db_fed_repayment.ug.rate` | `DBRR10_FED_UG_RT` | float | 3 | Undergraduate federal student loan dollar-based 10-year repayment rate |
| `latest.repayment.10_yr_db_fed_repayment.gr.count` | `DBRR10_FED_GR_N` | integer | 3 | Graduate federal student loan dollar-based 10-year repayment rate borrower count |
| `latest.repayment.10_yr_db_fed_repayment.gr.numerator` | `DBRR10_FED_GR_NUM` | long | 3 | Graduate federal student loan dollar-based 10-year repayment rate numerator |
| `latest.repayment.10_yr_db_fed_repayment.gr.denominator` | `DBRR10_FED_GR_DEN` | long | 3 | Graduate federal student loan dollar-based 10-year repayment rate denominator |
| `latest.repayment.10_yr_db_fed_repayment.gr.rate` | `DBRR10_FED_GR_RT` | float | 3 | Graduate federal student loan dollar-based 10-year repayment rate |
| `latest.repayment.20_yr_db_fed_repayment.ug.count` | `DBRR20_FED_UG_N` | integer | 3 | Undergraduate federal student loan dollar-based 20-year repayment rate borrower count |
| `latest.repayment.20_yr_db_fed_repayment.ug.numerator` | `DBRR20_FED_UG_NUM` | long | 3 | Undergraduate federal student loan dollar-based 20-year repayment rate numerator |
| `latest.repayment.20_yr_db_fed_repayment.ug.denominator` | `DBRR20_FED_UG_DEN` | long | 3 | Undergraduate federal student loan dollar-based 20-year repayment rate denominator |
| `latest.repayment.20_yr_db_fed_repayment.ug.rate` | `DBRR20_FED_UG_RT` | float | 3 | Undergraduate federal student loan dollar-based 20-year repayment rate |
| `latest.repayment.20_yr_db_fed_repayment.gr.count` | `DBRR20_FED_GR_N` | integer | 3 | Graduate federal student loan dollar-based 20-year repayment rate borrower count |
| `latest.repayment.20_yr_db_fed_repayment.gr.numerator` | `DBRR20_FED_GR_NUM` | long | 3 | Graduate federal student loan dollar-based 20-year repayment rate numerator |
| `latest.repayment.20_yr_db_fed_repayment.gr.denominator` | `DBRR20_FED_GR_DEN` | long | 3 | Graduate federal student loan dollar-based 20-year repayment rate denominator |
| `latest.repayment.20_yr_db_fed_repayment.gr.rate` | `DBRR20_FED_GR_RT` | float | 3 | Graduate federal student loan dollar-based 20-year repayment rate |
| `latest.repayment.1_yr_db_pp_repayment.ug.count` | `DBRR1_PP_UG_N` | integer | 3 | Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate borrower count |
| `latest.repayment.1_yr_db_pp_repayment.ug.numerator` | `DBRR1_PP_UG_NUM` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_pp_repayment.ug.denominator` | `DBRR1_PP_UG_DEN` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_pp_repayment.ug.rate` | `DBRR1_PP_UG_RT` | float | 3 | Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer.count` | `DBRR1_PP_UGCOMP_N` | integer | 3 | Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate borrower count |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer.numerator` | `DBRR1_PP_UGCOMP_NUM` | long | 3 | Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer.denominator` | `DBRR1_PP_UGCOMP_DEN` | long | 3 | Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer.rate` | `DBRR1_PP_UGCOMP_RT` | float | 3 | Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate |
| `latest.repayment.1_yr_db_pp_repayment.ug_noncompleter.count` | `DBRR1_PP_UGNOCOMP_N` | integer | 3 | Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate borrower count |
| `latest.repayment.1_yr_db_pp_repayment.ug_noncompleter.numerator` | `DBRR1_PP_UGNOCOMP_NUM` | long | 3 | Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate numerator |
| `latest.repayment.1_yr_db_pp_repayment.ug_noncompleter.denominator` | `DBRR1_PP_UGNOCOMP_DEN` | long | 3 | Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate denominator |
| `latest.repayment.1_yr_db_pp_repayment.ug_noncompleter.rate` | `DBRR1_PP_UGNOCOMP_RT` | float | 3 | Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate repayment rate |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer_unknown.count` | `DBRR1_PP_UGUNK_N` | integer | 3 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate b... |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer_unknown.numerator` | `DBRR1_PP_UGUNK_NUM` | long | 3 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate n... |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer_unknown.denominator` | `DBRR1_PP_UGUNK_DEN` | long | 3 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate d... |
| `latest.repayment.1_yr_db_pp_repayment.ug_completer_unknown.rate` | `DBRR1_PP_UGUNK_RT` | float | 3 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate r... |
| `latest.repayment.4_yr_db_pp_repayment.ug.count` | `DBRR4_PP_UG_N` | integer | 1 | Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate borrower count |
| `latest.repayment.4_yr_db_pp_repayment.ug.numerator` | `DBRR4_PP_UG_NUM` | long | 1 | Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate numerator |
| `latest.repayment.4_yr_db_pp_repayment.ug.denominator` | `DBRR4_PP_UG_DEN` | long | 1 | Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate denominator |
| `latest.repayment.4_yr_db_pp_repayment.ug.rate` | `DBRR4_PP_UG_RT` | float | 1 | Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer.count` | `DBRR4_PP_UGCOMP_N` | integer | 1 | Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate borrower count |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer.numerator` | `DBRR4_PP_UGCOMP_NUM` | long | 1 | Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate numerator |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer.denominator` | `DBRR4_PP_UGCOMP_DEN` | long | 1 | Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate denominator |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer.rate` | `DBRR4_PP_UGCOMP_RT` | float | 1 | Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate |
| `latest.repayment.4_yr_db_pp_repayment.ug_noncompleter.count` | `DBRR4_PP_UGNOCOMP_N` | integer | 1 | Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate borrower count |
| `latest.repayment.4_yr_db_pp_repayment.ug_noncompleter.numerator` | `DBRR4_PP_UGNOCOMP_NUM` | long | 1 | Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate numerator |
| `latest.repayment.4_yr_db_pp_repayment.ug_noncompleter.denominator` | `DBRR4_PP_UGNOCOMP_DEN` | long | 1 | Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate denominator |
| `latest.repayment.4_yr_db_pp_repayment.ug_noncompleter.rate` | `DBRR4_PP_UGNOCOMP_RT` | float | 1 | Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate repayment rate |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer_unknown.count` | `DBRR4_PP_UGUNK_N` | integer | 1 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate b... |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer_unknown.numerator` | `DBRR4_PP_UGUNK_NUM` | long | 1 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate n... |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer_unknown.denominator` | `DBRR4_PP_UGUNK_DEN` | long | 1 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate d... |
| `latest.repayment.4_yr_db_pp_repayment.ug_completer_unknown.rate` | `DBRR4_PP_UGUNK_RT` | float | 1 | Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate r... |
| `latest.repayment.5_yr_db_pp_repayment.ug.count` | `DBRR5_PP_UG_N` | integer | 3 | Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate borrower count |
| `latest.repayment.5_yr_db_pp_repayment.ug.numerator` | `DBRR5_PP_UG_NUM` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate numerator |
| `latest.repayment.5_yr_db_pp_repayment.ug.denominator` | `DBRR5_PP_UG_DEN` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate denominator |
| `latest.repayment.5_yr_db_pp_repayment.ug.rate` | `DBRR5_PP_UG_RT` | float | 3 | Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate |
| `latest.repayment.10_yr_db_pp_repayment.ug.count` | `DBRR10_PP_UG_N` | integer | 3 | Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate borrower count |
| `latest.repayment.10_yr_db_pp_repayment.ug.numerator` | `DBRR10_PP_UG_NUM` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate numerator |
| `latest.repayment.10_yr_db_pp_repayment.ug.denominator` | `DBRR10_PP_UG_DEN` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate denominator |
| `latest.repayment.10_yr_db_pp_repayment.ug.rate` | `DBRR10_PP_UG_RT` | float | 3 | Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate |
| `latest.repayment.20_yr_db_pp_repayment.ug.count` | `DBRR20_PP_UG_N` | integer | 3 | Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate borrower count |
| `latest.repayment.20_yr_db_pp_repayment.ug.numerator` | `DBRR20_PP_UG_NUM` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate numerator |
| `latest.repayment.20_yr_db_pp_repayment.ug.denominator` | `DBRR20_PP_UG_DEN` | long | 3 | Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate denominator |
| `latest.repayment.20_yr_db_pp_repayment.ug.rate` | `DBRR20_PP_UG_RT` | float | 3 | Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate |
| `latest.repayment.1_yr_bb_fed_repayment.ug.count` | `BBRR1_FED_UG_N` | integer | 3 | Undergraduate federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.ug.default` | `BBRR1_FED_UG_DFLT` | float | 3 | Percentage of undergraduate federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.delinquent` | `BBRR1_FED_UG_DLNQ` | float | 3 | Percentage of undergraduate federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.forbearance` | `BBRR1_FED_UG_FBR` | float | 3 | Percentage of undergraduate federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.deferment` | `BBRR1_FED_UG_DFR` | float | 3 | Percentage of undergraduate federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.noprogress` | `BBRR1_FED_UG_NOPROG` | float | 3 | Percentage of undergraduate federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.makingprogress` | `BBRR1_FED_UG_MAKEPROG` | float | 3 | Percentage of undergraduate federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.fullypaid` | `BBRR1_FED_UG_PAIDINFULL` | float | 3 | Percentage of undergraduate federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ug.discharge` | `BBRR1_FED_UG_DISCHARGE` | float | 3 | Percentage of undergraduate federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.count` | `BBRR1_FED_UGCOMP_N` | integer | 3 | Undergraduate completer undergraduate federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.default` | `BBRR1_FED_UGCOMP_DFLT` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.delinquent` | `BBRR1_FED_UGCOMP_DLNQ` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.forbearance` | `BBRR1_FED_UGCOMP_FBR` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.deferment` | `BBRR1_FED_UGCOMP_DFR` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.noprogress` | `BBRR1_FED_UGCOMP_NOPROG` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress afte... |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.makingprogress` | `BBRR1_FED_UGCOMP_MAKEPROG` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 1... |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.fullypaid` | `BBRR1_FED_UGCOMP_PAIDINFULL` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugcomp.discharge` | `BBRR1_FED_UGCOMP_DISCHARGE` | float | 3 | Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharge... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.count` | `BBRR1_FED_UGNOCOMP_N` | integer | 3 | Undergraduate non-completer undergraduate federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.default` | `BBRR1_FED_UGNOCOMP_DFLT` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.delinquent` | `BBRR1_FED_UGNOCOMP_DLNQ` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.forbearance` | `BBRR1_FED_UGNOCOMP_FBR` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.deferment` | `BBRR1_FED_UGNOCOMP_DFR` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 1... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.noprogress` | `BBRR1_FED_UGNOCOMP_NOPROG` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.makingprogress` | `BBRR1_FED_UGNOCOMP_MAKEPROG` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress afte... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.fullypaid` | `BBRR1_FED_UGNOCOMP_PAIDINFULL` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 1... |
| `latest.repayment.1_yr_bb_fed_repayment.ugnocomp.discharge` | `BBRR1_FED_UGNOCOMP_DISCHARGE` | float | 3 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans disch... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.count` | `BBRR1_FED_UGUNK_N` | integer | 3 | Undergraduate unknown completion status undergraduate federal student loan borrower-based 1-year borrower c... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.default` | `BBRR1_FED_UGUNK_DFLT` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defau... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.delinquent` | `BBRR1_FED_UGUNK_DLNQ` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delin... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.forbearance` | `BBRR1_FED_UGUNK_FBR` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbe... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.deferment` | `BBRR1_FED_UGUNK_DFR` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defer... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.noprogress` | `BBRR1_FED_UGUNK_NOPROG` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not maki... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.makingprogress` | `BBRR1_FED_UGUNK_MAKEPROG` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making p... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.fullypaid` | `BBRR1_FED_UGUNK_PAIDINFULL` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in... |
| `latest.repayment.1_yr_bb_fed_repayment.ugunkcomp.discharge` | `BBRR1_FED_UGUNK_DISCHARGE` | float | 3 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all... |
| `latest.repayment.1_yr_bb_fed_repayment.gr.count` | `BBRR1_FED_GR_N` | integer | 3 | Graduate federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.gr.default` | `BBRR1_FED_GR_DFLT` | float | 3 | Percentage of graduate federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.delinquent` | `BBRR1_FED_GR_DLNQ` | float | 3 | Percentage of graduate federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.forbearance` | `BBRR1_FED_GR_FBR` | float | 3 | Percentage of graduate federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.deferment` | `BBRR1_FED_GR_DFR` | float | 3 | Percentage of graduate federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.noprogress` | `BBRR1_FED_GR_NOPROG` | float | 3 | Percentage of graduate federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.makingprogress` | `BBRR1_FED_GR_MAKEPROG` | float | 3 | Percentage of graduate federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.fullypaid` | `BBRR1_FED_GR_PAIDINFULL` | float | 3 | Percentage of graduate federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.gr.discharge` | `BBRR1_FED_GR_DISCHARGE` | float | 3 | Percentage of graduate federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.count` | `BBRR1_FED_GRCOMP_N` | integer | 3 | Graduate completer graduate federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.default` | `BBRR1_FED_GRCOMP_DFLT` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.delinquent` | `BBRR1_FED_GRCOMP_DLNQ` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.forbearance` | `BBRR1_FED_GRCOMP_FBR` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.deferment` | `BBRR1_FED_GRCOMP_DFR` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.noprogress` | `BBRR1_FED_GRCOMP_NOPROG` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.makingprogress` | `BBRR1_FED_GRCOMP_MAKEPROG` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.fullypaid` | `BBRR1_FED_GRCOMP_PAIDINFULL` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grcomp.discharge` | `BBRR1_FED_GRCOMP_DISCHARGE` | float | 3 | Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 1... |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.count` | `BBRR1_FED_GRNOCOMP_N` | integer | 3 | Graduate non-completer graduate federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.default` | `BBRR1_FED_GRNOCOMP_DFLT` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.delinquent` | `BBRR1_FED_GRNOCOMP_DLNQ` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.forbearance` | `BBRR1_FED_GRNOCOMP_FBR` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.deferment` | `BBRR1_FED_GRNOCOMP_DFR` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.noprogress` | `BBRR1_FED_GRNOCOMP_NOPROG` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.makingprogress` | `BBRR1_FED_GRNOCOMP_MAKEPROG` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.fullypaid` | `BBRR1_FED_GRNOCOMP_PAIDINFULL` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.grnocomp.discharge` | `BBRR1_FED_GRNOCOMP_DISCHARGE` | float | 3 | Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged afte... |
| `latest.repayment.1_yr_bb_pp_repayment.ug.count` | `BBRR1_PP_UG_N` | integer | 3 | Undergraduate student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.ug.default` | `BBRR1_PP_UG_DFLT` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.delinquent` | `BBRR1_PP_UG_DLNQ` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.forbearance` | `BBRR1_PP_UG_FBR` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.deferment` | `BBRR1_PP_UG_DFR` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.noprogress` | `BBRR1_PP_UG_NOPROG` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.makingprogress` | `BBRR1_PP_UG_MAKEPROG` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.fullypaid` | `BBRR1_PP_UG_PAIDINFULL` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ug.discharge` | `BBRR1_PP_UG_DISCHARGE` | float | 3 | Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.count` | `BBRR1_PP_UGCOMP_N` | integer | 3 | Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.default` | `BBRR1_PP_UGCOMP_DFLT` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.delinquent` | `BBRR1_PP_UGCOMP_DLNQ` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after... |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.forbearance` | `BBRR1_PP_UGCOMP_FBR` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after... |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.deferment` | `BBRR1_PP_UGCOMP_DFR` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 1... |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.noprogress` | `BBRR1_PP_UGCOMP_NOPROG` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress... |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.makingprogress` | `BBRR1_PP_UGCOMP_MAKEPROG` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress afte... |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.fullypaid` | `BBRR1_PP_UGCOMP_PAIDINFULL` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 1... |
| `latest.repayment.1_yr_bb_pp_repayment.ugcomp.discharge` | `BBRR1_PP_UGCOMP_DISCHARGE` | float | 3 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans disch... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.count` | `BBRR1_PP_UGNOCOMP_N` | integer | 3 | Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.default` | `BBRR1_PP_UGNOCOMP_DFLT` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.delinquent` | `BBRR1_PP_UGNOCOMP_DLNQ` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency a... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.forbearance` | `BBRR1_PP_UGNOCOMP_FBR` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance a... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.deferment` | `BBRR1_PP_UGNOCOMP_DFR` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment aft... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.noprogress` | `BBRR1_PP_UGNOCOMP_NOPROG` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progr... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.makingprogress` | `BBRR1_PP_UGNOCOMP_MAKEPROG` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.fullypaid` | `BBRR1_PP_UGNOCOMP_PAIDINFULL` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full aft... |
| `latest.repayment.1_yr_bb_pp_repayment.ugnocomp.discharge` | `BBRR1_PP_UGNOCOMP_DISCHARGE` | float | 3 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans d... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.count` | `BBRR1_PP_UGUNK_N` | integer | 3 | Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 1-year borrow... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.default` | `BBRR1_PP_UGUNK_DFLT` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.delinquent` | `BBRR1_PP_UGUNK_DLNQ` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.forbearance` | `BBRR1_PP_UGUNK_FBR` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in f... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.deferment` | `BBRR1_PP_UGUNK_DFR` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.noprogress` | `BBRR1_PP_UGUNK_NOPROG` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.makingprogress` | `BBRR1_PP_UGUNK_MAKEPROG` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers maki... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.fullypaid` | `BBRR1_PP_UGUNK_PAIDINFULL` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid... |
| `latest.repayment.1_yr_bb_pp_repayment.ugunkcomp.discharge` | `BBRR1_PP_UGUNK_DISCHARGE` | float | 3 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with... |
| `latest.repayment.2_yr_bb_fed_repayment.ug.count` | `BBRR2_FED_UG_N` | integer | 2 | Undergraduate federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.ug.default` | `BBRR2_FED_UG_DFLT` | float | 2 | Percentage of undergraduate federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.delinquent` | `BBRR2_FED_UG_DLNQ` | float | 2 | Percentage of undergraduate federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.forbearance` | `BBRR2_FED_UG_FBR` | float | 2 | Percentage of undergraduate federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.deferment` | `BBRR2_FED_UG_DFR` | float | 2 | Percentage of undergraduate federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.noprogress` | `BBRR2_FED_UG_NOPROG` | float | 2 | Percentage of undergraduate federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.makingprogress` | `BBRR2_FED_UG_MAKEPROG` | float | 2 | Percentage of undergraduate federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.fullypaid` | `BBRR2_FED_UG_PAIDINFULL` | float | 2 | Percentage of undergraduate federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ug.discharge` | `BBRR2_FED_UG_DISCHARGE` | float | 2 | Percentage of undergraduate federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.count` | `BBRR2_FED_UGCOMP_N` | integer | 2 | Undergraduate completer undergraduate federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.default` | `BBRR2_FED_UGCOMP_DFLT` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.delinquent` | `BBRR2_FED_UGCOMP_DLNQ` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 2 y... |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.forbearance` | `BBRR2_FED_UGCOMP_FBR` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 2 y... |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.deferment` | `BBRR2_FED_UGCOMP_DFR` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.noprogress` | `BBRR2_FED_UGCOMP_NOPROG` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress afte... |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.makingprogress` | `BBRR2_FED_UGCOMP_MAKEPROG` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 2... |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.fullypaid` | `BBRR2_FED_UGCOMP_PAIDINFULL` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.ugcomp.discharge` | `BBRR2_FED_UGCOMP_DISCHARGE` | float | 2 | Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharge... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.count` | `BBRR2_FED_UGNOCOMP_N` | integer | 2 | Undergraduate non-completer undergraduate federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.default` | `BBRR2_FED_UGNOCOMP_DFLT` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 2 y... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.delinquent` | `BBRR2_FED_UGNOCOMP_DLNQ` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.forbearance` | `BBRR2_FED_UGNOCOMP_FBR` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.deferment` | `BBRR2_FED_UGNOCOMP_DFR` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 2... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.noprogress` | `BBRR2_FED_UGNOCOMP_NOPROG` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.makingprogress` | `BBRR2_FED_UGNOCOMP_MAKEPROG` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress afte... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.fullypaid` | `BBRR2_FED_UGNOCOMP_PAIDINFULL` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 2... |
| `latest.repayment.2_yr_bb_fed_repayment.ugnocomp.discharge` | `BBRR2_FED_UGNOCOMP_DISCHARGE` | float | 2 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans disch... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.count` | `BBRR2_FED_UGUNK_N` | integer | 2 | Undergraduate unknown completion status undergraduate federal student loan borrower-based 2-year borrower c... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.default` | `BBRR2_FED_UGUNK_DFLT` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defau... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.delinquent` | `BBRR2_FED_UGUNK_DLNQ` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delin... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.forbearance` | `BBRR2_FED_UGUNK_FBR` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbe... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.deferment` | `BBRR2_FED_UGUNK_DFR` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defer... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.noprogress` | `BBRR2_FED_UGUNK_NOPROG` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not maki... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.makingprogress` | `BBRR2_FED_UGUNK_MAKEPROG` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making p... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.fullypaid` | `BBRR2_FED_UGUNK_PAIDINFULL` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in... |
| `latest.repayment.2_yr_bb_fed_repayment.ugunkcomp.discharge` | `BBRR2_FED_UGUNK_DISCHARGE` | float | 2 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all... |
| `latest.repayment.2_yr_bb_fed_repayment.gr.count` | `BBRR2_FED_GR_N` | integer | 2 | Graduate federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.gr.default` | `BBRR2_FED_GR_DFLT` | float | 2 | Percentage of graduate federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.delinquent` | `BBRR2_FED_GR_DLNQ` | float | 2 | Percentage of graduate federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.forbearance` | `BBRR2_FED_GR_FBR` | float | 2 | Percentage of graduate federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.deferment` | `BBRR2_FED_GR_DFR` | float | 2 | Percentage of graduate federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.noprogress` | `BBRR2_FED_GR_NOPROG` | float | 2 | Percentage of graduate federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.makingprogress` | `BBRR2_FED_GR_MAKEPROG` | float | 2 | Percentage of graduate federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.fullypaid` | `BBRR2_FED_GR_PAIDINFULL` | float | 2 | Percentage of graduate federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.gr.discharge` | `BBRR2_FED_GR_DISCHARGE` | float | 2 | Percentage of graduate federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.count` | `BBRR2_FED_GRCOMP_N` | integer | 2 | Graduate completer graduate federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.default` | `BBRR2_FED_GRCOMP_DFLT` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.delinquent` | `BBRR2_FED_GRCOMP_DLNQ` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.forbearance` | `BBRR2_FED_GRCOMP_FBR` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.deferment` | `BBRR2_FED_GRCOMP_DFR` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.noprogress` | `BBRR2_FED_GRCOMP_NOPROG` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.makingprogress` | `BBRR2_FED_GRCOMP_MAKEPROG` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.fullypaid` | `BBRR2_FED_GRCOMP_PAIDINFULL` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grcomp.discharge` | `BBRR2_FED_GRCOMP_DISCHARGE` | float | 2 | Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 2... |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.count` | `BBRR2_FED_GRNOCOMP_N` | integer | 2 | Graduate non-completer graduate federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.default` | `BBRR2_FED_GRNOCOMP_DFLT` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.delinquent` | `BBRR2_FED_GRNOCOMP_DLNQ` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.forbearance` | `BBRR2_FED_GRNOCOMP_FBR` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.deferment` | `BBRR2_FED_GRNOCOMP_DFR` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.noprogress` | `BBRR2_FED_GRNOCOMP_NOPROG` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.makingprogress` | `BBRR2_FED_GRNOCOMP_MAKEPROG` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.fullypaid` | `BBRR2_FED_GRNOCOMP_PAIDINFULL` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.grnocomp.discharge` | `BBRR2_FED_GRNOCOMP_DISCHARGE` | float | 2 | Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged afte... |
| `latest.repayment.2_yr_bb_pp_repayment.ug.count` | `BBRR2_PP_UG_N` | integer | 2 | Undergraduate student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.ug.default` | `BBRR2_PP_UG_DFLT` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.delinquent` | `BBRR2_PP_UG_DLNQ` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.forbearance` | `BBRR2_PP_UG_FBR` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.deferment` | `BBRR2_PP_UG_DFR` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.noprogress` | `BBRR2_PP_UG_NOPROG` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.makingprogress` | `BBRR2_PP_UG_MAKEPROG` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.fullypaid` | `BBRR2_PP_UG_PAIDINFULL` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ug.discharge` | `BBRR2_PP_UG_DISCHARGE` | float | 2 | Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.count` | `BBRR2_PP_UGCOMP_N` | integer | 2 | Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.default` | `BBRR2_PP_UGCOMP_DFLT` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 2 y... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.delinquent` | `BBRR2_PP_UGCOMP_DLNQ` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.forbearance` | `BBRR2_PP_UGCOMP_FBR` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.deferment` | `BBRR2_PP_UGCOMP_DFR` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 2... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.noprogress` | `BBRR2_PP_UGCOMP_NOPROG` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.makingprogress` | `BBRR2_PP_UGCOMP_MAKEPROG` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress afte... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.fullypaid` | `BBRR2_PP_UGCOMP_PAIDINFULL` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 2... |
| `latest.repayment.2_yr_bb_pp_repayment.ugcomp.discharge` | `BBRR2_PP_UGCOMP_DISCHARGE` | float | 2 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans disch... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.count` | `BBRR2_PP_UGNOCOMP_N` | integer | 2 | Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.default` | `BBRR2_PP_UGNOCOMP_DFLT` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.delinquent` | `BBRR2_PP_UGNOCOMP_DLNQ` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency a... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.forbearance` | `BBRR2_PP_UGNOCOMP_FBR` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance a... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.deferment` | `BBRR2_PP_UGNOCOMP_DFR` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment aft... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.noprogress` | `BBRR2_PP_UGNOCOMP_NOPROG` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progr... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.makingprogress` | `BBRR2_PP_UGNOCOMP_MAKEPROG` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.fullypaid` | `BBRR2_PP_UGNOCOMP_PAIDINFULL` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full aft... |
| `latest.repayment.2_yr_bb_pp_repayment.ugnocomp.discharge` | `BBRR2_PP_UGNOCOMP_DISCHARGE` | float | 2 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans d... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.count` | `BBRR2_PP_UGUNK_N` | integer | 2 | Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 2-year borrow... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.default` | `BBRR2_PP_UGUNK_DFLT` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.delinquent` | `BBRR2_PP_UGUNK_DLNQ` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.forbearance` | `BBRR2_PP_UGUNK_FBR` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in f... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.deferment` | `BBRR2_PP_UGUNK_DFR` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.noprogress` | `BBRR2_PP_UGUNK_NOPROG` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.makingprogress` | `BBRR2_PP_UGUNK_MAKEPROG` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers maki... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.fullypaid` | `BBRR2_PP_UGUNK_PAIDINFULL` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid... |
| `latest.repayment.2_yr_bb_pp_repayment.ugunkcomp.discharge` | `BBRR2_PP_UGUNK_DISCHARGE` | float | 2 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.count` | `BBRR2_FED_UG_N_SUPP` | integer | 1 | Undergraduate federal student loan borrower-based 2-year borrower count, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.default` | `BBRR2_FED_UG_DFLT_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers in default after 2 years, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.delinquent` | `BBRR2_FED_UG_DLNQ_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers in delinquency after 2 years, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.forbearance` | `BBRR2_FED_UG_FBR_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers in forbearance after 2 years, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.deferment` | `BBRR2_FED_UG_DFR_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers in deferment after 2 years, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.noprogress` | `BBRR2_FED_UG_NOPROG_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers not making progress after 2 years, suppressed fo... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.makingprogress` | `BBRR2_FED_UG_MAKEPROG_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers making progress after 2 years, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.fullypaid` | `BBRR2_FED_UG_PAIDINFULL_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers paid in full after 2 years, suppressed for n<30 |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ug.discharge` | `BBRR2_FED_UG_DISCHARGE_SUPP` | float | 1 | Percentage of undergraduate federal student loan borrowers with all loans discharged after 2 years, suppres... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.count` | `BBRR2_FED_UGCOMP_N_SUPP` | integer | 1 | Undergraduate completer undergraduate federal student loan borrower-based 2-year borrower count, suppressed... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.default` | `BBRR2_FED_UGCOMP_DFLT_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 2 years... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.delinquent` | `BBRR2_FED_UGCOMP_DLNQ_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 2 y... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.forbearance` | `BBRR2_FED_UGCOMP_FBR_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 2 y... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.deferment` | `BBRR2_FED_UGCOMP_DFR_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 2 yea... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.noprogress` | `BBRR2_FED_UGCOMP_NOPROG_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress afte... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.makingprogress` | `BBRR2_FED_UGCOMP_MAKEPROG_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 2... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.fullypaid` | `BBRR2_FED_UGCOMP_PAIDINFULL_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 2 yea... |
| `latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.discharge` | `BBRR2_FED_UGCOMP_DISCHARGE_SUPP` | float | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharge... |
| `latest.repayment.1_yr_bb_fed_repayment.independent.count` | `BBRR1_FED_IND_N` | integer | 2 | Independent federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.independent.default` | `BBRR1_FED_IND_DFLT` | string | 2 | Percentage of independent federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.delinquent` | `BBRR1_FED_IND_DLNQ` | string | 2 | Percentage of independent federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.forbearance` | `BBRR1_FED_IND_FBR` | string | 2 | Percentage of independent federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.deferment` | `BBRR1_FED_IND_DFR` | string | 2 | Percentage of independent federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.noprogress` | `BBRR1_FED_IND_NOPROG` | string | 2 | Percentage of independent federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.makingprogress` | `BBRR1_FED_IND_MAKEPROG` | string | 2 | Percentage of independent federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.fullypaid` | `BBRR1_FED_IND_PAIDINFULL` | string | 2 | Percentage of independent federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.independent.discharge` | `BBRR1_FED_IND_DISCHARGE` | string | 2 | Percentage of independent federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.count` | `BBRR1_FED_DEP_N` | integer | 2 | Dependent federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.default` | `BBRR1_FED_DEP_DFLT` | string | 2 | Percentage of dependent federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.delinquent` | `BBRR1_FED_DEP_DLNQ` | string | 2 | Percentage of dependent federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.forbearance` | `BBRR1_FED_DEP_FBR` | string | 2 | Percentage of dependent federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.deferment` | `BBRR1_FED_DEP_DFR` | string | 2 | Percentage of dependent federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.noprogress` | `BBRR1_FED_DEP_NOPROG` | string | 2 | Percentage of dependent federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.makingprogress` | `BBRR1_FED_DEP_MAKEPROG` | string | 2 | Percentage of dependent federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.fullypaid` | `BBRR1_FED_DEP_PAIDINFULL` | string | 2 | Percentage of dependent federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.dependent.discharge` | `BBRR1_FED_DEP_DISCHARGE` | string | 2 | Percentage of dependent federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.count` | `BBRR1_FED_PELL_N` | integer | 2 | Pell Grant recipient federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.pell.default` | `BBRR1_FED_PELL_DFLT` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.delinquent` | `BBRR1_FED_PELL_DLNQ` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.forbearance` | `BBRR1_FED_PELL_FBR` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.deferment` | `BBRR1_FED_PELL_DFR` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.noprogress` | `BBRR1_FED_PELL_NOPROG` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.makingprogress` | `BBRR1_FED_PELL_MAKEPROG` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.fullypaid` | `BBRR1_FED_PELL_PAIDINFULL` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.pell.discharge` | `BBRR1_FED_PELL_DISCHARGE` | string | 2 | Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.count` | `BBRR1_FED_NOPELL_N` | integer | 2 | Non-Pell Grant recipient federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.default` | `BBRR1_FED_NOPELL_DFLT` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.delinquent` | `BBRR1_FED_NOPELL_DLNQ` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.forbearance` | `BBRR1_FED_NOPELL_FBR` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.deferment` | `BBRR1_FED_NOPELL_DFR` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.noprogress` | `BBRR1_FED_NOPELL_NOPROG` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.makingprogress` | `BBRR1_FED_NOPELL_MAKEPROG` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.fullypaid` | `BBRR1_FED_NOPELL_PAIDINFULL` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_pell.discharge` | `BBRR1_FED_NOPELL_DISCHARGE` | string | 2 | Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.count` | `BBRR1_FED_MALE_N` | integer | 2 | Male federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.male.default` | `BBRR1_FED_MALE_DFLT` | string | 2 | Percentage of male federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.delinquent` | `BBRR1_FED_MALE_DLNQ` | string | 2 | Percentage of male federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.forbearance` | `BBRR1_FED_MALE_FBR` | string | 2 | Percentage of male federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.deferment` | `BBRR1_FED_MALE_DFR` | string | 2 | Percentage of male federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.noprogress` | `BBRR1_FED_MALE_NOPROG` | string | 2 | Percentage of male federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.makingprogress` | `BBRR1_FED_MALE_MAKEPROG` | string | 2 | Percentage of male federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.fullypaid` | `BBRR1_FED_MALE_PAIDINFULL` | string | 2 | Percentage of male federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.male.discharge` | `BBRR1_FED_MALE_DISCHARGE` | string | 2 | Percentage of male federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.count` | `BBRR1_FED_NOMALE_N` | integer | 2 | Non-male federal student loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.default` | `BBRR1_FED_NOMALE_DFLT` | string | 2 | Percentage of non-male federal student loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.delinquent` | `BBRR1_FED_NOMALE_DLNQ` | string | 2 | Percentage of non-male federal student loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.forbearance` | `BBRR1_FED_NOMALE_FBR` | string | 2 | Percentage of non-male federal student loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.deferment` | `BBRR1_FED_NOMALE_DFR` | string | 2 | Percentage of non-male federal student loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.noprogress` | `BBRR1_FED_NOMALE_NOPROG` | string | 2 | Percentage of non-male federal student loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.makingprogress` | `BBRR1_FED_NOMALE_MAKEPROG` | string | 2 | Percentage of non-male federal student loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.fullypaid` | `BBRR1_FED_NOMALE_PAIDINFULL` | string | 2 | Percentage of non-male federal student loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_fed_repayment.non_male.discharge` | `BBRR1_FED_NOMALE_DISCHARGE` | string | 2 | Percentage of non-male federal student loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.count` | `BBRR1_PP_IND_N` | integer | 2 | Independent student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.independent.default` | `BBRR1_PP_IND_DFLT` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.delinquent` | `BBRR1_PP_IND_DLNQ` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.forbearance` | `BBRR1_PP_IND_FBR` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.deferment` | `BBRR1_PP_IND_DFR` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.noprogress` | `BBRR1_PP_IND_NOPROG` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.makingprogress` | `BBRR1_PP_IND_MAKEPROG` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.fullypaid` | `BBRR1_PP_IND_PAIDINFULL` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.independent.discharge` | `BBRR1_PP_IND_DISCHARGE` | string | 2 | Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.count` | `BBRR1_PP_DEP_N` | integer | 2 | Dependent student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.default` | `BBRR1_PP_DEP_DFLT` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.delinquent` | `BBRR1_PP_DEP_DLNQ` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.forbearance` | `BBRR1_PP_DEP_FBR` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.deferment` | `BBRR1_PP_DEP_DFR` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.noprogress` | `BBRR1_PP_DEP_NOPROG` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.makingprogress` | `BBRR1_PP_DEP_MAKEPROG` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.fullypaid` | `BBRR1_PP_DEP_PAIDINFULL` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.dependent.discharge` | `BBRR1_PP_DEP_DISCHARGE` | string | 2 | Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.count` | `BBRR1_PP_PELL_N` | integer | 2 | Pell Grant recipient student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.pell.default` | `BBRR1_PP_PELL_DFLT` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.delinquent` | `BBRR1_PP_PELL_DLNQ` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.forbearance` | `BBRR1_PP_PELL_FBR` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.deferment` | `BBRR1_PP_PELL_DFR` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.noprogress` | `BBRR1_PP_PELL_NOPROG` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.makingprogress` | `BBRR1_PP_PELL_MAKEPROG` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.fullypaid` | `BBRR1_PP_PELL_PAIDINFULL` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.pell.discharge` | `BBRR1_PP_PELL_DISCHARGE` | string | 2 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.count` | `BBRR1_PP_NOPELL_N` | integer | 2 | Non-Pell Grant recipient student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.default` | `BBRR1_PP_NOPELL_DFLT` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.delinquent` | `BBRR1_PP_NOPELL_DLNQ` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.forbearance` | `BBRR1_PP_NOPELL_FBR` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.deferment` | `BBRR1_PP_NOPELL_DFR` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.noprogress` | `BBRR1_PP_NOPELL_NOPROG` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.makingprogress` | `BBRR1_PP_NOPELL_MAKEPROG` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.fullypaid` | `BBRR1_PP_NOPELL_PAIDINFULL` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_pell.discharge` | `BBRR1_PP_NOPELL_DISCHARGE` | string | 2 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 1... |
| `latest.repayment.1_yr_bb_pp_repayment.male.count` | `BBRR1_PP_MALE_N` | integer | 2 | Male student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.male.default` | `BBRR1_PP_MALE_DFLT` | string | 2 | Percentage of male student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.delinquent` | `BBRR1_PP_MALE_DLNQ` | string | 2 | Percentage of male student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.forbearance` | `BBRR1_PP_MALE_FBR` | string | 2 | Percentage of male student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.deferment` | `BBRR1_PP_MALE_DFR` | string | 2 | Percentage of male student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.noprogress` | `BBRR1_PP_MALE_NOPROG` | string | 2 | Percentage of male student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.makingprogress` | `BBRR1_PP_MALE_MAKEPROG` | string | 2 | Percentage of male student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.fullypaid` | `BBRR1_PP_MALE_PAIDINFULL` | string | 2 | Percentage of male student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.male.discharge` | `BBRR1_PP_MALE_DISCHARGE` | string | 2 | Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.count` | `BBRR1_PP_NOMALE_N` | integer | 2 | Non-male student Parent PLUS Loan borrower-based 1-year borrower count |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.default` | `BBRR1_PP_NOMALE_DFLT` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers in default after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.delinquent` | `BBRR1_PP_NOMALE_DLNQ` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.forbearance` | `BBRR1_PP_NOMALE_FBR` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.deferment` | `BBRR1_PP_NOMALE_DFR` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers in deferment after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.noprogress` | `BBRR1_PP_NOMALE_NOPROG` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers not making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.makingprogress` | `BBRR1_PP_NOMALE_MAKEPROG` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers making progress after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.fullypaid` | `BBRR1_PP_NOMALE_PAIDINFULL` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers paid in full after 1 year |
| `latest.repayment.1_yr_bb_pp_repayment.non_male.discharge` | `BBRR1_PP_NOMALE_DISCHARGE` | string | 2 | Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 1 year |
| `latest.repayment.2_yr_bb_fed_repayment.independent.count` | `BBRR2_FED_IND_N` | integer | 1 | Independent federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.independent.default` | `BBRR2_FED_IND_DFLT` | string | 1 | Percentage of independent federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.delinquent` | `BBRR2_FED_IND_DLNQ` | string | 1 | Percentage of independent federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.forbearance` | `BBRR2_FED_IND_FBR` | string | 1 | Percentage of independent federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.deferment` | `BBRR2_FED_IND_DFR` | string | 1 | Percentage of independent federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.noprogress` | `BBRR2_FED_IND_NOPROG` | string | 1 | Percentage of independent federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.makingprogress` | `BBRR2_FED_IND_MAKEPROG` | string | 1 | Percentage of independent federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.fullypaid` | `BBRR2_FED_IND_PAIDINFULL` | string | 1 | Percentage of independent federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.independent.discharge` | `BBRR2_FED_IND_DISCHARGE` | string | 1 | Percentage of independent federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.count` | `BBRR2_FED_DEP_N` | integer | 1 | Dependent federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.default` | `BBRR2_FED_DEP_DFLT` | string | 1 | Percentage of dependent federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.delinquent` | `BBRR2_FED_DEP_DLNQ` | string | 1 | Percentage of dependent federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.forbearance` | `BBRR2_FED_DEP_FBR` | string | 1 | Percentage of dependent federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.deferment` | `BBRR2_FED_DEP_DFR` | string | 1 | Percentage of dependent federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.noprogress` | `BBRR2_FED_DEP_NOPROG` | string | 1 | Percentage of dependent federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.makingprogress` | `BBRR2_FED_DEP_MAKEPROG` | string | 1 | Percentage of dependent federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.fullypaid` | `BBRR2_FED_DEP_PAIDINFULL` | string | 1 | Percentage of dependent federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.dependent.discharge` | `BBRR2_FED_DEP_DISCHARGE` | string | 1 | Percentage of dependent federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.count` | `BBRR2_FED_PELL_N` | integer | 1 | Pell Grant recipient federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.pell.default` | `BBRR2_FED_PELL_DFLT` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.delinquent` | `BBRR2_FED_PELL_DLNQ` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.forbearance` | `BBRR2_FED_PELL_FBR` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.deferment` | `BBRR2_FED_PELL_DFR` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.noprogress` | `BBRR2_FED_PELL_NOPROG` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.makingprogress` | `BBRR2_FED_PELL_MAKEPROG` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.fullypaid` | `BBRR2_FED_PELL_PAIDINFULL` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.pell.discharge` | `BBRR2_FED_PELL_DISCHARGE` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.count` | `BBRR2_FED_NOPELL_N` | integer | 1 | Non-Pell Grant recipient federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.default` | `BBRR2_FED_NOPELL_DFLT` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.delinquent` | `BBRR2_FED_NOPELL_DLNQ` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.forbearance` | `BBRR2_FED_NOPELL_FBR` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.deferment` | `BBRR2_FED_NOPELL_DFR` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.noprogress` | `BBRR2_FED_NOPELL_NOPROG` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.makingprogress` | `BBRR2_FED_NOPELL_MAKEPROG` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.fullypaid` | `BBRR2_FED_NOPELL_PAIDINFULL` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_pell.discharge` | `BBRR2_FED_NOPELL_DISCHARGE` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.count` | `BBRR2_FED_MALE_N` | integer | 1 | Male federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.male.default` | `BBRR2_FED_MALE_DFLT` | string | 1 | Percentage of male federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.delinquent` | `BBRR2_FED_MALE_DLNQ` | string | 1 | Percentage of male federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.forbearance` | `BBRR2_FED_MALE_FBR` | string | 1 | Percentage of male federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.deferment` | `BBRR2_FED_MALE_DFR` | string | 1 | Percentage of male federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.noprogress` | `BBRR2_FED_MALE_NOPROG` | string | 1 | Percentage of male federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.makingprogress` | `BBRR2_FED_MALE_MAKEPROG` | string | 1 | Percentage of male federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.fullypaid` | `BBRR2_FED_MALE_PAIDINFULL` | string | 1 | Percentage of male federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.male.discharge` | `BBRR2_FED_MALE_DISCHARGE` | string | 1 | Percentage of male federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.count` | `BBRR2_FED_NOMALE_N` | integer | 1 | Non-male federal student loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.default` | `BBRR2_FED_NOMALE_DFLT` | string | 1 | Percentage of non-male federal student loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.delinquent` | `BBRR2_FED_NOMALE_DLNQ` | string | 1 | Percentage of non-male federal student loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.forbearance` | `BBRR2_FED_NOMALE_FBR` | string | 1 | Percentage of non-male federal student loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.deferment` | `BBRR2_FED_NOMALE_DFR` | string | 1 | Percentage of non-male federal student loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.noprogress` | `BBRR2_FED_NOMALE_NOPROG` | string | 1 | Percentage of non-male federal student loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.makingprogress` | `BBRR2_FED_NOMALE_MAKEPROG` | string | 1 | Percentage of non-male federal student loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.fullypaid` | `BBRR2_FED_NOMALE_PAIDINFULL` | string | 1 | Percentage of non-male federal student loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_fed_repayment.non_male.discharge` | `BBRR2_FED_NOMALE_DISCHARGE` | string | 1 | Percentage of non-male federal student loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.count` | `BBRR2_PP_IND_N` | integer | 1 | Independent student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.independent.default` | `BBRR2_PP_IND_DFLT` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.delinquent` | `BBRR2_PP_IND_DLNQ` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.forbearance` | `BBRR2_PP_IND_FBR` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.deferment` | `BBRR2_PP_IND_DFR` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.noprogress` | `BBRR2_PP_IND_NOPROG` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.makingprogress` | `BBRR2_PP_IND_MAKEPROG` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.fullypaid` | `BBRR2_PP_IND_PAIDINFULL` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.independent.discharge` | `BBRR2_PP_IND_DISCHARGE` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.count` | `BBRR2_PP_DEP_N` | integer | 1 | Dependent student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.default` | `BBRR2_PP_DEP_DFLT` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.delinquent` | `BBRR2_PP_DEP_DLNQ` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.forbearance` | `BBRR2_PP_DEP_FBR` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.deferment` | `BBRR2_PP_DEP_DFR` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.noprogress` | `BBRR2_PP_DEP_NOPROG` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.makingprogress` | `BBRR2_PP_DEP_MAKEPROG` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.fullypaid` | `BBRR2_PP_DEP_PAIDINFULL` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.dependent.discharge` | `BBRR2_PP_DEP_DISCHARGE` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.count` | `BBRR2_PP_PELL_N` | integer | 1 | Pell Grant recipient student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.pell.default` | `BBRR2_PP_PELL_DFLT` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.delinquent` | `BBRR2_PP_PELL_DLNQ` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.forbearance` | `BBRR2_PP_PELL_FBR` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.deferment` | `BBRR2_PP_PELL_DFR` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.noprogress` | `BBRR2_PP_PELL_NOPROG` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.makingprogress` | `BBRR2_PP_PELL_MAKEPROG` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.fullypaid` | `BBRR2_PP_PELL_PAIDINFULL` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.pell.discharge` | `BBRR2_PP_PELL_DISCHARGE` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.count` | `BBRR2_PP_NOPELL_N` | integer | 1 | Non-Pell Grant recipient student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.default` | `BBRR2_PP_NOPELL_DFLT` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.delinquent` | `BBRR2_PP_NOPELL_DLNQ` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.forbearance` | `BBRR2_PP_NOPELL_FBR` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.deferment` | `BBRR2_PP_NOPELL_DFR` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.noprogress` | `BBRR2_PP_NOPELL_NOPROG` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.makingprogress` | `BBRR2_PP_NOPELL_MAKEPROG` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.fullypaid` | `BBRR2_PP_NOPELL_PAIDINFULL` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_pell.discharge` | `BBRR2_PP_NOPELL_DISCHARGE` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 2... |
| `latest.repayment.2_yr_bb_pp_repayment.male.count` | `BBRR2_PP_MALE_N` | integer | 1 | Male student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.male.default` | `BBRR2_PP_MALE_DFLT` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.delinquent` | `BBRR2_PP_MALE_DLNQ` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.forbearance` | `BBRR2_PP_MALE_FBR` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.deferment` | `BBRR2_PP_MALE_DFR` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.noprogress` | `BBRR2_PP_MALE_NOPROG` | string | 1 | Percentage of male student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.makingprogress` | `BBRR2_PP_MALE_MAKEPROG` | string | 1 | Percentage of male student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.fullypaid` | `BBRR2_PP_MALE_PAIDINFULL` | string | 1 | Percentage of male student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.male.discharge` | `BBRR2_PP_MALE_DISCHARGE` | string | 1 | Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.count` | `BBRR2_PP_NOMALE_N` | integer | 1 | Non-male student Parent PLUS Loan borrower-based 2-year borrower count |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.default` | `BBRR2_PP_NOMALE_DFLT` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in default after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.delinquent` | `BBRR2_PP_NOMALE_DLNQ` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.forbearance` | `BBRR2_PP_NOMALE_FBR` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.deferment` | `BBRR2_PP_NOMALE_DFR` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in deferment after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.noprogress` | `BBRR2_PP_NOMALE_NOPROG` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers not making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.makingprogress` | `BBRR2_PP_NOMALE_MAKEPROG` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers making progress after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.fullypaid` | `BBRR2_PP_NOMALE_PAIDINFULL` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers paid in full after 2 years |
| `latest.repayment.2_yr_bb_pp_repayment.non_male.discharge` | `BBRR2_PP_NOMALE_DISCHARGE` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 2 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.count` | `BBRR3_FED_UG_N` | integer | 1 | Undergraduate federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.ug.default` | `BBRR3_FED_UG_DFLT` | string | 1 | Percentage of undergraduate federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.delinquent` | `BBRR3_FED_UG_DLNQ` | string | 1 | Percentage of undergraduate federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.forbearance` | `BBRR3_FED_UG_FBR` | string | 1 | Percentage of undergraduate federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.deferment` | `BBRR3_FED_UG_DFR` | string | 1 | Percentage of undergraduate federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.noprogress` | `BBRR3_FED_UG_NOPROG` | string | 1 | Percentage of undergraduate federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.makingprogress` | `BBRR3_FED_UG_MAKEPROG` | string | 1 | Percentage of undergraduate federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.fullypaid` | `BBRR3_FED_UG_PAIDINFULL` | string | 1 | Percentage of undergraduate federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ug.discharge` | `BBRR3_FED_UG_DISCHARGE` | string | 1 | Percentage of undergraduate federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.count` | `BBRR3_FED_UGCOMP_N` | integer | 1 | Undergraduate completer undergraduate federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.default` | `BBRR3_FED_UGCOMP_DFLT` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.delinquent` | `BBRR3_FED_UGCOMP_DLNQ` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 3 y... |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.forbearance` | `BBRR3_FED_UGCOMP_FBR` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 3 y... |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.deferment` | `BBRR3_FED_UGCOMP_DFR` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.noprogress` | `BBRR3_FED_UGCOMP_NOPROG` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress afte... |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.makingprogress` | `BBRR3_FED_UGCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 3... |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.fullypaid` | `BBRR3_FED_UGCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.ugcomp.discharge` | `BBRR3_FED_UGCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharge... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.count` | `BBRR3_FED_UGNOCOMP_N` | integer | 1 | Undergraduate non-completer undergraduate federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.default` | `BBRR3_FED_UGNOCOMP_DFLT` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 3 y... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.delinquent` | `BBRR3_FED_UGNOCOMP_DLNQ` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.forbearance` | `BBRR3_FED_UGNOCOMP_FBR` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.deferment` | `BBRR3_FED_UGNOCOMP_DFR` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 3... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.noprogress` | `BBRR3_FED_UGNOCOMP_NOPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.makingprogress` | `BBRR3_FED_UGNOCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress afte... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.fullypaid` | `BBRR3_FED_UGNOCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 3... |
| `latest.repayment.3_yr_bb_fed_repayment.ugnocomp.discharge` | `BBRR3_FED_UGNOCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans disch... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.count` | `BBRR3_FED_UGUNK_N` | integer | 1 | Undergraduate unknown completion status undergraduate federal student loan borrower-based 3-year borrower c... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.default` | `BBRR3_FED_UGUNK_DFLT` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defau... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.delinquent` | `BBRR3_FED_UGUNK_DLNQ` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delin... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.forbearance` | `BBRR3_FED_UGUNK_FBR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbe... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.deferment` | `BBRR3_FED_UGUNK_DFR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defer... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.noprogress` | `BBRR3_FED_UGUNK_NOPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not maki... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.makingprogress` | `BBRR3_FED_UGUNK_MAKEPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making p... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.fullypaid` | `BBRR3_FED_UGUNK_PAIDINFULL` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in... |
| `latest.repayment.3_yr_bb_fed_repayment.ugunkcomp.discharge` | `BBRR3_FED_UGUNK_DISCHARGE` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all... |
| `latest.repayment.3_yr_bb_fed_repayment.gr.count` | `BBRR3_FED_GR_N` | integer | 1 | Graduate federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.gr.default` | `BBRR3_FED_GR_DFLT` | string | 1 | Percentage of graduate federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.delinquent` | `BBRR3_FED_GR_DLNQ` | string | 1 | Percentage of graduate federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.forbearance` | `BBRR3_FED_GR_FBR` | string | 1 | Percentage of graduate federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.deferment` | `BBRR3_FED_GR_DFR` | string | 1 | Percentage of graduate federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.noprogress` | `BBRR3_FED_GR_NOPROG` | string | 1 | Percentage of graduate federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.makingprogress` | `BBRR3_FED_GR_MAKEPROG` | string | 1 | Percentage of graduate federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.fullypaid` | `BBRR3_FED_GR_PAIDINFULL` | string | 1 | Percentage of graduate federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.gr.discharge` | `BBRR3_FED_GR_DISCHARGE` | string | 1 | Percentage of graduate federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.count` | `BBRR3_FED_GRCOMP_N` | integer | 1 | Graduate completer graduate federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.default` | `BBRR3_FED_GRCOMP_DFLT` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.delinquent` | `BBRR3_FED_GRCOMP_DLNQ` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.forbearance` | `BBRR3_FED_GRCOMP_FBR` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.deferment` | `BBRR3_FED_GRCOMP_DFR` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.noprogress` | `BBRR3_FED_GRCOMP_NOPROG` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.makingprogress` | `BBRR3_FED_GRCOMP_MAKEPROG` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.fullypaid` | `BBRR3_FED_GRCOMP_PAIDINFULL` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grcomp.discharge` | `BBRR3_FED_GRCOMP_DISCHARGE` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 3... |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.count` | `BBRR3_FED_GRNOCOMP_N` | integer | 1 | Graduate non-completer graduate federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.default` | `BBRR3_FED_GRNOCOMP_DFLT` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.delinquent` | `BBRR3_FED_GRNOCOMP_DLNQ` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.forbearance` | `BBRR3_FED_GRNOCOMP_FBR` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.deferment` | `BBRR3_FED_GRNOCOMP_DFR` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.noprogress` | `BBRR3_FED_GRNOCOMP_NOPROG` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.makingprogress` | `BBRR3_FED_GRNOCOMP_MAKEPROG` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.fullypaid` | `BBRR3_FED_GRNOCOMP_PAIDINFULL` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.grnocomp.discharge` | `BBRR3_FED_GRNOCOMP_DISCHARGE` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged afte... |
| `latest.repayment.3_yr_bb_pp_repayment.ug.count` | `BBRR3_PP_UG_N` | integer | 1 | Undergraduate student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.ug.default` | `BBRR3_PP_UG_DFLT` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.delinquent` | `BBRR3_PP_UG_DLNQ` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.forbearance` | `BBRR3_PP_UG_FBR` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.deferment` | `BBRR3_PP_UG_DFR` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.noprogress` | `BBRR3_PP_UG_NOPROG` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.makingprogress` | `BBRR3_PP_UG_MAKEPROG` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.fullypaid` | `BBRR3_PP_UG_PAIDINFULL` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ug.discharge` | `BBRR3_PP_UG_DISCHARGE` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.count` | `BBRR3_PP_UGCOMP_N` | integer | 1 | Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.default` | `BBRR3_PP_UGCOMP_DFLT` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 3 y... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.delinquent` | `BBRR3_PP_UGCOMP_DLNQ` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.forbearance` | `BBRR3_PP_UGCOMP_FBR` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.deferment` | `BBRR3_PP_UGCOMP_DFR` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 3... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.noprogress` | `BBRR3_PP_UGCOMP_NOPROG` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.makingprogress` | `BBRR3_PP_UGCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress afte... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.fullypaid` | `BBRR3_PP_UGCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 3... |
| `latest.repayment.3_yr_bb_pp_repayment.ugcomp.discharge` | `BBRR3_PP_UGCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans disch... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.count` | `BBRR3_PP_UGNOCOMP_N` | integer | 1 | Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.default` | `BBRR3_PP_UGNOCOMP_DFLT` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.delinquent` | `BBRR3_PP_UGNOCOMP_DLNQ` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency a... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.forbearance` | `BBRR3_PP_UGNOCOMP_FBR` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance a... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.deferment` | `BBRR3_PP_UGNOCOMP_DFR` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment aft... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.noprogress` | `BBRR3_PP_UGNOCOMP_NOPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progr... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.makingprogress` | `BBRR3_PP_UGNOCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.fullypaid` | `BBRR3_PP_UGNOCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full aft... |
| `latest.repayment.3_yr_bb_pp_repayment.ugnoncomp.discharge` | `BBRR3_PP_UGNOCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans d... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.count` | `BBRR3_PP_UGUNK_N` | integer | 1 | Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 3-year borrow... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.default` | `BBRR3_PP_UGUNK_DFLT` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.delinquent` | `BBRR3_PP_UGUNK_DLNQ` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.forbearance` | `BBRR3_PP_UGUNK_FBR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in f... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.deferment` | `BBRR3_PP_UGUNK_DFR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.noprogress` | `BBRR3_PP_UGUNK_NOPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.makingprogress` | `BBRR3_PP_UGUNK_MAKEPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers maki... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.fullypaid` | `BBRR3_PP_UGUNK_PAIDINFULL` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid... |
| `latest.repayment.3_yr_bb_pp_repayment.ugunkcomp.discharge` | `BBRR3_PP_UGUNK_DISCHARGE` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with... |
| `latest.repayment.3_yr_bb_fed_repayment.independent.count` | `BBRR3_FED_IND_N` | integer | 1 | Independent federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.independent.default` | `BBRR3_FED_IND_DFLT` | string | 1 | Percentage of independent federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.delinquent` | `BBRR3_FED_IND_DLNQ` | string | 1 | Percentage of independent federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.forbearance` | `BBRR3_FED_IND_FBR` | string | 1 | Percentage of independent federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.deferment` | `BBRR3_FED_IND_DFR` | string | 1 | Percentage of independent federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.noprogress` | `BBRR3_FED_IND_NOPROG` | string | 1 | Percentage of independent federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.makingprogress` | `BBRR3_FED_IND_MAKEPROG` | string | 1 | Percentage of independent federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.fullypaid` | `BBRR3_FED_IND_PAIDINFULL` | string | 1 | Percentage of independent federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.independent.discharge` | `BBRR3_FED_IND_DISCHARGE` | string | 1 | Percentage of independent federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.count` | `BBRR3_FED_DEP_N` | integer | 1 | Dependent federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.default` | `BBRR3_FED_DEP_DFLT` | string | 1 | Percentage of dependent federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.delinquent` | `BBRR3_FED_DEP_DLNQ` | string | 1 | Percentage of dependent federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.forbearance` | `BBRR3_FED_DEP_FBR` | string | 1 | Percentage of dependent federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.deferment` | `BBRR3_FED_DEP_DFR` | string | 1 | Percentage of dependent federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.noprogress` | `BBRR3_FED_DEP_NOPROG` | string | 1 | Percentage of dependent federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.makingprogress` | `BBRR3_FED_DEP_MAKEPROG` | string | 1 | Percentage of dependent federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.fullypaid` | `BBRR3_FED_DEP_PAIDINFULL` | string | 1 | Percentage of dependent federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.dependent.discharge` | `BBRR3_FED_DEP_DISCHARGE` | string | 1 | Percentage of dependent federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.count` | `BBRR3_FED_PELL_N` | integer | 1 | Pell Grant recipient federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.pell.default` | `BBRR3_FED_PELL_DFLT` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.delinquent` | `BBRR3_FED_PELL_DLNQ` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.forbearance` | `BBRR3_FED_PELL_FBR` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.deferment` | `BBRR3_FED_PELL_DFR` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.noprogress` | `BBRR3_FED_PELL_NOPROG` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.makingprogress` | `BBRR3_FED_PELL_MAKEPROG` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.fullypaid` | `BBRR3_FED_PELL_PAIDINFULL` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.pell.discharge` | `BBRR3_FED_PELL_DISCHARGE` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.count` | `BBRR3_FED_NOPELL_N` | integer | 1 | Non-Pell Grant recipient federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.default` | `BBRR3_FED_NOPELL_DFLT` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.delinquent` | `BBRR3_FED_NOPELL_DLNQ` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.forbearance` | `BBRR3_FED_NOPELL_FBR` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.deferment` | `BBRR3_FED_NOPELL_DFR` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.noprogress` | `BBRR3_FED_NOPELL_NOPROG` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.makingprogress` | `BBRR3_FED_NOPELL_MAKEPROG` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.fullypaid` | `BBRR3_FED_NOPELL_PAIDINFULL` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_pell.discharge` | `BBRR3_FED_NOPELL_DISCHARGE` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.count` | `BBRR3_FED_MALE_N` | integer | 1 | Male federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.male.default` | `BBRR3_FED_MALE_DFLT` | string | 1 | Percentage of male federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.delinquent` | `BBRR3_FED_MALE_DLNQ` | string | 1 | Percentage of male federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.forbearance` | `BBRR3_FED_MALE_FBR` | string | 1 | Percentage of male federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.deferment` | `BBRR3_FED_MALE_DFR` | string | 1 | Percentage of male federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.noprogress` | `BBRR3_FED_MALE_NOPROG` | string | 1 | Percentage of male federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.makingprogress` | `BBRR3_FED_MALE_MAKEPROG` | string | 1 | Percentage of male federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.fullypaid` | `BBRR3_FED_MALE_PAIDINFULL` | string | 1 | Percentage of male federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.male.discharge` | `BBRR3_FED_MALE_DISCHARGE` | string | 1 | Percentage of male federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.count` | `BBRR3_FED_NOMALE_N` | integer | 1 | Non-male federal student loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.default` | `BBRR3_FED_NOMALE_DFLT` | string | 1 | Percentage of non-male federal student loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.delinquent` | `BBRR3_FED_NOMALE_DLNQ` | string | 1 | Percentage of non-male federal student loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.forbearance` | `BBRR3_FED_NOMALE_FBR` | string | 1 | Percentage of non-male federal student loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.deferment` | `BBRR3_FED_NOMALE_DFR` | string | 1 | Percentage of non-male federal student loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.noprogress` | `BBRR3_FED_NOMALE_NOPROG` | string | 1 | Percentage of non-male federal student loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.makingprogress` | `BBRR3_FED_NOMALE_MAKEPROG` | string | 1 | Percentage of non-male federal student loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.fullypaid` | `BBRR3_FED_NOMALE_PAIDINFULL` | string | 1 | Percentage of non-male federal student loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_fed_repayment.non_male.discharge` | `BBRR3_FED_NOMALE_DISCHARGE` | string | 1 | Percentage of non-male federal student loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.count` | `BBRR3_PP_IND_N` | integer | 1 | Independent student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.independent.default` | `BBRR3_PP_IND_DFLT` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.delinquent` | `BBRR3_PP_IND_DLNQ` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.forbearance` | `BBRR3_PP_IND_FBR` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.deferment` | `BBRR3_PP_IND_DFR` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.noprogress` | `BBRR3_PP_IND_NOPROG` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.makingprogress` | `BBRR3_PP_IND_MAKEPROG` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.fullypaid` | `BBRR3_PP_IND_PAIDINFULL` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.independent.discharge` | `BBRR3_PP_IND_DISCHARGE` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.count` | `BBRR3_PP_DEP_N` | integer | 1 | Dependent student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.default` | `BBRR3_PP_DEP_DFLT` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.delinquent` | `BBRR3_PP_DEP_DLNQ` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.forbearance` | `BBRR3_PP_DEP_FBR` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.deferment` | `BBRR3_PP_DEP_DFR` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.noprogress` | `BBRR3_PP_DEP_NOPROG` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.makingprogress` | `BBRR3_PP_DEP_MAKEPROG` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.fullypaid` | `BBRR3_PP_DEP_PAIDINFULL` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.dependent.discharge` | `BBRR3_PP_DEP_DISCHARGE` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.count` | `BBRR3_PP_PELL_N` | integer | 1 | Pell Grant recipient student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.pell.default` | `BBRR3_PP_PELL_DFLT` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.delinquent` | `BBRR3_PP_PELL_DLNQ` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.forbearance` | `BBRR3_PP_PELL_FBR` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.deferment` | `BBRR3_PP_PELL_DFR` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.noprogress` | `BBRR3_PP_PELL_NOPROG` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.makingprogress` | `BBRR3_PP_PELL_MAKEPROG` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.fullypaid` | `BBRR3_PP_PELL_PAIDINFULL` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.pell.discharge` | `BBRR3_PP_PELL_DISCHARGE` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.count` | `BBRR3_PP_NOPELL_N` | integer | 1 | Non-Pell Grant recipient student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.default` | `BBRR3_PP_NOPELL_DFLT` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.delinquent` | `BBRR3_PP_NOPELL_DLNQ` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.forbearance` | `BBRR3_PP_NOPELL_FBR` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.deferment` | `BBRR3_PP_NOPELL_DFR` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.noprogress` | `BBRR3_PP_NOPELL_NOPROG` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.makingprogress` | `BBRR3_PP_NOPELL_MAKEPROG` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.fullypaid` | `BBRR3_PP_NOPELL_PAIDINFULL` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_pell.discharge` | `BBRR3_PP_NOPELL_DISCHARGE` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 3... |
| `latest.repayment.3_yr_bb_pp_repayment.male.count` | `BBRR3_PP_MALE_N` | integer | 1 | Male student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.male.default` | `BBRR3_PP_MALE_DFLT` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.delinquent` | `BBRR3_PP_MALE_DLNQ` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.forbearance` | `BBRR3_PP_MALE_FBR` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.deferment` | `BBRR3_PP_MALE_DFR` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.noprogress` | `BBRR3_PP_MALE_NOPROG` | string | 1 | Percentage of male student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.makingprogress` | `BBRR3_PP_MALE_MAKEPROG` | string | 1 | Percentage of male student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.fullypaid` | `BBRR3_PP_MALE_PAIDINFULL` | string | 1 | Percentage of male student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.male.discharge` | `BBRR3_PP_MALE_DISCHARGE` | string | 1 | Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.count` | `BBRR3_PP_NOMALE_N` | integer | 1 | Non-male student Parent PLUS Loan borrower-based 3-year borrower count |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.default` | `BBRR3_PP_NOMALE_DFLT` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in default after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.delinquent` | `BBRR3_PP_NOMALE_DLNQ` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.forbearance` | `BBRR3_PP_NOMALE_FBR` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.deferment` | `BBRR3_PP_NOMALE_DFR` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in deferment after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.noprogress` | `BBRR3_PP_NOMALE_NOPROG` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers not making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.makingprogress` | `BBRR3_PP_NOMALE_MAKEPROG` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers making progress after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.fullypaid` | `BBRR3_PP_NOMALE_PAIDINFULL` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers paid in full after 3 years |
| `latest.repayment.3_yr_bb_pp_repayment.non_male.discharge` | `BBRR3_PP_NOMALE_DISCHARGE` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 3 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.count` | `BBRR4_FED_UG_N` | integer | 1 | Undergraduate federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.ug.default` | `BBRR4_FED_UG_DFLT` | string | 1 | Percentage of undergraduate federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.delinquent` | `BBRR4_FED_UG_DLNQ` | string | 1 | Percentage of undergraduate federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.forbearance` | `BBRR4_FED_UG_FBR` | string | 1 | Percentage of undergraduate federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.deferment` | `BBRR4_FED_UG_DFR` | string | 1 | Percentage of undergraduate federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.noprogress` | `BBRR4_FED_UG_NOPROG` | string | 1 | Percentage of undergraduate federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.makingprogress` | `BBRR4_FED_UG_MAKEPROG` | string | 1 | Percentage of undergraduate federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.fullypaid` | `BBRR4_FED_UG_PAIDINFULL` | string | 1 | Percentage of undergraduate federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ug.discharge` | `BBRR4_FED_UG_DISCHARGE` | string | 1 | Percentage of undergraduate federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.count` | `BBRR4_FED_UGCOMP_N` | integer | 1 | Undergraduate completer undergraduate federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.default` | `BBRR4_FED_UGCOMP_DFLT` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.delinquent` | `BBRR4_FED_UGCOMP_DLNQ` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 4 y... |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.forbearance` | `BBRR4_FED_UGCOMP_FBR` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 4 y... |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.deferment` | `BBRR4_FED_UGCOMP_DFR` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.noprogress` | `BBRR4_FED_UGCOMP_NOPROG` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress afte... |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.makingprogress` | `BBRR4_FED_UGCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 4... |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.fullypaid` | `BBRR4_FED_UGCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.ugcomp.discharge` | `BBRR4_FED_UGCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharge... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.count` | `BBRR4_FED_UGNOCOMP_N` | integer | 1 | Undergraduate non-completer undergraduate federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.default` | `BBRR4_FED_UGNOCOMP_DFLT` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 4 y... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.delinquent` | `BBRR4_FED_UGNOCOMP_DLNQ` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.forbearance` | `BBRR4_FED_UGNOCOMP_FBR` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.deferment` | `BBRR4_FED_UGNOCOMP_DFR` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 4... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.noprogress` | `BBRR4_FED_UGNOCOMP_NOPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.makingprogress` | `BBRR4_FED_UGNOCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress afte... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.fullypaid` | `BBRR4_FED_UGNOCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 4... |
| `latest.repayment.4_yr_bb_fed_repayment.ugnocomp.discharge` | `BBRR4_FED_UGNOCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans disch... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.count` | `BBRR4_FED_UGUNK_N` | integer | 1 | Undergraduate unknown completion status undergraduate federal student loan borrower-based 4-year borrower c... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.default` | `BBRR4_FED_UGUNK_DFLT` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defau... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.delinquent` | `BBRR4_FED_UGUNK_DLNQ` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delin... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.forbearance` | `BBRR4_FED_UGUNK_FBR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbe... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.deferment` | `BBRR4_FED_UGUNK_DFR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in defer... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.noprogress` | `BBRR4_FED_UGUNK_NOPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not maki... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.makingprogress` | `BBRR4_FED_UGUNK_MAKEPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making p... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.fullypaid` | `BBRR4_FED_UGUNK_PAIDINFULL` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in... |
| `latest.repayment.4_yr_bb_fed_repayment.ugunkcomp.discharge` | `BBRR4_FED_UGUNK_DISCHARGE` | string | 1 | Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all... |
| `latest.repayment.4_yr_bb_fed_repayment.gr.count` | `BBRR4_FED_GR_N` | integer | 1 | Graduate federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.gr.default` | `BBRR4_FED_GR_DFLT` | string | 1 | Percentage of graduate federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.delinquent` | `BBRR4_FED_GR_DLNQ` | string | 1 | Percentage of graduate federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.forbearance` | `BBRR4_FED_GR_FBR` | string | 1 | Percentage of graduate federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.deferment` | `BBRR4_FED_GR_DFR` | string | 1 | Percentage of graduate federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.noprogress` | `BBRR4_FED_GR_NOPROG` | string | 1 | Percentage of graduate federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.makingprogress` | `BBRR4_FED_GR_MAKEPROG` | string | 1 | Percentage of graduate federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.fullypaid` | `BBRR4_FED_GR_PAIDINFULL` | string | 1 | Percentage of graduate federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.gr.discharge` | `BBRR4_FED_GR_DISCHARGE` | string | 1 | Percentage of graduate federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.count` | `BBRR4_FED_GRCOMP_N` | integer | 1 | Graduate completer graduate federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.default` | `BBRR4_FED_GRCOMP_DFLT` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.delinquent` | `BBRR4_FED_GRCOMP_DLNQ` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.forbearance` | `BBRR4_FED_GRCOMP_FBR` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.deferment` | `BBRR4_FED_GRCOMP_DFR` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.noprogress` | `BBRR4_FED_GRCOMP_NOPROG` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.makingprogress` | `BBRR4_FED_GRCOMP_MAKEPROG` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.fullypaid` | `BBRR4_FED_GRCOMP_PAIDINFULL` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grcomp.discharge` | `BBRR4_FED_GRCOMP_DISCHARGE` | string | 1 | Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 4... |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.count` | `BBRR4_FED_GRNOCOMP_N` | integer | 1 | Graduate non-completer graduate federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.default` | `BBRR4_FED_GRNOCOMP_DFLT` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.delinquent` | `BBRR4_FED_GRNOCOMP_DLNQ` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.forbearance` | `BBRR4_FED_GRNOCOMP_FBR` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.deferment` | `BBRR4_FED_GRNOCOMP_DFR` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.noprogress` | `BBRR4_FED_GRNOCOMP_NOPROG` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.makingprogress` | `BBRR4_FED_GRNOCOMP_MAKEPROG` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.fullypaid` | `BBRR4_FED_GRNOCOMP_PAIDINFULL` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.grnocomp.discharge` | `BBRR4_FED_GRNOCOMP_DISCHARGE` | string | 1 | Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged afte... |
| `latest.repayment.4_yr_bb_pp_repayment.ug.count` | `BBRR4_PP_UG_N` | integer | 1 | Undergraduate student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.ug.default` | `BBRR4_PP_UG_DFLT` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.delinquent` | `BBRR4_PP_UG_DLNQ` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.forbearance` | `BBRR4_PP_UG_FBR` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.deferment` | `BBRR4_PP_UG_DFR` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.noprogress` | `BBRR4_PP_UG_NOPROG` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.makingprogress` | `BBRR4_PP_UG_MAKEPROG` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.fullypaid` | `BBRR4_PP_UG_PAIDINFULL` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ug.discharge` | `BBRR4_PP_UG_DISCHARGE` | string | 1 | Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.count` | `BBRR4_PP_UGCOMP_N` | integer | 1 | Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.default` | `BBRR4_PP_UGCOMP_DFLT` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 4 y... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.delinquent` | `BBRR4_PP_UGCOMP_DLNQ` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.forbearance` | `BBRR4_PP_UGCOMP_FBR` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.deferment` | `BBRR4_PP_UGCOMP_DFR` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 4... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.noprogress` | `BBRR4_PP_UGCOMP_NOPROG` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.makingprogress` | `BBRR4_PP_UGCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress afte... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.fullypaid` | `BBRR4_PP_UGCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 4... |
| `latest.repayment.4_yr_bb_pp_repayment.ugcomp.discharge` | `BBRR4_PP_UGCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans disch... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.count` | `BBRR4_PP_UGNOCOMP_N` | integer | 1 | Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.default` | `BBRR4_PP_UGNOCOMP_DFLT` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.delinquent` | `BBRR4_PP_UGNOCOMP_DLNQ` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency a... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.forbearance` | `BBRR4_PP_UGNOCOMP_FBR` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance a... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.deferment` | `BBRR4_PP_UGNOCOMP_DFR` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment aft... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.noprogress` | `BBRR4_PP_UGNOCOMP_NOPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progr... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.makingprogress` | `BBRR4_PP_UGNOCOMP_MAKEPROG` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.fullypaid` | `BBRR4_PP_UGNOCOMP_PAIDINFULL` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full aft... |
| `latest.repayment.4_yr_bb_pp_repayment.ugnocomp.discharge` | `BBRR4_PP_UGNOCOMP_DISCHARGE` | string | 1 | Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans d... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.count` | `BBRR4_PP_UGUNK_N` | integer | 1 | Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 4-year borrow... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.default` | `BBRR4_PP_UGUNK_DFLT` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.delinquent` | `BBRR4_PP_UGUNK_DLNQ` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.forbearance` | `BBRR4_PP_UGUNK_FBR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in f... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.deferment` | `BBRR4_PP_UGUNK_DFR` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in d... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.noprogress` | `BBRR4_PP_UGUNK_NOPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.makingprogress` | `BBRR4_PP_UGUNK_MAKEPROG` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers maki... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.fullypaid` | `BBRR4_PP_UGUNK_PAIDINFULL` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid... |
| `latest.repayment.4_yr_bb_pp_repayment.ugunkcomp.discharge` | `BBRR4_PP_UGUNK_DISCHARGE` | string | 1 | Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with... |
| `latest.repayment.4_yr_bb_fed_repayment.independent.count` | `BBRR4_FED_IND_N` | integer | 1 | Independent federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.independent.default` | `BBRR4_FED_IND_DFLT` | string | 1 | Percentage of independent federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.delinquent` | `BBRR4_FED_IND_DLNQ` | string | 1 | Percentage of independent federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.forbearance` | `BBRR4_FED_IND_FBR` | string | 1 | Percentage of independent federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.deferment` | `BBRR4_FED_IND_DFR` | string | 1 | Percentage of independent federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.noprogress` | `BBRR4_FED_IND_NOPROG` | string | 1 | Percentage of independent federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.makingprogress` | `BBRR4_FED_IND_MAKEPROG` | string | 1 | Percentage of independent federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.fullypaid` | `BBRR4_FED_IND_PAIDINFULL` | string | 1 | Percentage of independent federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.independent.discharge` | `BBRR4_FED_IND_DISCHARGE` | string | 1 | Percentage of independent federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.count` | `BBRR4_FED_DEP_N` | integer | 1 | Dependent federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.default` | `BBRR4_FED_DEP_DFLT` | string | 1 | Percentage of dependent federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.delinquent` | `BBRR4_FED_DEP_DLNQ` | string | 1 | Percentage of dependent federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.forbearance` | `BBRR4_FED_DEP_FBR` | string | 1 | Percentage of dependent federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.deferment` | `BBRR4_FED_DEP_DFR` | string | 1 | Percentage of dependent federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.noprogress` | `BBRR4_FED_DEP_NOPROG` | string | 1 | Percentage of dependent federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.makingprogress` | `BBRR4_FED_DEP_MAKEPROG` | string | 1 | Percentage of dependent federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.fullypaid` | `BBRR4_FED_DEP_PAIDINFULL` | string | 1 | Percentage of dependent federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.dependent.discharge` | `BBRR4_FED_DEP_DISCHARGE` | string | 1 | Percentage of dependent federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.count` | `BBRR4_FED_PELL_N` | integer | 1 | Pell Grant recipient federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.pell.default` | `BBRR4_FED_PELL_DFLT` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.delinquent` | `BBRR4_FED_PELL_DLNQ` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.forbearance` | `BBRR4_FED_PELL_FBR` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.deferment` | `BBRR4_FED_PELL_DFR` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.noprogress` | `BBRR4_FED_PELL_NOPROG` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.makingprogress` | `BBRR4_FED_PELL_MAKEPROG` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.fullypaid` | `BBRR4_FED_PELL_PAIDINFULL` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.pell.discharge` | `BBRR4_FED_PELL_DISCHARGE` | string | 1 | Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.count` | `BBRR4_FED_NOPELL_N` | integer | 1 | Non-Pell Grant recipient federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.default` | `BBRR4_FED_NOPELL_DFLT` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.delinquent` | `BBRR4_FED_NOPELL_DLNQ` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.forbearance` | `BBRR4_FED_NOPELL_FBR` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.deferment` | `BBRR4_FED_NOPELL_DFR` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.noprogress` | `BBRR4_FED_NOPELL_NOPROG` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.makingprogress` | `BBRR4_FED_NOPELL_MAKEPROG` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.fullypaid` | `BBRR4_FED_NOPELL_PAIDINFULL` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_pell.discharge` | `BBRR4_FED_NOPELL_DISCHARGE` | string | 1 | Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.count` | `BBRR4_FED_MALE_N` | integer | 1 | Male federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.male.default` | `BBRR4_FED_MALE_DFLT` | string | 1 | Percentage of male federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.delinquent` | `BBRR4_FED_MALE_DLNQ` | string | 1 | Percentage of male federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.forbearance` | `BBRR4_FED_MALE_FBR` | string | 1 | Percentage of male federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.deferment` | `BBRR4_FED_MALE_DFR` | string | 1 | Percentage of male federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.noprogress` | `BBRR4_FED_MALE_NOPROG` | string | 1 | Percentage of male federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.makingprogress` | `BBRR4_FED_MALE_MAKEPROG` | string | 1 | Percentage of male federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.fullypaid` | `BBRR4_FED_MALE_PAIDINFULL` | string | 1 | Percentage of male federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.male.discharge` | `BBRR4_FED_MALE_DISCHARGE` | string | 1 | Percentage of male federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.count` | `BBRR4_FED_NOMALE_N` | integer | 1 | Non-male federal student loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.default` | `BBRR4_FED_NOMALE_DFLT` | string | 1 | Percentage of non-male federal student loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.delinquent` | `BBRR4_FED_NOMALE_DLNQ` | string | 1 | Percentage of non-male federal student loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.forbearance` | `BBRR4_FED_NOMALE_FBR` | string | 1 | Percentage of non-male federal student loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.deferment` | `BBRR4_FED_NOMALE_DFR` | string | 1 | Percentage of non-male federal student loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.noprogress` | `BBRR4_FED_NOMALE_NOPROG` | string | 1 | Percentage of non-male federal student loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.makingprogress` | `BBRR4_FED_NOMALE_MAKEPROG` | string | 1 | Percentage of non-male federal student loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.fullypaid` | `BBRR4_FED_NOMALE_PAIDINFULL` | string | 1 | Percentage of non-male federal student loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_fed_repayment.non_male.discharge` | `BBRR4_FED_NOMALE_DISCHARGE` | string | 1 | Percentage of non-male federal student loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.count` | `BBRR4_PP_IND_N` | integer | 1 | Independent student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.independent.default` | `BBRR4_PP_IND_DFLT` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.delinquent` | `BBRR4_PP_IND_DLNQ` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.forbearance` | `BBRR4_PP_IND_FBR` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.deferment` | `BBRR4_PP_IND_DFR` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.noprogress` | `BBRR4_PP_IND_NOPROG` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.makingprogress` | `BBRR4_PP_IND_MAKEPROG` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.fullypaid` | `BBRR4_PP_IND_PAIDINFULL` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.independent.discharge` | `BBRR4_PP_IND_DISCHARGE` | string | 1 | Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.count` | `BBRR4_PP_DEP_N` | integer | 1 | Dependent student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.default` | `BBRR4_PP_DEP_DFLT` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.delinquent` | `BBRR4_PP_DEP_DLNQ` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.forbearance` | `BBRR4_PP_DEP_FBR` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.deferment` | `BBRR4_PP_DEP_DFR` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.noprogress` | `BBRR4_PP_DEP_NOPROG` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.makingprogress` | `BBRR4_PP_DEP_MAKEPROG` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.fullypaid` | `BBRR4_PP_DEP_PAIDINFULL` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.dependent.discharge` | `BBRR4_PP_DEP_DISCHARGE` | string | 1 | Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.count` | `BBRR4_PP_PELL_N` | integer | 1 | Pell Grant recipient student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.pell.default` | `BBRR4_PP_PELL_DFLT` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.delinquent` | `BBRR4_PP_PELL_DLNQ` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.forbearance` | `BBRR4_PP_PELL_FBR` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.deferment` | `BBRR4_PP_PELL_DFR` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.noprogress` | `BBRR4_PP_PELL_NOPROG` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.makingprogress` | `BBRR4_PP_PELL_MAKEPROG` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.fullypaid` | `BBRR4_PP_PELL_PAIDINFULL` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.pell.discharge` | `BBRR4_PP_PELL_DISCHARGE` | string | 1 | Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.count` | `BBRR4_PP_NOPELL_N` | integer | 1 | Non-Pell Grant recipient student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.default` | `BBRR4_PP_NOPELL_DFLT` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.delinquent` | `BBRR4_PP_NOPELL_DLNQ` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.forbearance` | `BBRR4_PP_NOPELL_FBR` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.deferment` | `BBRR4_PP_NOPELL_DFR` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.noprogress` | `BBRR4_PP_NOPELL_NOPROG` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.makingprogress` | `BBRR4_PP_NOPELL_MAKEPROG` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.fullypaid` | `BBRR4_PP_NOPELL_PAIDINFULL` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_pell.discharge` | `BBRR4_PP_NOPELL_DISCHARGE` | string | 1 | Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 4... |
| `latest.repayment.4_yr_bb_pp_repayment.male.count` | `BBRR4_PP_MALE_N` | integer | 1 | Male student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.male.default` | `BBRR4_PP_MALE_DFLT` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.delinquent` | `BBRR4_PP_MALE_DLNQ` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.forbearance` | `BBRR4_PP_MALE_FBR` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.deferment` | `BBRR4_PP_MALE_DFR` | string | 1 | Percentage of male student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.noprogress` | `BBRR4_PP_MALE_NOPROG` | string | 1 | Percentage of male student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.makingprogress` | `BBRR4_PP_MALE_MAKEPROG` | string | 1 | Percentage of male student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.fullypaid` | `BBRR4_PP_MALE_PAIDINFULL` | string | 1 | Percentage of male student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.male.discharge` | `BBRR4_PP_MALE_DISCHARGE` | string | 1 | Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.count` | `BBRR4_PP_NOMALE_N` | integer | 1 | Non-male student Parent PLUS Loan borrower-based 4-year borrower count |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.default` | `BBRR4_PP_NOMALE_DFLT` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in default after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.delinquent` | `BBRR4_PP_NOMALE_DLNQ` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.forbearance` | `BBRR4_PP_NOMALE_FBR` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.deferment` | `BBRR4_PP_NOMALE_DFR` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers in deferment after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.noprogress` | `BBRR4_PP_NOMALE_NOPROG` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers not making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.makingprogress` | `BBRR4_PP_NOMALE_MAKEPROG` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers making progress after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.fullypaid` | `BBRR4_PP_NOMALE_PAIDINFULL` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers paid in full after 4 years |
| `latest.repayment.4_yr_bb_pp_repayment.non_male.discharge` | `BBRR4_PP_NOMALE_DISCHARGE` | string | 1 | Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 4 years |

---

## Where these numbers came from

Everything in this file is a straight reshape of the workbook - no external data, no estimates. Regenerate with:

```bash
python scripts/build_data_reference.py
```
