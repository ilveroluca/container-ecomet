#!/usr/bin/env Rscript

# ---------- Load R environment ----------
# Setup R error handling to go to stderr
options(show.error.messages=F, error=function() { cat(geterrmessage(), file=stderr()); q("no",1,F) } )

# Set proper locale
loc <- Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")
loc <- Sys.setlocale(category="LC_ALL", locale="C")

# Set options
options(encoding="UTF-8")
options(stringAsfactors=FALSE, useFancyQuotes=FALSE)

# Take in trailing command line arguments
args <- commandArgs(trailingOnly=TRUE)
if (length(args) < 2) {
	print("Error! No or not enough arguments given.")
	print("Usage: $0 input.rdata plot.pdf")
	quit(save="no", status=1, runLast=FALSE)
}

# Load R environment
load(file=args[1])
args <- commandArgs(trailingOnly=TRUE)



# ---------- Plot simple PCA ----------
# Basic PCA
model_pca <- prcomp(x=feat_list, scale=TRUE)

# Plot
pdf(file=args[2], encoding="ISOLatin1", pointsize=10, width=5, height=5, family="Helvetica")
plot(model_pca$x[,c(1:2)], type="n", main="PCA of feature matrix")
points(model_pca$x[,c(1:2)], pch=16, col=species_samples_colors, cex=1.1)
legend("topleft", bty="n", pch=16, col=species_colors, pt.cex=0.8, cex=0.8, y.intersp=0.7, text.width=0.5, legend=species_names)
dev.off()


