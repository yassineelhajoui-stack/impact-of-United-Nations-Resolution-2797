*==============================================================================
* REFERENC -- "Amelioration du scenario de reference" (Tableau 1 de la
*              methodologie : "Improvement of the Baseline Scenario")
*
* Vous avez raison : ce fichier manquait. Le Tableau 1 de la methodologie
* decrit la rupture tarifaire Maroc-Algerie de 2021-2024 comme une
* amelioration du SCENARIO DE REFERENCE lui-meme (i.e. un fait historique
* deja survenu, integre au "sans choc"), et non comme un element propre aux
* scenarios de choc A'/A/B/C. Or, en verifiant les donnees reelles que vous
* m'avez transmises (Results_SANS_choc.xlsx), les exportations Maroc-Algerie
* y croissent de facon lisse sur 2017-2024, SANS aucune trace de la rupture
* tarifaire -- ce qui confirme que le run "sans choc" fourni ne l'incluait
* pas encore. Ce fichier corrige ce point : il ne contient QUE la rupture
* tarifaire rendue permanente (Tableau 1), SANS le choc institutionnel et
* geopolitique de la section 3.7.2 (celui-ci reste propre aux scenarios de
* choc A'/A/B/C, puisqu'il represente l'effet, encore hypothetique, de la
* Resolution 2797 elle-meme).
*
* Consequence pratique : le "scenario sans choc" utilise comme reference
* pour les indicateurs SE.REF et VS de la section 4.2 doit desormais etre
* regenere en executant CE fichier (via la copie complete fournie,
* PEP-w-t_v4.1_CAL_B_line-25-18_referenc.gms), et non plus le fichier
* d'origine sans aucun $INCLUDE. Les resultats Results_SANS_choc.xlsx deja
* transmis doivent etre consideres comme perimes et remplaces par les
* nouveaux resultats de ce run (voir le fichier wrapper pour le nom de
* sortie retenu, Results_reference.xlsx).
*
* USAGE : voir A_prime.gms pour le mecanisme general d'insertion. Utilisez
* directement PEP-w-t_v4.1_CAL_B_line-25-18_referenc.gms, deja pret a
* l'emploi -- c'est desormais ce fichier, et non plus l'original sans
* $INCLUDE, qui constitue l'ETAPE 0 (generation de B_line-25-18_REF.gdx)
* necessaire avant de lancer A_prime.gms, A.gms, B.gms et C.gms.
*
* Convention temporelle : t1 = 2017 ; periode n = annee 2016+n. Periode 5 =
* 2021 (debut de la rupture), periode 8 = 2024 (dernier palier, +40 %),
* periode 9 = 2025 (le tarif reste au palier de 2024 pour le reste de
* l'horizon de simulation, conformement au Tableau 1 : "-- +40%" reconduit
* sans interruption de 2025 a 2040).
*==============================================================================

* CORRECTIF (meme cause que pour A_prime.gms/A.gms/B.gms/C.gms) : ce fichier
* est inclus a l'interieur du LOOP[time,...] du programme principal, ou une
* declaration ALIAS n'est pas autorisee. L'alias ALIAS(time,timej), utilise
* ci-dessous, est donc deja declare dans PEP-w-t_v4.1_CAL_B_line-25-18_
* referenc.gms, avant le LOOP, a cote de "ALIAS (UMA,UMAj)".

*==============================================================================
* (1) RUPTURE TARIFAIRE MAROC-ALGERIE, 2021-2024 -- Tableau 1, lignes 1-8
*     [VALIDE : syntaxe identique a Untitled_2.gms / Untitled_4.gms, et aux
*      blocs (1) de A_prime.gms / A.gms / B.gms / C.gms]
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
* (2) MAINTIEN DU PALIER DE 2024 JUSQU'EN 2040 -- Tableau 1, lignes "-- +40%"
*     reconduites sans interruption de 2025 a 2040. Aucun choc institutionnel
*     ni geopolitique n'est applique ici : cette amelioration du scenario de
*     reference porte uniquement sur le fait tarifaire deja survenu.
*     [VALIDE : meme syntaxe que le bloc (3) "statu quo tarifaire" de A.gms]
*==============================================================================
 ttim.fx(i,'MAR','dza',time)$(ord(time) ge 9)
                     = sum(timej$(ord(timej) eq 8), ttim.l(i,'MAR','dza',timej));
 ttim.fx(i,'dza','MAR',time)$(ord(time) ge 9)
                     = sum(timej$(ord(timej) eq 8), ttim.l(i,'dza','MAR',timej));
