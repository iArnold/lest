REBOL[]

do %test-framework/test-framework.r

test-file: func [
	file
	script
	/local flags result log-file summary script-checksum
] [
	; TODO: invent own flags (low priority)
	; Check if we run R3 or R2.
	set 'flags pick [
		[#64bit #r3only #r3]
		[#32bit #r2only]
	] found? in system 'catalog

	; calculate script checksum
	script-checksum: checksum/method read script 'sha1

	print "Testing ..."
	result: do-recover file flags script-checksum
	set [log-file summary] result

	print ["Done, see the log file:" log-file]
	print summary
]

home: pwd

print "===Test Bootrapy==="
do %bootrapy.r3
test-file %tests/main-test.r3 %bootrapy.r3
change-dir home

halt