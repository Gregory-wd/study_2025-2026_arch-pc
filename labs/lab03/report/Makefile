all:
	pandoc report.md -o report.pdf --pdf-engine=xelatex -V mainfont="DejaVu Sans"
	pandoc report.md -o report.docx
clean:
	rm -f report.pdf report.docx