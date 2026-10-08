.DEFAULT_GOAL := help
DECK := hyperdeveloper-advanced.md
MARP := bunx @marp-team/marp-cli@latest --allow-local-files

help: ## Show targets
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

preview: ## Live preview in the browser (watch mode)
	$(MARP) --preview --watch $(DECK)

html: ## Export to HTML (copies diagrams next to it)
	$(MARP) $(DECK) -o dist/hyperdeveloper-advanced.html
	mkdir -p dist && cp -R diagrams dist/

pdf: ## Export to PDF
	$(MARP) $(DECK) --pdf -o dist/hyperdeveloper-advanced.pdf

pptx: ## Export to PowerPoint
	$(MARP) $(DECK) --pptx -o dist/hyperdeveloper-advanced.pptx

diagrams: ## Render mermaid diagrams (diagrams/*.mmd -> PNG, white background)
	for f in diagrams/*.mmd; do bunx -p @mermaid-js/mermaid-cli mmdc -i $$f -o $${f%.mmd}.png -b white -s 2; done

png: ## Export each slide as PNG (for review)
	$(MARP) $(DECK) --images png -o dist/png/slide.png

all: html pdf pptx ## Export HTML, PDF and PPTX
