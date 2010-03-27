DRUM = 3146__robbiesurp__TAMA_Steel6
SOX = sox

temp/$(DRUM).by24.wav: samples/$(DRUM).wav 
	$(SOX) $< $@ trim 0 0:0:0.12

temp/$(DRUM).by8.wav: samples/$(DRUM).wav 
	$(SOX) $< $@ trim 0 0:0:0.36

temp/$(DRUM).triplet.wav: temp/$(DRUM).by24.wav
	$(SOX) $< $< $< $@

temp/ostinato.wav: temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav
	$(SOX) temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).by8.wav temp/$(DRUM).by8.wav \
	temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).triplet.wav temp/$(DRUM).triplet.wav $@

temp/tambour0_1.wav: temp/ostinato.wav
	$(SOX) $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $@ gain -20

all: temp/$(DRUM).by24.wav

clean: 
	$(RM) temp/*
	$(RM) tracks/*

#		measure
#	0	 0
#	1	34
#	2	38

