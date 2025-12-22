# select only 'Legitimate' names and sort column 2 (current name) to get unique names
grep -w 'Legitimate' ./Geotrichum_mycobank | awk -F'\t' '{print $2}' | sort | uniq > ./Geotrichum_uniq.txt
# select names which are currently in genus 'Geotrichum' and make a tsv file with them
grep -w 'Geotrichum' ./Geotrichum_uniq.txt | awk '{print $1 "\t" $2 "\t" $3 "\t" $4}' > ./Geotrichum_species_name.tsv
#count and show the number of lines
echo 'Geotrichum species number'
wc -l ./Geotrichum_species_name.tsv
# select names with 'var.' or 'f.' and concatinate $2~$4 to one column
grep -w 'var.' ./Geotrichum_species_name.tsv | awk -F'\t' '{print $1"\t"$2,$3,$4}' > ./Geotrichum_final.tsv
grep -w 'f.' ./Geotrichum_species_name.tsv | awk -F'\t' '{print $1"\t"$2,$3,$4}' >> ./Geotrichum_final.tsv
# select the rest of the names and print $1 and $2 
grep -wv 'var.' ./Geotrichum_species_name.tsv | grep -wv 'f.' | awk -F'\t' '{print $1"\t"$2}' >> ./Geotrichum_final.tsv
sort ./Geotrichum_final.tsv > ./Geotrichum_DB.tsv
# count and show the number of lines
echo 'Geotrichum final DB number'
wc -l ./Geotrichum_DB.tsv
