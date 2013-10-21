-module(yharvest_facebook).
-export([fb_countries/0,
		 fb_agegroups/0
		 ]).



%% Return a list of countries.
%% Currently it returns a static list to avoid querying facebook everytime for list of countries
%% Alternatively this can be obtained by Querying Facebook for list of countries
fb_countries() ->
	["DE","GR","HK","IN","ID","IE","IL","IT","JP","JO","KW","LB","MY","MX","NL","NZ","NG","NO","PK","PA","PE","PH","PL","RU","SA","RS","SG","ZA","KR","ES","SE","CH","TW","TH","TR","AE","VE","PT","LU","BG","CZ","SI","IS","SK","LT","TT","BD","LK","KE","HU","MA","CY","JM","EC","RO","BO","GT","CR","QA","SV","HN","NI","PY","UY","PR","BA","PS","TN","BH","VN","GH","MU","UA","MT","BS","MV","OM","MK","LV","EE","IQ","DZ","AL","NP","MO","ME","SN","GE","BN","UG","GP","BB","AZ","TZ","LY","MQ","CM","BW","ET","KZ","NA","MG","NC","MD","FJ","BY","JE","GU","YE","ZM","IM","HT","KH","AW","PF","AF","BM","GY","AM","MW","AG","RW","GG","GM","FO","LC","KY","BJ","AD","GD","VI","BZ","VC","MN","MZ","ML","AO","GF","UZ","DJ","BF","MC","TG","GL","GA","GI","CD","KG","PG","BT","KN","SZ","LS","LA","LI","MP","SR","SC","VG","TC","DM","MR","AX","SM","SL","NE","CG","AI","YT","CV","GN","TM","BI","TJ","VU","SB","ER","WS","AS","FK","GQ","TO","KM","PW","FM","CF","SO","MH","VA","TD","KI","ST","TV","NR","RE"]
.	

%% Returns a static list of age groups
%% Update this List when facebook introduces new age groups.
fb_agegroups() ->
	[
	    " ",
		"'age_min':'13','age_max':'17'",
		"'age_min':'18','age_max':'24'",
		"'age_min':'25','age_max':'34'",
		"'age_min':'35','age_max':'44'",
		"'age_min':'45','age_max':'54'",
		"'age_min':'55','age_max':'64'",
		"'age_min':'65'"
	]
.