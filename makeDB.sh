# select only 'Legitimate' names and sort column 2 (current name) to get unique names
grep -w 'Legitimate' ./mycobank.tsv | awk -F'\t' '{print $2}' | sort | uniq > ./uniq.txt
# select names which are currently in genus 'Geotrichum' and make a tsv file with them

######### change the genus name! #########
grep -w '^Graphium' ./uniq.txt | awk '{print $1 "\t" $2 "\t" $3 "\t" $4}' > ./species_name.tsv

#count and show the number of lines
echo 'species number'
wc -l ./species_name.tsv
# select names with 'var.' or 'f.' and concatinate $2~$4 to one column
grep -w 'var.' ./species_name.tsv | awk -F'\t' '{print $1"\t"$2,$3,$4}' > ./merged_names.tsv
grep -w 'f.' ./species_name.tsv | awk -F'\t' '{print $1"\t"$2,$3,$4}' >> ./merged_names.tsv
grep -w 'subsp.' ./species_name.tsv | awk -F'\t' '{print $1"\t"$2,$3,$4}' >> ./merged_names.tsv
# select the rest of the names except the one without species name ($2 starts with an uppercase) and print $1 and $2 
grep -wv 'var.' ./species_name.tsv | grep -wv 'f.' | grep -wv 'subsp.' | awk -F'\t' '$2 ~ /^[a-z]/ {print $1"\t"$2}' >> ./merged_names.tsv
sort ./merged_names.tsv > ./final_DB.tsv
# count and show the number of lines
echo 'final DB number'
wc -l ./final_DB.tsv
