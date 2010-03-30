DRUM = 3146__robbiesurp__TAMA_Steel6
SOX = sox
AYMAKER = wine ../aymaker/AYMakeR.EXE
AY2WAV = wine ../ay2wav/ay2wav.exe
Z80ASM = z80asm

temp:
	mkdir temp

temp/$(DRUM).by24.wav: samples/$(DRUM).wav temp
	$(SOX) $< $@ trim 0 0:0:0.12

temp/$(DRUM).by8.wav: samples/$(DRUM).wav temp
	$(SOX) $< $@ trim 0 0:0:0.36

temp/$(DRUM).triplet.wav: temp/$(DRUM).by24.wav temp
	$(SOX) $< $< $< $@

temp/ostinato.wav: temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp
	$(SOX) temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).by8.wav temp/$(DRUM).by8.wav \
	temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).by8.wav temp/$(DRUM).triplet.wav temp/$(DRUM).triplet.wav temp/$(DRUM).triplet.wav $@

temp/tambour0_1.wav: temp/ostinato.wav temp
	$(SOX) $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $< $@ gain -20

temp/test.bin: test.asm
	$(Z80ASM) -i $< -o $@

temp/test.ay: temp/test.bin test.ini
	$(AYMAKER) test.ini
	mv test.ay temp/

temp/test.ay.wav: temp/test.ay
	$(AY2WAV) temp/test.ay

all: temp/$(DRUM).by24.wav

clean: 
	$(RM) temp/*
	$(RM) tracks/*

#		measure
#	0	 0
#	1	34
#	2	38

