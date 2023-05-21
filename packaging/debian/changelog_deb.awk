BEGIN{
	FS="\n";
	RS="\n\n\n";
}
{
	tmpdate=substr($1, 0, 10)
	gsub(/-/, " ", tmpdate)
	tm=mktime(tmpdate " 00 00 00")
	sub(/^........../, strftime("%a, %d %b %Y", tm), $1);
	debdate=substr($1, 0, 32)
	usrmail=substr($1, 33)

	ver=""
	match($3, /[0-9\.]+/);
	ver=substr($3,RSTART, RLENGTH);

	app="wxmedit"
	match($3, /MadEdit/);
	if (RLENGTH > 0)
	{
		app="madedit"
	}

	print app " (" ver ") unstable; urgency=low"
	print ""

	for(i=4; i<=NF; ++i)
	{
		if ($i == "")
			continue;

		sub(/^\t *[0-9]+\./, "  *", $i)
		print $i;
	}
	print ""
	print " -- " usrmail "  " debdate
	print ""
}
