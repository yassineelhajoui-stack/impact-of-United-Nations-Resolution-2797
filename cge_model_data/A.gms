*==============================================================================
* SCENARIO A -- "Choc institutionnel seul, statu quo tarifaire"
* Section 3.7.3 (Table 2) de la methodologie revisee de l'article.
*
* Isole le choc institutionnel et geopolitique decrit en section 3.7.2,
* toutes choses egales par ailleurs sur le plan tarifaire : les droits
* Maroc-Algerie restent geles au niveau atteint lors de la rupture de
* 2021-2024, sans normalisation ni nouvelle degradation.
*
* STATUT : version 3 -- a deja tourne avec succes sous GAMS (voir A_prime.gms
* pour l'historique des corrections 1 et 2). Cette version corrige en plus le
* benchmark du choc de PTF (CORRECTIF 3, voir ci-dessous) et necessite un
* nouveau run precede d'une ETAPE 0 (generation de B_line-25-18_REF.gdx) --
* voir A_prime.gms pour la procedure complete et les instructions d'insertion.
*
* CORRECTIF 5 (26/08, suite a votre remarque "les scenarios avec choc
* donnent des resultats moins avantageux que le scenario sans choc") : un
* bug de chargement de donnees dans la copie complete
* (PEP-w-t_v4.1_CAL_B_line-25-18_A.gms) faussait le PIB reel
* marocain des 2018, avant tout choc reel -- voir A_prime.gms pour le
* diagnostic complet. Corrige dans la copie complete ; les
* Results_choc_A.xlsx actuels sont perimes, un nouveau run est
* necessaire.
*
* Convention temporelle : t1 = 2017 ; periode n = annee 2016+n. Periode 5 =
* 2021, periode 8 = 2024, periode 9 = 2025 (adoption de la Resolution 2797).
*
* AVERTISSEMENT : voir A_prime.gms pour le detail des blocs VALIDE vs PROPOSE
* (structure identique) et pour le statut de validation par execution GAMS.
*==============================================================================

* CORRECTIF 2 (Error 349 "Declaration not allowed inside a LOOP or IF
* statement") : ce fichier est inclus a l'interieur du LOOP[time,...] du
* programme principal -- une declaration ALIAS n'y est pas autorisee par
* GAMS. L'alias ALIAS(time,timej), necessaire ci-dessous, doit donc etre
* declare une fois pour toutes AVANT le LOOP, dans le fichier principal lui-
* meme (PEP-w-t_v4.1_CAL_B_line-25-18_A.gms etc., pres de la ligne 90, a
* cote de "ALIAS (UMA,UMAj)") -- c'est deja fait dans les copies que je
* vous ai fournies.

* CORRECTIF 3 (benchmarking du choc de PTF) : dans la version precedente de
* ce fichier, le choc de PTF etait applique en cumulant +0,12 %/an sur la
* PROPRE trajectoire du scenario (A_VA.l('MAR',time-1)) -- ce qui remplacait
* de fait la tendance de PTF sous-jacente aux projections CEPII/MaGE par une
* tendance beaucoup plus lente, au lieu de la majorer. Conformement a votre
* choix, le choc est desormais applique comme un supplement multiplicatif de
* +0,12 % a la trajectoire de PTF du scenario SANS CHOC (A_VA_REF, importee
* depuis B_line-25-18_REF.gdx -- voir les instructions d'usage detaillees
* dans A_prime.gms), periode par periode : A_VA_choc(t) = A_VA_REF(t)*1,0012,
* pour chaque t >= 2025. Ceci correspond exactement a la formule de la
* methodologie : PTF(z=Sahara,t) = PTF_reference(z=Sahara,t) x (1+0,12%).

*==============================================================================
* (1) RUPTURE TARIFAIRE MAROC-ALGERIE, 2021-2024 -- commune aux 4 scenarios
*     [VALIDE : syntaxe identique a Untitled_2.gms / Untitled_4.gms]
*==============================================================================
 ttim.fx(i,'MAR','dza',time)$(ord(time) eq 5)  = 1.1*ttim.l(i,'MAR','dza',time-1);
 ttim.fx(i,'MAR','dza',time)$(ord(time) eq 6)  = 1.2*ttim.l(i,'MAR','dza',time-1);
 ttim.fx(i,'MAR','dza',time)$(ord(time) eq 7)  = 1.3*ttim.l(i,'MAR','dza',time-1);
 ttim.fx(i,'MAR','dza',time)$(ord(time) eq 8)  = 1.4*ttim.l(i,'MAR','dza',time-1);

 ttim.fx(i,'dza','MAR',time)$(ord(time) eq 5)  = 1.1*ttim.l(i,'dza','MAR',time-1);
 ttim.fx(i,'dza','MAR',time)$(ord(time) eq 6)  = 1.2*ttim.l(i,'dza','MAR',time-1);
 ttim.fx(i,'dza','MAR',time)$(ord(time) eq 7)  = 1.3*ttim.l(i,'dza','MAR',time-1);
 ttim.fx(i,'dza','MAR',time)$(ord(time) eq 8)  = 1.4*ttim.l(i,'dza','MAR',time-1);

*==============================================================================
* (2) CHOC INSTITUTIONNEL ET GEOPOLITIQUE -- section 3.7.2, a partir de 2025
*     Identique, au mot pres, dans A_prime.gms / A.gms / B.gms / C.gms.
* Cible : sahara(J) = { Extraction, Constr, animale, Metal } (DATA_AGG-2007-25-18.gms).
* ATTENTION : "turisme" est desactive dans cette definition GAMS (ligne
* "****turisme" commentee) bien qu'il figure dans le texte de la section 3.7.2.
*==============================================================================

* --- (i) PTF : +0,12 %/an a partir de 2025 (Kim & Loayza, 2019) [PROPOSE] ---
* IMPORTANT -- dans PEP-w-t_v4.1_CAL_B_line-25-18.gms, A_VA(z,time) est LIBRE
* (resolue pour reproduire GDP_BP_REAL.fx, cale sur les projections CEPII/
* MaGE) : la fixer sans rien changer d'autre sur-determinerait le systeme
* CNS pour le Maroc. Changement de fermeture pour le Maroc a partir de 2025 :
* GDP_BP_REAL('MAR',.) devient endogene, A_VA('MAR',.) devient exogene
* (fixee a la trajectoire de reference (sans choc) majoree de 0,12 % --
* voir CORRECTIF 3 ci-dessus).
* Choix de modelisation substantiel a valider avant la version soumise.
 GDP_BP_REAL.lo('MAR',time)$(ord(time) ge 9) = -inf;
 GDP_BP_REAL.up('MAR',time)$(ord(time) ge 9) = +inf;
 A_VA.FX('MAR',time)$(ord(time) ge 9)        = A_VA_REF('MAR',time)*1.0012;

* --- (ii) Investissement : +1,5 % (Caldara & Iacoviello, 2022) [PROPOSE] ---
* Rehaussement ponctuel du stock de capital des secteurs sahariens en 2025,
* accumulation normale ensuite (cf. INIT.gms). Meme levier qu'esquisse dans
* Untitled_1.gms (KD.fx), jamais finalise dans vos fichiers.
* CORRECTIF (Error 329 "Wrong suffix on variable reference") : ".fx" n'est
* pas un suffixe lisible en GAMS (seul .l, .m, .lo, .up, etc. le sont) ;
* on ne peut pas lire KD.fx(...) a droite d'une affectation. Le membre de
* droite doit utiliser KD.l(...), la valeur courante (deja mise a jour par
* la loi d'accumulation standard d'INIT.gms plus haut dans la meme periode).
 KD.fx(k,j,'MAR',time)$(ord(time) eq 9 and sahara(j)) = 1.015*KD.l(k,j,'MAR',time);

* --- (iii) Elasticites CET/CES : +5 % (Aghion et al., 2005a, 2005b) [PROPOSE] ---
* CORRECTIF 6 (27/08 -- CAUSE REELLE DE LA DERIVE PRE-2025, trouvee suite
* a votre test placebo qui a prouve que le bloc A_VA_REF/GDXIN etait
* innocent) : ces trois lignes n'avaient AUCUNE condition sur "time" --
* seulement $sahara(j)/$sahara(i). Incluses dans le LOOP[time,...] du
* programme principal, elles s'executaient donc a CHAQUE periode (t=1 a
* t=24), et l'affectation etant AUTO-REFERENTE (nouvelle valeur = 1,05 x
* ancienne valeur), l'augmentation de 5% se COMPOSAIT indefiniment period
* apres periode (1,05^23 ~= 3,07, soit +207% en 2040) au lieu d'etre
* appliquee UNE SEULE FOIS comme le prevoit la methodologie ("+5%", pas
* "+5% par an"). Absent en periode 1 (2017) l'effet est invisible --
* l'annee de calibration reproduit le SAM independamment des
* elasticites -- mais des la periode 2 (2018) le modele se met a
* resoudre reellement, et la derive apparait, des annees avant meme le
* choc de 2025 : exactement le symptome que vous avez signale.
* Corrige en ajoutant "and ord(time) eq 9", pour que ce soit desormais
* un releve UNIQUE de +5% en 2025 (comme le fait deja KD.fx ci-dessus
* pour le capital), qui persiste ensuite sans se recomposer.
 sigma_INV(k,j,'MAR')$(sahara(j) and ord(time) eq 9) = 1.05*sigma_INV(k,j,'MAR');
 sigma_X1(j,'MAR')$(sahara(j) and ord(time) eq 9)    = 1.05*sigma_X1(j,'MAR');
 sigma_M1(i,'MAR')$(sahara(i) and ord(time) eq 9)    = 1.05*sigma_M1(i,'MAR');

*==============================================================================
* (3) STATU QUO TARIFAIRE -- specifique a A
* Le niveau atteint en 2024 (periode 8) est simplement reconduit pour toute
* la suite de l'horizon de simulation : aucune normalisation, aucune nouvelle
* degradation. [PROPOSE : discontinuite geree via une reference explicite a
* la periode 8, plutot qu'un simple report recursif de time-1, pour eviter
* toute ambiguite avec le bloc (1) ci-dessus.]
*==============================================================================
 ttim.fx(i,'MAR','dza',time)$(ord(time) ge 9)
                     = sum(timej$(ord(timej) eq 8), ttim.l(i,'MAR','dza',timej));
 ttim.fx(i,'dza','MAR',time)$(ord(time) ge 9)
                     = sum(timej$(ord(timej) eq 8), ttim.l(i,'dza','MAR',timej));
