*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to:                      *
*                         Veronique Robichaud, Andre Lemelin,                  *
*                         Helene Maisonnave and Bernard Decaluwe.              *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*
* Ce fichier permet le mappage entre les ensembles définis dans les fichiers
* PEP-w.GMS et les ensembles utilisés dans GTAP8.1.
* Il permet également la création des différents ensembles utilisés dans le modèle.

* Avant les étapes ci-dessous, les données GTAP8.1 doivent être converties en fichiers GDX.
* Nous avons d'abord utilisé GTAPAgg et un mappage 1 à 1 pour générer des fichiers HAR.
* Nous avons modifié les noms de deux secteurs afin d'éviter toute confusion
* avec des régions partageant les mêmes acronymes. Par conséquent, « autres
* activités minières » fait référence à l'utilisation d'OTM au lieu d'OMN
* (qui fait référence à Oman dans l'ensemble REG) et « Assurance » fait référence
* à l'utilisation d'INS au lieu d'ISR (qui fait référence à Israël dans l'ensemble REG).


* l'exécution de GTAPAgg génère automatiquement un certain nombre de fichiers,
* dont deux sont utilisés ci-dessous : BaseData2007.har et Default.prm. Ce dernier
* a été renommé Parameters2007.har.
* La fonction har2gdx permet de convertir ces deux fichiers au format GDX.

*===============================================================================
* 1. Définir les ensembles
*===============================================================================
* 1.1 Ensembles qui seront utilisés dans le modèle agrégé
*===============================================================================
SET J All industries
/
agr
ser
adm
Food
Mog
Text
Wood
Metal
TraEqp
Transport
Constr
animale
Extraction
MachEqp
chm_pharm
turisme
fincnce
/

I1(J) All commodities except agriculture
/
*agr
ser
adm
Food
Mog
Text
Wood
Metal
TraEqp
Transport
Constr
animale
Extraction
MachEqp
chm_pharm
turisme
fincnce
/

BUS(J) Private industries
/
agr
ser
*adm
Food
Mog
Text
Wood
Metal
TraEqp
Transport
Constr
animale
Extraction
MachEqp
chm_pharm
turisme
fincnce

/

PUB(J) Public industries
/
adm
/
sahara(J) les secteurs intensifs dans les régions sahariennes du Maroc
/
Extraction
Constr
animale
turisme
Metal
/

F Production factors
/
 slab            Skilled labour
 ulab            Unskilled Labour
 cap             Capital
 land            Land
 natr            Natural resources
/

L(F) Labor categories
/
 slab            Skilled labour
 ulab            Unskilled Labour
/

K(F) Capital categories
/
 cap             Capital
 land            Land
 natr            Natural resources
/

Z Regions
/
*UMA
mar
egy
tun
dza
chn
usa
can
sau
ARE
omn
qat
irn
*irq
JOR
*  KWT
*  LBN
TUR
 LBY_
* SYR
  bhr
  ISR
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*NordAmerica
*EastEuro
*SouthAsia
*EastAsia
*LatinAmer_1
*CentraAsia
*SSA_54
*SEAsia
*EU_28
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
jpn
fra
gbr
deu
ita
esp
prt
*dnk
rus
*pol
*swe
*kor
**2045
mex
*EU
grc
*pol
*aut
********pol
********dnk
********nld
********lux
*fin
********swe
********bel
********aut
ZAF
*NGA
***SEN
CIV
*UGA
*ETH
*RWA
*KEN
*NER
*TZA
*MWI
*BWA
*GIN
*CMR
*TGO
*SSA
/

Z1(Z) All regions except reference region
/
*UMA
mar
egy
tun
dza
chn
*usa
can
sau
ARE
omn
qat
irn
*irq
JOR
*    KWT
*   LBN
TUR
  LBY_
*  SYR
  bhr
  ISR
*MENA
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*NordAmerica
*EastEuro
*SouthAsia
*EastAsia
*LatinAmer_1
*CentraAsia
*SSA_54
*SEAsia
*EU_28
*SSA
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
jpn
fra
gbr
deu
ita
esp
prt
rus
*swe
*kor
*2045
mex
*EU
grc
*pol
*aut

********pol
********dnk
********nld
********lux
*fin
********swe
********bel
********aut
ZAF
*NGA
*SEN
CIV
*UGA
*ETH
*RWA
*KEN
*NER
*TZA
*MWI
*BWA
*GIN
*CMR
*TGO
/

ZR(Z) Reference country
/
usa
/
UMA(Z) All regions except reference region
/
mar
tun
dza
LBY_
/
Zrich(Z) Rich regions

Zother(Z) Non-rich regions

TIME Time periods
/
2002*2054
/
*==============================================================================
*  1.2 Ensembles utilisés dans GTAP11
*==============================================================================

 GlobalSet(*)          Tous les éléments de tous les ensembles
 endw(GlobalSet)       Tous les facteurs de production
 acts(GlobalSet)       Tous secteurs et matières premières
 reg(GlobalSet)        Toutes les régions
 marg(acts)            Produits de marge
 comm(acts)            Tous secteurs et matières premières sauf investissement

$GDXIN basedata2017.gdx
$LOAD GlobalSet, reg, endw, acts, comm, marg

*==============================================================================
*  1.3 Mappage entre les ensembles utilisés dans PEP-w et GTAP11
*==============================================================================
z1c(reg)  Éléments de GTAP faisant référence à un seul pays
* Toutes les régions GTAP sauf celles commençant par un "x"
/
    dza ,tun, xnf,mar,egy
  , ben,bfa,civ,gha,gin,mli,ner,nga,sen,tgo,xwf,cmr
  , gab,gnq,cog,cod,tcd,caf,xac
  , com,eth,mdg,ken,mwi,mus,moz,rwa,sdn,tza,uga,zmb,zwe,xec
  , bwa,swz,nam,zaf,xsc
  , usa,chn,can,sau ,ARE ,irn,TUR ,omn , qat,JOR ,irq ,KWT,LBN,SYR,bhr,xws,pse
  , mng ,brn,hkg ,jpn,kor,twn,XEA ,Mex,fra ,
   BOL, CHL, COL, PRY, PER, VEN, XSM, HND, NIC, PAN, XCA, JAM, PRI
  , TTO, XCB, BRA, CRI, DOM, GTM, URY, CHE,rus,ukr,blr,srb,alb,xee
*  , SEAsia,EastAsia,NAmerica

/
z2reg(z,reg) Cartographie des régions
/
**************************************UMA***************************************
*UMA.(XNF,tun,dza,mar)
mar.(mar)
tun.(tun)
dza.(dza)
LBY_.(XNF,LBN)
*
**************************************MENA**************************************
egy.(egy)
sau.(sau)
ARE.(ARE)
omn.(omn)
irn.(irn)
JOR.(JOR)
TUR.(TUR)
qat.(qat)
bhr.(bhr)
isr.(ISR)
*   KWT.(KWT)
*   LBN.(LBN)
*   SYR.(SYR)
*   irq.(irq)
*MENA.(mar, egy,tun ,dza ,sau ,ARE ,irn,TUR ,omn , qat,JOR ,irq ,KWT,LBN,SYR,bhr,xws,xnf,pse )
**************************************UE****************************************
fra.(fra)
deu.(deu)
ita.(ita)
grc.(grc)
prt.(prt)
esp.(esp)
gbr.(gbr)
**************************************SSA***************************************
*SSA_54.(GIN,TGO, CMR, XWF, XAC, ETH, KEN, MDG, MWI, MUS
*      , MOZ, TZA, UGA, ZMB, XEC, BWA, XSC, NAM, BEN, BFA
*      , RWA, ZWE, SEN, CIV, GHA, NGA,NER,CAF,COD,COG,GAB,GNQ,COM,SWZ,ZAF,SDN)
ZAF.(ZAF)
*NGA.(NGA)
*SEN.(SEN)
CIV.(CIV)
*UGA.(UGA)
*ETH.(ETH)
*RWA.(RWA)
*KEN.(KEN)
*NER.(NER)
*TZA.(TZA)
*MWI.(MWI)
*BWA.(BWA)
*GIN.(GIN)
*CMR.(CMR)
*TGO.(TGO)
**************************************R_wod*************************************
chn.(chn)
usa.(usa)
can.(can)
jpn.(jpn)
rus.(rus)
mex.(mex)
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*NordAmerica.(USA,CAN,Mex )
*EastEuro.(rus,ukr,blr,srb,alb,xee )
*SouthAsia.(lao,xse,khm,ind,bgd,lka,pak,npl)
*EastAsia.(chn,twn ,brn,hkg ,jpn,kor,XEA,mng)
*LatinAmer_1.(BRA,BOL, CHL, COL, PRY, PER, VEN,XSM, HND, NIC, PAN, XCA, JAM,PRI
*      , TTO, XCB, CRI, DOM, GTM, URY, CIV, GHA, CHE)
*CentraAsia.(xsu,kaz,kgz,tjk,uzb,arm,aze,geo)
*SSA.(gin,tgo,cmr,xwf,xac,eth,ken,mdg,mwi,mus,moz,tza,uga,zmb,xec,bwa,zaf,xsc
*     ,nam,ben,bfa,rwa,zwe,sen,civ,gha,nga)
*SEAsia.(lao,xse,khm,idn,phl,mys,sgp,vnm,tha)
*EU_28.(fra,deu,ita,est,hun,lva,svk,rou,dnk,fin,pol,lux,grc,bel,bgr
*     ,aut,cze,irl,nld,prt,esp,swe,ltu,mlt)
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/
j2comm(j,acts) Cartographie des secteurs
/
 Agr.       (pdr, wht,gro,pcr,vol, osd, v_f, c_b, pfb, ocr, sgr, ofd, b_t)
 Wood.      (lum, ppp)
 TraEqp.    (mvh, otn)
 Text.      (tex, wap, lea)
 animale.   (ctl, oap, rmk, wol, frs, fsh,cmt, omt, mil)
 Metal.     (i_s, nfm, fmp, nmm )
 Transport. (otp, wtp, atp ,whs)
 Extraction.(coa,gas,oxt,p_c,gdt)
 MachEqp.   (ome,ele,eeq,omf)
 chm_pharm. (chm,bph,rpp)
 adm.       (wtr,OSG,edu,hht)
 Food.      (cmt, omt, vol, mil, pcr, sgr, ofd,b_t)
 Mog.       (coa, oil, gas ,oxt)
* OthServ.  (cmn, ros, dwe)
 ser.       (ely, wtr,trd,afs,otp, wtp, atp,cns,cmn)
*ser.(trd,cmn,obs,ros)
 turisme.   (afs)
 Constr.    (cns,rsa,dwe)
 fincnce.   (ofi,ins)
/
f2endw(f,endw) Cartographie des facteurs de production
/
 slab.     (SkLab)
 ulab.     (UnSkLab)
 cap.      (Capital)
 land.     (Land)
 natr.     (NatRes)
/

ALIAS(reg,regj)
ALIAS(comm,commj)
ALIAS(j,jj,i,ij)
ALIAS(l,lj)
ALIAS(k,kj)
ALIAS(z,zj,zjj)
ALIAS(time,timej)
;
*==============================================================================
* 2. Calibrage des variables
*==============================================================================

Parameter
*==============================================================================
*  2.1 Variables dans GTAP11
*==============================================================================
* Ce sont les variables de GTAP11 utilisées dans le processus d'étalonnage.
* Les données démographiques sont en millions tandis que toutes les autres donn
*ées sont exprimées en millions de dollars.

 EVOS(endw,acts,reg)              Dotations aux prix des agents
 EVFB(endw,acts,reg)              dotation les entreprises achètent aux prix du marché

 FBEP(endw,acts,reg)              Subventions basées sur les facteurs
 FTRV(endw,acts,reg)              Taxes - Recettes fiscales sur l'emploi des facteurs
 MFRV(comm,reg,reg)               taxe à l'exportation équivalente à la prime de contingentement de l'AMF
* OSEP(comm,reg)                   Subventions ordinaires à la production
 POP(reg)                         Population
 TFRV(comm,reg,reg)               Protection Droit d'importation ordinaire
 VDEP(reg)                        Valeur du stock de capital de l'amortissement(La dépréciation du capital)
 PTAX(comm,acts,reg)
 VDFP(comm,acts,reg)    Les entreprises intermédiaires achètent aux prix d’achat
 VDFB(comm,acts,reg)    Les entreprises intermédiaires achètent aux prix de base
 VDIP(comm,reg)         Achats de matières premières nationales par les agents d’investissement aux prix d’achat
 VDIB(comm,reg)         Achats de matières premières importées par les agents d'investissement aux prix de base
 VDGP(comm,reg)         Le gouvernement dom achète aux prix d’achat
 VDGB(comm,reg)         Le gouvernement achète aux prix de base
 VDPP(comm,reg)         Achats de propriétés privées aux prix d’achat
 VDPB(comm,reg)         Achats privés de ménages aux prix de base

 VMFP(COMM,ACTS,REG)    importations d'entreprises intermédiaires aux prix d’achat
 VMFB(COMM,ACTS,REG)    Importations des entreprises intermédicales aux prix de base
 VMIP(COMM,REG)         Achats de matières premières importées par les agents d’investissement aux prix d’achat
 VMIB(COMM,REG)         Achats de matières premières importées par les agents d'investissement aux prix de base
 VMGP(COMM,REG)              Importations gouvernementales aux prix d’achat
 VMGB(COMM,REG)              Importations gouvernementales aux prix de base
 VMPP(COMM,REG)              Importations des ménages privés aux prix d’achat
 VMPB(COMM,REG)              Importations des ménages privés aux prix de base

 VMSB(COMM,REG,REG)          Commerce des importations bilatérales aux prix de base
 VCIF(COMM,REG,REG)          Échanger des Importations bilatérales aux prix CIF
 VXSB(COMM,REG,REG)          Échanger des exportations bilatérales aux prix de base
 VFOB(COMM,REG,REG)          Échanger des exportations bilatérales aux prix FOB

 VKB(reg)                     Valeur du stock de capital en début de période
 VST(marg,reg)                Trade Exports Internatl Trans Mkt Prices
 VTWR(marg,comm,reg,reg)      Trade Margins Internatl Trans World Prices
 XTRV(comm,reg,reg)           les taxes à l'exportation « ordinaires »

*==============================================================================
*  2.2 Variables dans le modèle agrégé
*==============================================================================
 CO(i,z)         Consommation des ménages du produit I
 CGO(i,z)        Consommation finale publique du produit i
 INVO(i,z)       Demande finale du produit i à des fins d'investissement
 DIO(i,j,z)      Consommation intermédiaire du bien i par industrie j
 IMO(i,zj,z)     Importations du produit i par pays z depuis le pays zj
 EXO(i,z,zj)     Exporte l’offre du produit i du pays z vers le pays zj
 tmrg(i,ij,zj,z) Taux de marge sur le produit i appliqué aux importations ij en provenance du pays zj
 MRGNO(i,z)      Demande de produit i en marge
 TIXO(i,z,zj)    Recettes publiques de taxes indirectes sur les exportations de produits i
 TIMO(i,zj,z)    Recettes publiques de taxes indirectes sur les importations de produits i
 TIWO(l,j,z)     Recettes publiques d'impôts indirects sur les salaires et traitements de l'industrie j
 TIKO(k,j,z)     Recettes publiques d'impôts indirects sur le capital k de l'industrie j
 TIPO(i,z)       Recettes publiques d'impôts indirects sur la production industrielle j
 TICO(i,z)       Recettes publiques de taxes indirectes sur les produits de base i
 TDHO(z)         Impôts sur le revenu des ménages
 LDO(l,j,z)      Industrie j demande de main d’œuvre l
 RKDO(k,j,z)     Revenu du capital de type k dans l'industrie j
 KSTO(z)         Stock de capital total dans la région z
 DEPO(z)         Depreciation
 POPO(z)         Population
 DDO(i,z)        Demande de production nationale du produit i
 DSO(i,z)       Offre de la production nationale du produit i
 XSO(j,z)       industrie j production totale
;
*==============================================================================
*  2.3 Chargement des paramètres depuis la base de données GTAP
*==============================================================================
$LOAD EVOS ,EVFB,FBEP,FTRV,MFRV ,POP,TFRV,VDEP,VDFP,VDFB, VDIP,VDIB,VDGP
$LOAD VMFP,VMFB, VMIP, VMIB,VMGP, VMGB, VMPP, VMPB,VMSB, VCIF, VXSB, VFOB, VKB
$LOAD VDGB,VDPP,VDPB ,VST, VTWR, XTRV,PTAX
*,OSEP
*==============================================================================
* 2.4 Mappage entre les variables du modèle et GTAP
*==============================================================================
* NOTE: In GTAP parlance, "agents' prices" are prices paid by buyers, and
*       "market prices" are prices received by sellers.
*==============================================================================
* 2.4.1Consommation des ménages
*==============================================================================
* Households consumption is given by the sum of domestic purchases at
* agents prices (VDPA) and private household imports at agents prices (VIPA).

 CO(i,z)         = SUM{(comm,reg)$[j2comm(i,comm)$z2reg(z,reg)],
                       VDPP(comm,reg)+VMPP(comm,reg)};

*==============================================================================
* 2.4.2 Consommation finale publique
*==============================================================================
* Public final consumption is given by the sum of domestic purchases at
* agents prices (VDGA) and public final imports at agents prices (VIGA).

 CGO(i,z)        = SUM{(comm,reg)$[j2comm(i,comm)$z2reg(z,reg)],
                       VDGP(comm,reg)+VMGP(comm,reg)};

*==============================================================================
* 2.4.3 Demande à des fins d'investissement
*=============================================================================
*  In the GTAP data, the accumulation account is presented in the
*  production sector CGDS (Capital goods). Demand for investment purposes
*  is thus given by the sum of domestic purchases at agents prices (VDFA)
*  and public final imports at agents prices (VIFA) for this sector.

 INVO(i,z)       = SUM{(comm,reg)$[j2comm(i,comm)$z2reg(z,reg)],
                        VDIP(comm,reg)+VMIP(comm,reg)};

*==============================================================================
* 2.4.4 Demande intermédiaire
*==============================================================================
* Intermediate consumption is given by the sum of domestic purchases at
* agents prices (VDFA) and public final imports at agents prices (VIFA).

 DIO(i,j,z)      = SUM[(comm,commj,reg)$[j2comm(i,comm)
                      $j2comm(j,commj)$z2reg(z,reg)],
                      VDFP(comm,commj,reg)
                     +VMFP(comm,commj,reg)];

*==============================================================================
* 2.4.5 Importations
*==============================================================================
* Imports are defined in GTAP at world prices (VIWS) and at market prices
* (VIMS). Data on bilateral flows also include margins on imports (VTWR) and
* import duties (TFRV). On the export side, the database includes exports at
* market prices (VXMD), at world prices (VXWD) and subsidies on exports (MFRV
* and XTRV).
* The relationships between those variables is the following:
*       VIMS = VIWS + TFRV
*       VIWS = VXWD + VTWR
*       VXMD = VXWD - MFRV - XTRV
*
* Imports are evaluated at world prices (VIWS) less transport margins (VTWR).

** Elimination of trade within a country:
** Trade within any entity that is a GTAP single-country region (or equivalent)
** is removed.
 VCIF(comm,z1c,z1c)           = 0;
 VTWR(marg,comm,z1c,z1c) = 0;

 IMO(i,zj,z)     = SUM{(comm,regj,reg)$[j2comm(i,comm)
                       $z2reg(zj,regj)$z2reg(z,reg)],
                       VCIF(comm,regj,reg)-
                       SUM[marg,VTWR(marg,comm,regj,reg)]};

*==============================================================================
* 2.4.6 Exportations
*==============================================================================
*  To limit the sources of potential desequilibrium, exports are simply set
*  equal to imports.

 EXO(i,zj,z)     = IMO(i,zj,z);

*==============================================================================
* 2.4.7 Margins
*==============================================================================
*  Transport margins are given by the variable VTWR
 tmrg('ser',ij,zj,z)$IMO(ij,zj,z)
                 = SUM{(comm,regj,reg)$[j2comm(ij,comm)
                       $z2reg(zj,regj)$z2reg(z,reg)],
                       SUM[marg,VTWR(marg,comm,regj,reg)]};

* Supply of transport margin are given by the variable VST
 MRGNO(i,z)      = SUM{(marg,reg)$[j2comm(i,marg)$z2reg(z,reg)],
                       VST(marg,reg)};

*==============================================================================
* 2.4.8 Droits à l'importation
*==============================================================================
*  Import duties are given by the variable TFRV

 TIMO(i,zj,z)$IMO(i,zj,z)
                 = SUM{(comm,regj,reg)$[j2comm(i,comm)
                       $z2reg(zj,regj)$z2reg(z,reg)],
                       TFRV(comm,regj,reg)};

*==============================================================================
* 2.4.9 Taxes sur les exportations
*==============================================================================
*  Taxes on exports are given by the sum of MRRV and XTRV

 TIXO(i,z,zj)$IMO(i,z,zj)
                 = SUM{(comm,reg,regj)$[j2comm(i,comm)
                       $z2reg(z,reg)$z2reg(zj,regj)],
                       MFRV(comm,reg,regj)+XTRV(comm,reg,regj)};

*==============================================================================
* 2.4.10 Taxes sur les facteurs de production
*==============================================================================
* Net taxes on factor of production are calculated as taxes (FTRV)
* less subsidies (FBEP).

 TIWO(l,j,z)      = SUM{(endw,comm,reg)$[f2endw(l,endw)
                       $j2comm(j,comm)$z2reg(z,reg)],
                       FTRV(endw,comm,reg)-
                       FBEP(endw,comm,reg)};

 TIKO(k,j,z)     = SUM{(endw,comm,reg)$[f2endw(k,endw)
                       $j2comm(j,comm)$z2reg(z,reg)],
                       FTRV(endw,comm,reg)-
                       FBEP(endw,comm,reg)};

*==============================================================================
* 2.4.11 Taxes sur la production
*==============================================================================
* Taxes on production are set equal to the negative value of production
* subsidies (OSEP).

* TIPO(j,z)       = -SUM{(comm,reg)$[j2comm(j,comm)$z2reg(z,reg)],
*                       OSEP(comm,reg)};
 TIPO(j,z)       = -SUM{(comm,reg)$[j2comm(j,comm)$z2reg(z,reg)],
                       (sum(ACTS,PTAX(comm,ACTS,reg)))};
*==============================================================================
* 2.4.12 Taxes intérieures sur les produits
*==============================================================================
* Domestic taxes on commodities are evaluated as the difference between
* demand at agent prices and demand at market prices.

 TICO(i,z)       = SUM{(comm,reg)$[j2comm(i,comm)$z2reg(z,reg)],
                      VDPP(comm,reg)-VDPB(comm,reg)
                     +VMPP(comm,reg)-VMPB(comm,reg)
                     +VDGP(comm,reg)-VDGB(comm,reg)
                     +VMGP(comm,reg)-VMGB(comm,reg)
                     +SUM[ACTS,VDFP(comm,ACTS,reg)
                          -VDFB(comm,ACTS,reg)]
                     +SUM[ACTS,VMFP(comm,ACTS,reg)
                          -VMFB(comm,ACTS,reg)]
                    +[VDIP(comm,reg)-VDIB(comm,reg)]
                    +[VMIP(comm,reg)-VMIB(comm,reg)]};
;
*==============================================================================
* 2.4.13 Impôts directs
*==============================================================================
* Direct taxes is given by the difference between factor payment at
* market prices (VFM) and endowment at agent prices (EVOA)

 TDHO(z)         = SUM{reg$z2reg(z,reg),
                       SUM[endw,SUM(ACTS,EVOS(endw,ACTS,reg)
                                        -EVFB(endw,ACTS,reg))]};

*==============================================================================
* 2.4.14 Facteurs de production
*==============================================================================
* Remuneration of the production factors is evaluated at market prices,
* that is before taxes (VFM).

LDO(l,j,z)      = SUM{(endw,comm,reg)$[f2endw(l,endw)
                       $j2comm(j,comm)$z2reg(z,reg)],
                       EVFB(endw,comm,reg)};

 RKDO(k,j,z)      = SUM{(endw,comm,reg)$[f2endw(k,endw)
                       $j2comm(j,comm)$z2reg(z,reg)],
                       EVFB(endw,comm,reg)};

* Total capital stock at the beginning of the period
 KSTO(z)         = SUM{reg$z2reg(z,reg),VKB(reg)};

*==============================================================================
* 2.4.15 Dépréciation
*==============================================================================
* Depreciation is given by the variable VDEP

 DEPO(z)         = SUM{reg$z2reg(z,reg),VDEP(reg)};

*==============================================================================
* 2.4.16 Population
*==============================================================================
*  Population by region
 POPO(z)         = SUM{reg$z2reg(z,reg),POP(reg)};


*==============================================================================
* 2.4.17 Demande intérieure
*==============================================================================
* Once again, to avoid descrepencies, domestic purchases are calculated
* by substracting imports, transport margins and indirect taxes from total
* domestic absorption.

 DDO(i,z)        = CO(i,z)+CGO(i,z)+INVO(i,z)+SUM[j,DIO(i,j,z)]-TICO(i,z)
                   -SUM[zj,TIMO(i,zj,z)]-SUM[zj,IMO(i,zj,z)]
                   -SUM[(ij,zj),tmrg(ij,i,zj,z)];

*==============================================================================
* 2.5 Équilibrer les données
*==============================================================================
*  2.5.1 Équilibre sur le marché mondial des marges
*==============================================================================
*  The first step would be to equilibrate international markets. As there is a
*  small difference between supply of margins and demand, we chose to adjust
*  the supply side by increasing or reducing each region's production
*  proportionately.

 MRGNO(i,z)$MRGNO(i,z)
                 = MRGNO(i,z)*SUM[(ij,zj,zjj),tmrg(i,ij,zj,zjj)]
                  /SUM[zjj,MRGNO(i,zjj)];

**==============================================================================
* 2.5.2 Équilibre dans chaque région
*==============================================================================
*  As exports have already been set equal to imports, the remaining differences
*  would appear in the national data. Total production is first set equal to
*  the sum of production for the domestic market (DSO), adjusted production
*  of margins (MRGNO) and exports.

 DSO(i,z)        = DDO(i,z);
 XSO(j,z)        = DSO(j,z)+MRGNO(j,z)+SUM[zj,EXO(j,z,zj)-TIXO(j,z,zj)];

*  The operating surplus is the variable that was used to equilibrate the
*  regional data. As all other variables (income, savings and so on) will
*  be calculated based on the variables described in these steps, there
*  should not be any other descrepency.

* RKDO('cap',j,z)  = XSO(j,z)-SUM[i,DIO(i,j,z)]-SUM[l,LDO(l,j,z)+TIWO(l,j,z)]
*                   -TIPO(j,z)-SUM[k,TIKO(k,j,z)]-RKDO('land',j,z)
*                   -RKDO('natr',j,z);

TIPO(j,z)      = XSO(j,z)-SUM[i,DIO(i,j,z)]-SUM[l,LDO(l,j,z)+TIWO(l,j,z)]
                   -SUM[k,TIKO(k,j,z)+RKDO(k,j,z)];
*==============================================================================
* 3. CES élasticités
*==============================================================================
* 3.1 Définition des paramètres GTAP
*==============================================================================
PARAMETER
 ESUBD(comm,reg)  Élasticité de substitution entre produit intérieur et importations
 ESUBM(comm,reg)  Élasticité de substitution entre les importations en provenance de différentes régions
 ESUBVA(ACTS,reg) Élasticité de substitution entre facteurs primaires dans la production de valeur ajoutée

*==============================================================================
* 3.2 Définition en PEP w
*==============================================================================
 sigma_M1(i,z)   Élasticité (CES - matière première composite)
 sigma_M2(i,z)   Élasticité (CES - import composite)
 sigma_VA(j,z)   Elasticité (CES - valeur ajoutée)

;

*==============================================================================
* 3.4 Chargez le fichier GTAP qui comprend les paramètres
*==============================================================================
$GDXIN Parameters2017.gdx
$LOAD ESUBD, ESUBM, ESUBVA

*==============================================================================
*  3.5 sigma_M1
*==============================================================================
* Elasticities of substitution between domestic product and imports are
* aggregated acording to the share of each commodity (QO) TRAD_COMM in total I



 sigma_M1(i,z)   = SUM{(comm,reg)$[j2comm(i,comm)
                       $z2reg(z,reg)],
                       ESUBD(comm,reg)}
*sigma_M1(i,z)   =100
*10
* sigma_M1(i,z)=1
*sigma_M1(i,z) =  max(sigma_M1(i,z), 10)
;

*==============================================================================
*  3.6 sigma_M2
*==============================================================================
* Elasticities of substitution between imports from different partners are
* aggregated acording to the share of total import (IMTO) TRAD_COMM in total I


 sigma_M2(i,z)   = SUM{(comm,reg)$[j2comm(i,comm)
                       $z2reg(z,reg)],
                       ESUBM(comm,reg)}
* sigma_M2(i,z)   =100
*/10
*sigma_M2(i,z)   = 5
*sigma_M2(i,z) =  max(sigma_M2(i,z), 10)
;

*==============================================================================
*  3.7 sigma_VA
*==============================================================================
* Elasticities of substitution between factors of production are aggregated
* acording to the share of each sector (VA) TRAD_COMM in total I

 sigma_VA(j,z)   = SUM{(comm,reg)$[j2comm(j,comm)
                       $z2reg(z,reg)],
                       ESUBVA(comm,reg)}
* sigma_VA(j,z)   = 100
*/10
*sigma_VA(j,z)   =1
* sigma_VA(j,z) =  max( sigma_VA(j,z), 10)
;
*==============================================================================
* 4. Projections used in PEP w-t model
*==============================================================================
* The following file includes data from:
* Source: "The Great Shift: Macroeconomic projections for the world economy at
* the 2050 horizon" CEPII Working Paper 2012-03
* by Jean Foure, Agnes Benassy-Quere & Lionel Fontagne
* February 2012.

** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
**NOTE THAT THE FOLLOWING GTAP8.1 REGIONS ARE ABSENT FROM THE PROJECTIONS**
**   aze, ben, bfa, cyp, ecu, gin, hrv, nam, rwa, slv, svn, tgo, twn,    **
**   xea, xer, xna, xtw, zwe                                             **
** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
PARAMETER
PROpopAC2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROpopAC2021 rng=PROpopAC2021!A2:D21176 Rdim=3
$GDXIN PPP
$LOAD PROpopAC2021
$GDXIN

PARAMETER
PROpop2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROpop2021 rng=PROpop2021!A2:D21176 Rdim=3
$GDXIN PPP
$LOAD PROpop2021
$GDXIN

PARAMETER
PROSavings2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROSavings2021 rng=PROSavings2021!A2:D21176  Rdim=3
$GDXIN PPP
$LOAD PROSavings2021
$GDXIN

PARAMETER
PROGDP_K(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROGDP_K rng=PROGDP_K!A2:D21176  Rdim=3
$GDXIN PPP
$LOAD PROGDP_K
$GDXIN

PARAMETER
PROinvest2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROinvest2021 rng=PROinvest2021!A2:D21176  Rdim=3
$GDXIN PPP
$LOAD PROinvest2021
$GDXIN

PARAMETER
PROEnergyC2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROEnergyC2021 rng=PROEnergyC2021!A2:D21176  Rdim=3
$GDXIN PPP
$LOAD PROEnergyC2021
$GDXIN

PARAMETER
PROTFPxGDP2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROTFPxGDP2021 rng=PROTFPxGDP2021!A2:D21176  Rdim=3
$GDXIN PPP
$LOAD PROTFPxGDP2021
$GDXIN


PARAMETER
PROK_Stock2021(*,*,*);

$CALL GDXXRW.EXE PPP.xlsx par=PROK_Stock2021 rng=PROK_Stock2021!A2:D21176 Rdim=3
$GDXIN PPP
$LOAD PROK_Stock2021
$GDXIN
*$include Projection.gms

* Data on total and active population are expressed in thousands
* Data on GDP is expressed in millions of USD
PARAMETER
 ACT_POP(z,time)         Active population from 1980 to 2050 based on the PEP w aggregation
 ACT_POP_GTAP8(reg,time) Active population from 1980 to 2050 based on the GTAP8 aggregation
 CAB_Foure(z,time)       Implicit CAB in Foure et al projections
 exogro(z,time)          Exogenous growth factor for exogenously growing variables
 exogro_LS(z,time)       Exogenous growth factor for exogenously growing labor supply
 g_GDP(z,time)           GDP growth
 g_KS(z,time)            Capital stock growth rate
 g_LS(z,time)            Active population growth rate
 g_POP(z,time)           Population growth rate
 g_SDR(z,time)           Domestic savings rate growth rate
 GDP(z,time)             GDP projection based on the PEP w aggregation
 GDP_GTAP8(reg,time)     GDP from 1980 to 2050 based on the GTAP8 aggregation
 gdp_per_cap(z)          GDP per capita
 I_rate(z,time)          Investment rate - domestic savings over GDP
 Invest(z,time)          Investments from 1980 to 2050 based on PEP w aggregation
 Invest_GTAP8(reg,time)  Investments from 1980 to 2050 based on GTAP8 aggregation
 K_Stock_GTAP8(reg,time) Capital stock from 1980 to 2050 based on the GTAP8 aggregation
 K_Stock(z,time)         Capital stock from 1980 to 2050 based on the PEP w aggregation
 TFP(z,time)             Total factor productivity index 1980-2050 for PEP w aggregation
 TFP_GTAP8(reg,time)     Total factor productivity 1980-2050 for GTAP8 aggregation
 S_rate(z,time)          Savings rate - domestic savings over GDP
 Savings(z,time)         Domestic savings from 1980 to 2050 based on PEP w aggregation
 Savings_GTAP8(reg,time) Domestic savings from 1980 to 2050 based on GTAP8 aggregation
 sdr_fac(z,time)         Exogenous change factor for domestic savings rate
 TOT_POP(z,time)         Total population from 1980 to 2050 based on the PEP w aggregation
 TOT_POP_GTAP8(reg,time) Total population from 1980 to 2050 based on the GTAP8 aggregation
;

*==============================================================================
* 4.1 Real GDP projections
*==============================================================================
 GDP_GTAP8(reg,time)     = PROGDP_K('GDP_K',reg,time);
 GDP(z,time)             = SUM{reg$z2reg(z,reg),GDP_GTAP8(reg,time)};

loop{time$[time.val lt 2050],
 g_GDP(z,time)          = [GDP(z,time+1)/GDP(z,time)]-1;
};
 g_GDP(z,time)$[time.val ge 2050]
                         = g_GDP(z,time-1);

*==============================================================================
* 4.2 Active population projections
*==============================================================================
 ACT_POP_GTAP8(reg,time) = PROpopAC2021('PopAc',reg,time);
 ACT_POP(z,time)         = SUM{reg$z2reg(z,reg),ACT_POP_GTAP8(reg,time)};
loop{time$[time.val lt 2050],
 g_LS(z,time)  = [ACT_POP(z,time+1)/ACT_POP(z,time)]-1;
};
 g_LS(z,time)$[time.val ge 2050]
                         = g_LS(z,time-1);
 exogro_LS(z,'2017')     = 1;
loop{time$([time.val gt 2017] and [time.val le 2050]),
 exogro_LS(z,time)       = exogro_LS(z,time-1)*[1+g_LS(z,time-1)];
};


*==============================================================================
* 4.3 Total population projections
*==============================================================================
 TOT_POP_GTAP8(reg,time) = PROpop2021 ('Pop',reg,time);
 TOT_POP(z,time)         = SUM{reg$z2reg(z,reg),TOT_POP_GTAP8(reg,time)};
loop{time$[time.val lt 2050],
 g_POP(z,time)  = [TOT_POP(z,time+1)/TOT_POP(z,time)]-1;
};
 g_POP(z,time)$[time.val ge 2050]
                         = g_POP(z,time-1);

*==============================================================================
* 4.4 Growth factor
*==============================================================================
* In the projections of Fouré et al. (2012), the growth rate of labor,
* based on demographic variables, is generally much more stable than the
* growth rate of either GDP, or output per worker. In order to obtain a smooth
* reference scenario, we suggest using a 10 year moving average.

 exogro(z,'2017')        = 1;
loop{time$([time.val gt 2017] and [time.val le 2050]),
 exogro(z,time)          = exogro(z,time-1)*[1+g_LS(z,time-1)]*
            SUM[timej${(timej.val ge time.val-5) and (timej.val le time.val+4)},
                [1+g_GDP(z,timej)]/[1+g_LS(z,timej)]]/10;
};

*==============================================================================
* 4.5 Total factor productivity projections
*==============================================================================
 TFP_GTAP8(reg,time)            = PROTFPxGDP2021 ('TFPxGDP',reg,time);
 TFP(z,time)                    = SUM{reg$z2reg(z,reg),TFP_GTAP8(reg,time)};
 TFP(z,time)$([time.val le 2050]) = TFP(z,time)/GDP(z,time);
 TFP(z,time)                   = TFP(z,time)/TFP(z,'2017');

*==============================================================================
* 4.6 Capital stock projections
*==============================================================================
 K_Stock_GTAP8(reg,time) = PROK_Stock2021 ('K_Stock',reg,time);
 K_Stock(z,time)         = SUM{reg$z2reg(z,reg),K_Stock_GTAP8(reg,time)};

loop{time$[time.val lt 2050],
 g_KS(z,time)           = [K_Stock(z,time+1)/K_Stock(z,time)]-1;
};
 g_KS(z,time)$[time.val ge 2050]
                         = g_KS(z,time-1);

*==============================================================================
* 4.7 Savings and savings rate projections
*==============================================================================
 Savings_GTAP8(reg,time) = PROSavings2021 ('Savings',reg,time);
 Savings(z,time)         = SUM{reg$z2reg(z,reg),Savings_GTAP8(reg,time)};
 S_rate(z,time)$Savings(z,time) = Savings(z,time)/GDP(z,time);

loop{time$[time.val lt 2050],
 g_SDR(z,time)          = [S_rate(z,time+1)/S_rate(z,time)]-1;
};
 g_SDR(z,time)$[time.val ge 2050]
                         = g_SDR(z,time-1);
 sdr_fac(z,'2017')        = 1;
loop{time$([time.val gt 2017] and [time.val le 2050]),
 sdr_fac(z,time)          = sdr_fac(z,time-1)*[1+g_SDR(z,time-1)];
};
*==============================================================================
* 4.8 Investments, investment rate projections and implicit CAB
*==============================================================================
 Invest_GTAP8(reg,time) = PROinvest2021 ('Invest',reg,time);
 Invest(z,time)         = SUM{reg$z2reg(z,reg),Invest_GTAP8(reg,time)};
 I_rate(z,time)$Invest(z,time) = Invest(z,time)/GDP(z,time);
 CAB_Foure(z,time)      = Savings(z,time) - Invest(z,time);

*==============================================================================
* 5. Endogenous definition of set for rich regions/countries
*==============================================================================
* In the World Bank's 2007 World Development Indicators, "High-income" countries
* are defined as those with a per capita Gross National Income of 10726USD
* or above. Since there is no income from abroad in PEP-w-t, GDP is equal to
* GNI, and we define high-income economies according to GDP per capita.

 gdp_per_cap(z)  = [GDP(z,'2017')*1000000]/[TOT_POP(z,'2017')*1000];
 Zrich(Z)        = yes$[gdp_per_cap(z) ge 10726];
 Zother(Z)       = yes$[not Zrich(Z)];

execute_unload 'DATA_AGG-2007-25-18',
*Ensembles utilisés dans le PEP w-1 et le PEP w-t
 J, I1, BUS, PUB, F, L, K, Z, ZR, Z1, Zrich, Zother, sahara, UMA

*Variables de référence et paramètres utilisés dans le PEP w-1 et le PEP w-t
 CO, CGO, DDO, DEPO, DIO, DSO, EXO, IMO, INVO, KSTO, LDO, MRGNO, POPO, RKDO,
 TDHO, TICO, TIKO, TIMO, TIPO, TIWO, TIXO, tmrg, XSO, sigma_M1, sigma_M2,
 sigma_VA

*Paramètres utilisés dans PEP w-t uniquement
 exogro, exogro_LS, sdr_fac, g_POP, g_SDR, g_GDP, g_LS

*Autres paramètres qui ne sont pas utilisés dans les modèles PEP w
* TFP, g_KS, GDP, ACT_POP, TOT_POP, K_Stock, Savings, S_rate, Invest, I_rate,
* CAB_Foure
;
