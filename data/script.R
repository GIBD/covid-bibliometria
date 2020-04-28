# cargo librería Bibliometrix
library(bibliometrix)

#leo archivo de publicaciones sobre SARS COV 2 (2020)
setwd("C:/Users/Anabella/GIBD/coronavirus/bibliometria/covid-bibliometria/data")
D <- readFiles('sars_cov_2.bib')

#convierto a dataframe
M <- convert2df(D, dbsource = "scopus", format = "bibtex")

# descriptive analysis of the bibliographic data frame
results <- biblioAnalysis(M, sep = ";")

#summarize main results of the bibliometric analysis
S <- summary(object = results, k = 10, pause = FALSE)

plot(x = results, k = 10, pause = FALSE)

#BIBLIOGRAPHIC NETWORK MATRICES
#*biblioNetwork* function
#uses two arguments to define the network to compute: 
#*analysis* argument can be "cocitation", "coupling", "collaboration", or "co-occurrences". 
#*network* argument can be "authors","references", "sources", "countries", "universities", "keywords", "author_keywords", "titles" and
#"abstracts"

NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ". ")


#VISUALIZING BIBLIOGRAPHIC NETWORKS

### Country Scientific Collaboration
# Create a country collaboration network
M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, n = dim(NetMatrix)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.8)

### Co-Citation Network
# Create a co-citation network
NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ". ")
# Plot the network
net=networkPlot(NetMatrix, n = 30, Title = "Co-Citation Network", type = "fruchterman", size=T,
                remove.multiple=FALSE, labelsize=0.7,edgesize = 5)



### Keyword co-occurrences
# Create keyword co-occurrences network
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Cooccurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)


###CO-WORD ANALYSIS: THE CONCEPTUAL STRUCTURE OF A FIELD
# The aim of the co-word analysis is to map the conceptual structure of a framework using the word
# co-occurrences in a bibliographic collection. The analysis can be performed through dimensionality
# reduction techniques such as Multidimensional Scaling (MDS), Correspondence Analysis (CA) or
# Multiple Correspondence Analysis (MCA). Here, we show an example using the function *conceptualStructure* that performs a CA or MCA to draw a conceptual structure of the field and K-means
# clustering to identify clusters of documents which express common concepts. Results are plotted
# on a two-dimensional map. *conceptualStructure* includes natural language processing (NLP) routines (see the function *termExtraction*) to extract terms from titles and abstracts. In addition, it
# implements the Porter’s stemming algorithm to reduce inflected (or sometimes derived) words to
# their word stem, base or root form.

# Conceptual Structure using keywords (method="CA")
CS <- conceptualStructure(M,field="ID", method="CA", minDegree=4, k.max=8, stemming=FALSE,
                          labelsize=10, documents=10)

### HISTORICAL DIRECT CITATION NETWORK
# The historiographic map is a graph proposed by E. Garfield to represent a chronological network
# map of most relevant direct citations resulting from a bibliographic collection. The function histNetwork generates a chronological direct citation network matrix which can be plotted using *histPlot*:

# Create a historical citation network
histResults <- histNetwork(M, n=20, sep = ". ")
# Plot a historical co-citation network
net <- histPlot(histResults, size = FALSE,label=TRUE, arrowsize = 0.5)



