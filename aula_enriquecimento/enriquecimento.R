
# Análise de enriquecimento funcional -------------------------------------

if(!require(clusterProfiler)) BiocManager::install("clusterProfiler")
if(!require(enrichplot)) BiocManager::install("enrichplot")
if(!require(org.Hs.eg.db)) BiocManager::install("org.Hs.eg.db")
if(!require(pathview)) BiocManager::install("pathview")
if(!require(ggnewscale)) install.packages("ggnewscale")

library(clusterProfiler)
library(enrichplot)
library(org.Hs.eg.db)
library(pathview)
library(ggnewscale)

# Análise de enriquecimento com o pacote clusterProfiler ------------------

# Importar os dados da expressão diferencial
load("DElimma.rda")

# Obter uma lista de genes ----------------------------------------------

# Neste exemplo, vamos obter a lista correspondente aos genes diferencialmente
# expressos no contraste (5 dias - 0 hora), da análise de expressão da aula passada:
genes_eg <- unique(DElimma$entrez[DElimma$degenes.t5d...t0d != 0])

# Criar um vetor com os logFC correspondentes ao contraste 5 dias - 0 hora:
genes_eg_logFC <- DElimma$logFC.t5d...t0d[DElimma$degenes.t5d...t0d != 0]
names(genes_eg_logFC) <- genes_eg

# Fazer enriquecimento com o Gene Ontology --------------------------------

# Usar a função enrichGO()
enrich_go <- enrichGO(
  gene = genes_eg, # Lista de genes
  OrgDb = "org.Hs.eg.db", # pacote de anotação
  keyType = "ENTREZID", # # Usa o entrez id como identificador para o enriquecimento
  ont = "ALL", # Todas as ontologias
  qvalueCutoff = 0.05, # Qvalor
  pAdjustMethod = "BH" # Método de ajuste de p-valor
)

#####
# OBS.: Caso os genes usem um identificador diferente do ENTREZ ID, pode-se mudar o argumento
# 'keyType' para o identificador mais adequado:
keytypes(org.Hs.eg.db) # Mostra quais identificadores suportados pelo pacote de anotação 'org.Hs.eg.db'

# Obter a lista de genes em gene symbol
# genes_symbol <- unique(DElimma$symbol[DElimma$degenes.t5d...t0d != 0])
# enrich_go <- enrichGO(
#   gene = genes_symbol, # Lista de genes
#   OrgDb = "org.Hs.eg.db", # pacote de anotação
#   keyType = "SYMBOL", # Usa o gene symbol como identificador para o enriquecimento
#   ont = "ALL", # Todas as ontologias
#   qvalueCutoff = 0.05, # Qvalor
#   pAdjustMethod = "BH" # Método de ajuste de p-valor
# )
enrich_terms <- enrich_go@result
#####

# Filtrar apenas as ontologias relacionadas a processos biológicos:
enrich_terms <- enrich_terms[enrich_terms$ONTOLOGY == "BP",]

# Barplot
barplot(enrich_go,
        drop = TRUE,
        showCategory = 10,
        title = "GO Biological Pathways")

# Dotplot
dotplot(enrich_go, showCategory = 20)

# Rede de termos e genes
enrich_go_readable <- setReadable(enrich_go, 'org.Hs.eg.db', 'ENTREZID')
cnetplot(enrich_go_readable, foldChange = genes_eg_logFC)


# Fazer enriquecimento com o KEGG -----------------------------------------

enrich_kegg <- enrichKEGG(
  gene = genes_eg,
  organism = "hsa",
  keyType = "ncbi-geneid",
  pAdjustMethod = "BH",
  qvalueCutoff = 0.05
)

enrich_terms_kegg <- enrich_kegg@result

# Barplot
barplot(enrich_kegg,
        drop = TRUE,
        showCategory = 10,
        title = "KEGG Pathways")

# Dotplot
dotplot(enrich_kegg, showCategory = 20)


# Plotar o logFC em uma das vias do KEGG. A via escolhida aqui é 'DNA replication' = 'hsa03030'
pathview(gene.data = genes_eg_logFC,
         pathway.id = "hsa03030",
         limit = list(gene = c(-3,3), cpd = 1),
         low = list(gene = "blue", cpd = "green"),
         mid = list(gene = "gray", cpd = "gray"),
         high = list(gene = "red", cpd = "yellow"))



