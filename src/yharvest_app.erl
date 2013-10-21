%% @doc Erlang Application to regulate calls to facebook and handle account and app restrictsions

-module(yharvest_app).

-behaviour(application).

-author("venkateshk@ybrantdigital.com").

%% Application callbacks
-export([start/2, stop/1]).



%% ===================================================================
%% Application callbacks
%% ===================================================================
%% @doc Start the main supervisor which inturn starts multiple supervsiors, one per each account/ queue 
start(_StartType, _StartArgs) ->
    yharvest_sup:start_link().

%% @doc stop the supervisor
stop(_State) ->
    ok.
