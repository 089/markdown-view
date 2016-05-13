#!/usr/bin/env bash

# markdown-view converts the selected .md files to html using pandoc and displays them in your default browser. 
# 
# STATUS:   alpha
# LICENSE:	http://choosealicense.com/licenses/gpl-3.0/
# AUTHOR: 	https://github.com/089
#

# settings 
    SCRIPT_FILENAME=$(basename "$0")
    TMP_DIR="/tmp"  # no slash at the end!
    FILENAME_PREFIX="markdown-view"
    FILENAME_EXT="html"
    TIMESTAMP=`date +%Y%m%d-%H%M%S`
    

if [ $# -lt 1 ]; then

	echo -e "\033[1m\033[31merror: Filename is missing\033[0m"
	echo -e "\033[1musage: ${SCRIPT_FILENAME} file1.md [file2.md] [file3.md]\033[0m"
	echo -e "\033[1musage: ${SCRIPT_FILENAME} *.md\033[0m"
	exit 1

else

	while [ $# -gt 0 ]
	do

	  for FILENAME in $1
	  do

	    if test -f "${FILENAME}"; then
        
            if [[ "${FILENAME}" == *.md ]]; then
                
                OUTPUT_FILENAME="${TMP_DIR}/${FILENAME_PREFIX}.${TIMESTAMP}.${FILENAME}.${FILENAME_EXT}"

                # convert
                pandoc ${FILENAME} -o ${OUTPUT_FILENAME} 
                
                # open in default browser
                xdg-open ${OUTPUT_FILENAME} & 

                echo "copy ${FILENAME} ==> ${OUTPUT_FILENAME}"
                
            fi
	      
          echo ">>> $FILENAME"

	    else

	        echo -e "\033[1m\033[31mFile(s) $FILENAME does not exist.\033[0m"
		exit 1

	    fi

	  done

	  shift

	done
fi

echo

exit 0
