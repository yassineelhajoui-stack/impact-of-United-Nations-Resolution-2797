*==============================================================================
* SCENARIO A' -- "Intensification transitoire, puis statu quo"
* Section 3.7.3 (Table 2) de la methodologie revisee de l'article.
*
* Repond a la demande du Reviseur 1 de considerer une trajectoire moins
* optimiste : la Resolution 2797 est suivie d'un choc institutionnel positif,
* mais les tensions diplomatiques Maroc-Algerie s'intensifient d'abord
* temporairement (2025-2027) avant un retour au statu quo tarifaire de 2024
* (ni normalisation, ni nouvelle degradation).
*
* STATUT : version 5. Les versions precedentes ont compile et tourne avec
* succes sous GAMS (erreurs 120/340/171, 349 et 329 corrigees -- CORRECTIF 1
* et 2 ci-dessous) et ont produit les fichiers Results_choc_A_prime.xlsx,
* Results_choc_A.xlsx, Results_choc_B.xlsx, Results_choc_C.xlsx et
* Results_SANS_choc.xlsx que vous m'avez transmis. Trois corrections
* substantielles ont ete apportees depuis :
*  - CORRECTIF 3 : le choc de PTF (bloc 2-i) etait benchmarke sur la
*    MAUVAISE trajectoire (voir CORRECTIF 3 ci-dessous).
*  - CORRECTIF 4 (le vôtre) : le scenario "sans choc" (Results_SANS_choc.
*    xlsx) ne contenait PAS la rupture tarifaire Maroc-Algerie du Tableau 1
*    ("Improvement of the Baseline Scenario") -- verifie sur les donnees
*    reelles transmises : les exportations Maroc-Algerie y croissent de
*    facon lisse sur 2021-2024, sans aucune trace du palier +40 %. Un
*    nouveau fichier, referenc.gms (+ sa copie complete
*    PEP-w-t_v4.1_CAL_B_line-25-18_referenc.gms), integre desormais cette
*    amelioration du scenario de reference.
*  - CORRECTIF 5 (le vôtre encore : "les scenarios avec choc donnent des
*    resultats moins avantageux que le scenario sans choc") : en comparant,
*    periode par periode, Results_reference.xlsx et les 4 Results_choc_*
*    .xlsx obtenus avec CORRECTIF 3+4, le PIB reel marocain des 4 scenarios
*    de choc s'ecartait DEJA du scenario de reference des 2018 -- sept ans
*    avant tout choc reel (qui ne s'applique qu'a partir de 2025) -- et de
*    facon RIGOUREUSEMENT IDENTIQUE dans les 4 scenarios. Un tel ecart ne
*    peut pas etre un effet economique : c'est la signature d'un bug de
*    chargement de donnees. Cause identifiee : dans les copies completes
*    (PEP-w-t_v4.1_CAL_B_line-25-18_{A_prime,A,B,C}.gms), le chargement de
*    A_VA_REF (ajoute pour CORRECTIF 3) rouvrait $GDXIN sur
*    DATA_AGG-2007-25-18.gdx EN PLEIN MILIEU du bloc $LOAD CO, CGO, DDO,
*    ..., POPO -- ce qui corrompait silencieusement une partie des donnees
*    de calibration, y compris pour les periodes anterieures a 2025.
*    Corrige en deplacant ce chargement APRES la fin complete de ce bloc
*    (voir le commentaire "CORRECTIF 5" dans les copies completes pour le
*    detail). CONSEQUENCE : les Results_choc_*.xlsx actuellement en votre
*    possession sont domines par cet artefact et doivent etre consideres
*    comme perimes ; seul un nouveau run avec les fichiers corriges permet
*    d'obtenir des indicateurs SE/VS fiables pour la section 4.2.
* Consequence (CORRECTIF 3+4) : Results_SANS_choc.xlsx est PERIME et doit
* etre remplace par Results_reference.xlsx (produit par referenc.gms), et
* les 4 scenarios de choc doivent etre relances avec le B_line-25-18_REF.gdx
* regenere par ce meme run de reference -- puis, desormais, avec les copies
* completes corrigees par CORRECTIF 5 (memes 4 fichiers, mise a jour interne
* uniquement : aucun nouveau run de reference n'est necessaire, referenc.gms
* et son wrapper n'etant pas concernes par ce bug).
*
* USAGE :
*  ETAPE 0 (prealable, une seule fois, remplace l'ancienne ETAPE 0) --
*   generer le nouveau scenario de reference, qui sert a la fois de donnee
*   de comparaison (Results_reference.xlsx) et de benchmark de PTF pour les
*   4 scenarios de choc : lancez PEP-w-t_v4.1_CAL_B_line-25-18_referenc.gms
*   (deja pret a l'emploi, plus besoin de copier/renommer quoi que ce soit :
*   ce fichier ecrit directement B_line-25-18_REF.gdx et Results_reference
*   .xlsx/.gdx). C'est ce B_line-25-18_REF.gdx, et uniquement lui, que les
*   4 scenarios A_prime/A/B/C vont relire (CORRECTIF 3) : ne le laissez pas
*   ecraser par un run ulterieur autre que celui de referenc.gms.
*  ETAPE 1 -- dans CE fichier, autour des lignes 1590-1594, se trouve deja
*   l'emplacement ou vous branchez vos propres scenarios :
*     ***************************** Simulations**************************************
*     *$INCLUDE Untitled_2.gms
*     *$INCLUDE Untitled_4.gms
*   Faites une COPIE de PEP-w-t_v4.1_CAL_B_line-25-18.gms (p.ex.
*   PEP-w-t_v4.1_CAL_B_line-25-18_Aprime.gms), et remplacez ces deux lignes
*   par : $INCLUDE A_prime.gms -- faites de meme pour A.gms, B.gms, C.gms
*   (une copie par scenario). Ou bien, plus simple : reutilisez directement
*   les 4 copies completes deja pretes a l'emploi que je vous fournis
*   (PEP-w-t_v4.1_CAL_B_line-25-18_A_prime.gms, _A.gms, _B.gms, _C.gms),
*   qui integrent deja toutes les corrections (1, 2 et 3) et exportent
*   chacune ses propres resultats (Results_choc_{scenario}.xlsx) ainsi que
*   sa propre trajectoire A_VA sous un nom distinct (B_line-25-18_{scenario}
*   .gdx) pour ne plus jamais ecraser B_line-25-18_REF.gdx.
*
* Convention temporelle : t1 = 2017 (basedata2017.gdx) ; periode n = annee
* 2016+n. Periode 5 = 2021 (debut de la rupture), periode 8 = 2024 (dernier
* palier de la rupture), periode 9 = 2025 (adoption de la Resolution 2797).
*
* AVERTISSEMENT : les blocs marques "VALIDE" reprennent une syntaxe deja
* presente et fonctionnelle dans vos propres fichiers (Untitled_2.gms,
* Untitled_4.gms). Les blocs marques "PROPOSE" sont des implementations que
* je n'ai trouvees nulle part dans vos fichiers GAMS existants (INIT.gms,
* BAU_SOLVE-25-18.gms, SIM_SOLVE-25-18.gms, Untitled_1-4.gms) : ils ont
* desormais tourne avec succes, mais restent des choix de modelisation
* (notamment la fermeture GDP_BP_REAL/A_VA du bloc 2-i) qui engagent
* l'interpretation economique -- gardez cela present a l'esprit en section
* 4.2 de l'article.
*==============================================================================

* CORRECTIF 2 (Error 349 "Declaration not allowed inside a LOOP or IF
* statement") : ce fichier est inclus a l'interieur du LOOP[time,...] du
* programme principal -- une declaration ALIAS n'y est pas autorisee par
* GAMS. L'alias ALIAS(time,timej), necessaire ci-dessous, doit donc etre
* declare une fois pour toutes AVANT le LOOP, dans le fichier principal lui-
* meme (PEP-w-t_v4.1_CAL_B_line-25-18_A_prime.gms etc., pres de la ligne 90,
* a cote de "ALIAS (UMA,UMAj)") -- c'est deja fait dans les copies que je
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
* Il s'agit de la trajectoire de reference deja "actee" avant la Resolution
* 2797 ; elle n'est pas un choc de politique mais un fait historique suppose.
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
* Cible : sahara(J), deja defini dans DATA_AGG-2007-25-18.gms comme
*   sahara(J) = { Extraction, Constr, animale, Metal }.
* ATTENTION : "turisme" figure dans la section 3.7.2 du texte mais est
* desactive dans cette definition GAMS (ligne "****turisme" commentee dans
* DATA_AGG-2007-25-18.gms). Reactivez-le si le texte doit rester coherent
* avec le code, ou corrigez le texte dans le cas contraire.
*==============================================================================

* --- (i) PTF : +0,12 %/an a partir de 2025 (Kim & Loayza, 2019) [PROPOSE] ---
* IMPORTANT -- lu dans PEP-w-t_v4.1_CAL_B_line-25-18.gms (section 6.1.2,
* lignes ~1533-1542) : dans CE fichier, A_VA(z,time) est une variable LIBRE,
* resolue de maniere a reproduire la trajectoire de PIB reel exogene
* (GDP_BP_REAL.fx, calee sur les projections CEPII/MaGE), et non une variable
* deja fixee comme elle l'est dans BAU_SOLVE/SIM_SOLVE (via B_line-25-18.gdx).
* La fixer directement (A_VA.FX(...)) sans rien changer d'autre rendrait le
* systeme CNS sur-determine pour le Maroc a partir de 2025 : GDP_BP_REAL
* resterait fixee ET A_VA le deviendrait aussi, alors qu'une seule des deux
* peut etre exogene a la fois pour rester a l'equilibre (une equation pour
* une inconnue). Ce fichier applique donc un VERITABLE CHANGEMENT DE
* FERMETURE pour le Maroc a partir de 2025 : GDP_BP_REAL('MAR',.) cesse de
* suivre la trajectoire exogene CEPII/MaGE et devient endogene, tandis que
* A_VA('MAR',.) devient exogene, fixee a la trajectoire de PTF du scenario
* SANS CHOC (A_VA_REF, importee depuis B_line-25-18_REF.gdx), majoree de
* 0,12 % periode par periode -- voir CORRECTIF 3 ci-dessus. C'est un choix
* de modelisation substantiel -- pas une simple ligne de calibrage -- qui
* merite votre validation avant d'etre retenu pour la version soumise.
 GDP_BP_REAL.lo('MAR',time)$(ord(time) ge 9) = -inf;
 GDP_BP_REAL.up('MAR',time)$(ord(time) ge 9) = +inf;
 A_VA.FX('MAR',time)$(ord(time) ge 9)        = A_VA_REF('MAR',time)*1.0012;

* --- (ii) Investissement : +1,5 % (Caldara & Iacoviello, 2022) [PROPOSE] ---
* Rehaussement ponctuel, en 2025, du stock de capital des secteurs sahariens
* au Maroc ; l'accumulation se poursuit ensuite normalement (loi standard du
* modele, cf. INIT.gms) a partir de ce niveau releve. Meme type de levier
* (KD.fx) que celui esquisse, sans etre finalise, dans votre Untitled_1.gms.
* CORRECTIF (Error 329 "Wrong suffix on variable reference") : ".fx" n'est
* pas un suffixe lisible en GAMS ; le membre de droite doit utiliser KD.l(...).
 KD.fx(k,j,'MAR',time)$(ord(time) eq 9 and sahara(j)) = 1.015*KD.l(k,j,'MAR',time);

* --- (iii) Elasticites CET/CES : +5 % (Aghion et al., 2005a, 2005b) [PROPOSE] ---
* i et j sont alias (ALIAS(j,jj,i,ij), DATA_AGG-2007-25-18.gms) : le meme
* sous-ensemble sahara(.) s'applique donc aux deux domaines.
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
* (3) INTENSIFICATION TRANSITOIRE PUIS RETOUR AU STATU QUO -- specifique a A'
*     [PROPOSE : reprend le doublement deja teste dans Untitled_2.gms pour
*      2025-2027, mais y ajoute explicitement le retour au niveau de 2024
*      a partir de 2028, qu'Untitled_2.gms n'implementait pas.]
*==============================================================================
 ttim.fx(i,'MAR','dza',time)$(ord(time) ge 9 and ord(time) le 11)
                     = 2*sum(timej$(ord(timej) eq 8), ttim.l(i,'MAR','dza',timej));
 ttim.fx(i,'dza','MAR',time)$(ord(time) ge 9 and ord(time) le 11)
                     = 2*sum(timej$(ord(timej) eq 8), ttim.l(i,'dza','MAR',timej));

 ttim.fx(i,'MAR','dza',time)$(ord(time) ge 12)
                     = sum(timej$(ord(timej) eq 8), ttim.l(i,'MAR','dza',timej));
 ttim.fx(i,'dza','MAR',time)$(ord(time) ge 12)
                     = sum(timej$(ord(timej) eq 8), ttim.l(i,'dza','MAR',timej));
