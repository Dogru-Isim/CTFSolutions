pos_pw="8c86\n7692\na519\n3e61\n7dd6\n8919\naaea\nf34b\nd9a2\n39f7\n626b\ndc78\n2a98\n7a85\ncd15\n80fa\n8571\n2f8a\n2ca6\n7e6b\n9c52\n7423\na42c\n7da0\n95ab\n \
7de8\n6537\nba1e\n4fd4\n20a0\n8a28\n2801\n2c9a\n4eb1\n22a5\nc07b\n1f39\n72bd\n97e9\naffc\n4e41\nd039\n5d30\nd13f\nc264\nc8be\n2221\n37ea\nca5f\nfa6b\n5ada\n \
607a\ne469\n5681\ne0a4\n60aa\nd8f8\n8f35\n9474\nbe73\nef80\nea43\n9f9e\n77d7\nd766\n55a0\ndc2d\na970\ndf5d\ne747\ndc69\ncc89\ne59a\n4f68\n14ff\n7928\n36b9\n \
eac6\n5c87\nda48\n5c1d\n9f63\n8b30\n5534\n2434\n4a82\nd72c\n9b6b\n73c5\n1bcf\nc739\n6c31\ne138\n9e77\nace1\n2ede\n32e0\n3694\nfc92\na7e2"

for i in $(echo $pos_pw); do
echo $i | python3 level4.py | grep pico
done
