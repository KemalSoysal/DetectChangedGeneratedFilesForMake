
.PHONY: calculateHash
calculateHash:
	AUTOFILES=$$( find . \( \( -name '*auto.cpp' -or -name '*auto.h' \) -or -name 'auto-*.h' \)  -print ); \
	echo "$$AUTOFILES" ; \
	if [[ -n $$AUTOFILES ]]; \
    then \
		NEWHASH=$$( cat $$AUTOFILES | git hash-object --stdin ) ;\
		if ! [[ -f files.hash && "1" -eq "`grep -c $$NEWHASH files.hash`" ]]; \
		then \
		  echo hash changed to "$$NEWHASH" for file contents of $$AUTOFILES; \
		  echo "$$NEWHASH" > files.hash; \
		else \
		  echo hash "$$NEWHASH" did not change, touching auto generated files; \
		  HASHTIME=$$( ls -la -D "%FT%T" files.hash | awk '{print $$6}' ); \
		  echo $$AUTOFILES | xargs -t touch -d "$$HASHTIME"; \
		fi \
	else \
  		echo no files to hash; \
  	fi

