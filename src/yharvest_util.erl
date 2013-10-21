-module(yharvest_util).
-export([date_as_string/0, date_as_binary/0]).

date_as_string() ->

	{{Year, Month, Day},{_, _, _}} = erlang:universaltime(),
	DateAsString = io_lib:format("~4..0w~2..0w~2..0w", [Year, Month, Day]),
	lists:flatten(DateAsString)
.

date_as_binary() ->
	list_to_binary(yharvest_util:date_as_string())
.