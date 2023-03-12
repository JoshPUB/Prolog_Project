all: check

check: check-challenging check-veryhard 
# check: check-challenging check-veryhard check-easy

GOAL := "solution(S), solve(S), not((solve(T), T\=S)), writeln(\"Found 1 solutions\"); writeln(\"Too many solutions\")"

%.output: %.pl 
	timeout 10m swipl -q -g ${GOAL} -t halt  $*.pl 2>&1 > $*.output 

check-veryhard: veryhard.output
# 	Verify that the  solution has 6 rows (veryhard)
	@if [ $$(swipl -q -g "solution(S), length(S, L), write(L)." -t halt  veryhard.pl) -ne 6 ]; then echo "Not Very Hard" && (exit 1); else echo "Yes, It's Very Hard"; fi	
	diff veryhard.output veryhard.expected
	@echo veryhard - Success!

check-challenging: challenging.output
# 	Verify that the  solution has 5 rows (challenging)
	@if [ $$(swipl -q -g "solution(S), length(S, L), write(L)." -t halt  challenging.pl) -ne 5 ]; then echo "Not Challenging" && (exit 1); else echo "Yes, It's Challenging"; fi	
	diff challenging.output challenging.expected
	@echo challenging - Success!

update: update-ssh

update-ssh:
	git pull  git@gitlab.csi.miamioh.edu:CSE465/instructor/project1.git master
	
update-http:
	git pull  https://gitlab.csi.miamioh.edu/CSE465/instructor/project1.git master


submit: check submit-without-check

submit-without-check:
	git add -u 
	git commit -m "Submission" || echo "** Nothing has changed"
	git push origin master 
	git log -1
