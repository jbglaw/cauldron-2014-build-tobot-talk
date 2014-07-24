#!/usr/bin/make -f


all:
	for aspect in 43 169; do														\
		for handout in '' handout; do													\
			sed -e 's/^.documentclass.*$$/\\documentclass[aspectratio='"$$aspect"','"$$handout"']{beamer}/' < build_robot.latex > temp.latex;	\
			pdflatex temp.latex || exit 1;												\
			pdflatex temp.latex || exit 1;												\
			pdflatex temp.latex || exit 1;												\
			echo XXXXXXX mv temp.pdf build_robot_$$aspect_$$handout.pdf;										\
			mv temp.pdf build_robot_$${aspect}_$${handout}.pdf;										\
			if [ "$${handout}" = handout ]; then											\
				for paper in a4paper letterpaper; do											\
					cat print.latex | sed -e 's/paper/'"$${paper}"'/' -e 's/pdffile/'"build_robot_$${aspect}_$${handout}.pdf"'/' > pprint.latex;	\
					pdflatex pprint.latex || exit 1;												\
					pdflatex pprint.latex || exit 1;												\
					mv pprint.pdf build_robot_$${aspect}_$${handout}_print-$${paper}.pdf;								\
				done;																	\
			fi;																		\
		done;																\
	done

clean:
	rm -f temp.* pprint.*

distclean: clean
	rm -f build*.pdf
