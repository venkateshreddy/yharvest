-module(yharvest_query_creator).
-export([batch_json_creator_all_genders/6]).
-include("include/defines.hrl").


%% Batch Query Geenrator for all Queries
batch_json_creator_all_genders(Method, Account, Action, Fragment, Country, AgeGroups) ->
	%pick URL1 and URL2 from facebook.hrl
	ParamString = paramstring_iterator(Method, Account, Action, Fragment, Country, AgeGroups),
	QueryUrl1 = string:concat(?URL1, ParamString),
	FinalUrl = string:concat(QueryUrl1, ?URL2),
	{FinalUrl,Country}
.

%% Iterate through all the genders and call paramstring for genders
paramstring_iterator(Method, Account, Action, Fragment, Country, AgeGroups) ->
	GenderParamsList = [ paramstring_for_genders(Method, Account, Action, Fragment, Country, Gender, AgeGroups) || Gender <- ?GENDERS],
	MyBatch = string:strip(lists:append([string:concat(X,",") || X <- GenderParamsList]),right, $,),
	ibrowse_lib:url_encode(MyBatch)
.

%% Prepare a paramstring for a country 
paramstring_for_genders(Method, Account, Action, Fragment, Country, Gender, AgeGroups) ->
	Objects = [string:concat("'countries' : ['", C) || C <- [string:concat(Country, B) || B <- [string:concat("'],", A ) || A <-[string:concat("'genders' : ['", Z) || Z <- [string:concat(Gender, Y) || Y <- [string:concat("'],", X) || X <- AgeGroups]]]]]],
	EscapedObjects = [ re:replace(O, "'", "\\\\'", [global, {return, list}]) || O <- Objects],
	EscapedTuple1 = [string:concat("{ ", T) || T <- EscapedObjects],
	EscapedTuples = [string:concat(S, " }'") || S <- EscapedTuple1],
	RelativeUrl = [string:concat(Account, Ru6) || Ru6 <- [string:concat("/", Ru5) || Ru5 <- [string:concat(Action, Ru4) || Ru4 <- [string:concat("?", Ru3) || Ru3 <- [string:concat(Fragment, Ru2) || Ru2 <- [string:concat("=", Ru1) || Ru1 <- EscapedTuples]]]]]],
	Str1 = string:concat("{'method' : '", Method ),
	Str2 = string:concat(Str1, "'"),
	Str3 = string:concat(Str2, ", 'relative_url' : '"),
	BatchJson = [string:concat(Bj2, "}" ) || Bj2 <- [string:concat(Str3, Bj1) || Bj1 <- RelativeUrl]],
	MyBatch = string:strip(lists:append([string:concat(X,",") || X <- BatchJson]), right, $,),
	%ParamString = ibrowse_lib:url_encode(MyBatch),
	MyBatch
.
