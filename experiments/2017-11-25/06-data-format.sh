# 6. Data format

# Download and unzip the file on the fly. 
curl http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr22.fa.gz | gunzip -c > chr22.fa

# Look at the file
cat chr22.fa | head -4