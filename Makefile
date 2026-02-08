.PHONY: all clean watch

RESUME_MD = resume.md
RESUME_PDF = resume.pdf

# Pandoc options for Chinese resume
PANDOC_OPTS = \
	--pdf-engine=xelatex \
	-V documentclass=ctexart \
	-V geometry:margin=0.8in \
	-V fontsize=11pt \
	-V colorlinks=true \
	-V linkcolor=blue \
	-V urlcolor=blue \
	--highlight-style=tango

all: $(RESUME_PDF)

$(RESUME_PDF): $(RESUME_MD)
	pandoc $(RESUME_MD) -o $(RESUME_PDF) $(PANDOC_OPTS)

clean:
	rm -f $(RESUME_PDF)

watch:
	@while true; do \
		inotifywait -e modify $(RESUME_MD) 2>/dev/null || sleep 1; \
		$(MAKE) --no-print-directory all; \
	done
