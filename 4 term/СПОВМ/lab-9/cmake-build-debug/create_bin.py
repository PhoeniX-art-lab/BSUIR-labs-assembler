import os

os.system("dd if=/dev/random of=random.bin bs=16384 count=12739")
os.system("dd if=/dev/random bs=1 count=5845 >> random.bin")
os.system("wc -c random.bin")
