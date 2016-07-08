# Structured Writing Book

Source and tools for my book on structured writing. The book and the languages and tools that it is built with are all works in progress.

Source files are written in [SAM](https://github.com/mbakeranalecta/sam).

To build DocBook from the SAM source files, use sam2docbook.xsl with the
SAM Parser.

The command line for the SAM Parser is:

    samparser <sam file> -o <docbook file> -x sam2docbook.xsl
    
For example (assuming the parser is run from the root directory of the project):

    samparser sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl
    
To run on Mac of Linux you will need to invoke the Python 3 interpreter to
run the SAM Parser. For example:

    python3 samparser.py sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl
    
In case of an error, it may be helpful to dump the intermediate XML file 
which is produced by the SAM parser from the SAM markup. This is the file 
that sam2docbook.xslt is processing. To dump this file, use the `-i` option:

    samparser sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl -i intermediate/whatis.int.xml
    
To invoke the smart quotes function of the parser, use the `-q` option. 

    samparser sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl -q
    
To validate the SAM file, use the `-xsd` option to validate the intermediate 
file against the schema `swchapter.xsd` (coming soon!). You will want to dump the 
intermediate file if using this option because validation errors will 
be reported against this file, not the SAM file. (True SAM Schema support is 
TBD.)
 
    samparser sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl -i intermediate/whatis.int.xml -xsd swchapter.xsd
    
Sorry, don't yet have support for batch converting files.

The book file will eventually be used to create a DocBook book file. This 
is not developed yet. 

The production will eventually go through SPFE, so that the soft link mechanism
of SPFE can be used. 
 

    


