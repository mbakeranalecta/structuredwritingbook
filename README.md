# Structured Writing Book

Source and tools for my book on structured writing. The book and the languages and tools that it is built with are all works in progress.

Source files are written in [SAM](https://github.com/mbakeranalecta/sam).

To build DocBook from the SAM source files, use sam2docbook.xsl with the
SAM Parser.

The command line to convert one SAM file to DocBook is:

    samparser <sam file> -o <docbook file> -x sam2docbook.xsl -i intermediate/<intermediate file>
    
For example (assuming the parser is run from the root directory of the project):

    samparser sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl -i intermediate/whatis.xml
    
To run on Mac or Linux you will need to invoke the Python 3 interpreter to
run the SAM Parser. For example:

    python3 samparser.py sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl -i intermediate/whatis.xml
    
  
To validate the SAM file, use the `-xsd` option to validate the intermediate 
file against the schema `swchapter.xsd` (coming soon!). You will want to dump the 
intermediate file if using this option because validation errors will 
be reported against this file, not the SAM file. (True SAM Schema support is 
TBD.)
 
    samparser sam/whatis.sam -o docbook/whatis.xml -x sam2docbook.xsl -i intermediate/whatis.xml -xsd swchapter.xsd
    
Batch conversion
================

You can also batch convert a set of SAM files. To do a batch conversion, you specify the source files using wild cards, and specify output and intermediate directories rather than files. 

    samparser sam/*.sam -id intermediate -od docbook -x sam2docbook.xsl -q
    
The output files will always be a flat list of files in the specified directory, even if the input files are in a directory hierarchy. 

The default extension for intermediate files and output files is `.xml` but 
you can change the extension using the `-outputextension` and `-intermediateextension` parameters. 

The production will eventually go through SPFE, so that the soft link mechanism
of SPFE can be used. 
 

    


