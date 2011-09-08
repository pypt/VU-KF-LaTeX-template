![LaTeX komfake](http://i.imgur.com/M30dR.png "LaTeX komfake")

Čia yra **neoficialus *LaTeX* šablonas** Vilniaus universiteto Komunikacijos fakulteto rašto darbams rengti.

This is an **unofficial *LaTeX* template** for preparing Vilnius university Faculty of Communication course work.

# Savybės

* „Moka“ automatiškai pagaminti:
	* **titulinį lapą**,
	* **referato lapą**,
	* **santraukas**,
	* **turinį**,
	* **bibliografinių nuorodų sąrašą**,
	* **priedus**.
* Formatuoja *BibTeX* **bibliografinių nuorodų sąrašą** (daugmaž) pagal reikalavimus.
* Atitinka Komunikacijos fakulteto [**Rašto darbų metodinius nurodymus**][1]:
	* teisingas šriftas,
	* korektiškos antraštės,
	* tarpai tarp eilučių,
	* lapo/paragrafo atitraukimas nuo kraštų,
	* citatos,
	* etc.

# Kaip įdiegti

- Įsidiegti *TeX* dokumentų rengimo programą.
  * Rekomenduojamas [TeX Live][2] paketas MS Windows / Linux sistemoms arba [MacTeX][3] paketas Mac OS X sistemai
- Parsisiųstus failus `vukf.cls` (pats *LaTeX* šablonas) ir `vukfbibtex.bst` (*BibTeX* stilius bibliografinių nuorodų sąrašui) įkelti į tą patį katalogą, kuriame yra ir rengiamas darbas.

# Kaip naudoti

Žr. katalogą `pavyzdys/`. Jame patalpintas gal ne pats geriausias, bet *LaTeX*'u parašytas kursinis darbas.

* `kursinis-piratines-radijo-stotys.tex` - pats kursinis darbas.
* `kursinis-piratines-radijo-stotys-bibliografija.bib` - kursinio darbo bibliografiniai šaltiniai.
* `kursinis-piratines-radijo-stotys.pdf` - kursinio darbo PDF, sugeneruotas naudojant šį šabloną.

# Kodėl ne *Word*'as?

Nes:

* Rašto darbus galima parengti *Notepad'u*.
* Didelį darbą galima iškelti į kelias bylas.
* Nebereikia užsiimti metodinių nurodymų biurokratija.
* Nereikia pirkti *Microsoft Office* arba spjaudytis dėl *OpenOffice*.
* Smagiau (savaip).

# Pastabos

* Dokumento kūrimui naudoti *XeTeX* (nes būtinas *Times New Roman* šriftas).
* „Ilgi“ lietuviški brūkšniai rašomi įterpiant du brūkšnius (`--`).
* Kol kas *BibTeX* stilius „nemoka“ autoriaus pavardės pakeisti į didžiąsias raides (todėl teks rankomis).

# Klaidos / FIXME / TODO

* Keista klaida `Latex Error: abc.tex:2 Missing = inserted for \ifnum.` (bet PDF byla vis tiek sukuriama)
* „Lietuviškos“ kabutės galėtų būti rašomos patogiau.
	* Šiuo metu geriausia rašyti du kablelius (`,,`), dvi viengubas kabutes (`''`) ir galiausiai panaudoti *Find and Replace* ;-)
* Baigti realizuoti *BibTeX* stilių.
* Referato puslapyje nesuskaičiuojamas priedų puslapių skaičius.
* Turinio kūrimas galėtų būti patobulintas (pirmo lygio skyrių pavadinimai didžiosiomis raidėmis, numerių lygiavimas ir kt.)
* Turinyje „nepasispaudžia“ nuoroda „Bibliografinių nuorodų sąrašas“
* Išplėsti darbų pasirinkimą - pridėti referatą, praktikos ataskaitą, bakalaurinį, magistrinį ir pan.
* Įvykdyti *peer review* ;-)

# Šaltiniai ir nuorodos

* [Kas tas *LaTeX*?][8]
* [Kas tas *BibTeX*?][9]
* [VU MIF studentų parengtas *LaTeX* šablonas][4]
* [UAB „VTEX“ *LaTeX* lituanizacija][5]
* [LaTeX @ WikiBooks][6], puikus šaltinis dokumentų rengimo kalbos mokymuisi

# Papildymai, pataisymai

...yra laukiami! [Rašykite][7] arba darykite *Pull request*'ą.


[1]: http://www.kf.vu.lt/uploads/docs/Studiju%20dokumentai/metodiniai_nurodymai090204.pdf	"VU Komunikacijos fakulteto Rašto darbų metodiniai nurodymai"
[2]: http://www.tug.org/texlive/ "TeX Live"
[3]: http://www.tug.org/mactex/ "MacTeX"
[4]: http://ims.mii.lt/~lauras/latexlt/ "VU MIF LaTeX šablonas"
[5]: http://www.vtex.lt/tex/littex/index.html "„VTEX“ *LaTeX* lituanizacija"
[6]: http://en.wikibooks.org/wiki/LaTeX "LaTeX @ WikiBooks"
[7]: mailto:linas.valiukas@kf.stud.vu.lt "Linas Valiukas"
[8]: http://en.wikipedia.org/wiki/LaTeX "LaTeX @ Wikipedia"
[9]: http://en.wikipedia.org/wiki/BibTeX "BibTeX @ Wikipedia"
