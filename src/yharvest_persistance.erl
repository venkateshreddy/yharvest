-module(yharvest_persistance).

-author("venkateshk@ybrantdigital.com").

-include("include/defines.hrl").
-export([save_response_to_db/2]).

save_response_to_db(GenderObject, Country) ->
	%% Handle the exception here
	lager:info("Opening Connection to Riak"),
	{ok, Pid} = riakc_pb_socket:start_link(?RIAK_HOST, ?RIAK_PORT),
	Object = riakc_obj:new(yharvest_util:date_as_binary(), list_to_binary(Country), GenderObject ,"application/x-erlang-binary"),
	io:format("~p~n",[Object]),
	lager:info("Storing Data Successfully"),
	riakc_pb_socket:put(Pid, Object).