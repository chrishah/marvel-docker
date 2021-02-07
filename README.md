# marvel-docker
Ubuntu 20.04 fully contained for MARVEL assembly

Find information about the MARVEL assembler [here](https://github.com/schloi/MARVEL).

I am not part of the developer team - I just made this image.

## Example E. coli assembly

Copy files from MARVEL example section.
```bash
docker run --rm -v $(pwd):/in -w /in chrishah/marvel:e3f3cae gunzip -c /usr/src/MARVEL/examples/e.coli_nanopore/01_Ecoli_K12_R9_1D_Rapid_basecalled.pass.20x.fasta.gz > E_coli.20x.fasta
docker run --rm -v $(pwd):/in -w /in chrishah/marvel:e3f3cae cp /usr/src/MARVEL/examples/e.coli_nanopore/do.py .
```

Set up initial database with for reads.
```bash
docker run --rm -v $(pwd):/in -w /in chrishah/marvel:e3f3cae DBprepare.py ECOL E_coli.20x.fasta
```

Run assembly (individual steps as detailed in `do.py` script).
```bash
docker run --rm -v $(pwd):/in -w /in chrishah/marvel:e3f3cae python3 ./do.py
```


