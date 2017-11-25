# 7. How to get data

# If you wanted to download the human transcriptome according to Ensembl you could do that with:
# curl -O ftp://ftp.ensembl.org/pub/release-86/gtf/homo_sapiens/Homo_sapiens.GRCh38.86.gtf.gz

# How do I use Entrez E-utils web API?
# Returns the the data for accession number AF086833.2 in the FASTA format:
# curl -s 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?id=AF086833.2&db=nuccore&rettype=fasta' | head

# How do I use Entrez Direct?
efetch -db=nuccore -format=gb -id=AF086833 | head

# Accession number AF086833 in Genbank format.
efetch -db=nuccore -format=gb -id=AF086833 > AF086833.gb

# Accession number AF086833 in Fasta format.
efetch -db=nuccore -format=fasta -id=AF086833 > AF086833.fa

# efetch can take additional parameters and select a section of the sequence.
efetch -db=nuccore -format=fasta -id=AF086833 -seq_start=1 -seq_stop=3

# It can even produce the sequence from reverse strands:
efetch -db=nuccore -format=fasta -id=AF086833 -seq_start=1 -seq_stop=5 -strand=1
efetch -db=nuccore -format=fasta -id=AF086833 -seq_start=1 -seq_stop=5 -strand=2

# How do we search with Entrez Direct?
esearch -db nucleotide -query PRJNA257197
esearch -db protein -query PRJNA257197

# To fetch the data for a search, pass it into efetch:
esearch -db nucleotide -query PRJNA257197 | efetch -format=fasta > genomes.fa
# To get all proteins:
esearch -db protein -query PRJNA257197 | efetch -format=fasta > proteins.fa

# Can we extract more complex information with Entrez Direct?
# Specifically, the xtract tool in Entrez Direct allows navigating and selecting parts of an XML file.
efetch -db taxonomy -id 9606,7227,10090 -format xml | xtract -Pattern Taxon -first TaxId ScientificName GenbankCommonName Division

#
# Accessing the Short Read Archive (SRA)
#

## How does the sratoolkit work?
# fastq-dump SRR1553607
# fastq-dump --split-files  SRR1553607 
fastq-dump --split-files -X 10000 SRR1553607

## How do we get information on the run?
### The sra-stat program can generate an XML report on the data.
sra-stat --xml --quick SRR1553610
### Get read length statistics on a PacBio dataset:
sra-stat --xml --statistics SRR4237168

#
# FASTA/Q manipulations
#

# Example data
wget http://data.biostarhandbook.com/reads/duplicated-reads.fq.gz
wget ftp://ftp.ncbi.nih.gov/refseq/release/viral/viral.1.1.genomic.fna.gz
wget ftp://ftp.ncbi.nih.gov/refseq/release/viral/viral.1.protein.faa.gz
# Sequence format and type are automatically detected.
seqkit stat *.gz
# GC content:
seqkit fx2tab --name --only-id --gc viral*.fna.gz

# Using TaxonKit
cat taxids.txt | taxonkit lineage
