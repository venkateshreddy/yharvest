-module(yharvest_country_stats).

-behaviour(gen_server).

-author("venkateshk@ybrantdigital.com").

-export([start_link/1, stop/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-include("include/defines.hrl").

-record(state, {state, countryname}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link(CountryName) ->
 	gen_server:start_link({local, list_to_atom(CountryName)}, ?MODULE, [CountryName], [] )
 	.

stop() ->
 	gen_server:cast(?MODULE, stop).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================


init([CountryName]) ->
	process_flag(trap_exit, true),
	{ok, #state{state = init, countryname = CountryName}, 0}
.
handle_call(Message, From, State) ->
	{reply,Message, State}
.

handle_cast(_Request, State) ->
	{noreply, State}.


handle_info(timeout,  #state{state = init, countryname = CountryName} = State) ->
	io:format("Monitor Started for ~p~n",[CountryName]),
	Query = yharvest_query_creator:batch_json_creator_all_genders("GET",?FACEBOOK_ACCOUNT,"reachestimate","targeting_spec", CountryName, ?FACEBOOK_AGE_GROUPS),
	Result = yharvest_httpc:get_country_stats(Query),
	yharvest_persistance:save_response_to_db(Result, CountryName),
	{noreply, State#state{state = run, countryname = CountryName }};
handle_info(_Init, State) ->
	{noreply, State}
.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.


