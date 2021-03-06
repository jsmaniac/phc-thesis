.PHONY: all
all: doc/pdf/phc-thesis.pdf

doc/pdf/phc-thesis.pdf: from-dissertation-tobin-hochstadt/*.scrbl scribblings/*.scrbl scribblings/*.rkt
	raco setup --doc-pdf doc/pdf/ --pkgs phc-thesis > pdf.log 2>&1 || (cat pdf.log && exit 1)
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dFastWebView=true -sOutputFile=doc/pdf/phc-thesis-linearized.pdf doc/pdf/phc-thesis.pdf
	mv doc/pdf/phc-thesis-linearized.pdf doc/pdf/phc-thesis.pdf
